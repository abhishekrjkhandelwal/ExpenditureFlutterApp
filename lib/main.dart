import 'package:expenditureapp/models/transaction.dart';
import 'package:expenditureapp/widgets/transaction_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import './widgets/new_transaction.dart';
import './widgets/chart.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personal Expenses',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        accentColor: Colors.amber,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        fontFamily: 'Quicksand',
        appBarTheme: AppBarTheme(
          textTheme: ThemeData.light().textTheme.copyWith(
            title: TextStyle(
              fontFamily: 'OpenSans',
              fontSize: 20,
              fontWeight: FontWeight.bold,
            )
          )
        )

      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);


  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {


  final List<Transaction> _userTransaction = [
    Transaction(
      id: 't1',
      title: 'New Shoes',
      amount: 70.00,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't2',
      title: 'Old Shoes',
      amount: 30.00,
      date: DateTime.now(),
    ),
  ];

  List<Transaction> get _recentTransactions {
    return _userTransaction.where((tx) {
      return tx.date.isAfter(
          DateTime.now().subtract(
              Duration(
                  days: 7)
          ),
      );
    }).toList();
  }

  void _addNewTransation(String txTitle, double txAmount) {
    final _newTx =  Transaction(
        id: DateTime.now().toString(),
        title: txTitle,
        amount: txAmount,
        date: DateTime.now()
    );

    setState(() {
      _userTransaction.add(
          _newTx
      );
    });
  }

  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(context: ctx, builder: (_) {
      return NewTransaction(_addNewTransation);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
            color: Colors.blue,
            child: Text('CHART!'),
            width: 100,
        ),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.add), onPressed: () {})
        ],
      ),
      body: SingleChildScrollView(
      child: Column(
        //mainAxisAlignment: MainAxisAlignment.center,
         crossAxisAlignment: CrossAxisAlignment.center,
         children: <Widget>[
         Chart(_recentTransactions),
         TransactionList(_userTransaction),
         ],
        )
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _startAddNewTransaction(context),
      ),// This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}