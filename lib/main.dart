import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:print_test_3/printer.dart';
import 'package:qr_flutter/qr_flutter.dart';

import 'package:screenshot/screenshot.dart';
import 'package:esc_pos_printer/esc_pos_printer.dart';
import 'package:esc_pos_utils/esc_pos_utils.dart';
import 'dart:io';

import 'ImagestorByte.dart';

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
    const PaperSize paper = PaperSize.mm80;
    PaperSize kagit = PaperSize.mm58;
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

  TextEditingController Printer = TextEditingController(text: "192.168.1.19");
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
              TextField(
                controller: Printer,
                decoration: const InputDecoration(hintText: "printer ip"),
              ),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton(
                child: const Text(
                  'Yazdır',
                  style: TextStyle(fontSize: 40),
                ),
                onPressed: () {
                  screenshotController
                      .capture(delay: const Duration(milliseconds: 10))
                      .then((capturedImage) async {
                    setState(() {
                      theimageThatComesfromThePrinter = capturedImage!;
                      theimageThatComesfromThePrinter = capturedImage;
                      testPrint(Printer.text, theimageThatComesfromThePrinter);
                    });
                  }).catchError((onError) {
                    print(onError);
                  });
                },
              ),
              Divider(
                color: Colors.transparent,
                height: 20,
              ),
              Screenshot(child: Text("AASDFA"), controller: screenshotController),
            ],
          ),
        ],
      )),
    );
  }
}

/*

Screenshot(
                controller: screenshotController,
                child: Container(

                  color: Colors.yellowAccent,
                  width: MediaQuery.of(context).size.width*0.95,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                          Text("Bilgi 1"),
                          QrImage(
                            data: 'Bilgi123456789',
                            version: QrVersions.auto,
                            size: 100,
                            gapless: false,
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Text("Bilgi 2"),
                          QrImage(
                            data: 'Bilgi 2',
                            version: QrVersions.auto,
                            size: 100,
                            gapless: false,
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Text("Bilgi 3"),
                          QrImage(
                            data: 'Bilgi 3',
                            version: QrVersions.auto,
                            size: 100,
                            gapless: false,
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),

*/