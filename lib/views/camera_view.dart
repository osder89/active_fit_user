import 'dart:io';

import 'package:active_fit_user/models/exercise_model.dart';
import 'package:active_fit_user/models/push_up_model.dart';
import 'package:active_fit_user/painters/pose_painter.dart';
import 'package:active_fit_user/utils.dart' as utils;
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:google_mlkit_commons/google_mlkit_commons.dart';

class CameraView extends StatefulWidget {
  CameraView(
      {Key? key,
      required this.customPaint,
      required this.onImage,
      required this.posePainter,
      required this.exerciseName,
      this.onCameraFeedReady,
      this.onDetectorViewModeChanged,
      this.onCameraLensDirectionChanged,
      this.initialCameraLensDirection = CameraLensDirection.back})
      : super(key: key);

  final PosePainter? posePainter;
  final String exerciseName;
  final CustomPaint? customPaint;
  final Function(InputImage inputImage) onImage;
  final VoidCallback? onCameraFeedReady;
  final VoidCallback? onDetectorViewModeChanged;
  final Function(CameraLensDirection direction)? onCameraLensDirectionChanged;
  final CameraLensDirection initialCameraLensDirection;

  @override
  State<CameraView> createState() => _CameraViewState();
}

class _CameraViewState extends State<CameraView> {
  static List<CameraDescription> _cameras = [];
  CameraController? _controller;
  int _cameraIndex = -1;
  double _currentZoomLevel = 1.0;
  double _minAvailableZoom = 1.0;
  double _maxAvailableZoom = 1.0;
  double _minAvailableExposureOffset = 0.0;
  double _maxAvailableExposureOffset = 0.0;
  double _currentExposureOffset = 0.0;
  bool _changingCameraLens = false;

  PoseLandmark? p1;
  PoseLandmark? p2;
  PoseLandmark? p3;

  int _plankTimeCounter = 0;

