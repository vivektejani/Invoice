import 'dart:io';
import 'package:pdf/widgets.dart' as pw;

import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';


import 'global.dart';


class NextPage extends StatefulWidget {
  const NextPage({Key? key}) : super(key: key);

  @override
  State<NextPage> createState() => _NextPageState();
}

class _NextPageState extends State<NextPage> {
  final GlobalKey<FormState> customer = GlobalKey<FormState>();

  final TextEditingController numberController = TextEditingController();
  final TextEditingController nameController = TextEditingController();

  String? customerName;
  String? customerNumber;

  final pdf = pw.Document();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Customer"),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () async {
              if (customer.currentState!.validate()) {
                customer.currentState!.save();
                await getPdf(pdf);
                Directory? dir = await getExternalStorageDirectory();

                File file = File("${dir!.path}/${Global.customerName}.pdf");

                await file.writeAsBytes(await pdf.save());

                await OpenFile.open(file.path);
              }
            },
            icon: Icon(Icons.picture_as_pdf),
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "Customer Details",
          ),
          Container(
            padding: const EdgeInsets.all(25),
            child: Form(
              key: customer,
              autovalidateMode: AutovalidateMode.always,
              child: Column(
                children: [
                  TextFormField(
                    validator: (val) {
                      if (val!.isEmpty) {
                        return "Customer Name...";
                      }
                      return null;
                    },
                    onSaved: (val) {
                      Global.customerName = val;
                    },
                    controller: nameController,
                    decoration:
                    const InputDecoration(hintText: "Customer Name."),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    validator: (val) {
                      if (val!.isEmpty) {
                        return "Customer Number...";
                      }
                      return null;
                    },
                    onSaved: (val) {
                      Global.customerNumber = val;
                    },
                    keyboardType: TextInputType.number,
                    controller: numberController,
                    decoration:
                    const InputDecoration(hintText: "Customer Number."),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

getPdf(pdf) {
  final image = pw.MemoryImage(
    File(Global.image!.path).readAsBytesSync(),
  );

  var amt = [];

  num total = 0;

  for (int i = 0; i < Global.itemList.length; i++) {
    amt.add(int.parse(Global.itemList[i].price) *
        int.parse(Global.itemList[i].qty));
  }
  for (int i = 0; i < amt.length; i++) {
    total = total + amt[i];
  }

  return pdf.addPage(
    pw.MultiPage(
      build: (context) => [
        pw.Text(
          "INVOICE",
        ),
        pw.Divider(),
        pw.SizedBox(height: 5),
        pw.Container(
          alignment: pw.Alignment.center,
          child: pw.Column(
            children: [
              pw.Container(
                height: 50,
                width: 50,
                child: pw.ClipRRect(
                  horizontalRadius: 25,
                  verticalRadius: 25,
                  child: pw.Image(image, fit: pw.BoxFit.cover),
                ),
              ),
              pw.SizedBox(width: 20),
              pw.Text(
                "${Global.name}",
                style: pw.TextStyle(
                  fontSize: 20,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        pw.SizedBox(height: 5),
        pw.Divider(),
        pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.SizedBox(height: 5),
            pw.Text("BILL TO"),
            pw.SizedBox(height: 2),
            pw.Text(
              "${Global.customerName}",
            ),
            pw.SizedBox(height: 2),
            pw.Text(
              "${Global.customerNumber}",
            ),
          ],
        ),
        pw.SizedBox(height: 20),
        pw.Container(
          height: 25,
          child: pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.start,
            children: [
              pw.Expanded(
                flex: 8,
                child: pw.Text("Description"),
              ),
              pw.Expanded(
                child: pw.Text("Qty."),
              ),
              pw.Expanded(
                flex: 2,
                child: pw.Text("Unit Price"),
              ),
              pw.Expanded(
                flex: 2,
                child: pw.Text("Amount"),
              ),
            ],
          ),
        ),
        pw.Divider(thickness: 1),
        ...Global.itemList.map(
              (e) => pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.start,
            children: [
              pw.Expanded(
                flex: 8,
                child: pw.Text(e.productName),
              ),
              pw.Expanded(
                child: pw.Text(e.qty),
              ),
              pw.Expanded(
                flex: 2,
                child: pw.Text(e.price),
              ),
              pw.Expanded(
                flex: 2,
                child: pw.Text(
                  "${amt[Global.itemList.indexOf(e)]}",
                ),
              ),
            ],
          ),
        ),
        pw.Divider(thickness: 1),
        pw.Container(
          height: 25,
          child: pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.start,
            children: [
              pw.Expanded(
                flex: 8,
                child: pw.Text("Total Amount"),
              ),
              pw.Expanded(
                child: pw.Text(""),
              ),
              pw.Expanded(flex: 2, child: pw.Text("")),
              pw.Expanded(
                flex: 2,
                child: pw.Text("Rs. $total"),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
