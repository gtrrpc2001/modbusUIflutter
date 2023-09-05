import 'package:flutter/material.dart';

class DrawerListTile extends StatelessWidget{
  const DrawerListTile({
    Key? key,
    required this.title,
    required this.icon,
    required this.press,
  }) : super(key: key);

  final Icon icon;
  final String title;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      horizontalTitleGap: 0.0,
      title: Text(title, style: TextStyle(color: Colors.white54),),
      leading: icon,
      onTap: press,
    );
  }

}