import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:print_test_3/printer.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:screenshot/screenshot.dart';
import 'package:esc_pos_printer/esc_pos_printer.dart';
import 'package:esc_pos_utils/esc_pos_utils.dart';
import 'dart:io';
import 'ImagestorByte.dart';
import 'widgets/mycustomtextbox.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  ScreenshotController screenshotController = ScreenshotController();
  String dir = Directory.current.path;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // print(dir);
    // setState(() {
    //   Process.run('$dir/images/installerX64/install.exe', [' start '])
    //       .then((ProcessResult results) {
    //     print(results.stdout);
    //   });
    // });
  }

  void testPrint(String printerIp, Uint8List theimageThatComesfr) async {
    print("im inside the test print 2");
    // TODO Don't forget to choose printer's paper size
    const PaperSize paper = PaperSize.mm58;

    final profile = await CapabilityProfile.load();
    final printer = NetworkPrinter(paper, profile);

    final PosPrintResult res = await printer.connect(printerIp, port: 9100);

    if (res == PosPrintResult.success) {
      // DEMO RECEIPT
      await testReceipt(printer, theimageThatComesfr);
      print(res.msg);
      await Future.delayed(const Duration(seconds: 3), () {
        print("prinnter desconect");
        printer.disconnect();
      });
    }
  }

  TextEditingController Printer = TextEditingController(text: "192.168.1.198");
  TextEditingController qrController1 = TextEditingController();
  TextEditingController qrController2 = TextEditingController();
  TextEditingController qrController3 = TextEditingController();

  Future<dynamic> ShowCapturedWidget(
      BuildContext context, Uint8List capturedImage) {
    return showDialog(
      useSafeArea: false,
      context: context,
      builder: (context) => Scaffold(
        appBar: AppBar(
          title: Text("Captured widget screenshot"),
        ),
        body: Center(
            child: capturedImage != null
                ? Image.memory(capturedImage)
                : Container()),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Network Printer Test"),
      ),
      body: Center(
          child: ListView(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 20,
              ),
              MyCustomTextBox(
                hintText: "Printer IP",
                textBoxController: Printer,
                inputAction: TextInputAction.next,
              ),
              const SizedBox(
                height: 10,
              ),
              MyCustomTextBox(
                hintText: "QR 1",
                textBoxController: qrController1,
                inputAction: TextInputAction.next,
              ),
              const SizedBox(
                height: 10,
              ),
              MyCustomTextBox(
                hintText: "QR 2",
                textBoxController: qrController2,
                inputAction: TextInputAction.next,
              ),
              const SizedBox(
                height: 10,
              ),
              MyCustomTextBox(
                hintText: "QR 3",
                textBoxController: qrController3,
                inputAction: TextInputAction.done,
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.5,
                height: MediaQuery.of(context).size.height * 0.06,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: Color(0xFF143d54)),
                  child: const Text(
                    'Print',
                    style: TextStyle(fontSize: 25),
                  ),
                  onPressed: () {
                    screenshotController
                        .captureFromWidget(
                            InheritedTheme.captureAll(
                                context,
                                Material(
                                  child: Column(children: [
                                    Text("data"),
                                    Text("data"),
                                    Text("data"),
                                    Text("data"),
                                  ],)
                                  /*
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width * 0.9,
                                    height: MediaQuery.of(context).size.height *
                                        0.2,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Column(
                                          children: [
                                            Text(
                                              "QR 1",
                                              style: TextStyle(
                                                  fontSize:
                                                      MediaQuery.of(context)
                                                              .size
                                                              .width *
                                                          0.05),
                                            ),
                                            QrImage(
                                              data: qrController1.text,
                                              version: QrVersions.auto,
                                              size: 100,
                                              gapless: false,
                                            )
                                          ],
                                        ),
                                        Column(
                                          children: [
                                            Text(
                                              "QR 2",
                                              style: TextStyle(
                                                  fontSize:
                                                      MediaQuery.of(context)
                                                              .size
                                                              .width *
                                                          0.05),
                                            ),
                                            QrImage(
                                              data: qrController2.text,
                                              version: QrVersions.auto,
                                              size: 100,
                                              gapless: false,
                                            )
                                          ],
                                        ),
                                        Column(
                                          children: [
                                            Text(
                                              "QR 3",
                                              style: TextStyle(
                                                  fontSize:
                                                      MediaQuery.of(context)
                                                              .size
                                                              .width *
                                                          0.05),
                                            ),
                                            QrImage(
                                              data: qrController3.text,
                                              version: QrVersions.auto,
                                              size: 100,
                                              gapless: false,
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  */
                                )),
                            delay: Duration(seconds: 1))
                        .then((capturedImage) async {
                      setState(() {
                        theimageThatComesfromThePrinter = capturedImage;

                        //show captured widget
                        ShowCapturedWidget(
                            context, theimageThatComesfromThePrinter);
                        //Print Widget
                        testPrint(
                            Printer.text, theimageThatComesfromThePrinter);
                      });
                    }).catchError((onError) {
                      print(onError);
                    });
                  },
                ),
              ),
              Divider(
                color: Colors.transparent,
                height: 20,
              ),
              /*
              Card(
                elevation: 20,
                child: Screenshot(
                    child: FlutterLogo(size: 200),
                    controller: screenshotController),
              ),
              */
            ],
          ),
        ],
      )),
    );
  }
}


/*

Container(
                      width: MediaQuery.of(context).size.width * 0.9,
                      height: MediaQuery.of(context).size.height * 0.2,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            children: [
                              Text(
                                "QR 1",
                                style: TextStyle(
                                    fontSize:
                                        MediaQuery.of(context).size.width *
                                            0.05),
                              ),
                              QrImage(
                                data: qrController1.text,
                                version: QrVersions.auto,
                                size: 100,
                                gapless: false,
                              )
                            ],
                          ),
                          Column(
                            children: [
                              Text(
                                "QR 2",
                                style: TextStyle(
                                    fontSize:
                                        MediaQuery.of(context).size.width *
                                            0.05),
                              ),
                              QrImage(
                                data: qrController2.text,
                                version: QrVersions.auto,
                                size: 100,
                                gapless: false,
                              )
                            ],
                          ),
                          Column(
                            children: [
                              Text(
                                "QR 3",
                                style: TextStyle(
                                    fontSize:
                                        MediaQuery.of(context).size.width *
                                            0.05),
                              ),
                              QrImage(
                                data: qrController3.text,
                                version: QrVersions.auto,
                                size: 100,
                                gapless: false,
                              )
                            ],
                          ),
                        ],
                      ),
                    ),

*/

/*

.capture(delay: const Duration(milliseconds: 10))
                        .then((capturedImage) async {
                      setState(() {
                        theimageThatComesfromThePrinter = capturedImage!;
                        theimageThatComesfromThePrinter = capturedImage;
                        testPrint(
                            Printer.text, theimageThatComesfromThePrinter);
                      });
                    }).catchError((onError) {
                      print(onError);
                    });

*/