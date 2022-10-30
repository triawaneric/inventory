import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:inventory/models/product.dart';
import 'package:inventory/modul/input/preview_input_qr_screen.dart';
import 'package:inventory/utils/db.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class AddInventoryQR extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _AddInventoryQR();
  }
}

class _AddInventoryQR extends State<AddInventoryQR>{

  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  QRViewController? controller;

  TextEditingController deviceName = TextEditingController();
  TextEditingController deviceLocation = TextEditingController();
  TextEditingController deviceType = TextEditingController();
  TextEditingController deviceId = TextEditingController();
  TextEditingController status = TextEditingController();
  List _listStatus = ["Good","Repair"];
  String? _valStatus ;

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    } else if (Platform.isIOS) {
      controller!.resumeCamera();
    }
  }




  @override
  void initState() {
    // MyDb.dbs.open();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Item"),
      ),
      body: Column(
        children: <Widget>[
          Expanded(

            child: QRView(
              key: qrKey,
              onQRViewCreated: _onQRViewCreated,
            ),
          ),

        ],
      ),
    );


  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) async  {
      // final datajson = scanData.code;
      // final parsedJson = jsonDecode(datajson!);

      Product product = Product(
          167788888,
          "parsedJson",
          "parsedJson",
          "parsedJson",
          "good");

      Navigator.push(context, MaterialPageRoute(builder: (context) => PreviewAddInventory(product:product,)));

     // print(parsedJson.toString());
      setState(() {
        result = scanData;
      });
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}