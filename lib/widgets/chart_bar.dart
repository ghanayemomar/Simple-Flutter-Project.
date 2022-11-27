import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final double spendingAmount;
  final double spendingPctOftotal;
  ChartBar(this.label, this.spendingAmount, this.spendingPctOftotal);
  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      Container(
        height: 25,
        child: FittedBox(
          child: Text('\$${spendingAmount.toStringAsFixed(0)}'),
        ),
      ),
      SizedBox(
        height: 4,
      ),
      Container(
        height: 100,
        width: 20,
        child: Stack(children: <Widget>[
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey, width: 1.0),
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          FractionallySizedBox(
              heightFactor: spendingPctOftotal,
              child: Container(
                decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(10)),
              ))
        ]),
      ),
      SizedBox(
        height: 4,
      ),
      Text(label),
    ]);
  }
}
