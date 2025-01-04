import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import '../../model/cart_shoe_item_model.dart';

class CartDatabaseHelper{

  static final CartDatabaseHelper _instance = CartDatabaseHelper._internal();

  factory CartDatabaseHelper() => _instance;

  CartDatabaseHelper._internal();

  static const _databaseName = "cartdatabase.db";
  static const _databaseVersion = 1;

  static const cartTable = "carttable";
  static const id = "id";
  static const productId = "productidentity";
  static const productName = "productname";
  static const productPrice = "productprice";
  static const productImage = "productimage";
  static const productQuantity = "productquantity";

  late Database db;

  Future<void> init()async{
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, _databaseName);

    db = await openDatabase(
      path,
      version: _databaseVersion,
      onCreate: (Database db, int version) async {
        // Create product table
        await db.execute('''
          CREATE TABLE $cartTable (
            $id INTEGER PRIMARY KEY AUTOINCREMENT,
            $productId INTEGER,
            $productName TEXT,
            $productImage TEXT,
            $productPrice REAL,
            $productQuantity INTEGER
           
          )
        ''');
        print("Product table created");
      },
    );
  }

  Future<int> addCartItem(CartShoeItemModel items) async {
    try{
      final existingData = await db.query(cartTable,where: '$productId = ?', whereArgs: [items.id]);

      if(existingData.isNotEmpty){
        print("Already Exists");
        ////////////// we are going to update Quantity and Price of that product//////////

        int existingQuantity = existingData[0]['productquantity'] as int;
        int newQuantity = existingQuantity + items.quantity;

        double existingPrice =existingData[0]['productprice'] as double;
        double newPrice = existingPrice + items.price;

       return await db.update(cartTable, {productQuantity: newQuantity,productPrice: newPrice},where: '$productId = ?',whereArgs: [items.id]);
      } else {
        return await db.insert(cartTable, items.toMap());
      }
    }catch(e){
      rethrow;
    }

  }

  Future<List<CartShoeItemModel>> getCartItems() async {
    try{
      final List<Map<String, dynamic>> data = await db.query(cartTable);

      if(data.isNotEmpty){
        return data.map((items) => CartShoeItemModel.fromMap(items)).toList();
      }
      return [];
    }
    catch(e){
      rethrow;
    }
  }

  Future<int> deleteCartItems()async{
    int result =  await db.delete(cartTable);
    print(result);
    return result;
  }

  Future<int> deleteCartItemsByID(int identity)async{
     int result= await db.delete(
        cartTable,
        where: "$productId = ?",
        whereArgs: [identity],
    );
     return result;
  }

  Future<int> updateCartItemQuantityById(int identity, int value) async {
    final existingData = await db.query(
      cartTable,
      where: '$productId = ?',
      whereArgs: [identity],
    );

    if (existingData.isNotEmpty) {
      final int existingQuantity = existingData[0]["productquantity"] as int;
      final int newQuantity = existingQuantity + value;

      if (newQuantity < 1) {
        print("Quantity cannot be less than 1. No action performed.");
        return 0;
      }

      return await db.update(
        cartTable,
        {productQuantity: newQuantity},
        where: '$productId = ?',
        whereArgs: [identity],
      );
    } else {
      print("Product with identity $identity not found.");
      return 0; // Return 0 to indicate no action taken
    }
  }

}