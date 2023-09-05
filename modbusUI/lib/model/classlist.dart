import 'package:flutter/cupertino.dart';
import 'package:modbusui/zone/azone.dart';
import 'package:modbusui/zone/bzone.dart';
import '../zone/czone.dart';

class widgetList {
  widgetList({
    required this.widget,
  });

  final Widget widget;
}

  final classList = <widgetList>[
  widgetList(widget: azone()),
  widgetList(widget: bzone()),
  widgetList(widget: MyApp()),
];