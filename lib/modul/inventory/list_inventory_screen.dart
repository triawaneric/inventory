import 'package:flutter/material.dart';
import 'package:inventory/models/product.dart';
import 'package:inventory/modul/input/input_qr_screen.dart';
import 'package:inventory/utils/db.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';

import 'detail_inventory_screen.dart';

class ListInventory extends StatefulWidget{
  const ListInventory({super.key});

  @override
  State<StatefulWidget> createState() {
    return _ListInventory();
  }

}

class _ListInventory extends State<ListInventory>{

  List<Product> slist = [];
  bool _searchBoolean = false;
  List<int> _searchIndexList = [];



  Widget _searchTextField() {
    return TextField(
      onChanged: (String s) {
        setState(() {
          _searchIndexList = [];
          for (int i = 0; i < slist.length; i++) {
            if (slist[i].deviceName.contains(s)) {
              _searchIndexList.add(i);
            }
          }
        });
      },
      autofocus: true,
      cursorColor: Colors.white,
      style: TextStyle(
        color: Colors.white,
        fontSize: 20,
      ),
      textInputAction: TextInputAction.search,
      decoration: InputDecoration(
        enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white)
        ),
        focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white)
        ),
        hintText: 'Search',
        hintStyle: TextStyle(
          color: Colors.white60,
          fontSize: 20,
        ),
      ),
    );
  }

  Widget _searchListView() {
    return ListView.builder(
        itemCount: _searchIndexList.length,
        itemBuilder: (context, index) {
          index = _searchIndexList[index];
          return Card(
              child: ListTile(
                  title: Text("_list[index]")
              )
          );
        }
    );
  }


  Widget _defaultListView() {
    return FutureBuilder<List<Product>>(
      future: MyDb.db.getAllProducts(),
      builder: (BuildContext context, AsyncSnapshot<List<Product>> snapshot) {

        if (snapshot.hasData) {
          print("item"+snapshot.data!.length.toString());
          // return Card(
          //   child: Text(snapshot.data!.first.deviceType),
          // );
          return ListView.builder(
            shrinkWrap: true, //
            physics: ScrollPhysics(),
            itemCount: snapshot.data!.length,
            itemBuilder: (BuildContext context, int index) {
              final item = snapshot.data![index];


              return Dismissible(
                background: Container(
                  alignment: Alignment.centerRight,
                  color: Colors.red,
                  child: const Icon(
                    Icons.delete,
                    size: 40.0,
                    color: Colors.white,
                  ),
                ),
                direction: DismissDirection.endToStart,
                confirmDismiss: (direction) {
                  return showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text('Confirmation'),
                          content: const Text('Are you sure delete this item?'),
                          actions: [
                            TextButton(
                              onPressed: () async {
                                await MyDb.db.deleteProductWithId(item.deviceId);
                                Navigator.of(context).pop(true);
                              },
                              child: const Text('Yes'),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop(false);
                              },
                              child: const Text('no'),
                            )
                          ],
                        );
                      });
                },
                key: Key(index.toString()),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => DetailInventory(product:item,)));
                  }

                    ,
                  child: Card(
                    child: Container(
                      padding: EdgeInsets.all(10),
                      child: Row(

                        children: [
                          Expanded(
                            flex: 0,
                              child: Image.asset("assets/images/placehole.png",
                                height: 90,
                                width: 90,
                              )
                          ),

                          Align(
                            alignment: Alignment.centerRight,
                            child:  Container(
                              margin: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [

                                  const Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text('ID',style:
                                    TextStyle(
                                        fontWeight: FontWeight.w300,
                                        fontSize: 10

                                    ),
                                    ),
                                  ),



                                  Text(item.deviceId.toString()),
                                  Text('Name',style:
                                    TextStyle(
                                        fontWeight: FontWeight.w300,
                                        fontSize: 10
                                    ),
                                  ),
                                  Text(item.deviceName,
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w400
                                    ),

                                  ),

                                  Text('Status',style:
                                  TextStyle(
                                      fontWeight: FontWeight.w300,
                                      fontSize: 10
                                  ),
                                  ),

                                  Text(item.status,
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w400
                                    ),

                                  ),
                                ],

                              ),
                            )
                          ),

                        ],
                      )

                    )

                )
                )
              );
            },
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }


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
          backgroundColor: Color(0xFF21899C),
          title: !_searchBoolean ? Text("Product") : _searchTextField(),
          actions: !_searchBoolean
              ? [
            IconButton(
                icon: Icon(Icons.search),
                onPressed: () {
                  setState(() {
                    _searchBoolean = true;
                    _searchIndexList = [];
                  });
                })
          ]
              : [
            IconButton(
                icon: Icon(Icons.clear),
                onPressed: () {
                  setState(() {
                    _searchBoolean = false;
                  });
                }
            )
          ]
      ),
          body: SingleChildScrollView(

        child:!_searchBoolean ? _defaultListView() : _searchListView()
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => AddInventoryQR()));
        },

        child: Icon( Icons.qr_code),
        backgroundColor: Color(0xFFFE9879),
      ),
    );
  }

  Widget buildFloatingSearchBar() {
    final isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;

    return FloatingSearchBar(
      hint: 'Search...',
      scrollPadding: const EdgeInsets.only(top: 16, bottom: 56),
      transitionDuration: const Duration(milliseconds: 800),
      transitionCurve: Curves.easeInOut,
      physics: const BouncingScrollPhysics(),
      axisAlignment: isPortrait ? 0.0 : -1.0,
      openAxisAlignment: 0.0,
      width: isPortrait ? 600 : 500,
      debounceDelay: const Duration(milliseconds: 500),
      onQueryChanged: (query) {
        // Call your model, bloc, controller here.
      },
      // Specify a custom transition to be used for
      // animating between opened and closed stated.
      transition: CircularFloatingSearchBarTransition(),
      actions: [
        FloatingSearchBarAction(
          showIfOpened: false,
          child: CircularButton(
            icon: const Icon(Icons.place),
            onPressed: () {},
          ),
        ),
        FloatingSearchBarAction.searchToClear(
          showIfClosed: false,
        ),
      ],
      builder: (context, transition) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Material(
            color: Colors.white,
            elevation: 4.0,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: Colors.accents.map((color) {
                return Container(height: 112, color: color);
              }).toList(),
            ),
          ),
        );
      },
    );
  }
}
