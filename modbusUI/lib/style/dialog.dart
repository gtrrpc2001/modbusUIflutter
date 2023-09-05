import 'package:flutter/material.dart';
import 'package:modbusui/DB/getdata.dart';
import 'package:modbusui/model/datamodel.dart';

class dialog{

 static void FlutterDialog(context, list,double endX,double endY,bool updated) {
    showDialog(context: context,
        barrierDismissible: true,
        builder: (BuildContext context){
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10)
            ),
            title: Column(
              children: <Widget>[
                Text('저장 하시겠습니까?'),
              ],
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                TextButton(
                  child: Text('확인'),
                  onPressed: () {
                    setUpdate(list,endX,endY,updated);
                    Navigator.pop(context);
                  },
                ),
                TextButton(
                  child: Text('아니오'),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                )
              ],
            ),
          );
        }
    );
  }
  static void setUpdate(positionXY_ListTodo list,double endX,double endY,bool updated) async{
    var groupName = list.groupName;
    var tag = list.tag;
    var addr = list.addr;
    if (updated){
      await getData.positionXYPatch(groupName,tag,addr,endX,endY);
    }else{
      await getData.positionXYPost(groupName, tag,addr, endX, endY);
    }

  }
}