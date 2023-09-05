import 'package:flutter/material.dart';
import 'package:modbusui/style/dialog.dart';
import '../chart/mainchart.dart';
import '../model/datamodel.dart';
import 'package:modbusui/DB/getdata.dart';

class Setpositioned extends StatefulWidget{
  int used;
  String groupName;
  String tag;
String addr;
Color color;
String value;
Color textColor;
double fontSize;
double width;
double height;
List<positionXY_ListTodo> XYList = [];
int? index;

Setpositioned({super.key,required this.used,required this.groupName,required this.tag,required this.addr,required this.width,required this.height,required this.color,required this.value,required this.textColor,required this.fontSize,required this.XYList,required this.index});

@override
State<Setpositioned> createState() => positioned(this.used,this.groupName,this.tag,this.addr,this.width,this.height, this.color, this.value, this.textColor, this.fontSize,this.XYList, this.index);
}

class positioned extends State<Setpositioned> {
  int used;
  String groupName;
String tag;
String addr;
Color color;
String value;
Color textColor;
double fontSize;
double width;
double height;
List<positionXY_ListTodo> XYList = [];
int? index;

positioned(this.used,this.groupName,this.tag,this.addr,this.width,this.height, this.color, this.value, this.textColor, this.fontSize,this.XYList, this.index);

double _x = 0;
double _y = 0;
double _offsetX = 0;
double _offsetY = 0;

  @override
  Widget build(BuildContext context) {
    used = widget.used;
    groupName = widget.groupName;
    tag = widget.tag;
    addr = widget.addr;
    value = widget.value;
    XYList = widget.XYList;
    index = widget.index;

     double left = GetLeft();
     double top = GetTop();

    return Positioned(
         left: GetXposition(left),
         top: GetYposition(top),
         child: GestureDetector(
           onPanStart: _onPanStart,
           onPanUpdate: _onPanUpdate,
           onPanEnd: _onPanEnd,
           child: svPositionUnit(tag,width,height,color,value,textColor,fontSize),
         )
     );
  }

  double GetLeft(){
    double left = 0;
    if(XYList.length != 0){
      if(XYList[index!].tag == tag){
        left = XYList[index!].x;
      }
    }
    return left;
  }

  double GetTop(){
    double top = 0;
    if(XYList.length != 0){
      if(XYList[index!].tag == tag){
        top = XYList[index!].y;
      }
    }
    return top;
  }

void _onPanEnd(DragEndDetails details){

  print('end(${tag} - x: ${_x}, y: ${_y})');

  double x = _x;
  double y = _y;
  //여기서 db 로 좌표 업데이트

}

void _onPanStart(DragStartDetails details){
print('start(${tag} - x: ${_x}, y: ${_y})   ///  (dx: ${details.globalPosition.dx}, dy: ${details.globalPosition.dy}) ');
_offsetX = _x - details.globalPosition.dx;
_offsetY = _y - details.globalPosition.dy;
}

void _onPanUpdate(DragUpdateDetails details) {
setState(() {
print('update(${tag} - x: ${_x}, y: ${_y})   ///  (dx: ${details.globalPosition.dx}, dy: ${details.globalPosition.dy}) ');

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

List<Widget> childrenContainer(){
    return [
      SizedBox(
        width: width,
        height: 14,
        child: Row(
          children: [
            SizedBox(
              width: width/2.5,
             height: 14,
             child: Text(
                tag ,
                textAlign: TextAlign.start,
                style: TextStyle(
                    color: textColor,
                    fontSize: fontSize
                ),

              ),
            ),
            SizedBox(
              width: width/2.3,
              height: 14,
              child: Text(
                used == 1? 'ON': 'OFF' ,
                textAlign: TextAlign.end,
                style: TextStyle(
                    color: used == 1? Colors.blue: Colors.red,
                    fontSize: 12,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.bold
                ),
              ),
            ),
          ],
        )
      ),
      Divider(
        color: Colors.black,
        thickness: 1.0,
      ),
      SizedBox(
        width: width,
        height: 14,
        child: Text(
            value ,
            textAlign: TextAlign.start,
            style: TextStyle(
                color: textColor,
                fontSize: fontSize
            )
        ),
      ),
      Divider(
        color: Colors.black,
        thickness: 1.0,
      ),
      SizedBox(
        width: width,
        height: 14,
        child: TextButton(
            onPressed: () {
              var length = XYList.length;
              if (length == 0 || XYList[index!].tag != tag){
                List<positionXY_ListTodo> list = [];
                list.add(positionXY_ListTodo(idx:0,groupName: groupName,tag:tag,addr:addr,x:_x,y:_y));
                dialog.FlutterDialog(context,list[0],_x,_y,false);
              }else{
                dialog.FlutterDialog(context,XYList[index!],_x,_y,true);
              }

            },
            style: ButtonStyle(
                alignment: Alignment.topCenter,
                backgroundColor:  MaterialStatePropertyAll<Color>(Colors.lightBlue)
            ),
            child: Text('위치 저장버튼', style: TextStyle(fontSize: 8,color: textColor),)
        ),
      )
    ];
}

Widget svPositionUnit(tag,width,height,color, value,textColor,fontSize){
return InkWell(
onTap: () {

Navigator.push(context, MaterialPageRoute(
builder: (context) => DataChart(tag: tag)
)
);
},
child:
    Container(
        width: width,
        height:height,
        child: Column(
          children: childrenContainer(),
        ) ,
        decoration: BoxDecoration(
            color: color,
            borderRadius:BorderRadius.all(
                Radius.circular(15)
            ),
            border: Border.all(
                width: 2,
                color: Colors.black
              )
            )
          ),
        );
    }


}