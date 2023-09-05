import 'package:flutter/material.dart';
import 'package:modbusui/image/imgelist.dart';
import 'package:modbusui/model/datamodel.dart';
import 'package:modbusui/style/clsPositioned.dart';

class pagesBody{

  static List<Widget> stackChildren(List<mainUIList> uiList,List<positionXY_ListTodo> XYList,int indexImg){
    List<Widget> list = [];
    list.add(containerImg(indexImg));
    Color containerColor = Colors.white;
    double width = 80;
    double height = 80;
    Color textColor = Colors.black;
    double fontSize = 15;
    var uiLength = uiList.length;
    if(uiLength != 0){
      for(int i=0; i < uiLength; i++){
        var used = uiList[i].used;
        var groupName = uiList[i].group;
       var tag = uiList[i].tag;
       var addr = uiList[i].addr;
       var value = uiList[i].value.toString();
       int index =  getIndexCheck(XYList,tag);

        list.add(Setpositioned(used: used,groupName: groupName,tag: tag,addr: addr,width: width,height: height,color: containerColor,value: value,textColor: textColor,fontSize: fontSize,XYList: XYList,index:index));
      }
    }
    return list;
  }

  static int getIndexCheck(XYList,tag){
    int index = 0;
    for (int i = 0; i < XYList.length; i++){
      if (tag == XYList[i].tag){
        index = i;
        break;
      }
    }

    return index;
  }

  static Widget containerImg(int index){
    return Container(
        child: Image(
          image: AssetImage(imageItems[index].imageUrl),
          width: 2200,
          fit: BoxFit.fitHeight,
        )
    );
  }

}