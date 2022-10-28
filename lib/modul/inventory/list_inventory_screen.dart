import 'package:flutter/material.dart';
import 'package:inventory/models/product.dart';
import 'package:inventory/utils/db.dart';

class ListInventory extends StatefulWidget{
  const ListInventory({super.key});

  @override
  State<StatefulWidget> createState() {
    return _ListInventory();
  }

}

class _ListInventory extends State<ListInventory>{

  List<Product> slist = [];


  @override
  void initState() {

    getdata();
    super.initState();
  }

  getdata(){
    Future.delayed(Duration(milliseconds: 500),() async {
      slist = await MyDb.db.getAllProducts();
      print('data list :'+slist.length.toString());
      setState(() { });
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("List of Students"),
      ),
      body: SingleChildScrollView(
        child:FutureBuilder<List<Product>>(
          future: MyDb.db.getAllProducts(),
          builder: (BuildContext context, AsyncSnapshot<List<Product>> snapshot) {

            if (snapshot.hasData) {
              print("item"+snapshot.data!.length.toString());
              // return Card(
              //   child: Text(snapshot.data!.first.deviceType),
              // );
              return ListView.builder(
                shrinkWrap: true, //
                itemCount: snapshot.data!.length,
                itemBuilder: (BuildContext context, int index) {
                final item = snapshot.data![index];
                return Card(
                child: Text(item.deviceType),
                );
                },
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}
