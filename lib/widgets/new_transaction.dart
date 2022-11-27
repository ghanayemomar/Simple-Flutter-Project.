import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addTx;
  NewTransaction(this.addTx);

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  //to accept the pointer that point on the add new transaction function in the user_transaction function.
  final _titleController = TextEditingController();

  final _amountController = TextEditingController();

  DateTime _selectedDate;

  @override
  void _submitData() {
    if (_amountController.text.isEmpty) {
      return;
    }
    final enteredTitle = _titleController.text;
    final enteredAmount = double.parse(_amountController.text);

    if (enteredTitle.isEmpty || enteredAmount <= 0 || _selectedDate == null) {
      return;
    }
    widget.addTx(enteredTitle, enteredAmount, _selectedDate);
    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2022),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return; //if the user did open and then click cancel.
      }
      setState(() {
        _selectedDate = pickedDate; //here is the user click ok.
      });
    });
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
                    controller: _titleController,
                    onSubmitted: (_) => _submitData(),
                  ),
                  TextField(
                    decoration: InputDecoration(labelText: "Amount"),
                    controller: _amountController,
                    onSubmitted: (_) => _submitData(),
                    keyboardType: TextInputType.number,
                  ),
                  Container(
                    // height: 17,
                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: Text(
                            _selectedDate == null
                                ? "No Date Chosen!"
                                : 'Pidcked Date: ${DateFormat.yMd().format(_selectedDate)}',
                          ),
                        ),
                        TextButton(
                          style: ButtonStyle(
                              foregroundColor: MaterialStateProperty.all<Color>(
                                  Theme.of(context).primaryColorDark)),
                          child: Text("Choose Date",
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          onPressed: _presentDatePicker,
                        )
                      ],
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      _submitData();
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
