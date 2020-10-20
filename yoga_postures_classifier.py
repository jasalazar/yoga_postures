#!/usr/bin/env python3
"""Camera image classification demo code.
Runs continuous image classification on camera frames and prints detected object
classes.
Example:
image_classification_camera.py --num_frames 10
"""
import argparse
import contextlib
import numpy as np
import tensorflow as tf
import aiy.vision.annotator as Annotator
from aiy.vision.inference import CameraInference
#from aiy.vision.models import image_classification
from picamera import PiCamera
#
# def classes_info(classes):
#     return ', '.join('%s (%.2f)' % pair for pair in classes)
#
# @contextlib.contextmanager
# def CameraPreview(camera, enabled):
#     if enabled:
#         camera.start_preview()
#     try:
#         yield
#     finally:
#         if enabled:
#             camera.stop_preview()
#
# def main():
#     parser = argparse.ArgumentParser('Image classification camera inference example.')
#     parser.add_argument('--num_frames', '-n', type=int, default=None,
#         help='Sets the number of frames to run for, otherwise runs forever.')
#     parser.add_argument('--num_objects', '-c', type=int, default=3,
#         help='Sets the number of object inferences to print.')
#     parser.add_argument('--nopreview', dest='preview', action='store_false', default=True,
#         help='Enable camera preview')
#     parser.add_argument(
#         '--model_path',
#         required=True,
#         help='Path to converted model file that can run on VisionKit.')
#     parser.add_argument(
#             '--label_path',
#             required=True,
#             help='Path to label file that corresponds to the model.')
#     args = parser.parse_args()
#
#     interpreter = tf.lite.Interpreter(
#       model_path=args.model_file, num_threads=args.num_threads)
#     interpreter.allocate_tensors()
#
#     input_details = interpreter.get_input_details()
#     output_details = interpreter.get_output_details()
#
#     with PiCamera(sensor_mode=4, framerate=30) as camera, \
#         CameraPreview( camera, enabled=args.preview ), \
#         CameraInference( args.model_path ) as inference:
#         for result in inference.run( args.num_frames ):
#             #classes = image_classification.get_classes(result, top_k=args.num_objects, threshold=0.0)
#             print(classes_info(classes))
#             if classes:
#                 camera.annotate_text = '%s (%.2f)' % classes[0]
#             else:
#                 camera.annotate_text = 'No Class detected'

def main():
    with PiCamera() as camera:
        # while True:
            camera.start_preview( alpha=50 )
            # annotator = Annotator.Annotator( camera )
            # annotator.clear()
            # annotator.bounding_box(
            #     (20, 20, 70, 70), outline=(0, 0xFF, 0, 0xFF), fill=0)
            # annotator.text( (35, 70), 'Hola Gabriela' )

if __name__ == '__main__':
    main()