  void _incrementPlankTimeCounter() {
  final bloc = BlocProvider.of<ExerciseCounter>(context);
  if (bloc.state == ExerciseState.complete && widget.exerciseName == 'plank') {
    print('---------------------------');
    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        _plankTimeCounter++;
        print(_plankTimeCounter);
      });
      _incrementPlankTimeCounter(); // Llamar recursivamente para contar cada segundo
    });
  }
}



  @override
  void initState() {
    super.initState();

    _initialize();
  }

  void _initialize() async {
    if (_cameras.isEmpty) {
      _cameras = await availableCameras();
    }
    for (var i = 0; i < _cameras.length; i++) {
      if (_cameras[i].lensDirection == widget.initialCameraLensDirection) {
        _cameraIndex = i;
        break;
      }
    }
    if (_cameraIndex != -1) {
      _startLiveFeed();
    }
  }

  //para verificar y contar
  /* @override
  void didUpdateWidget(covariant CameraView oldWidget) {
    if(widget.customPaint != oldWidget.customPaint){
      if(widget.customPaint != null){
        final bloc = BlocProvider.of<PushCounter>(context);
        for(final pose in widget.posePainter!.poses){
          PoseLandmark getPoseLnadmark(PoseLandmarkType type1){
            final PoseLandmark joint1 = pose.landmarks[type1]!;
            return joint1;
          }

          p1 = getPoseLnadmark(PoseLandmarkType.rightShoulder);
          p2 = getPoseLnadmark(PoseLandmarkType.rightElbow);
          p3 = getPoseLnadmark(PoseLandmarkType.rightWrist);
        }

        //verificar 
        if(p1 != null && p2 != null && p3 != null){
          final rtangle = utils.angle(p1!, p2!, p3!);
          final rta = utils.isPushUp(rtangle, bloc.state);
          print('Angulo: ${rtangle.toStringAsFixed(2)}');
          if(rta != null){
            if(rta == PushUpState.init){
              bloc.setPushUpState(rta);
            }else if(rta == PushUpState.complete){
              bloc.incrementar();
              bloc.setPushUpState(PushUpState.neutral);
            }
          }
        }
      }
    }
    super.didUpdateWidget(oldWidget);
  }*/

  @override
  void didUpdateWidget(covariant CameraView oldWidget) {
    if (widget.customPaint != oldWidget.customPaint) {
      if (widget.customPaint != null) {
        final bloc = BlocProvider.of<ExerciseCounter>(context);

        for (final pose in widget.posePainter!.poses) {
          PoseLandmark getPoseLandmark(PoseLandmarkType type) {
            return pose.landmarks[type]!;
          }

          PoseLandmark? p1, p2, p3, p4;

          // Obtener poses relevantes para cada ejercicio
          switch (widget.exerciseName) {
            case 'pushUp':
              p1 = getPoseLandmark(PoseLandmarkType.rightShoulder);
              p2 = getPoseLandmark(PoseLandmarkType.rightElbow);
              p3 = getPoseLandmark(PoseLandmarkType.rightWrist);
              break;
            case 'squat':
              p1 = getPoseLandmark(PoseLandmarkType.rightHip);
              p2 = getPoseLandmark(PoseLandmarkType.rightKnee);
              p3 = getPoseLandmark(PoseLandmarkType.rightAnkle);
              p4 = getPoseLandmark(PoseLandmarkType.rightElbow);
              break;
            case 'plank':
              p1 = getPoseLandmark(PoseLandmarkType.rightShoulder);
              p2 = getPoseLandmark(PoseLandmarkType.rightElbow);
              p3 = getPoseLandmark(PoseLandmarkType.rightWrist);
              break;
            case 'lunges':
            case 'burpees':
              // Obtener poses adicionales para zancadas y burpees
              p1 = getPoseLandmark(PoseLandmarkType.rightHip);
              p2 = getPoseLandmark(PoseLandmarkType.rightKnee);
              p3 = getPoseLandmark(PoseLandmarkType.rightAnkle);
              p4 = getPoseLandmark(PoseLandmarkType.rightElbow);
              break;
          }

          // Verificar poses y ángulos para contar repeticiones
          if (p1 != null && p2 != null && p3 != null) {
            double angle1 = utils.angle(p1!, p2!, p3!);
            double? angle2;

            if (p4 != null) {
              angle2 = utils.angle(p2!, p3!, p4!);
            }
            print('Angulo1 ${angle1} Angulo2 ${angle2}');
            final exerciseState = utils.getExerciseState(
                widget.exerciseName, angle1, angle2, bloc.state);

            if (exerciseState != null) {
              if (exerciseState == ExerciseState.init) {
                bloc.setExerciseState(exerciseState);
              } else if (exerciseState == ExerciseState.complete) {
                bloc.incrementRepetition();
                bloc.setExerciseState(ExerciseState.neutral);
                if (bloc.currentExercise != null &&
                    bloc.repetitionCounter >=
                        bloc.currentExercise!.repetitionsPerSeries) {
                  bloc.incrementSeries();
                  bloc.resetRepetitionCounter();
                }
              }
            }
          }
        }
      }
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    _stopLiveFeed();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: _liveFeedBody());
  }

  Widget _liveFeedBody() {
    if (_cameras.isEmpty) return Container();
    if (_controller == null) return Container();
    if (_controller?.value.isInitialized == false) return Container();
    return Container(
      color: Colors.black,
      child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Center(
            child: _changingCameraLens
                ? Center(
                    child: const Text('Changing camera lens'),
                  )
                : CameraPreview(
                    _controller!,
                    child: widget.customPaint,
                  ),
          ),
          _counterWidget(),
          _backButton(),
          _switchLiveCameraToggle(),
          _detectionViewModeToggle(),
          _zoomControl(),
          _exposureControl(),
        ],
      ),
    );
  }

  Widget _counterWidget() {
    final bloc = BlocProvider.of<ExerciseCounter>(context);
    return Positioned(
      left: 0,
      right: 0,
      top: 50,
      child: Container(
        width: 120, // Aumentamos el ancho para acomodar ambos contadores
        child: Column(
          children: [
            const Text(
              'Counter',
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment
                  .spaceEvenly, // Distribuye los elementos equitativamente
              children: [
                _buildCounterItem(
                    'Series', bloc.seriesCounter), // Contador de series
                _buildCounterItem('Repetitions',
                    bloc.repetitionCounter), // Contador de repeticiones
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCounterItem(String label, int value) {
    return Container(
      width: 50, // Ancho del contenedor del contador
      decoration: BoxDecoration(
        color: Colors.black54,
        border: Border.all(color: Colors.white.withOpacity(0.4), width: 4),
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
      child: Column(
        children: [
          Text(
            label,
            style: TextStyle(
                color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          Text(
            '$value',
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
          ),
          /*if (widget.exerciseName == 'plank')
          Text(
            '$_plankTimeCounter',
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
          )
        else
          Text(
            '$value',
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
          ),*/
        ],
      ),
    );
  }

  Widget _backButton() => Positioned(
        top: 40,
        left: 8,
        child: SizedBox(
          height: 50.0,
          width: 50.0,
          child: FloatingActionButton(
            heroTag: Object(),
            onPressed: () {
              Navigator.of(context).pop();
              BlocProvider.of<ExerciseCounter>(context).resetExercise();
            },
            backgroundColor: Colors.black54,
            child: Icon(
              Icons.arrow_back_ios_outlined,
              size: 20,
            ),
          ),
        ),
      );

  Widget _detectionViewModeToggle() => Positioned(
        bottom: 8,
        left: 8,
        child: SizedBox(
          height: 50.0,
          width: 50.0,
          child: FloatingActionButton(
            heroTag: Object(),
            onPressed: widget.onDetectorViewModeChanged,
            backgroundColor: Colors.black54,
            child: Icon(
              Icons.photo_library_outlined,
              size: 25,
            ),
          ),
        ),
      );

  Widget _switchLiveCameraToggle() => Positioned(
        bottom: 8,
        right: 8,
        child: SizedBox(
          height: 50.0,
          width: 50.0,
          child: FloatingActionButton(
            heroTag: Object(),
            onPressed: _switchLiveCamera,
            backgroundColor: Colors.black54,
            child: Icon(
              Platform.isIOS
                  ? Icons.flip_camera_ios_outlined
                  : Icons.flip_camera_android_outlined,
              size: 25,
            ),
          ),
        ),
      );

  Widget _zoomControl() => Positioned(
        bottom: 16,
        left: 0,
        right: 0,
        child: Align(
          alignment: Alignment.bottomCenter,
          child: SizedBox(
            width: 250,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Slider(
                    value: _currentZoomLevel,
                    min: _minAvailableZoom,
                    max: _maxAvailableZoom,
                    activeColor: Colors.white,
                    inactiveColor: Colors.white30,
                    onChanged: (value) async {
                      setState(() {
                        _currentZoomLevel = value;
                      });
                      await _controller?.setZoomLevel(value);
                    },
                  ),
                ),
                Container(
                  width: 50,
                  decoration: BoxDecoration(
                    color: Colors.black54,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: Text(
                        '${_currentZoomLevel.toStringAsFixed(1)}x',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );

  Widget _exposureControl() => Positioned(
        top: 40,
        right: 8,
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: 250,
          ),
          child: Column(children: [
            Container(
              width: 55,
              decoration: BoxDecoration(
                color: Colors.black54,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Text(
                    '${_currentExposureOffset.toStringAsFixed(1)}x',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
            Expanded(
              child: RotatedBox(
                quarterTurns: 3,
                child: SizedBox(
                  height: 30,
                  child: Slider(
                    value: _currentExposureOffset,
                    min: _minAvailableExposureOffset,
                    max: _maxAvailableExposureOffset,
                    activeColor: Colors.white,
                    inactiveColor: Colors.white30,
                    onChanged: (value) async {
                      setState(() {
                        _currentExposureOffset = value;
                      });
                      await _controller?.setExposureOffset(value);
                    },
                  ),
                ),
              ),
            )
          ]),
        ),
      );

  Future _startLiveFeed() async {
    final camera = _cameras[_cameraIndex];
    _controller = CameraController(
      camera,
      // Set to ResolutionPreset.high. Do NOT set it to ResolutionPreset.max because for some phones does NOT work.
      ResolutionPreset.high,
      enableAudio: false,
      imageFormatGroup: Platform.isAndroid
          ? ImageFormatGroup.nv21
          : ImageFormatGroup.bgra8888,
    );
    _controller?.initialize().then((_) {
      if (!mounted) {
        return;
      }
      _controller?.getMinZoomLevel().then((value) {
        _currentZoomLevel = value;
        _minAvailableZoom = value;
      });
      _controller?.getMaxZoomLevel().then((value) {
        _maxAvailableZoom = value;
      });
      _currentExposureOffset = 0.0;
      _controller?.getMinExposureOffset().then((value) {
        _minAvailableExposureOffset = value;
      });
      _controller?.getMaxExposureOffset().then((value) {
        _maxAvailableExposureOffset = value;
      });
      _controller?.startImageStream(_processCameraImage).then((value) {
        if (widget.onCameraFeedReady != null) {
          widget.onCameraFeedReady!();
        }
        if (widget.onCameraLensDirectionChanged != null) {
          widget.onCameraLensDirectionChanged!(camera.lensDirection);
        }
      });
      setState(() {});
    });
  }

  Future _stopLiveFeed() async {
    await _controller?.stopImageStream();
    await _controller?.dispose();
    _controller = null;
  }

  Future _switchLiveCamera() async {
    setState(() => _changingCameraLens = true);
    _cameraIndex = (_cameraIndex + 1) % _cameras.length;

    await _stopLiveFeed();
    await _startLiveFeed();
    setState(() => _changingCameraLens = false);
  }

  void _processCameraImage(CameraImage image) {
    final inputImage = _inputImageFromCameraImage(image);
    if (inputImage == null) return;
    widget.onImage(inputImage);
  }

  final _orientations = {
    DeviceOrientation.portraitUp: 0,
    DeviceOrientation.landscapeLeft: 90,
    DeviceOrientation.portraitDown: 180,
    DeviceOrientation.landscapeRight: 270,
  };

  InputImage? _inputImageFromCameraImage(CameraImage image) {
    if (_controller == null) return null;

    // get image rotation
    // it is used in android to convert the InputImage from Dart to Java: https://github.com/flutter-ml/google_ml_kit_flutter/blob/master/packages/google_mlkit_commons/android/src/main/java/com/google_mlkit_commons/InputImageConverter.java
    // `rotation` is not used in iOS to convert the InputImage from Dart to Obj-C: https://github.com/flutter-ml/google_ml_kit_flutter/blob/master/packages/google_mlkit_commons/ios/Classes/MLKVisionImage%2BFlutterPlugin.m
    // in both platforms `rotation` and `camera.lensDirection` can be used to compensate `x` and `y` coordinates on a canvas: https://github.com/flutter-ml/google_ml_kit_flutter/blob/master/packages/example/lib/vision_detector_views/painters/coordinates_translator.dart
    final camera = _cameras[_cameraIndex];
    final sensorOrientation = camera.sensorOrientation;
    // print(
    //     'lensDirection: ${camera.lensDirection}, sensorOrientation: $sensorOrientation, ${_controller?.value.deviceOrientation} ${_controller?.value.lockedCaptureOrientation} ${_controller?.value.isCaptureOrientationLocked}');
    InputImageRotation? rotation;
    if (Platform.isIOS) {
      rotation = InputImageRotationValue.fromRawValue(sensorOrientation);
    } else if (Platform.isAndroid) {
      var rotationCompensation =
          _orientations[_controller!.value.deviceOrientation];
      if (rotationCompensation == null) return null;
      if (camera.lensDirection == CameraLensDirection.front) {
        // front-facing
        rotationCompensation = (sensorOrientation + rotationCompensation) % 360;
      } else {
        // back-facing
        rotationCompensation =
            (sensorOrientation - rotationCompensation + 360) % 360;
      }
      rotation = InputImageRotationValue.fromRawValue(rotationCompensation);
      // print('rotationCompensation: $rotationCompensation');
    }
    if (rotation == null) return null;
    // print('final rotation: $rotation');

    // get image format
    final format = InputImageFormatValue.fromRawValue(image.format.raw);
    // validate format depending on platform
    // only supported formats:
    // * nv21 for Android
    // * bgra8888 for iOS
    if (format == null ||
        (Platform.isAndroid && format != InputImageFormat.nv21) ||
        (Platform.isIOS && format != InputImageFormat.bgra8888)) return null;

    // since format is constraint to nv21 or bgra8888, both only have one plane
    if (image.planes.length != 1) return null;
    final plane = image.planes.first;

    // compose InputImage using bytes
    return InputImage.fromBytes(
      bytes: plane.bytes,
      metadata: InputImageMetadata(
        size: Size(image.width.toDouble(), image.height.toDouble()),
        rotation: rotation, // used only in Android
        format: format, // used only in iOS
        bytesPerRow: plane.bytesPerRow, // used only in iOS
      ),
    );
  }
}
