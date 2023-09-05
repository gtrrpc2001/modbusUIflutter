import 'dart:convert';

class TagList{
  List<tag_listTodo>? tag_list;
  TagList(this.tag_list);

  factory TagList.fromJson(String jsonString){
    List<dynamic> listFromJson = json.decode(jsonString);
    /* 여기부분 수정 */
    List<tag_listTodo> Tag_list = <tag_listTodo>[];
    Tag_list = listFromJson.map((e) => tag_listTodo.fromJson(e)).toList();

    return TagList(Tag_list);
  }
}

class tag_listTodo{
   final int idx;
   final int used;
   final String? eq;
   final String group;
   final String tag;
   final String addr;
   final String? comment;
   final double value;
   final String datatime;
   final double vmin;
   final double vmax;
   final double vsum;
   final int vcnt;
   final double vavg;
   final double scale;
   final double offset;
   final double alarm_hh;
   final double alarm_h;
   final double alarm_l;
   final double alarm_ll;
   final String? alarm_result;
   final String? explain;
   final String? unit;
   final int? UnitID;
   final String Host;
   final String Port;
   final String CommSetting;
   final int CommTimeOutSec;
   final String SaveMode;
   final int SaveInterval;

  tag_listTodo({required this.idx,required this.used,required this.eq,required this.group,required this.tag,required this.addr,required this.comment,required this.value,required this.datatime,required this.vmin,
  required this.vmax,required this.vsum,required this.vcnt,required this.vavg,required this.scale,required this.offset,required this.alarm_hh,required this.alarm_h,
  required this.alarm_l,required this.alarm_ll,required this.alarm_result,required this.explain,required this.unit,required this.UnitID,required this.Host,
    required this.Port,required this.CommSetting,required this.CommTimeOutSec,required this.SaveMode,required this.SaveInterval});

  factory tag_listTodo.fromJson(Map<String, dynamic> json){
    return tag_listTodo(
        idx: json['idx'],
        used: json['사용'],
        eq: json['설비'] ?? '',
        group: json['그룹'] ?? '',
        tag: json['태그'] ?? '',
        addr: json['addr'] ?? '',
        comment: json['comment'] ?? '',
        value: json['value'] ?? 0,
        datatime: json['datatime'] ?? '',
        vmin: json['vmin'],
        vmax: json['vmax'],
        vsum: json['vsum'],
        vcnt: json['vcnt'],
        vavg: json['vavg'],
        scale: json['scale'],
        offset: json['offset'],
        alarm_hh: json['alarm_hh'],
        alarm_h: json['alarm_h'],
        alarm_l: json['alarm_l'],
        alarm_ll: json['alarm_ll'],
        alarm_result: json['alarm_result'] ?? '',
        explain: json['설명'] ?? '',
        unit: json['단위'] ?? '',
        UnitID: json['UnitID'],
        Host: json['Host'] ?? '',
        Port: json['Port'] ?? '',
        CommSetting: json['CommSetting'] ?? '',
        CommTimeOutSec: json['CommTimeOutSec'],
        SaveMode: json['SaveMode'] ?? '',
        SaveInterval: json['SaveInterval']
    );
  }
}

class rawList{
  final List<raw_ListTodo>? raw_list;
  rawList(this.raw_list);

  factory rawList.fromJson(String jsonString){
    List<dynamic> listFromJson = json.decode(jsonString);

    /* 여기부분 수정 */
    List<raw_ListTodo> raw_list = <raw_ListTodo>[];
    raw_list = listFromJson.map((e) => raw_ListTodo.fromJson(e)).toList();

    return rawList(raw_list);
  }
}

class raw_ListTodo{
  final dynamic idx;
  final String? eq;
  final String? tag;
  final String? datatime;
  final double value;
  final String? ext;
  final int kind;
  final double avg_value;

  raw_ListTodo({required this.idx,required this.eq,required this.tag,required this.datatime,required this.value,required this.ext,required this.kind, required this.avg_value});

  factory raw_ListTodo.fromJson(Map<String, dynamic> json){
    return raw_ListTodo(
        idx: json['idx'],
        eq: json['eq'] ?? '',
        tag: json['tag'] ?? '',
        datatime: json['datatime'] ?? '',
        value: json['value'] ?? 0,
        ext: json['ext'] ?? '',
        kind: json['kind'] ?? 0,
        avg_value: json['avg_value'] ?? 0
    );
  }
}

class positionXY_ListTodo{
  final int idx;
  final String? groupName;
  final String? tag;
  final String? addr;
  final double x;
  final double y;

  positionXY_ListTodo({required this.idx,required this.groupName,required this.tag,required this.addr,required this.x,required this.y});

  factory positionXY_ListTodo.fromJson(Map<String, dynamic> json){
    return positionXY_ListTodo(
        idx: json['idx'],
        groupName: json['groupName'] ?? '',
        tag: json['tag'] ?? '',
        addr: json['addr'] ?? '',
        x: json['x'] ?? 0,
        y: json['y'] ?? 0,
    );
  }
}

class mainUIList{
  final int used;
  final String group;
  final String tag;
  final String addr;
  final double value;
  final String datatime;
  mainUIList(this.used,this.group,this.tag,this.addr,this.value,this.datatime);
}
