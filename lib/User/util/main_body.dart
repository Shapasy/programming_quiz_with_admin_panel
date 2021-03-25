import 'package:flutter/material.dart';

Widget _get_appbar(String title,Widget leading) => AppBar(
  backgroundColor: Colors.orange[800],
  title: Text(title),
  centerTitle: true,
  actions: (leading == null)?null:[leading],
);

Widget main_body({Widget body:null,String title:"Programming Quiz",Widget leading:null}){
  return Scaffold(
    appBar: _get_appbar(title,leading),
    backgroundColor: Colors.indigo,
    body: body,
  );
}


