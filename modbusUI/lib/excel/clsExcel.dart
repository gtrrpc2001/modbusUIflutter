import 'dart:convert';
import 'dart:io';
import 'package:modbusui/model/datamodel.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart' as xlsx ;
import 'package:path_provider/path_provider.dart';
import 'package:open_file/open_file.dart';
import 'package:universal_html/html.dart' show AnchorElement;
import 'package:flutter/foundation.dart' show kIsWeb;

class clsExcel{

 static Future<void> createExcel(List<raw_ListTodo> rawList) async{
    final xlsx.Workbook workbook = xlsx.Workbook();
    final xlsx.Worksheet sheet = GetSheetValue(workbook,rawList);
    final List<int> bytes = workbook.saveAsStream();
    workbook.dispose();
    if(kIsWeb) {
      AnchorElement(
          href:
          'data:application/octet-stream;charset=utf-16le;base64,${base64.encode(bytes)}')
        ..setAttribute('download', 'down.xlsx')
        ..click();
    }else{
      final String path = (await getApplicationSupportDirectory()).path;
      final String fileName = '$path/down.xlsx';
      final File file = File(fileName);
      await file.writeAsBytes(bytes, flush: true);
      OpenFile.open(fileName);
    }

  }

  static xlsx.Worksheet GetSheetValue(workbook,List<raw_ListTodo> rawList){
    final xlsx.Worksheet sheet = workbook.worksheets[0];
    SetValue(sheet,rawList);
    return sheet;
  }
  static void SetValue(sheet,List<raw_ListTodo> rawList){
    sheet.getRangeByName('A1').setText('설비');
    sheet.getRangeByName('B1').setText('태그');
    sheet.getRangeByName('C1').setText('날짜');
    sheet.getRangeByName('D1').setText('평균값');
    sheet.getRangeByName('E1').setText('EXT');
    sheet.getRangeByName('F1').setText('종류');
   List<String> Columns = ['A','B','C','D','E','F'];
       for(int i = 0; i < rawList.length; i++){
         sheet.getRangeByName('A${i+2}').setText(rawList[i].eq);
         sheet.getRangeByName('B${i+2}').setText(rawList[i].tag);
         sheet.getRangeByName('C${i+2}').setText(rawList[i].datatime);
         sheet.getRangeByName('D${i+2}').setText(rawList[i].avg_value.toString());
         sheet.getRangeByName('E${i+2}').setText(rawList[i].ext.toString());
         sheet.getRangeByName('F${i+2}').setText(rawList[i].kind.toString());
       };
  }
}