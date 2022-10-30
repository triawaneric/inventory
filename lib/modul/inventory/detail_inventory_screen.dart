import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:inventory/models/product.dart';
import 'package:inventory/modul/input/input_qr_screen.dart';
import 'package:inventory/utils/db.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';

class DetailInventory extends StatefulWidget{
  DetailInventory({required this.product,super.key});

  Product product;

  @override
  State<StatefulWidget> createState() {
    return _DetailInventory();
  }

}

class _DetailInventory extends State<DetailInventory>{

  List<Product> slist = [];
  bool _isEditable = false;
  List<int> _searchIndexList = [];

  TextEditingController deviceName = TextEditingController();
  TextEditingController deviceLocation = TextEditingController();
  TextEditingController deviceType = TextEditingController();
  TextEditingController deviceId = TextEditingController();
  TextEditingController status = TextEditingController();
  List _listStatus = ["Good","Repair"];
  String? _valStatus ;






  @override
  void initState() {
    getdata();

    //set first value
    deviceId.text = widget.product.deviceId.toString();
    deviceName.text = widget.product.deviceName;
    deviceType.text = widget.product.deviceType;
    deviceLocation.text = widget.product.deviceLocation;
    _valStatus = widget.product.status;
    super.initState();
  }

  getdata(){
    Future.delayed(Duration(milliseconds: 500),() async {
      slist = await MyDb.db.getAllProducts();
      print('data list :'+slist.length.toString());
      setState(() { });
    });
  }

  Widget _defaultDetailScreen(Size size) {

    return Column(
      children: [
        //


        //


        //
      ],
    );

  }


  Widget _editableDetailScreen(Size size) {

    return Container(
        padding: EdgeInsets.all(20),

        width: 300,
        child:Column(
          crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        deviceIdTextField(size),
        const SizedBox(
          height: 20,
        ),
        deviceNameTextField(size),
        const SizedBox(
          height: 20,
        ),
        deviceTypeTextField(size),
        const SizedBox(
          height: 20,
        ),
        deviceLocationTextField(size),
        const SizedBox(
          height: 20,
        ),
        deviceStatusTextField(size),

      ],
        )
    );

  }




  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF21899C),
        title:_isEditable ? Text('Edit Item'):Text('Detail Item'),
      ),
      body: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          // background image and bottom contents
          Column(
            children: <Widget>[
              Container(
                height: 200.0,
                color: Colors.orange,
                child: Center(
                  child: Image.asset("assets/images/placehole.png",
                    height: size.height,
                    fit: BoxFit.cover,
                    width: size.width,
                  )
                ),
              ),

            ],
          ),
          // Profile image
          Positioned(
            top: 150.0, // (background container size) - (circle height / 2)
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              elevation: 10,
              child: _isEditable ? _editableDetailScreen(size): Container(
                padding: EdgeInsets.all(20),

                width: 300,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                 children: [
                   //
                   //No
                   Text('No',style:
                     TextStyle(
                         fontWeight: FontWeight.w300,
                         fontSize: 10
                     ),
                   ),
                   Text(widget.product.deviceId.toString(),
                     style: TextStyle(
                         fontSize: 20,
                         fontWeight: FontWeight.w400
                     ),

                   ),
                   SizedBox(height: 20,),

                   //Name
                   Text('Device Name',style:
                   TextStyle(
                       fontWeight: FontWeight.w300,
                       fontSize: 10
                   ),
                   ),
                   Text(widget.product.deviceName,
                     style: TextStyle(
                         fontSize: 20,
                         fontWeight: FontWeight.w400
                     ),

                   ),

                   SizedBox(height: 20,),

                   Text('Device Type',style:
                   TextStyle(
                       fontWeight: FontWeight.w300,
                       fontSize: 10
                   ),
                   ),
                   Text(widget.product.deviceType,
                     style: TextStyle(
                         fontSize: 20,
                         fontWeight: FontWeight.w400
                     ),

                   ),


                   SizedBox(height: 20,),

                   Text('Device Location ',style:
                   TextStyle(
                       fontWeight: FontWeight.w300,
                       fontSize: 10
                   ),
                   ),
                   Text(widget.product.deviceLocation,
                     style: TextStyle(
                         fontSize: 20,
                         fontWeight: FontWeight.w400
                     ),

                   ),


                   SizedBox(height: 20,),

                   Text('Device Status ',style:
                   TextStyle(
                       fontWeight: FontWeight.w300,
                       fontSize: 10
                   ),
                   ),
                   Text(widget.product.status,
                     style: TextStyle(
                         fontSize: 20,
                         fontWeight: FontWeight.w400
                     ),

                   ),
                 ],
                ),
              ),
            ),
          )
        ],
      ),

      floatingActionButton: FloatingActionButton (
        onPressed: () async {

          if(_isEditable == true ) {

            Product prod = Product(
                int.parse(deviceId.text),
                deviceName.text,
                deviceType.text,
                deviceLocation.text,
                _valStatus!);
            await MyDb.db.updateProduct(prod);
            setState(() {
              _isEditable = false;
              print(" _isEditable"+ _isEditable.toString());
            });
            CoolAlert.show(
              context: context,
              type: CoolAlertType.success,
              text: 'Transaction completed successfully!',
              autoCloseDuration: const Duration(seconds: 2),
            );
            Navigator.of(context).pop();

          }else{
            setState(() {
              _isEditable = true;
              print(" _isEditable"+ _isEditable.toString());
            });
          }





        },

        child: _isEditable ? Icon( Icons.check) : Icon( Icons.edit),
        backgroundColor: Color(0xFFFE9879),
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
