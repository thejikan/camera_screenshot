import 'dart:io';

import 'package:face_camera/face_camera.dart';
import 'package:flutter/material.dart';

class FaceCameras extends StatefulWidget {
  const FaceCameras({super.key});

  @override
  State<FaceCameras> createState() => _FaceCamerasState();
}

class _FaceCamerasState extends State<FaceCameras> {
  File? _capturedImage;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: const Text('Camera'),
          ),
          body: Builder(builder: (context) {
            if (_capturedImage != null) {
              return Center(
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    Image.file(
                      _capturedImage!,
                      width: double.maxFinite,
                      fit: BoxFit.fitWidth,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 16.0),
                      child: ElevatedButton(
                          onPressed: () =>
                              setState(() => _capturedImage = null),
                          child: const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              'Capture Again',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w700),
                            ),
                          )),
                    )
                  ],
                ),
              );
            }
            return SmartFaceCamera(
              indicatorShape: IndicatorShape.circle,
              showFlashControl: false,
              showCameraLensControl: false,
              // autoCapture: true,
              defaultCameraLens: CameraLens.front,
              onCapture: (File? image) {
                setState(() => _capturedImage = image);
              },
              onFaceDetected: (Face? face) {
                //Do something
              },
              messageBuilder: (context, face) {
                if (face == null) {
                  return _message('Place your face in the camera');
                }
                if (!face.wellPositioned) {
                  return _message('Center your face');
                }
                return const SizedBox.shrink();
              },
            );
          })),
    );
  }

  Widget _message(String msg) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 55, vertical: 15),
        child: Text(msg,
            textAlign: TextAlign.center,
            style: const TextStyle(
                fontSize: 20, height: 1.6, fontWeight: FontWeight.w500)),
      );
}
