import 'dart:io';

import 'package:flutter/cupertino.dart';
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
  bool _showChart = false;
  final List<Transaction> _dummyData = [
    // Transaction(
    //     amount: 69.99, date: DateTime.now(), id: 't1', title: 'New Shoes'),
    // Transaction(
    //     amount: 59.99, date: DateTime.now(), id: 't2', title: 'Groceries'),
    // Transaction(
    //     amount: 33.45, date: DateTime.now(), id: 't3', title: 'Internet')
  ];
  void _addNewTransaction(String title, double amount, DateTime pickedDate) {
    Transaction newTx = Transaction(
        amount: amount,
        date: pickedDate,
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

  void _deleteTransaction(String id) {
    setState(() {
      _dummyData.removeWhere((element) => id == element.id);
    });
  }

  List<Transaction> get _recentTransactions {
    return _dummyData.where((tx) {
      return tx.date.isAfter(DateTime.now().subtract(const Duration(days: 7)));
    }).toList();
  }

  List<Widget> _buildLandscapeContent(
      double deviceHeight, Widget listOfTxWidget) {
    return [
      Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        const Text('Show Chart'),
        Switch(
          value: _showChart,
          onChanged: (bool value) {
            setState(() {
              _showChart = value;
            });
          },
        )
      ]),
      _showChart
          ? SizedBox(
              height: deviceHeight * 0.8,
              child: Chart(recentTransactions: _recentTransactions))
          : listOfTxWidget,
    ];
  }

  List<Widget> _buildPortraitContent(
      double deviceHeight, Widget listOfTxWidget) {
    return [
      SizedBox(
          height: deviceHeight * 0.3,
          child: Chart(recentTransactions: _recentTransactions)),
      listOfTxWidget
    ];
  }

  PreferredSizeWidget _buildAndroidAppBar() {
    return AppBar(
      title: const Text(
        'Expense Planner',
        style: TextStyle(color: Colors.black),
      ),
      actions: [
        IconButton(
            onPressed: () => _addNewTransactionScreen(context),
            icon: const Icon(Icons.add))
      ],
    );
  }

  PreferredSizeWidget _buildIOSAppBar() {
    return CupertinoNavigationBar(
      middle: const Text('Expense Planner'),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(
            onTap: () => _addNewTransactionScreen(context),
            child: const Icon(CupertinoIcons.add),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final PreferredSizeWidget appBar =
        Platform.isIOS ? _buildIOSAppBar() : _buildAndroidAppBar();

    final mediaQuery = MediaQuery.of(context);
    final deviceHeight = mediaQuery.size.height -
        appBar.preferredSize.height -
        mediaQuery.padding.top;
    final isLandScape = mediaQuery.orientation == Orientation.landscape;
    final listOfTxWidget = SizedBox(
      height: deviceHeight * 0.7,
      child: ListOfTx(
        transactions: _dummyData,
        deleteTransaction: _deleteTransaction,
      ),
    );
    final pageBody = SafeArea(
      child: SingleChildScrollView(
        child:
            Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          if (isLandScape)
            ..._buildLandscapeContent(deviceHeight, listOfTxWidget),
          if (!isLandScape)
            ..._buildPortraitContent(deviceHeight, listOfTxWidget)
        ]),
      ),
    );

    return Platform.isIOS
        ? CupertinoPageScaffold(
            navigationBar: appBar as ObstructingPreferredSizeWidget,
            child: pageBody,
          )
        : Scaffold(
            appBar: appBar,
            body: pageBody,
            floatingActionButton: Platform.isIOS
                ? Container()
                : FloatingActionButton(
                    onPressed: () => _addNewTransactionScreen(context),
                    child: const Icon(Icons.add)),
          );
  }
}
