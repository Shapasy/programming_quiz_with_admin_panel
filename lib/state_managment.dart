import 'package:flutter/material.dart';
import './Database/databaseHandler.dart';

class State_Management extends InheritedWidget {
  final database = DatabaseHandler();

  State_Management({
    Key key,
    @required Widget child
  }):super(key: key,child: child);


  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return false;
  }

}