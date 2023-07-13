import 'package:easacc_task_final/components/defaultText.dart';
import 'package:easacc_task_final/cubit/cubit.dart';
import 'package:easacc_task_final/cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'dart:async';
import 'package:camera/camera.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
  //the two variables that gonna tell us whether the specific device is connected

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => CheckerCubit(),
      child: BlocConsumer<CheckerCubit, CheckerStates>(
        listener: (context, state) {
          if (state is LoadingState) {
            print('loading');
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: Text(widget.title),
            ),
            //webview package specified link that shows and function in the app
            body: const WebView(initialUrl: 'https://instagram.com'),

            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //   children: [
            //     Center(
            //       child: ElevatedButton(
            //         onPressed: (() {}),
            //         child: Text('Login'),
            //         style: ButtonStyle(
            //           backgroundColor: MaterialStateProperty.all(Colors.blue),
            //         ),
            //       ),
            //     ),
            //   ],
            // ),
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
                          if (CheckerCubit.get(context).isCameraConnected)
                            const DefaultText(
                              text: 'Camera is connected',
                              icon: Icons.check,
                            ),
                          if (!CheckerCubit.get(context).isCameraConnected)
                            const DefaultText(
                              text: 'Camera is\'nt connected',
                              icon: Icons.not_interested,
                            ),
                          const Spacer(),
                          if (CheckerCubit.get(context).isPrinterConnected)
                            const DefaultText(
                              text: 'Printer is connected',
                              icon: Icons.check,
                            ),
                          if (!CheckerCubit.get(context).isPrinterConnected)
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
                      //making an object of the cubit class and calling the desired method
                      onPressed: () =>
                          CheckerCubit.get(context).cameraConnectionTest(),

                      tooltip: 'checks if the camera is connected',
                      elevation: 12,
                      child: const Icon(Icons.camera_alt),
                    ),
                    const Spacer(),
                    FloatingActionButton(
                      onPressed: () =>
                          CheckerCubit.get(context).printerConnectionTest(),
                      tooltip: 'checks if the printer is connected',
                      elevation: 12,
                      child: const Icon(Icons.print),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
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
