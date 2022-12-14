import 'package:flutter/material.dart';
import '../../models/transaction.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTx;
  TransactionList(this.transactions,
      this.deleteTx); //constructor that mean we moght recive data.
  @override
  Widget build(BuildContext context) {
    return transactions.isEmpty
        ? LayoutBuilder(builder: (ctx, constraints) {
            return Column(
              children: <Widget>[
                Text("No Transaction added yet",
                    style:
                        TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
                SizedBox(
                  height: 100,
                ),
                Container(
                  height: constraints.maxHeight * 0.6,
                  child: Image.asset(
                    'lib/assets/images/waiting.png',
                    fit: BoxFit.cover,
                  ),
                )
              ],
            );
          })
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
                  subtitle:
                      Text(DateFormat.yMMMd().format(transactions[index].date)),
                  trailing: MediaQuery.of(context).size.width > 360
                      ? TextButton.icon(
                          icon: Icon(Icons.delete),
                          onPressed: () => deleteTx(transactions[index].id),
                          label: Text("Delete",
                              style: TextStyle(
                                  color: Theme.of(context).errorColor)))
                      : IconButton(
                          icon: Icon(Icons.delete),
                          color: Theme.of(context).errorColor,
                          onPressed: () => deleteTx(transactions[index].id),
                        ),
                ),
              );
            },
            itemCount: transactions.length,
          );
  }
}
