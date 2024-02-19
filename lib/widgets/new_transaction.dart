import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// ignore: must_be_immutable
class NewTransaction extends StatefulWidget {
  Function addNewTransaction;
  NewTransaction({required this.addNewTransaction, super.key});

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  DateTime? _selectedDate;

  void _submitData() {
    final enteredTitle = _titleController.text;
    final enteredAmount = double.parse(_amountController.text);
    final enteredDate = _selectedDate;
    if (enteredTitle.isEmpty || enteredAmount <= 0 || enteredDate == null) {
      return;
    }
    widget.addNewTransaction(enteredTitle, enteredAmount, enteredDate);
    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    showDatePicker(
            context: context,
            firstDate: DateTime(2024),
            initialDate: DateTime.now(),
            lastDate: DateTime.now())
        .then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectedDate = pickedDate;
      });
    });
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
              controller: _titleController,
              decoration: const InputDecoration(
                  labelText: 'Title', border: OutlineInputBorder()),
              onSubmitted: (_) => _submitData(),
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              controller: _amountController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                  labelText: 'Amount', border: OutlineInputBorder()),
              onSubmitted: (_) => _submitData(),
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 70,
              child: Row(
                children: [
                  Expanded(
                      child: _selectedDate == null
                          ? const Text('No Date Chosen!')
                          : Text(
                              'Picked Date: ${DateFormat.yMd().format(_selectedDate!)}')),
                  ElevatedButton(
                    onPressed: _presentDatePicker,
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).primaryColor,
                        foregroundColor: Colors.white),
                    child: const Text('Choose Date'),
                  )
                ],
              ),
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
