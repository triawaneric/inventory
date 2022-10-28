import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import '../models/product.dart';

class MyDb{


  static Database? _database;

  MyDb._();

   static final MyDb db = MyDb._();




   Future<Database?> get database async {
     if (_database != null) return _database;
     _database = await getDatabaseInstance();
     return _database;
   }


   Future<Database> getDatabaseInstance() async {
     Directory directory = await getApplicationDocumentsDirectory();
     String path = join(directory.path, "inventory.db");
     return await openDatabase(path, version: 1,
         onCreate: (Database db, int version) async {
           await db.execute('''

                    CREATE TABLE IF NOT EXISTS inventorys( 
                          id primary key,
                          device_id int not null, 
                          device_type varchar(255) not null,
                          device_name varchar(255) not null,
                          device_location varchar(255) not null,
                          status varchar(255) not null
                      );

                      //create more table here
                  
                  ''');
           print("Table Created");
         });
   }


  addProductToDatabase(Product product) async {
     print("add");
    final db = await database;
    var raw = await db!.insert(
      "inventorys",
      product.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return raw;
  }


   Future<List<Product>> getAllProducts() async {
     final db = await database;
     var response = await db!.query("inventorys");
     List<Product> list = response.map((c) => Product.fromMap(c)).toList();
     return list;
   }

  Future<Map<dynamic, dynamic>?> getInventory(int deviceno) async {
    final db = await database;
    List<Map> maps = await db!.query('inventorys',
        where: 'device_id = ?',
        whereArgs: [deviceno]);

    if (maps.length > 0) {
       return maps.first;
    }
    return null;
  }
}