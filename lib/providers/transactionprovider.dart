import 'package:flutter/foundation.dart';
import 'package:flutter_database/datadase/transaction_db.dart';
import 'package:flutter_database/model/transactions.dart';

class TransactionProvider with ChangeNotifier{
  List<Transactions> transactions = [];
    // Transaction(title: "hhh",amount: 500,name: "ggg");
    // Transaction("title", 500, "1000"),
    //  Transaction("ffff", 500, "1000")
  // ];

  // list<Transaction> getTransaction(){
  //   return Transaction;
  // }

  List<Transactions> getTransaction(){
    return transactions;
  }

   addTransaction(Transactions statement) async{
    var db = TransactionDB("transaction.db");

    await db.InsertData(statement);

    await db.loadAllData();
  //  var db =await TransactionDB("transaction.db").openDatadase();
  //  print(db);

    // transactions.add(statement);
    transactions.insert(0,statement);
    notifyListeners();
  }


}