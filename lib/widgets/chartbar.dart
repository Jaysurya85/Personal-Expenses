import 'package:flutter/material.dart';


class ChartBar extends StatelessWidget {
  final weekday;
  final amount;
  final percent;
  ChartBar(this.weekday,this.amount,this.percent);
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Column(
      children: <Widget>[
        Container(
          height: constraints.maxHeight*0.15,
          child: FittedBox(
            child: Text('\$${amount.toStringAsFixed(0)}')
            ),
        ),
        SizedBox(
          height: constraints.maxHeight*0.05,),
        Container(
          
          height: constraints.maxHeight*0.6,
          width: 15,
          child:Stack(
            children: <Widget>[
              Container(
                decoration:BoxDecoration(
                  border: Border.all(
                    color: Colors.grey,width: 1.0),
                  color: Color.fromRGBO(220,220,220,1),
                  borderRadius: BorderRadius.circular(10)
                    )
              ),
              FractionallySizedBox(
                heightFactor: percent,
                child: Container(
                  decoration:BoxDecoration(
                  border: Border.all(
                    color: Theme.of(context).primaryColorDark,width: 1.0),
                  color: Theme.of(context).primaryColorLight,
                  borderRadius: BorderRadius.circular(10)
                    )
                    ),
              )

          ],)
        ),
        SizedBox(height: constraints.maxHeight*0.05,),
        Container(
          height: constraints.maxHeight*0.15,
          child: FittedBox(
            child: Text('${weekday}'),
            ),
        ), 
      ],
    );
    },
    );
  }
}