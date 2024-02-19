import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:styling_and_arch/models/transaction.dart';

// ignore: must_be_immutable
class ListOfTx extends StatelessWidget {
  final List<Transaction> transactions;
  Function deleteTransaction;
  ListOfTx(
      {super.key, required this.transactions, required this.deleteTransaction});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 500,
      child: transactions.isEmpty
          ? Column(
              children: [
                Text(
                  'No Transactions added Yet!',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                    height: 300,
                    child: Image.asset(
                      'images/waiting.png',
                      fit: BoxFit.cover,
                    ))
              ],
            )
          : ListView.builder(
              itemBuilder: (context, index) {
                return Card(
                    elevation: 5,
                    margin: const EdgeInsets.all(10),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Theme.of(context).primaryColor,
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: FittedBox(
                            child: Text(
                              transactions[index].amount.toString(),
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                      title: Text(transactions[index].title),
                      subtitle: Text(
                          DateFormat.yMMMd().format(transactions[index].date)),
                      trailing: IconButton(
                        onPressed: () =>
                            deleteTransaction(transactions[index].id),
                        icon: const Icon(Icons.delete),
                        color: Theme.of(context).colorScheme.error,
                      ),
                    ));
              },
              itemCount: transactions.length,
            ),
    );
  }
}
