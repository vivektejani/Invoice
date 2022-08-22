import 'dart:io';

class Products {
  String? productName;
  String? price;
  String? qty;

  Products({required this.productName, required this.price, required this.qty});

  factory Products.fromAdd(
      {required String productName,
        required String price,
        required String qty}) {
    return Products(
      productName: productName,
      price: price,
      qty: qty,
    );
  }
}

class Global {
  static var itemList = [];

  static File? image;
  static String? name;
  static String? gst;
  static String? number;
  static String? email;

  static String? customerName;
  static String? customerNumber;
}
