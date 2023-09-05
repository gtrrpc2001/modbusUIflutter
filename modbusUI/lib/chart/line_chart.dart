import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fl_chart/fl_chart.dart';

class LineChartContent extends StatelessWidget{

  List<LineChartBarData> chart ;
  final double _maxX;
  final double _maxY;

  LineChartContent(this.chart,this._maxX,this._maxY);

  @override
  Widget build(BuildContext context){
    return LineChart(
      LineChartData(
        borderData: FlBorderData(
          border: Border.all(
            color: Colors.white,
            width: 0.5
          )
        ),
        gridData: FlGridData(
            drawHorizontalLine: false,

        ),
        titlesData: FlTitlesData(
          topTitles: AxisTitles(
              sideTitles: SideTitles(
               // interval: 2,
                getTitlesWidget: defaultGetTitle,
                showTitles: true,
              )
          )
          ,
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              //interval: 2,
              getTitlesWidget: defaultGetTitle,
              showTitles: true,
            )
          ),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              //interval: 4,
              getTitlesWidget: defaultGetTitle,
              reservedSize: 35,
              showTitles: true,
            )
          ),
          rightTitles: AxisTitles(
              sideTitles: SideTitles(
                //interval: 4,
                reservedSize: 35,
                getTitlesWidget: defaultGetTitle,
                showTitles: true,
              )
          )
        ),
        minX: 0,
        minY: 0,
        maxX: _maxX -1 ,
        maxY: _maxY,

        lineBarsData: chart,
        //betweenBarsData: betweenBarsData

     ),

      );

  }
  Widget defaultGetTitle(double value, TitleMeta meta) {
    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: Text(
        meta.formattedValue,
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}