import 'package:flutter/material.dart';
import 'package:modbusui/model/classlist.dart';
class mainApp {
 static AppBar uiAppBar(context){
    return AppBar(
      iconTheme: const IconThemeData(color: Colors.white),
      elevation: 0,
      backgroundColor: Color(0xff212332),
      flexibleSpace: new Container(
        decoration: BoxDecoration(
            color: Color(0xff212332)
        ),
      ),
      title: Container(
        child: InkWell(
          onTap: () async{
            //Navigator.pop(context);
            refresh(context);

          },
          child: Row(
            children: [
              Image(image: AssetImage("assets/images/ommsIcon.png"),width: 200,),
              SizedBox(width: 10),
              Text('대기환경시설가동 모니터링시스템',style: TextStyle(fontSize: 15),)
            ],
          ),
        ),
      ),
      centerTitle: true,
      actions: [],
    );
  }
 static Future<void> refresh(context) async{
    await Future.delayed(Duration(milliseconds: 1000));
    await Navigator.push(context, MaterialPageRoute(builder: (context) => classList[2].widget)).then((value) {

    });
  }
}


