import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChartContainer extends StatelessWidget{
  final Color color;
  final String title;
  final Widget chart;
  final double width;
  final double height;
  final Alignment alignment;

  const ChartContainer({
    Key? key,
    required  this.title,
    required  this.color,
    required  this.chart,
    required this.width,
    required this.height,
    required this.alignment
  }) : super(key: key);

  @override
  Widget build(BuildContext context){
    return  Container(
          width: width,
          height: height,
          alignment: alignment,
        padding: EdgeInsets.fromLTRB(0, 10, 20, 10),

        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Text(
              title,
              style: TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.bold
              ),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.only(top: 10),
                child: chart,
              ),
            )
          ],
        ),
      );
  }

}