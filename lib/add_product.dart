import 'package:flutter/material.dart';

import 'global.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({Key? key}) : super(key: key);

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  final GlobalKey<FormState> addProduct = GlobalKey<FormState>();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController qtyController = TextEditingController();

  String? productName;
  String? price;
  String? qty;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Products"),
        centerTitle: true,
        actions: [
          ElevatedButton(
            onPressed: () {
              if (addProduct.currentState!.validate()) {
                addProduct.currentState!.save();

                setState(() {
                  Products item = Products.fromAdd(
                    productName: productName.toString(),
                    price: price.toString(),
                    qty: qty.toString(),
                  );

                  Global.itemList.add(item);

                  Navigator.of(context)
                      .pushNamedAndRemoveUntil("/", (route) => false);
                });
              }
            },
            child: const Text("ADD"),
          ),
        ],
      ),
      body: Container(
        alignment: Alignment.center,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Enter Your Product Details",
              ),
              Container(
                padding: const EdgeInsets.all(30),
                child: Form(
                  key: addProduct,
                  autovalidateMode: AutovalidateMode.always,
                  child: Column(
                    children: [
                      TextFormField(
                        validator: (val) {
                          if (val!.isEmpty) {
                            return "Enter Name...";
                          }
                          return null;
                        },
                        onSaved: (val) {
                          productName = val;
                        },
                        controller: nameController,
                        decoration: const InputDecoration(
                          hintText: "Product Name",
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        validator: (val) {
                          if (val!.isEmpty) {
                            return "Enter Price...";
                          }
                          return null;
                        },
                        onSaved: (val) {
                          price = val;
                        },
                        keyboardType: TextInputType.number,
                        controller: priceController,
                        decoration: const InputDecoration(
                          hintText: "Price",
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        validator: (val) {
                          if (val!.isEmpty) {
                            return "Enter qty...";
                          }
                          return null;
                        },
                        onSaved: (val) {
                          qty = val;
                        },
                        keyboardType: TextInputType.number,
                        controller: qtyController,
                        decoration: const InputDecoration(
                          hintText: "qty.",
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
