import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'chart/mainchart.dart';
import 'style/drawerlisttile.dart';
import 'model/classlist.dart';

class mainMenuDrawer extends StatefulWidget{
  @override
  _mainMenuDrawer createState() => _mainMenuDrawer();
}

  class _mainMenuDrawer extends State<mainMenuDrawer>{


  @override
  Widget build(BuildContext context) {
    return uiMenu(context);
  }
  Widget uiMenu(BuildContext context){
    return Drawer(
      backgroundColor: Color(0xff2a2d3e),
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              //color: Colors.white,
            ),
            child: Icon(Icons.monitor_heart,color: Colors.white,),
          ),
          ExpansionTile(
            collapsedIconColor: Colors.grey,
            initiallyExpanded: true,
            title: Text("구역", style: TextStyle(color: Colors.white),),
            leading: Icon(Icons.monitor, color: Colors.white),
            childrenPadding: EdgeInsets.only(left: 20),
            children: [
              DrawerListTile(
                  title: "A구역",
                  icon: Icon(Icons.edit_location,color: Colors.white),
                  press: (){
                    moveToPage(0);
                  }
              ),
              DrawerListTile(
                  title: "B구역",
                  icon: Icon(Icons.edit_location,color: Colors.white),
                  press: (){
                    moveToPage(1);
                  }
              ),
              DrawerListTile(
                  title: "C구역",
                  icon: Icon(Icons.edit_location,color: Colors.white),
                  press: (){
                   // Navigator.push(context, MaterialPageRoute(
                   //     builder: (context) => MyApp()
                   // )
                   // );
                    moveToPage(2);
                  }
              ),
            ],
          ),
          ExpansionTile(
            collapsedIconColor: Colors.grey,
            initiallyExpanded: true,
            title: Text("그래프", style: TextStyle(color: Colors.white),),
            leading: Icon(Icons.monitor, color: Colors.white),
            childrenPadding: EdgeInsets.only(left: 20),
            children: [
              DrawerListTile(
                  title: "tag그래프",
                  icon: Icon(Icons.edit_location,color: Colors.white),
                  press: (){

                    Navigator.push(context, MaterialPageRoute(
                        builder: (context) => DataChart(tag: "")));
                  }
              ),
            ],
          )
        ],
      ),
    );
  }

  void moveToPage(int index){
    Navigator.push(context, MaterialPageRoute(
        builder: (context) =>classList[index].widget //MyApp()
    )
    );
  }

}

