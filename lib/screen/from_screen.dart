import 'package:flutter/material.dart';

import 'package:flutter_database/model/transactions.dart';
import 'package:flutter_database/providers/transactionprovider.dart';
import 'package:provider/provider.dart';


class FromScreen extends StatelessWidget {
  // var _value = '-1';
  // const FromScreen({super.key});
  final formkey = GlobalKey<FormState>();
// Controller
  final titleController = TextEditingController();
  final amountController = TextEditingController();
  final bankController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ບັນທຶກຂໍ້ມູນ"),
      ),
      body: Padding(
        // padding: const EdgeInsets.all(8.0),
        padding:  const EdgeInsets.symmetric(vertical: 8, horizontal: 10),

        child: Form(
          key: formkey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

                 DropdownMenu<String>(
                enableFilter: false,
                width: 340,
              initialSelection: list.first,
              controller: bankController,
               onSelected: (String? value) {
              // This is called when the user selects an item.
       
              },
                 dropdownMenuEntries: list.map<DropdownMenuEntry<String>>((String value) {
               return DropdownMenuEntry<String>(value: value, label: value);
              }).toList(),
              ),


              TextFormField(
                decoration: new InputDecoration(labelText: "ຊື່ລາຍການ"),
                autofocus: true,
                controller: titleController,
                validator: (String? str) {
                  if (str!.isEmpty) {
                    return "ກະລຸນາປ້ອນລາຍການ";
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: new InputDecoration(labelText: "ຈໍານວນເງິນ"),
                keyboardType: TextInputType.number,
                controller: amountController,
                validator: (String? str) {
                  if (str!.isEmpty) {
                    return "ກະລຸນາປ້ອນຈໍານວນເງິນ";
                  }
                  if (double.parse(str) <= 0) {
                    return "ກະລຸນາປ້ອນຈໍານວນເງິນໃຫຍ່ກວ່າ '0'";
                  }
                  return null;
                },
              ),

           
 
              ElevatedButton(
                child: Text("ບັນທຶກ"),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                onPressed: () {
                  // try {
                  if (formkey.currentState!.validate()) {
                    var title = titleController.text;
                    var amount = amountController.text;
                   var bank = bankController.text;
                    Transactions statement =
                        Transactions(title, double.parse(amount), bank);

                    var provider = Provider.of<TransactionProvider>(context,
                        listen: false);
                        provider.addTransaction(statement);
                    Navigator.pop(context);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

const List<String> list = <String>['ທະນາຄານBCEL', 'ທະນາຄານLDB', 'ທະນາຄານJDB'];

