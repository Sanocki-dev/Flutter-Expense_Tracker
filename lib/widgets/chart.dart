import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// Local Import
import './chart_bar.dart';
import '../models/transaction.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;

  // Passed from parent
  Chart(this.recentTransactions);

  // Creates a new list of the last 7 days of transactions {day, amount}
  List<Map<String, dynamic>> get groupedTransactionValues {
    // Generate list of the last 7 days
    return List.generate(7, (index) {
      // Gets the date being examined
      final weekDay = DateTime.now().subtract(Duration(days: index));
      var totalSum = 0.0;

      // Loops through the days to get the total sum of each day
      for (var i = 0; i < recentTransactions.length; i++) {
        // Checks that the transaction is done on the day being examined
        if (recentTransactions[i].date.day == weekDay.day &&
            recentTransactions[i].date.month == weekDay.month &&
            recentTransactions[i].date.year == weekDay.year) {
          totalSum += recentTransactions[i].amount;
        }
      }

      // Returns day with total amount spent
      return {
        'day': DateFormat.E().format(weekDay).substring(0, 1),
        'amount': totalSum,
      };
    }).reversed.toList();
  }

  double get totalSpending {
    return groupedTransactionValues.fold(0.0, (sum, item) {
      return sum + (item['amount'] as double);
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
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: groupedTransactionValues.map((data) {
            return Flexible(
              fit: FlexFit.tight,
              child: ChartBar(
                data['day'],
                data['amount'],
                totalSpending == 0.0 ? 0.0 : data['amount'] / totalSpending,
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
