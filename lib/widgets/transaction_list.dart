import 'package:flutter/material.dart';
import '../../models/transaction.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  TransactionList(
      this.transactions); //constructor that mean we moght recive data.
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      child: transactions.isEmpty
          ? Column(
              children: <Widget>[
                Text("No Transaction added yet",
                    style:
                        TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
                SizedBox(
                  height: 50,
                ),
                Container(
                  height: 230,
                  child: Image.asset(
                    'lib/assets/images/waiting.png',
                    fit: BoxFit.cover,
                  ),
                )
              ],
            )
          : ListView.builder(
              itemBuilder: (ctx, index) {
                return Card(
                  elevation: 3,
                  margin: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 30,
                      child: Padding(
                        padding: EdgeInsets.all(6),
                        child: FittedBox(
                          child: Text("\$${transactions[index].amount}"),
                        ),
                      ),
                    ),
                    title: Text(transactions[index].title),
                    subtitle: Text(
                        DateFormat.yMMMd().format(transactions[index].date)),
                  ),
                );
              },
              itemCount: transactions.length,
            ),
    );
  }
}
