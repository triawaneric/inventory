import 'package:flutter/material.dart';
import 'package:inventory/modul/input/input_manual_screen.dart';
import 'package:inventory/modul/inventory/list_inventory_screen.dart';

class HomeScreen extends StatefulWidget{
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() {
    return _HomeScreenState();
  }

}

class _HomeScreenState extends State<HomeScreen>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
        children: <Widget>[

          Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height*2/8,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Color(0xFF21899C), Color(0xff0fb2ea)],
                  ),
                ),
              ),



          //
          SizedBox(

            child: GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.all(5),
                  child: GestureDetector(
                    onTap:(){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => AddInventory()));
                    },
                    child:  _customCard(
                        imageUrl: "input.png",
                        item: "Input"
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(5),
                  child: GestureDetector(
                    onTap:(){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => ListInventory()));
                    },
                    child:  _customCard(
                        imageUrl: "inventory.png",
                        item: "Inventory"
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(5),
                  child: GestureDetector(
                    onTap:(){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => AddInventory()));
                    },
                    child:  _customCard(
                        imageUrl: "exit.png",
                        item: "Exit"
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      )
      )


          // Column(
          //   children: <Widget>[
          //     //header
          //     // Container(
          //     //   width: double.infinity,
          //     //   height: MediaQuery.of(context).size.height*2/8,
          //     //   decoration: const BoxDecoration(
          //     //     gradient: LinearGradient(
          //     //       begin: Alignment.topCenter,
          //     //       end: Alignment.bottomCenter,
          //     //       colors: [Color(0xFF21899C), Color(0xff0fb2ea)],
          //     //     ),
          //     //   ),
          //     // ),
          //
          //
          //
          //   ],
          // ),
    );
  }

  _customCard({required String imageUrl, required String item}){
    return SizedBox(
      height: 90,
      width: 90,
      child: Card(
        color: Colors.white,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20)
        ),
        elevation: 10,
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                height: 80,
                width: 80,
                child:  Image.asset("assets/images/" + imageUrl),
              ),

              Align(
                alignment: Alignment.center,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      item,
                      style: const TextStyle(fontSize: 24),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

}
