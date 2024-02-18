import 'package:flutter/material.dart';

// ignore: must_be_immutable
class NewTransaction extends StatefulWidget {
  Function addNewTransaction;
  NewTransaction({required this.addNewTransaction, super.key});

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final TextEditingController titleController = TextEditingController();

  final TextEditingController amountController = TextEditingController();

  void _submitData() {
    final enteredTitle = titleController.text;
    final enteredAmount = double.parse(amountController.text);
    if (enteredTitle.isEmpty || enteredAmount <= 0) {
      return;
    }
    widget.addNewTransaction(enteredTitle, enteredAmount);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(
                  labelText: 'Title', border: OutlineInputBorder()),
              onSubmitted: (_) => _submitData(),
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              controller: amountController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                  labelText: 'Amount', border: OutlineInputBorder()),
              onSubmitted: (_) => _submitData(),
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
                onPressed: _submitData,
                style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).primaryColor,
                    foregroundColor: Colors.white),
                child: const Text('Add Transaction'))
          ],
        ),
      ),
    );
  }
}
