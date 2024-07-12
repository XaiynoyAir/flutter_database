import 'package:flutter_database/model/transactions.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';

class TransactionDB {
  String dbName;

  TransactionDB(this.dbName);

  Future<Database> openDatadase() async {
//ຫາຕໍາແຕ່ງເກັບຂໍ້ມູນ
    var appDirectory = await getApplicationDocumentsDirectory();
    String dbLocation = join(appDirectory.path, dbName);

// ສ້າງດາຕ້າ
    DatabaseFactory dbFactory = await databaseFactoryIo;
    Database db = await dbFactory.openDatabase(dbLocation);
    return db;
  }

  //ບັນທຶກຂໍ້ມູນ
  Future<int> InsertData(Transactions statement) async {
    // ຖານຂໍ້ມູນ => store
    var db = await this.openDatadase();
    var store = intMapStoreFactory.store("expense");

//json
    var KeyID = store.add(db, {
      "title": statement.title,
      "amount": statement.amount,
      "bank": statement.name,
    });
    db.close();
    return KeyID;
  }

  Future<bool> loadAllData() async {
    // var db = await this.openDatadase();
    // var store = intMapStoreFactory.store("expense");
    var db = await this.openDatadase();
    var store = intMapStoreFactory.store("expense");

    var snapshot = await store.find(db);
    print(snapshot);

    // List transactionList = List<Transactions>();

    // for (var record in snapshot) {
    //   transactionList.add(Transactions(
    //       Transactions.title: record["title"],
    //       amount: record["amount"],
    //       name: record["bank"]));
    // }

    // for (var record in snapshot) {
    //   transactionList.add(Transactions(record["title"],"amount","bank"));
    // }

    return true;
  }
}
