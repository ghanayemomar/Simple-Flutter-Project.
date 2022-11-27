import 'package:flutter/material.dart';

class NewTransaction extends StatefulWidget {
  final Function addTx;
  NewTransaction(this.addTx);

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  //to accept the pointer that point on the add new transaction function in the user_transaction function.
  final titleController = TextEditingController();

  final amountController = TextEditingController();

  @override
  void submitData() {
    final enteredTitle = titleController.text;
    final enteredAmount = double.parse(amountController.text);

    if (enteredTitle.isEmpty || enteredAmount <= 0) {
      return;
    }
    widget.addTx(enteredTitle, enteredAmount);
    Navigator.of(context).pop();
  }

  Widget build(BuildContext context) {
    return Card(
        elevation: 5,
        child: Container(
            padding: EdgeInsets.all(10),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  TextField(
                    decoration: InputDecoration(labelText: 'Title'),
                    controller: titleController,
                    onSubmitted: (_) => submitData(),
                  ),
                  TextField(
                    decoration: InputDecoration(labelText: "Amount"),
                    controller: amountController,
                    onSubmitted: (_) => submitData(),
                    keyboardType: TextInputType.number,
                  ),
                  Container(
                    // height: 17,
                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                    child: Row(
                      children: <Widget>[
                        Text("No Date Chosen!"),
                        TextButton(
                          style: ButtonStyle(
                              foregroundColor: MaterialStateProperty.all<Color>(
                                  Theme.of(context).primaryColorDark)),
                          child: Text("Choose Date",
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          onPressed: () {},
                        )
                      ],
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      submitData();
                    },
                    child: Text("Add Transaction",
                        style: TextStyle(color: Colors.white)),
                    style: ButtonStyle(
                      foregroundColor: MaterialStateProperty.all<Color>(
                          Theme.of(context).primaryColor),
                    ),
                  )
                ])));
  }
}
