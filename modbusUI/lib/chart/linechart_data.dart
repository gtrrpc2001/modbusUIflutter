import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:modbusui/model/datamodel.dart';

Color lineColor = Color(0xfff3f169);

List<LineChartBarData> lineChartBarData(List<raw_ListTodo> rawList,String tag,chk1){

  List<FlSpot> spotList = [];
  if(rawList.length != 0){

    for(double i = 0; i < rawList.length; i++){
      FlSpot spot = FlSpot(i,rawList[i as int].avg_value as double);
      spotList.add(spot);
    }
  }

  return   [
    LineChartBarData(
      show: chk1,
      color: lineColor,
      isCurved: true,
      spots: spotList,
    ),
  ];
   // LineChartBarData(
    //  show: chk2,
    //  color: lineColor,
     // isCurved: true,
     // spots: [
     //   FlSpot(1, 2),
     //   FlSpot(2, 15),
     //   FlSpot(3,8),
     //   FlSpot(4, 12),
    //    FlSpot(5, 5),
    //    FlSpot(6, 6),
     //   FlSpot(7, 14),
    //    FlSpot(8, 7),
   //   ],
  //  )
}




