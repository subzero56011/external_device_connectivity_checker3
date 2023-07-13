import 'package:bloc/bloc.dart';
import 'package:easacc_task_final/cubit/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easacc_task_final/components/defaultText.dart';
import 'package:easacc_task_final/cubit/cubit.dart';
import 'package:easacc_task_final/cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'dart:async';
import 'package:camera/camera.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:async';

class CheckerCubit extends Cubit<CheckerStates> {
  CheckerCubit() : super(CheckerInitialState());

  static CheckerCubit get(context) => BlocProvider.of(context);

  bool isPrinterConnected = false;
  bool isCameraConnected = false;

  cameraConnectionTest() async {
    // the camera related function that tests if the available camera is found and make its variable true

    // bool isCameraConnected = false;

    emit(LoadingState());

    try {
      var camera = await availableCameras().then((value) {
        isCameraConnected = true;
        emit(CameraSuccessState());

        print('camera is connected');
      }).catchError((error) {
        emit(CameraFailState());
        isCameraConnected = false;
        print(error.toString());
      });
    } catch (e) {
      emit(CameraFailState());

      isCameraConnected = false;
      print(e);
      print(e.toString());
      print('an error got caught');
    }
  }

  printerConnectionTest() async {
    FlutterBlue flutterBlue = FlutterBlue.instance;
    // bool isPrinterConnected = false;

    try {
      emit(LoadingState());
      final printers = flutterBlue.scan(timeout: const Duration(seconds: 2));
      printers.forEach((printer) async {
        if (printer.device.name.isNotEmpty) {
          emit(PrinterSuccessState());
          isPrinterConnected = true;
          print('printer is connected');
        } else {
          emit(PrinterFailState());

          isPrinterConnected = false;
          print('printer is not connected');
        }
      });
    } catch (e) {
      emit(PrinterFailState());
      isPrinterConnected = false;
      print(e);
      print(e.toString());
      print('an error got caught');
    }
  }
}
