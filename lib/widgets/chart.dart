import 'package:flutter/material.dart';
import '../models/Transactions.dart';
import 'package:intl/intl.dart';
import 'chartbar.dart';
class Chart extends StatelessWidget {

 final List<Transaction> recentTransactions;
 Chart(this.recentTransactions);
  List<Map<String,Object>>get groupdTransaction{
    return List.generate(7, (index) {
      final weekday = DateTime.now().subtract(Duration(days: index));
      double totalSum=0.0;
      for(var i=0;i<recentTransactions.length;i++){
        if(recentTransactions[i].date.day==weekday.day&&
            recentTransactions[i].date.month==weekday.month&&
            recentTransactions[i].date.year==weekday.year){
                      
            totalSum = totalSum+ recentTransactions[i].amount;

            }
      }
       return {
         'day':DateFormat.E().format(weekday).toString().substring(0,1),
         'amount':totalSum};
    }
     
    ).reversed.toList();
  }

  double get totalspending{
    return groupdTransaction.fold(0.0,(sum,item){
          return sum = sum + item['amount'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      child: Padding(
        padding: EdgeInsets.all(20),
              child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: groupdTransaction.map((data){
            return Flexible(
              fit: FlexFit.tight,
              child: ChartBar(
                data['day'], 
                data['amount'], 
                totalspending==0.0 ? 0.0:(data['amount'] as double)/totalspending),
            );
          }

          ).toList(),
        ),
      ),      
    );
  }
}