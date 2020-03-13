import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
class NewTransactions extends StatefulWidget {
  final Function addtx;
  NewTransactions(this.addtx);

  @override
  _NewTransactionsState createState() => _NewTransactionsState();
}

class _NewTransactionsState extends State<NewTransactions> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime _pickedDate;
   void _submit(){
     final submittedTitle = _titleController.text;
     final submittedAmount = double.parse(_amountController.text);
      if(submittedAmount==null||submittedTitle==null||submittedAmount<0||_pickedDate==null){
        return;
      }
    widget.addtx(
        submittedTitle ,
         submittedAmount,
         _pickedDate,
         );
}
void _datePicker(){
  showDatePicker(
    context: context,
   initialDate: DateTime.now(), 
   firstDate: DateTime(2019), 
   lastDate: DateTime.now()
   ).then((selectedDate){
     if(selectedDate==null){
       return;
     }
     setState(() {
       _pickedDate = selectedDate;
     });
     
    });
}
  @override
  Widget build(BuildContext context) {
    
    return SingleChildScrollView(
          child: Card(
                  margin: EdgeInsets.only(
                    top: 0,
                    left: 0,
                    right: 0,
                     bottom:MediaQuery.of(context).viewInsets.bottom +1 ,
                     ),
                  child:Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      TextField(
                        decoration: InputDecoration(labelText: 'Title'),
                        controller: _titleController,
                        onSubmitted: (_)=>_submit(),
                      ),
                       TextField(
                        decoration: InputDecoration(labelText: 'Amount',),
                        controller: _amountController,
                        keyboardType: TextInputType.number,
                        onSubmitted: (_)=>_submit(),
                      ),
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: Text(_pickedDate == null ? 
                            'No date is chosen' :
                            DateFormat.yMd().format(_pickedDate)),
                          ),
                          SizedBox(width:5),
                          FlatButton(onPressed: _datePicker,
                           child: Text(
                            'Date Picker',style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).primaryColorDark,
                            ),
                          ),
                          ),
                              
                        ],
                      ),
                      Container(
                        margin: EdgeInsets.all(10),
                        child: RaisedButton(
                        
                          color: Theme.of(context).primaryColorDark,
                          child: Text('Add',
                          style: TextStyle(color: Colors.white,),
                          ),
                          onPressed:_submit,
                        ),
                      ),
                      SizedBox(
                        height: 150,
                      )
                    ],
                  ),
                  ),
    );
  }
}