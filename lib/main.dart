import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import './widgets/newTransactions.dart';
import './widgets/transactionList.dart';
import './models/Transactions.dart';
import './widgets/chart.dart';

void main() {
  runApp(MyApp());
  }


class MyApp extends StatefulWidget {
  
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
       home: MyHome(),
    );
  }
}
class MyHome extends StatefulWidget {
  @override
  _MyHomeState createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
 bool _showChart = false;
 
//List of transactions

  final List<Transaction> _usertransactions =  [];
//end of list
// recent Transactions
List<Transaction> get _recentTransactions{
  return _usertransactions.where((tx){
    return tx.date.isAfter(
      DateTime.now().subtract(Duration(days: 7))
    );
  }).toList();
}
// add a new transaction
  void _addNewTransactions(String title,double amount,DateTime choosenDate){
    setState(() {
      _usertransactions.add(
      Transaction(
        title:title,
        amount: amount,
        date: choosenDate,
        id: DateTime.now().toString(),
      )
    );
    });
  }
  //Delete a transaction
  void _deleteTransaction(String id){
    setState(() {
            _usertransactions.retainWhere((tx)=>tx.id!=id);

    });
  }

  // Modal Bottom Sheet
  void _startNewTransaction(BuildContext context){
    showModalBottomSheet(context: context, 
    builder: (context){
      return GestureDetector(
        onTap: (){},
        child: NewTransactions(_addNewTransactions),
        behavior: HitTestBehavior.opaque,
        );
    },
    );
  }
  

  @override
  Widget build(BuildContext context) {
    bool isLanscape =MediaQuery.of(context).orientation == Orientation.landscape;
    final appbar=AppBar(
          title: Text('Personal Expenses')
    );
    final txChart = Container(
               height: (
                 MediaQuery.of(context).size.height- 
                 appbar.preferredSize.height-MediaQuery.of(context).padding.top)*0.6,
               child: Chart(_recentTransactions));
    final txlist = Container(
                height:(
                  MediaQuery.of(context).size.height- 
                  appbar.preferredSize.height-MediaQuery.of(context).padding.top)*0.7,
                child: TransactionList(_usertransactions,_deleteTransaction),
                );
    return Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        appBar: appbar,
        body:SingleChildScrollView(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  if(isLanscape)
                  Text('Show Chart'),
                  if(isLanscape)
                  Switch(value: _showChart, onChanged: (val){
                    setState(() {
                      _showChart = val;
                    });
                  })
              ],),
              if(!isLanscape)Container(
               height: (
                 MediaQuery.of(context).size.height- 
                 appbar.preferredSize.height-MediaQuery.of(context).padding.top)*0.3,
               child: Chart(_recentTransactions)),
              if(!isLanscape)txlist,
             if(isLanscape) 
            _showChart==true?
             Container(
               height: (
                 MediaQuery.of(context).size.height- 
                 appbar.preferredSize.height-MediaQuery.of(context).padding.top)*0.6,
               child: Chart(_recentTransactions)):
              txlist,
            ],
          ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Builder(
  builder: (context) => FloatingActionButton(
      child: Icon(Icons.add),
      onPressed: () { showModalBottomSheet(
          context: context,
          builder: (context) {
            return GestureDetector(
        onTap: (){},
        child: NewTransactions(_addNewTransactions),
        behavior: HitTestBehavior.opaque,
        
        );
          });
      }
  ),
),
      );
  }
}