import 'package:flutter/material.dart';
import './state_managment.dart';
import 'package:programming_quiz/User/home_screen.dart';
import 'package:programming_quiz/User/how_it_work_screen.dart';
import 'package:programming_quiz/User/quiz_screen.dart';
import "./Admin/admin_home_screen.dart";
import './Admin/admin_update_question.dart';
import './Admin/admin_add_question.dart';
import './Admin/admin_search_question.dart';

void main(){ runApp(MyApp()); }

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return State_Management(
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Programming Quiz',
          routes: {
            '/': (BuildContext context) => Home(),
            '/how_work':(BuildContext context) => HowWork(),
            '/quiz':(BuildContext context) => Quizz(),
            '/admin':(BuildContext context) => Admin_Home(),
            '/admin/add_question':(BuildContext context) => Add_Question_Screen(),
            '/admin/add_question':(BuildContext context) => Add_Question_Screen(),
            '/admin/update_question':(BuildContext context) => Admin_Update_Question(),
            '/admin/search_question':(BuildContext context) => Search_Question_Screen()
          },
          initialRoute: '/',
      )
    );
//    return
  }
}

