import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import './widgets/transaction_list.dart';
import './widgets/new_transaction.dart';
import './models/transaction.dart';
import './widgets/chart.dart';

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations(
  //     [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter App',
        theme:
            ThemeData(primarySwatch: Colors.blueGrey, accentColor: Colors.grey),
        home: MyHomePage(),
        debugShowCheckedModeBanner: false);
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _userTransactions = [
    Transaction(
      id: 't1',
      title: 'New Shoes',
      amount: 69.99,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't2',
      title: 'Weekly Groceries',
      amount: 16.999,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't3',
      title: 'Vape',
      amount: 100.99,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't4',
      title: 'Mobile Cover',
      amount: 34.99,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't5',
      title: 'Pizza',
      amount: 50.99,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't6',
      title: 'Mobile',
      amount: 1000.99,
      date: DateTime.now(),
    ),
  ];
  bool _showChart = true;
  List<Transaction> get _recentTransaction {
    return _userTransactions.where((tx) {
      //where allow you to run a function on every elemnt and treturn which the function accept it
      return tx.date.isAfter(
        DateTime.now().subtract(
          Duration(
              days:
                  7), //to retrive the transaction from 7 days before this day.
        ),
      );
    }).toList();
  }

  void _addNewTransaction(
      String txTitle, double txAmount, DateTime chosenDate) {
    final newTx = Transaction(
      title: txTitle,
      amount: txAmount,
      date: chosenDate,
      id: DateTime.now().toString(),
    );
    setState(() {
      _userTransactions.add(newTx);
    }); //we can call set state here beacuse we're inside the state.
  }

  void _deleteTransaction(String id) {
    setState(() {
      _userTransactions.removeWhere((tx) => tx.id == id);
    });
  }

  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return GestureDetector(
          onTap: () {},
          child: NewTransaction(_addNewTransaction),
          behavior: HitTestBehavior.opaque,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // final appBarHeight = appBar.preferredSize.height;
    final appBar = AppBar(
      title: Text('Personal Expenses'),
      actions: <Widget>[
        Row(
          children: <Widget>[
            Text("Show Chart"),
            Switch(
              activeColor: Colors.green,
              activeTrackColor: Colors.blueGrey,
              inactiveThumbColor: Colors.white,
              inactiveTrackColor: Colors.blueGrey,
              value: _showChart,
              onChanged: (val) {
                setState(() {
                  _showChart = val;
                });
              },
            ),
          ],
        ),
        IconButton(
            onPressed: () => _startAddNewTransaction(context),
            icon: Icon(Icons.add, color: Colors.white))
      ],
    );
    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            _showChart
                ? Container(
                    height: (MediaQuery.of(context).size.height -
                            appBar.preferredSize.height -
                            MediaQuery.of(context).padding.top) *
                        0.3,
                    child: Chart(_recentTransaction))
                : Container(
                    height: (MediaQuery.of(context).size.height -
                            appBar.preferredSize.height -
                            MediaQuery.of(context).padding.top) *
                        0.7,
                    child:
                        TransactionList(_userTransactions, _deleteTransaction))
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _startAddNewTransaction(context),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
