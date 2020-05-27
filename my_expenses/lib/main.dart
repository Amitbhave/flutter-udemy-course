import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:myexpenses/database/database_service.dart';
import 'package:myexpenses/models/transaction.dart';
import 'package:myexpenses/widgets/chart.dart';
import 'package:myexpenses/widgets/new_transaction.dart';
import 'package:myexpenses/widgets/transaction_list.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Expenses',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        accentColor: Colors.amber,
        textTheme: ThemeData.light().textTheme.copyWith(
          title: TextStyle(
            fontFamily: 'OpenSans',
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
          button: TextStyle(
            color: Colors.white,
          )
        )
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _userTransactions = [];

  List<Transaction> get _recentTransactions{
    return _userTransactions.where((tx) {
      return tx.date.isAfter(
          DateTime.now().subtract(Duration(days: 7))
      );
    }).toList();
  }

  Future<void> _addTransaction(String title, double amount, DateTime transactionDate) async {
    final newTransaction = Transaction(
      title: title,
      amount: amount,
      date: transactionDate,
      id: DateTime.now().toString(),
    );
    await DatabaseService.instance.insertTransaction(newTransaction);
    updateTransactionsList();
  }

  void _deleteTransaction(String id){
    DatabaseService.instance.deleteTransaction(id);
    updateTransactionsList();
  }

  void _startAddNewExpense(BuildContext context){
    showModalBottomSheet(context: context, builder: (bctx){
      return GestureDetector(
        onTap: () {},
        child: NewTransaction(_addTransaction),
        behavior: HitTestBehavior.opaque,
      );
    });
  }

  void updateTransactionsList() async {
    List<Transaction> transactions = await DatabaseService.instance.getAllTransaction();
    setState(() {
      _userTransactions.clear();
      _userTransactions.addAll(transactions);
    });
  }

  @override
  Widget build(BuildContext context) {
    updateTransactionsList();

    final appbar = AppBar(
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.add),
          onPressed: () => _startAddNewExpense(context),
        )
      ],
      title: Text('My Expenses'),
    );
    return Scaffold(
      appBar: appbar,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
          Container(
            height: (MediaQuery.of(context).size.height - appbar.preferredSize.height - MediaQuery.of(context).padding.top) * 0.3,
            child: Chart(_recentTransactions)
          ),
           FutureBuilder<List<Transaction>>(
             future: DatabaseService.instance.getAllTransaction(),
             builder: (context, AsyncSnapshot<List<Transaction>> snapshot) {
               if(snapshot.hasData){
                 return Container(
                     height: (MediaQuery.of(context).size.height - appbar.preferredSize.height - MediaQuery.of(context).padding.top) * 0.7,
                     child: TransactionList(snapshot.data, _deleteTransaction)
                 );
               } else {
                 return Center(child: CircularProgressIndicator());
               }
             },
           ),
        ],),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _startAddNewExpense(context),
      ),
    );
  }
}
