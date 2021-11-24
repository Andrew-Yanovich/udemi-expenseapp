import 'package:expense_app/model/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactionList;
  final Function deleteTx;

  TransactionList({Key? key, required this.transactionList, required this.deleteTx})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return transactionList.isEmpty
        ? LayoutBuilder(builder: (ctx, constraints) {
            return Column(
              children: [
                Text(
                  'No transactions added yet!',
                  style: Theme.of(context).textTheme.headline6,
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                    height: constraints.maxHeight * 0.6,
                    child: Image.asset(
                      'assets/images/waiting.png',
                      fit: BoxFit.cover,
                    )),
              ],
            );
          })
        : ListView.builder(
            itemBuilder: (ctx, index) {
              return Card(
                elevation: 5,
                margin: EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 30,
                    child: Padding(
                      padding: EdgeInsets.all(6),
                      child: FittedBox(
                        child: Text(
                          '\$${transactionList[index].amount}',
                        ),
                      ),
                    ),
                  ),
                  title: Text(
                    transactionList[index].title,
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  subtitle: Text(
                    DateFormat.yMMMd().format(transactionList[index].date),
                  ),
                  trailing: MediaQuery.of(context).size.width > 360
                      ? TextButton.icon(
                          style: TextButton.styleFrom(primary: Theme.of(context).errorColor),
                          onPressed: () => deleteTx(transactionList[index].id),
                          label: Text('Delete'),
                          icon: Icon(Icons.delete),
                        )
                      : IconButton(
                          icon: Icon(Icons.delete),
                          color: Theme.of(context).errorColor,
                          onPressed: () => deleteTx(transactionList[index].id),
                        ),
                ),
              );
            },
            itemCount: transactionList.length,
          );
  }
}
