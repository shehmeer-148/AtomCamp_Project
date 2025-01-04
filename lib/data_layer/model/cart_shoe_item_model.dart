import 'package:cleanproject/domain/entites/Cart_shoe_items_Entities.dart';

class CartShoeItemModel{
  final int id;
  final String name;
  final double price;
  final String image;
  final int quantity;

  CartShoeItemModel({required this.id,required this.name, required this.price, required this.image, required this.quantity});

////// convert  entries to Map<String, dynamic> format for saving data in database sqflite/////
  Map<String, dynamic> toMap(){
    return {
      "productidentity": id,
      "productname": name,
      "productprice": price,
      "productimage": image,
      "productquantity": quantity,
    };
  }

  ////// convert catch data from dataase Map<String, dynamic> format to Entities /////
  factory CartShoeItemModel.fromMap(Map<String, dynamic> data){
    return CartShoeItemModel(
        id : data['productidentity'],
        name: data['productname'],
        price: data['productprice'],
        image: data['productimage'],
        quantity: data['productquantity'],
    );
  }

  CartShoeItemEntities toEntities(){
    return CartShoeItemEntities(
        id: id,
        name: name,
        price: price,
        image: image,
        quantity: quantity,
    );
  }

}