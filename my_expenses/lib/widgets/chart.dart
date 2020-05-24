import 'package:flutter/material.dart';
import 'package:myexpenses/models/transaction.dart';
import 'package:intl/intl.dart';
import 'package:myexpenses/widgets/chart_bar.dart';

class Chart extends StatelessWidget{
  final List<Transaction> recentTransactions;

  Chart(this.recentTransactions);

  List<Map<String, Object>> get groupedTransactionValues{
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(
        Duration(days: index),
      );
      var totalSum = 0.0;
      for(var tx in recentTransactions){
        if(tx.date.day == weekDay.day &&
           tx.date.month == weekDay.month &&
           tx.date.year == weekDay.year){
          totalSum += tx.amount;
        }
      }

      return {
        'day': DateFormat.E().format(weekDay).substring(0, 1),
        'amount': totalSum
      };
    }).reversed.toList();
  }

  double get totalSpending{
    return groupedTransactionValues.fold(0.0, (sum, element) {
      return sum + element['amount'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: groupedTransactionValues.map((data){
            return Flexible(
              fit: FlexFit.tight,
              child: ChartBar(
                data['day'],
                data['amount'],
                totalSpending == 0 ? 0 : (data['amount'] as double) / totalSpending,
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
  
  
}