import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:inventory/models/product.dart';
import 'package:inventory/modul/input/input_qr_screen.dart';
import 'package:inventory/utils/db.dart';
import 'package:cool_alert/cool_alert.dart';

class PreviewAddInventory extends StatefulWidget{
  PreviewAddInventory({required this.product,super.key});

  Product product;

  @override
  State<StatefulWidget> createState() {
    return _PreviewAddInventory();
  }
}

class _PreviewAddInventory extends State<PreviewAddInventory>{

  TextEditingController deviceName = TextEditingController();
  TextEditingController deviceLocation = TextEditingController();
  TextEditingController deviceType = TextEditingController();
  TextEditingController deviceId = TextEditingController();
  TextEditingController status = TextEditingController();
  List _listStatus = ["Good","Repair"];
  String? _valStatus ;



  @override
  void initState() {

    //set first value
    deviceId.text = widget.product.deviceId.toString();
    deviceName.text = widget.product.deviceName;
    deviceType.text = widget.product.deviceType;
    deviceLocation.text = widget.product.deviceLocation;
    _valStatus = widget.product.status;
    super.initState();
  }





  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          title: Text("Add Item QR"),
          backgroundColor: Color(0xFF21899C),
        ),
        body:SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(30),
          child: Column(children: [

            deviceIdTextField(size),
            const SizedBox(
              height: 25,
            ),
            deviceNameTextField(size),
            const SizedBox(
              height: 25,
            ),
            deviceTypeTextField(size),
            const SizedBox(
              height: 25,
            ),
            deviceLocationTextField(size),
            const SizedBox(
              height: 25,
            ),
            deviceStatusTextField(size),
            const SizedBox(
              height: 30,
            ),


            submitButton(size)


          ],),
        ),
        ),

    );

  }


  Widget submitButton(Size size) {


    return GestureDetector(
      onTap: () async{
        //Tap

        Product prod = Product(
            int.parse(deviceId.text),
            deviceName.text,
            deviceType.text,
            deviceLocation.text,
            _valStatus!);




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





      },
      child:Container(
        alignment: Alignment.center,
        height: size.height / 13,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
          color: const Color(0xFF21899C),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF4C2E84).withOpacity(0.2),
              offset: const Offset(0, 15.0),
              blurRadius: 60.0,
            ),
          ],
        ),
        child: Text(
          'Submit',
          style: GoogleFonts.inter(
            fontSize: 16.0,
            color: Colors.white,
            fontWeight: FontWeight.w600,
            height: 1.5,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }


  //Device Id
  Widget deviceIdTextField(Size size) {
    return SizedBox(
      height: size.height / 10,
      child: TextFormField(
        controller: deviceId,
        style: GoogleFonts.inter(
          fontSize: 16.0,
          color: const Color(0xFF151624),
        ),
        maxLines: 1,
        keyboardType: TextInputType.number,
        maxLength: 16,
        cursorColor: const Color(0xFF151624),
        decoration: InputDecoration(
          hintText: 'Device Id',
          labelText: 'Device Id',
          hintStyle: GoogleFonts.inter(
            fontSize: 12.0,
            color: const Color(0xFF151624).withOpacity(0.5),
          ),
          fillColor: deviceId.text.isNotEmpty
              ? Colors.transparent
              : const Color.fromRGBO(248, 247, 251, 1),
          filled: true,
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(
                color: deviceId.text.isEmpty
                    ? Colors.transparent
                    : const Color.fromRGBO(44, 185, 176, 1),
              )),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: const BorderSide(
                color: Color.fromRGBO(44, 185, 176, 1),
              )),

          suffix: Container(
            alignment: Alignment.center,
            width: 24.0,
            height: 24.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100.0),
              color: const Color.fromRGBO(44, 185, 176, 1),
            ),
            child: deviceId.text.isEmpty
                ? const Center()
                : const Icon(
              Icons.check,
              color: Colors.white,
              size: 13,
            ),
          ),
        ),
      ),
    );
  }


  //Device Name
  Widget deviceNameTextField(Size size) {
    return SizedBox(
      height: size.height / 12,
      child: TextField(
        controller: deviceName,
        style: GoogleFonts.inter(
          fontSize: 16.0,
          color: const Color(0xFF151624),
        ),
        maxLines: 1,

        cursorColor: const Color(0xFF151624),
        decoration: InputDecoration(
          hintText: 'Device Name',
          labelText: 'Device Name',
          hintStyle: GoogleFonts.inter(
            fontSize: 12.0,
            color: const Color(0xFF151624).withOpacity(0.5),
          ),
          fillColor: deviceName.text.isNotEmpty
              ? Colors.transparent
              : const Color.fromRGBO(248, 247, 251, 1),
          filled: true,
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(
                color: deviceName.text.isEmpty
                    ? Colors.transparent
                    : const Color.fromRGBO(44, 185, 176, 1),
              )),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: const BorderSide(
                color: Color.fromRGBO(44, 185, 176, 1),
              )),

          suffix: Container(
            alignment: Alignment.center,
            width: 24.0,
            height: 24.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100.0),
              color: const Color.fromRGBO(44, 185, 176, 1),
            ),
            child: deviceName.text.isEmpty
                ? const Center()
                : const Icon(
              Icons.check,
              color: Colors.white,
              size: 13,
            ),
          ),
        ),
      ),
    );
  }


  //Device Type
  Widget deviceTypeTextField(Size size) {
    return SizedBox(
      height: size.height / 12,
      child: TextField(
        controller: deviceType,
        style: GoogleFonts.inter(
          fontSize: 16.0,
          color: const Color(0xFF151624),
        ),
        maxLines: 1,
        cursorColor: const Color(0xFF151624),
        decoration: InputDecoration(
          hintText: 'Device Type',
          labelText: 'Device Type',
          hintStyle: GoogleFonts.inter(
            fontSize: 12.0,
            color: const Color(0xFF151624).withOpacity(0.5),
          ),
          fillColor: deviceType.text.isNotEmpty
              ? Colors.transparent
              : const Color.fromRGBO(248, 247, 251, 1),
          filled: true,
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(
                color: deviceType.text.isEmpty
                    ? Colors.transparent
                    : const Color.fromRGBO(44, 185, 176, 1),
              )),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: const BorderSide(
                color: Color.fromRGBO(44, 185, 176, 1),
              )),

          suffix: Container(
            alignment: Alignment.center,
            width: 24.0,
            height: 24.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100.0),
              color: const Color.fromRGBO(44, 185, 176, 1),
            ),
            child: deviceType.text.isEmpty
                ? const Center()
                : const Icon(
              Icons.check,
              color: Colors.white,
              size: 13,
            ),
          ),
        ),
      ),
    );
  }


  //Device Location
  Widget deviceLocationTextField(Size size) {
    return SizedBox(
      height: size.height / 12,
      child: TextField(
        controller: deviceLocation,
        style: GoogleFonts.inter(
          fontSize: 16.0,
          color: const Color(0xFF151624),
        ),
        maxLines: 1,
        cursorColor: const Color(0xFF151624),
        decoration: InputDecoration(
          hintText: 'Device Location',
          labelText: 'Device Location',
          hintStyle: GoogleFonts.inter(
            fontSize: 12.0,
            color: const Color(0xFF151624).withOpacity(0.5),
          ),
          fillColor: deviceLocation.text.isNotEmpty
              ? Colors.transparent
              : const Color.fromRGBO(248, 247, 251, 1),
          filled: true,
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(
                color: deviceLocation.text.isEmpty
                    ? Colors.transparent
                    : const Color.fromRGBO(44, 185, 176, 1),
              )),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: const BorderSide(
                color: Color.fromRGBO(44, 185, 176, 1),
              )),

          suffix: Container(
            alignment: Alignment.center,
            width: 24.0,
            height: 24.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100.0),
              color: const Color.fromRGBO(44, 185, 176, 1),
            ),
            child: deviceLocation.text.isEmpty
                ? const Center()
                : const Icon(
              Icons.check,
              color: Colors.white,
              size: 13,
            ),
          ),
        ),
      ),
    );
  }


  //Device Location
  Widget deviceStatusTextField(Size size) {
    return SizedBox(
      height: size.height / 12,
      child: DropdownButtonFormField(
        decoration: InputDecoration(
          labelText: "Device Status",
          hintText: "Device Status",
          hintStyle: GoogleFonts.inter(
            fontSize: 16.0,
            color: const Color(0xFF151624).withOpacity(0.5),
          ),
          fillColor: deviceLocation.text.isNotEmpty
              ? Colors.transparent
              : const Color.fromRGBO(248, 247, 251, 1),
          filled: true,
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(
                color: deviceLocation.text.isEmpty
                    ? Colors.transparent
                    : const Color.fromRGBO(44, 185, 176, 1),
              )),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: const BorderSide(
                color: Color.fromRGBO(44, 185, 176, 1),
              )),

          suffix: Container(
            alignment: Alignment.center,
            width: 24.0,
            height: 24.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100.0),
              color: const Color.fromRGBO(44, 185, 176, 1),
            ),
            child: deviceLocation.text.isEmpty
                ? const Center()
                : const Icon(
              Icons.check,
              color: Colors.white,
              size: 13,
            ),
          ),
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
    );
  }




}