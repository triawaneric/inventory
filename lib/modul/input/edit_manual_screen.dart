import 'package:flutter/material.dart';
import 'package:inventory/models/product.dart';
import 'package:inventory/modul/input/input_qr_screen.dart';
import 'package:inventory/utils/db.dart';
import 'package:cool_alert/cool_alert.dart';

class EditInventory extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _EditInventory();
  }
}

class _EditInventory extends State<EditInventory>{

  TextEditingController deviceName = TextEditingController();
  TextEditingController deviceLocation = TextEditingController();
  TextEditingController deviceType = TextEditingController();
  TextEditingController deviceId = TextEditingController();
  TextEditingController status = TextEditingController();
  List _listStatus = ["Good","Repair"];
  String? _valStatus ;



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
        body:SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(30),
          child: Column(children: [
            TextFormField(

              validator: (value) => value!.isEmpty ? 'Device Id cant be empty':null,
              controller: deviceId,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "Device Id",
                hintText: "Device Id",
              ),
            ),
            TextFormField(
              validator: (value) => value!.isEmpty ? 'Device Name cant be empty':null,
              controller: deviceName,
              decoration: InputDecoration(
                labelText: "Device Name",
                hintText: "Device Name",
              ),
            ),

            TextFormField(
              validator: (value) => value!.isEmpty ? 'Device Type cant be empty':null,
              controller: deviceType,
              decoration: InputDecoration(
                labelText: "Device Type",
                hintText: "Device Type",
              ),
            ),

            TextFormField(
              validator: (value) => value!.isEmpty ? 'Device Location cant be empty':null,
              controller: deviceLocation,
              decoration: InputDecoration(
                labelText: "Device Location",
                hintText: "Device Location",
              ),
            ),
            DropdownButtonFormField(


              decoration: InputDecoration(
                labelText: "Device Status",
                hintText: "Device Status",
              ),
              value: _valStatus,
              items: _listStatus.map((value) {
                return DropdownMenuItem(
                  child: Text(value),
                  value: value,
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _valStatus = value as String?;
                });
              },
            ),

            ElevatedButton(onPressed: () async {
              
              Product prod = Product(
                  int.parse(deviceId.text), 
                  deviceName.text,
                  deviceType.text, 
                  deviceLocation.text, 
                  status.text);




              await MyDb.db.addProductToDatabase(prod);
              deviceId.clear();
              deviceName.clear();
              deviceType.clear();
              deviceLocation.clear();
              status.clear();
              CoolAlert.show(
                context: context,
                type: CoolAlertType.success,
                text: 'Transaction completed successfully!',
                autoCloseDuration: const Duration(seconds: 2),
              );




            }, child: Text("Save Data")),
          ],),
        ),
        ),

    );
  }
}