import 'package:flutter/material.dart';
import 'package:styling_and_arch/models/transaction.dart';
import 'package:styling_and_arch/widgets/chart.dart';
import 'package:styling_and_arch/widgets/list_of_transactions.dart';
import 'package:styling_and_arch/widgets/new_transaction.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Transaction> _dummyData = [
    // Transaction(
    //     amount: 69.99, date: DateTime.now(), id: 't1', title: 'New Shoes'),
    // Transaction(
    //     amount: 59.99, date: DateTime.now(), id: 't2', title: 'Groceries'),
    // Transaction(
    //     amount: 33.45, date: DateTime.now(), id: 't3', title: 'Internet')
  ];
  void _addNewTransaction(String title, double amount) {
    Transaction newTx = Transaction(
        amount: amount,
        date: DateTime.now(),
        id: 't${_dummyData.length + 1}',
        title: title);
    setState(() {
      _dummyData.add(newTx);
    });
  }

  void _addNewTransactionScreen(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return NewTransaction(addNewTransaction: _addNewTransaction);
        });
  }

  List<Transaction> get _recentTransactions {
    return _dummyData.where((tx) {
      return tx.date.isAfter(DateTime.now().subtract(const Duration(days: 7)));
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () => _addNewTransactionScreen(context),
              icon: const Icon(Icons.add))
        ],
        title: const Text('Expense Planner'),
      ),
      body: SingleChildScrollView(
        child:
            Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          Chart(recentTransactions: _recentTransactions),
          ListOfTx(transactions: _dummyData)
        ]),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () => _addNewTransactionScreen(context),
          child: const Icon(Icons.add)),
    );
  }
}
