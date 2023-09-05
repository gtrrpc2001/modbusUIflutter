import 'dart:async';

import 'package:flutter/material.dart';
import 'package:modbusui/model/datamodel.dart';
import '../mainapp.dart';
import '../mainmenu.dart';
import 'package:modbusui/style/pagesbody.dart';
import 'package:modbusui/DB/getdata.dart';

class azone extends StatefulWidget{

  @override
  _azone createState() => _azone();

}

class _azone extends State<azone>{

  List<positionXY_ListTodo> _positionXYList = [];
  List<tag_listTodo> _tagList = [];
  List<mainUIList> uiList = [];

  Future<bool>? taskReload;
  Future<bool>? positionXYReload;

  Timer? _timer;

  String groupName = 'A지구';

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  void initState(){
    Future.delayed(Duration.zero, () async {
      SetTimer();
    });

    super.initState();
  }

  void SetTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        taskReload = GetTagList();
        if (_positionXYList.length == 0){
          positionXYReload = GetPositionXY();
        }
      });
    });
  }

  Future<bool> GetPositionXY() async{
    bool check = false;
    try{
      _positionXYList = await getData.positionXYread(groupName);
      if (_positionXYList.length != 0){
        check = true;
      }
    }catch(E){
      //_positionXYList.add(positionXY_ListTodo(0,'C지구','035',1165,428));
    }
    return check;
  }

  Future<bool> GetTagList() async{
    bool checked = false;
    try{
      _tagList = await getData.read(groupName);
      List<mainUIList> _uiList = [];
      if (_tagList.length != 0){
        _tagList.forEach((data) {
          _uiList.add(mainUIList(data.used,data.group,data.tag,data.addr, data.value, data.datatime));
        });
      }
      if (_uiList.length != 0 ){
        uiList.clear();
        uiList = _uiList;
        checked = true;
      }else{
        checked = false;
      }
    }catch(E){
      print(E);
    }
    return checked;
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      drawer: mainMenuDrawer(),
      backgroundColor: Color(0xfffafafa),
      appBar: mainApp.uiAppBar(context),
      body: mainBody(),
    );

  }

  Widget mainBody(){
    return FutureBuilder(
        future: taskReload,
        builder: (BuildContext context, AsyncSnapshot snapshot){
          return SetStack();
        });
  }

  Widget SetStack(){
    return Stack(
      clipBehavior: Clip.none,
      children: pagesBody.stackChildren(uiList,_positionXYList,0)
    );
  }

}