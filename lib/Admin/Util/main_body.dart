import 'package:flutter/material.dart';

Widget _get_appbar(String title,List actions) => AppBar(
  backgroundColor: Colors.brown[700],
  title: Text(title),
  centerTitle: true,
  actions: actions,
);

Widget main_body({Widget body:null,String title:"Admin Panel",List<Widget> actions:null}){
  return Scaffold(
    appBar: _get_appbar(title,actions),
    backgroundColor: Colors.brown[300],
    body: body,
  );
}


