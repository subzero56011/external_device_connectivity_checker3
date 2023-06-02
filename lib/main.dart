import 'package:easacc_task_final/components/defaultText.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'dart:async';
import 'package:camera/camera.dart';
import 'package:flutter_blue/flutter_blue.dart';

void main() async {
  // Ensure that cameras are initialized
  WidgetsFlutterBinding.ensureInitialized();
  final cameras = await availableCameras();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Device connection tester',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Device connection tester'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _isPrinterConnected = false;
  bool _isCameraConnected = false;
  //the two variables that gonna tell us whether the specific device is connected

  Future<void> _cameraConnectionTest() async {
    // the camera related function that tests if the available camera is found and make its variable true

    // bool isCameraConnected = false;
    try {
      var camera = await availableCameras().then((value) {
        setState(() {
          _isCameraConnected = true;
        });
        print('camera is connected');
      }).catchError((error) {
        _isCameraConnected = false;
        print(error.toString());
      });
    } catch (e) {
      _isCameraConnected = false;
      print(e);
      print(e.toString());
      print('an error got caught');
    }
  }

  Future<void> _printerConnectionTest() async {
    FlutterBlue flutterBlue = FlutterBlue.instance;
    // bool isPrinterConnected = false;

    try {
      final printers = flutterBlue.scan(timeout: const Duration(seconds: 2));
      printers.forEach((printer) async {
        if (printer.device.name.isNotEmpty) {
          _isPrinterConnected = true;
          print('printer is connected');
        } else {
          _isPrinterConnected = false;
          print('printer is not connected');
        }
      });
    } catch (e) {
      _isPrinterConnected = false;
      print(e);
      print(e.toString());
      print('an error got caught');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      //webview package specified link that shows and function in the app
      body: const WebView(initialUrl: 'https://google.com'),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: [
              BoxShadow(
                color: Colors.blue,
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: BottomAppBar(
            color: Colors.white,
            child: Container(
              height: 230.0,
              child: Padding(
                padding: const EdgeInsets.all(50.0),
                child: Column(
                  children: [
                    //by using the reusable widget and simple if conditions i managed to bring up the
                    if (_isCameraConnected)
                      const DefaultText(
                        text: 'Camera is connected',
                        icon: Icons.check,
                      ),
                    if (!_isCameraConnected)
                      const DefaultText(
                        text: 'Camera is\'nt connected',
                        icon: Icons.not_interested,
                      ),
                    const Spacer(),
                    if (_isPrinterConnected)
                      const DefaultText(
                        text: 'Printer is connected',
                        icon: Icons.check,
                      ),
                    if (!_isPrinterConnected)
                      const DefaultText(
                        text: 'Printer is\'nt connected',
                        icon: Icons.not_interested,
                      ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: Transform.scale(
        scale: 1.4,
        child: Container(
          padding: const EdgeInsets.all(70),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const SizedBox(
                width: 30,
              ),
              FloatingActionButton(
                onPressed: _cameraConnectionTest,
                tooltip: 'checks if the camera is connected',
                elevation: 12,
                child: const Icon(Icons.camera_alt),
              ),
              const Spacer(),
              FloatingActionButton(
                onPressed: _printerConnectionTest,
                tooltip: 'checks if the printer is connected',
                elevation: 12,
                child: const Icon(Icons.print),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// void _printerConnectionTest() async {
//   bool isConnected = false;
//   try {
//     CapabilityPr
//     var printer = await availableCameras().then((value) {
//       isConnected = true;
//       print('printer is connected');
//     }).catchError((error) {
//       print(error.toString());
//     });
//   } catch (e) {
//     print(e);
//     print(e.toString());
//     print('an error got caught');
//   }
//   setState(() {
//     _isPrinterConnected = isConnected;
//   });
// }
