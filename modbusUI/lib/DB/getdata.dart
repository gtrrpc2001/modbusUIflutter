import 'dart:convert';
import '../model/datamodel.dart';
import 'package:http/http.dart' as http;

class getData{

  static Future<List<mainUIList>> get UIList async{
    List<tag_listTodo> _tagList = await UIread;
    List<mainUIList> _uiList = [];
    if (_tagList.length != 0){
      _tagList.forEach((data) {
        _uiList.add(mainUIList(data.used,data.group,data.tag,data.addr, data.value, data.datatime));
      });
    }
    return _uiList;
}

  static Future<List<tag_listTodo>> get UIread async {
    List<tag_listTodo> list = [];
    String url = '';
    final uri = Uri.parse(url);
    http.Response response = await http.get(uri);
    if(response.statusCode == 200){
      list = _UIFromJson(response.body);
    }
    return list;
  }

  static List<tag_listTodo> _UIFromJson(String str) {
    return List<tag_listTodo>.from(
      json.decode(str).map(
            (x) => tag_listTodo.fromJson(x),
      ),
    );
  }

 static Future<List<tag_listTodo>> read(String groupName) async {
    List<tag_listTodo> list = [];
    String url = '';
    if (groupName == ''){
      url = 'http://localhost:3000/users/';
    }else{
      url = 'http://localhost:3000/users/List?그룹=$groupName';
    }
    final uri = Uri.parse(url);
    http.Response response = await http.get(uri);
    if(response.statusCode == 200){
      list = _tagFromJson(response.body);
    }
    return list;
  }

 static List<tag_listTodo> _tagFromJson(String str) {
    return List<tag_listTodo>.from(
      json.decode(str).map(
            (x) => tag_listTodo.fromJson(x),
      ),
    );
  }

static Future<List<raw_ListTodo>> Rawread(tag,date) async {
   List<raw_ListTodo> list = [];
   final url = 'http://localhost:3000/raws/graph?tag=${tag}&datatime=$date';
   final uri = Uri.parse(url);
   final response = await http.get(uri);
   try{

     if(response.statusCode == 200)
       list = _rawFromJson(response.body);
   }catch(E){
     print(E);
   }
   return list;
 }

 static List<raw_ListTodo> _rawFromJson(String str) {
   return List<raw_ListTodo>.from(
     json.decode(str).map(
           (x) => raw_ListTodo.fromJson(x),
     ),
   );
 }

 static Future<bool> positionXYPatch(groupName,tag,addr,updateX,updateY) async {
    bool checked = false;
    try{
      final url = 'http://localhost:3000/positionXYs/$groupName/$tag/$addr'; //groupName=$groupName&tag=$tag&updateX=$updateX&updateY=$updateY
      final uri = Uri.parse(url);
      Map<String,dynamic> data = {"groupName":groupName,"tag":tag,"addr":addr,"updateX": updateX,"updateY": updateY};
      String jsonData = json.encode(data);
      final patch = await http.patch(uri,     //);
      headers: <String,String>{
       "Content-Type": "application/json; charset=UTF-8",
          },
        body: jsonData
          );
      print('update - ${patch.statusCode}');
      if(patch.statusCode == 200){
        checked = true;
      }
    }catch(E){
      print(E);
    }
    return checked;
 }

  static Future<bool> positionXYPost(groupName,tag,addr,updateX,updateY) async{
    bool checked = false;
    try{
      final url = 'http://localhost:3000/positionXYs/insert';
      final uri = Uri.parse(url);
      Map<String,dynamic> data = {"groupName": groupName,"tag":tag,"addr":addr,"updateX": updateX,"updateY": updateY};
      String jsonData = json.encode(data);
      final insert = await http.post(uri,
      headers: <String,String>{
        "Content-Type": "application/json; charset=UTF-8",
      },
        body: jsonData
      );
      print('insert - ${insert.statusCode}');
      if(insert.statusCode == 200){
        checked = true;
      }
    }catch(E){
      print(E);
    }
    return checked;
  }

  static Future<List<positionXY_ListTodo>> positionXYread(groupName) async {
    List<positionXY_ListTodo> list = [];
    final url = 'http://localhost:3000/positionXYs/xy?groupName=${groupName}';
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    try{
      if(response.statusCode == 200)
        list = _positionXYFromJson(response.body);
    }catch(E){
      print(E);
    }
    return list;
  }

  static List<positionXY_ListTodo> _positionXYFromJson(String str) {
    return List<positionXY_ListTodo>.from(
      json.decode(str).map(
            (x) => positionXY_ListTodo.fromJson(x),
      ),
    );
  }
}
