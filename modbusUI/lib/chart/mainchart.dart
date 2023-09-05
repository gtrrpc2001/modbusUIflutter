import 'dart:async';
import 'dart:math';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:modbusui/DB/getdata.dart';
import '../mainmenu.dart';
import '../model/datamodel.dart';
import 'linechart_data.dart';
import '../excel/clsExcel.dart';
import 'package:modbusui/mainapp.dart';
import 'positionedgraph.dart';

class DataChart extends StatefulWidget{
  DataChart({Key? key, required this.tag}): super(key:key);

  final String tag;

  @override
  _chart createState() => _chart(tag);

}

class _chart extends State<DataChart>{
  _chart(this.tag);

  bool _isChecked = true;
  String tag;
  Future<bool>? rawReload;
  List<raw_ListTodo> _rawList = [];
  List<mainUIList> tagUIList = [];
  DateTime date = DateTime.now();
  int indexPrevListTile = -1;
  List<bool> boolListTileClickList = [];
  bool buttonClickChecked = false;

  Timer? _timer;

  Future<bool> GetRawList() async{
    bool checked = false;
    tagUIList = await getData.UIList;
    _rawList = await getData.Rawread(tag,dateToString());
    if (_rawList.length != 0 && tagUIList.length != 0){
      checked = true;
    }
    print(checked);
    return checked;
  }

  Widget Getfuture(){
   return FutureBuilder(
        future: rawReload,
        builder: (BuildContext context, AsyncSnapshot snapshot){
            return mainBody();
          }
        );
  }

  @override
  Widget build(BuildContext context) {
    if(indexPrevListTile == -1)tag = widget.tag;
    if(tag == "") tag = "035";
    rawReload = GetRawList();
    return Chart();
  }

Widget RawSet(){
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
              children: [
                Checkbox(
                    value: _isChecked,
                    onChanged: (value) {
                      setState(() {
                        _isChecked = value!;
                      });
                    }
                ),
                Text(tag),


              ]
          ),
          Row(
            children: [
                  TextButton(
                      onPressed: () {
                        if (_rawList.length != 0){
                          clsExcel.createExcel(_rawList);
                        }
                      }
                      ,
                      child: Text('엑셀 다운'))
                ],

          )
        ]
    );
}

 double FindMaxValue(){
    if(_rawList.length != 0){
      double maxValue = _rawList.map((e) => e.value).reduce(max);
      return maxValue < 1 ? 1 : maxValue;
    }else {
      return 0;
    }
 }

 double maxX(){
    if (_rawList.length != 0){
      return _rawList.length as double;
    }else{
      return 0;
    }
 }

  List<ListTile> GetListItems(String groupName){
    List<ListTile> listItems = [];
    var listLength = tagUIList.length;

    if (listLength != 0) {
      for (int i = 0; i < listLength; i++) {
        var list = tagUIList[i];

        boolListTileClickList.add(false);

        if (list.group == groupName) {
          //boolListTileClickList[i] = false;
          //listTileTag = list.tag;
         var listTileTag = list.tag;
          listItems.add(
              ListTile(title: Text(listTileTag,
                style: TextStyle(color: Colors.black, fontSize: 15),),
                leading: Icon(
                  Icons.tag_faces, color: Color.fromRGBO(150, 110, 13, 100),),
                shape: RoundedRectangleBorder(
                  side: BorderSide(width: 2),
                  borderRadius: BorderRadius.circular(20)
                ),
                trailing:boolListTileClickList[i] || (tag == listTileTag && indexPrevListTile == -1)? Icon(Icons.check) : null,
                onTap: () {
                    setState(() {
                      listTileClickCheck(i);
                      tag = list.tag;

                    });
                },
              ),
          );
        }
      }
    }
      return listItems;
  }

  void listTileClickCheck(int i){
    boolListTileClickList[i] = true;
    if(indexPrevListTile != -1)
      boolListTileClickList[indexPrevListTile] = false;

    if(boolListTileClickList[i])
      indexPrevListTile = i;
  }

Widget getListViewBuilder(){
    List<String> zoneList = ['A지구','B지구','C지구'];
    return ListView.separated(
  controller: ScrollController(),
  itemCount: zoneList.length,
  scrollDirection: Axis.vertical,
  itemBuilder: (BuildContext context, int index){
    var groupName = zoneList[index];
    List<ListTile> list = GetListItems(groupName);
      return ExpansionTile(
          title: Text(groupName,style: TextStyle(color: Colors.black,fontSize: 15)),
          children:list,
          initiallyExpanded: true
          );
        },
   separatorBuilder: (BuildContext context, int index) {
      return Divider(height: 5.0, color: Colors.black,);
    },
  );
}



  String dateToString(){
    return "${date.year.toString()}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
  }

Widget rightBodyHeader(){

    return SizedBox(
      width: MediaQuery.of(context).size.width - 800,
      height: 60,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 270,
            height: 60,
            child:TextField(
              controller: TextEditingController(text:buttonClickChecked == false ? '' :  dateToString()),
              decoration: InputDecoration(
                hintText: '옆에 버튼에서 날짜를 선택해 주세요.',

                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() {
                  value =  dateToString();
                });
              },
            ),
          ),
          SizedBox(
            width: 50,
            height: 60,
            child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 2.0,),
                child: IconButton(
                  alignment: Alignment.center,
                  iconSize: 30,
                    icon: Icon(Icons.calendar_today_rounded,),
                    onPressed: () async {
                      final selectedDate = await showDatePicker(
                          context: context,
                          initialDate: date,
                          firstDate: DateTime(2000),
                          lastDate: DateTime.now(),
                          initialEntryMode: DatePickerEntryMode.calendarOnly
                      );
                      if(selectedDate != null && date != selectedDate){
                        setState(() {
                          date = selectedDate;
                          buttonClickChecked = true;
                        });
                      }
                    }
                )
            ),
          ),
          RawSet()
        ],
      ),
    );
}

Widget leftBody(){
    return Container(
      child: SizedBox(
        width: 800,
        height: MediaQuery.of(context).size.height,
        child: getListViewBuilder(),
      ),
    );
}

Widget rightBody(){
    return Container(
        width: MediaQuery.of(context).size.width - 800,
        height: MediaQuery.of(context).size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            rightBodyHeader(),
            Divider(height: 1.0, color: Colors.black,),
            SizedBox(
              width: MediaQuery.of(context).size.width - 800,
              height: MediaQuery.of(context).size.height - 200,
              child: Stack(
                  alignment: AlignmentDirectional.topStart,
                  clipBehavior: Clip.none,
                  children: [
                    graph(),
                  ]
              ),
            ),
          ],
        )
    );
}

 Widget mainBody(){
  return Row(
    children: [
      leftBody(),
      rightBody(),
     ],
   );
  }

  Widget graph(){
    List<LineChartBarData> lineChart = lineChartBarData(_rawList,tag,_isChecked);
      return positionedGraph(
        lineChart: lineChart,
        title: tag,
        maxX: maxX(),
        maxY: FindMaxValue(),
        width: 900,
        height: 500,
        left: 0,
        top: 0,
        alignment: Alignment.topLeft,
      );
  }

  Widget Chart(){
      return Scaffold(
        resizeToAvoidBottomInset: false,
        drawer:mainMenuDrawer(),
        appBar: mainApp.uiAppBar(context),
        body: SingleChildScrollView(
            child:Getfuture()
        ),
      );
  }
}
