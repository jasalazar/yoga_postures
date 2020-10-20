python -m scripts.retrain \
--bottleneck_dir=tf_files/bottlenecks\
--how_many_training_steps=10\
--model_dir=tf_files/tf_models/\
--summaries_dir=tf_files/training_summaries/"${ARCHITECTURE}" \
--output_graph=tf_files/yoga_postures.pb\
--output_labels=tf_files/yoga_postures.txt\
--architecture="${ARCHITECTURE}" \
--image_dir=tf_files/images \
--random_brightness 15

================================================================

#THIS TRAINS A MODEL AND OUTPUTS A TFLITE FILE
# --tfhub_module https://tfhub.dev/google/tf2-preview/mobilenet_v2/feature_vector/4 \
# --tfhub_module https://tfhub.dev/google/tf2-preview/mobilenet_v2/classification/4 \

/home/jsalazar/anaconda3/bin/make_image_classifier \
--tfhub_module https://tfhub.dev/google/tf2-preview/mobilenet_v2/feature_vector/4 \
--image_size 224 \
--saved_model_dir trained_model \
--labels_output_file yoga_postures.txt \
--tflite_output_file new_mobile_model.tflite \
--train_epochs 50 \
--batch_size 50 \
--log_dir log
--image_dir tf_files/images \

------------TESTS-----------------

./bonnet_model_compiler.par \
--frozen_graph_path=mobilenet_v1_160res_0.5_imagenet.pb \
--output_graph_path=model.binaryproto \
--input_tensor_name=input \
--output_tensor_names=final_result \
--input_tensor_size=160 \
--debug

python yoga_postures_classifier.py \
--input_mean 0 --input_std 224 \
--model_path new_mobile_model.tflite \
--label_path yoga_postures.txt \
--nopreview True


python label_image.py \
--input_mean 0 --input_std 255 \
--model_file new_mobile_model.tflite --label_file yoga_postures.txt \
--image c_1.jpeg  # <<< Adjust filename.

./bonnet_model_compiler.par \
--frozen_graph_path=saved_model.pb \
--output_graph_path=yoga_postures.binaryproto \
--input_tensor_name=input \
--output_tensor_names=final_result \
--input_tensor_size=224


================

cmake -D CMAKE_BUILD_TYPE=RELEASE \
-D CMAKE_INSTALL_PREFIX=$cwd/installation/OpenCV-"$cvVersion" \
-D INSTALL_C_EXAMPLES=ON \
-D INSTALL_PYTHON_EXAMPLES=ON \
-D WITH_TBB=ON \
-D WITH_V4L=ON \
-D OPENCV_PYTHON3_INSTALL_PATH=$cwd/OpenCV-$cvVersion-py3/lib/python3.5/site-packages \
-D WITH_QT=ON \
-D WITH_OPENGL=ON \
-D OPENCV_EXTRA_MODULES_PATH=../../opencv_contrib/modules \
-D BUILD_EXAMPLES=ON ..
