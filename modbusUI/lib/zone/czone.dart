import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../mainmenu.dart';
import 'package:modbusui/model/datamodel.dart';
import 'package:modbusui/mainapp.dart';
import 'package:modbusui/DB/getdata.dart';
import 'package:modbusui/style/pagesbody.dart';


void main() {
  ErrorWidget.builder = (FlutterErrorDetails details) => Container();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'main',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home:MyHomePage(title: 'MainTest'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}): super(key:key);

  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState(key);
  }

class _MyHomePageState extends State<MyHomePage>{
  _MyHomePageState(this.key);
  List<positionXY_ListTodo> _positionXYList = [];
  List<tag_listTodo> _tagList = [];
  List<mainUIList> uiList = [];

  String groupName = 'C지구';

  Future<bool>? taskReload;
  Future<bool>? positionXYReload;

  Timer? _timer;
  Key? key;


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

  @override
  Widget build(BuildContext context) {
    //GetPositionXY();
   return RefreshIndicator(key: key,
        onRefresh: () => mainApp.refresh(context),
        child: Scaffold(
          drawer: mainMenuDrawer(),
          backgroundColor: Color(0xfffafafa),
          appBar: mainApp.uiAppBar(null),
          body: mainBody(),
        )
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
      children:pagesBody.stackChildren(uiList,_positionXYList,2)
    );
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
}
















