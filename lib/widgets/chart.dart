import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:styling_and_arch/models/transaction.dart';
import 'package:styling_and_arch/widgets/chart_bar.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;
  const Chart({super.key, required this.recentTransactions});
  List<Map<String, Object>> get _groupedTransactionsValues {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));
      double totalSum = 0;
      for (var i = 0; i < recentTransactions.length; i++) {
        if (recentTransactions[i].date.day == weekDay.day &&
            recentTransactions[i].date.month == weekDay.month &&
            recentTransactions[i].date.year == weekDay.year) {
          totalSum += recentTransactions[i].amount;
        }
      }
      return {
        'day': DateFormat.E().format(weekDay).substring(0, 1),
        'amount': totalSum
      };
    });
  }

  double get _maxSpending {
    return _groupedTransactionsValues.fold(0.0, (sum, item) {
      return sum + (item['amount'] as double);
    });
  }

  @override
  Widget build(BuildContext context) {
    // print(_groupedTransactionsValues);
    return Card(
      elevation: 6,
      margin: const EdgeInsets.all(20),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: _groupedTransactionsValues
              .map((e) => ChartBar(
                  label: e['day'] as String,
                  spendingAmount: e['amount'] as double,
                  spendingPctOfTotal: _maxSpending == 0.0
                      ? 0.0
                      : (e['amount'] as double) / _maxSpending))
              .toList(),
        ),
      ),
    );
  }
}
