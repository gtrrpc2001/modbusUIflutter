import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import 'chartcontatiner.dart';
import 'line_chart.dart';

class positionedGraph extends StatefulWidget{
  String title;
  double left;
  double top;
  double width;
  double height;
  double maxX;
  double maxY;
  List<LineChartBarData> lineChart = [];
  Alignment alignment;

  positionedGraph({super.key,required this.lineChart,required this.title,required this.maxX, required this.maxY,required this.width,required this.height,required this.left,required this.top,required this.alignment});

  @override
  _positionedGraph createState() => _positionedGraph(this.lineChart,this.title,this.maxX,this.maxY,this.width,this.height, this.left, this.top,this.alignment);
}

class _positionedGraph extends State<positionedGraph> {
  _positionedGraph(this.lineChart,this.title,this.maxX,this.maxY,this.width,this.height,this.left, this.top,this.alignment);

  String title;

  double left;
  double top;
  double width;
  double height;
  double maxX;
  double maxY;

  List<LineChartBarData> lineChart = [];

  double _x = 0;
  double _y = 0;
  double _offsetX = 0;
  double _offsetY = 0;

  Alignment alignment;

  @override
  Widget build(BuildContext context) {
    title = widget.title;
    maxX = widget.maxX;
    maxY = widget.maxY;
    lineChart = widget.lineChart;

    return Positioned(
        left: GetXposition(left),
        top: GetYposition(top),
        child: GestureDetector(
          onPanStart: _onPanStart,
          onPanUpdate: _onPanUpdate,
          onPanEnd: _onPanEnd,
          child: svPositionUnit(lineChart,title,maxX,maxY,width,height,alignment),
        )
    );
  }
  void _onPanEnd(DragEndDetails details){
    print('end- x: ${_x}, y: ${_y})');
    double x = _x;
    double y = _y;
    //여기서 db 로 좌표 업데이트

  }

  void _onPanStart(DragStartDetails details){
    print('start- x: ${_x}, y: ${_y})   ///  (dx: ${details.globalPosition.dx}, dy: ${details.globalPosition.dy}) ');
    _offsetX = _x - details.globalPosition.dx;
    _offsetY = _y - details.globalPosition.dy;
  }

  void _onPanUpdate(DragUpdateDetails details) {
    setState(() {
      print('update- x: ${_x}, y: ${_y})   ///  (dx: ${details.globalPosition.dx}, dy: ${details.globalPosition.dy}) ');

      _x = details.globalPosition.dx + _offsetX;
      _y = details.globalPosition.dy + _offsetY;

    });
  }

  double GetXposition(position){
    double x = 0;
    if(_x != 0){
      x = _x;
    }else{
      _x = position;
      x = position;
    }
    return x;
  }

  double GetYposition(position){
    double y = 0;
    if(_y != 0){
      y = _y;
    }else{
      _y = position;
      y = position;
    }
    return y;
  }

  Widget svPositionUnit(lineChart,title,maxX,maxY,width,height,alignment){
    return ChartContainer(
              title: title,
              color: Color(0xff212332),
              chart: LineChartContent(lineChart,maxX, maxY),
              width: width,
              height: height,
              alignment: alignment,
            );

  }
}