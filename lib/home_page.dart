import 'package:flutter/material.dart';

import 'global.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pushNamed("add_details");
          },
          icon: const Icon(Icons.account_circle, size: 27),
        ),
        title: const Text("Invoice Generator"),
        centerTitle: true,
        actions: [
          ElevatedButton(
            onPressed: () {
              if (Global.name == null) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    behavior: SnackBarBehavior.floating,
                    content: const Text(
                      "Enter Company Details First...",
                    ),
                    action: SnackBarAction(
                      onPressed: () {
                        Navigator.of(context).pushNamed("add_details");
                      },
                      label: "Open",
                    ),
                  ),
                );
              } else if (Global.itemList.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    behavior: SnackBarBehavior.floating,
                    content: const Text(
                      "Add Product First...",
                    ),
                    action: SnackBarAction(
                      onPressed: () {
                        Navigator.of(context).pushNamed("add_product");
                      },
                      label: "Add",
                    ),
                  ),
                );
              } else {
                Navigator.of(context).pushNamed("next_page");
              }
            },
            child: Text("Next"),
          ),
        ],
      ),
      floatingActionButton: ElevatedButton(
        onPressed: () {
          Navigator.of(context).pushNamed("add_product");
        },
        child: Container(
          width: 75,
          height: 40,
          child: Row(
            children: const [
              Icon(Icons.add),
              Text("Product"),
            ],
          ),
        ),
      ),
      body: Container(
        color: Colors.white,
        alignment: Alignment.center,
        child: ListView.builder(
          physics: const BouncingScrollPhysics(),
          itemCount: Global.itemList.length,
          itemBuilder: (context, i) {
            return Card(
              elevation: 0,
              child: ListTile(
                leading: Text(
                  "${i + 1}",
                ),
                title: Text(
                  "Name : ${Global.itemList[i].productName}",
                ),
                subtitle: Text(
                  "Qty : ${Global.itemList[i].qty}",
                ),
                trailing: Text(
                  "${Global.itemList[i].price}",
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
