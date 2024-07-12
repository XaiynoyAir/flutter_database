import 'package:flutter/material.dart';
import 'package:flutter_database/model/transactions.dart';
import 'package:flutter_database/providers/transactionprovider.dart';
import 'package:flutter_database/screen/from_screen.dart';
// import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) {
          return TransactionProvider();
        })
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: const MyHomePage(title: 'ບັນຊີ'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          actions: [
            IconButton(
                icon: Icon(Icons.add),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return FromScreen();
                  }));
                })
          ],
        ),
        body: Consumer(builder: (context,TransactionProvider provider, Widget? child) {
          var count = provider.transactions.length;
          if(count<=0){
            return Center(child: Text("ບໍ່ມີຂໍ້ມູນ", style: TextStyle(fontSize: 35), ),);
          } else
          return ListView.builder(
              itemCount: count,
              itemBuilder: (context, int index) {
                Transactions date = provider.transactions[index];
                return Card(
                  elevation: 5,
                  margin:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 30,
                      child: FittedBox(
                        child: Text(date.amount.toString()),
                      ),
                    ),
                    title: Text(date.title),
                    subtitle: Text(date.name),
                    // subtitle: Text(DateFormat("dd/MM/yyyy").format(date.date)),
                  ),
                );
              });
          
        }));
  }
}
