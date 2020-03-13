import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/Transactions.dart';
  class TransactionList extends StatelessWidget {
   final List<Transaction> transactions;
   Function deleteTransaction;
   TransactionList(this.transactions,this.deleteTransaction);
    @override
    Widget build(BuildContext context) {
      return Container(
        height: 500,
        child: ListView.builder(
          itemBuilder: (context,index){
           return  Card(
                    child: ListTile(
                      leading: Container(
                        
                        child: CircleAvatar(
                          radius: 30,
                               child: FittedBox(
                                child: Text(
                                  '\$ ${transactions[index].amount.toStringAsFixed(2)}',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                      
                          ),
                               ),
                        ),
                      ),
                      title: Text(
                        transactions[index].title,
                        style: TextStyle(
                          color: Theme.of(context).primaryColorDark,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          ),
                          ),
                      subtitle: Text(
                        DateFormat.yMMMd().format(transactions[index].date),
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                        ),
                    ) ,
                    trailing: IconButton(
                      icon: Icon(Icons.delete), 
                      onPressed: () => deleteTransaction(transactions[index].id),
                      color: Theme.of(context).primaryColor,
                      ),
                    ),
                  );
          },
          itemCount: transactions.length,
        ),
      );
    }
  }