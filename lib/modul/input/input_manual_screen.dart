import 'package:flutter/material.dart';
import 'package:inventory/models/product.dart';
import 'package:inventory/utils/db.dart';

class AddInventory extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _AddInventory();
  }
}

class _AddInventory extends State<AddInventory>{

  TextEditingController deviceName = TextEditingController();
  TextEditingController deviceLocation = TextEditingController();
  TextEditingController deviceType = TextEditingController();
  TextEditingController deviceId = TextEditingController();
  TextEditingController status = TextEditingController();



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
        body:Container(
          padding: EdgeInsets.all(30),
          child: Column(children: [
            TextField(
              controller: deviceId,
              decoration: InputDecoration(
                hintText: "Device Id",
              ),
            ),
            TextField(
              controller: deviceName,
              decoration: InputDecoration(
                hintText: "Device Name",
              ),
            ),

            TextField(
              controller: deviceType,
              decoration: InputDecoration(
                hintText: "Device Type",
              ),
            ),

            TextField(
              controller: deviceLocation,
              decoration: InputDecoration(
                hintText: "Device Location",
              ),
            ),

            ElevatedButton(onPressed: (){
              
              Product prod = Product(
                  int.parse(deviceId.text), 
                  deviceName.text,
                  deviceType.text, 
                  deviceLocation.text, 
                  status.text);


              MyDb.db.addProductToDatabase(prod);

              // mydb.db.rawInsert("INSERT INTO students (name, roll_no, address) VALUES (?, ?, ?);",
              //     [name.text, rollno.text, address.text]);
              //
              // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("New Student Added")));
              //
              // name.text = "";
              // rollno.text = "";
              // address.text = "";

            }, child: Text("Save Data")),
          ],),
        )
    );
  }
}