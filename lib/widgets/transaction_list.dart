import 'package:expenditureapp/models/transaction.dart';
import 'package:flutter/material.dart';
import '../models/transaction.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {

  final List<Transaction> transactions;
  TransactionList(this.transactions);

  @override
  Widget build(BuildContext context) {
    return  Container(
      height:  MediaQuery.of(context).size.height * 0.4,
        child: transactions.isEmpty ? Column(children: <Widget>[
          Text('No transaction added yet!',
           style: Theme.of(context).textTheme.title,
          ),
          SizedBox(
            height: 10,
          ),
          Container(
              child: Image.asset('assets/images/waiting.png',
                  fit: BoxFit.cover)
          ),
        ],
        ) : ListView.builder(
          itemBuilder: (ctx, index) {
            return  Card(
              margin: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
              child: ListTile(leading: CircleAvatar(
                radius: 30,
                child: Padding(
                  padding: EdgeInsets.all(6),
                  child: FittedBox(
                      child: Text('\$${transactions[index].amount}')
                  ),
                ),
               ),
                title: Text(transactions[index].title, style: Theme.of(context).textTheme.title),
                subtitle: Text(DateFormat.yMMMd().format(transactions[index].date)),
              ),
            );
          },
          itemCount: transactions.length,
      ),
    );
  }
}