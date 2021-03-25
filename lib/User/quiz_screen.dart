import 'package:flutter/material.dart';
import 'package:programming_quiz/User/util/main_body.dart';
import '../state_managment.dart';

class Quizz extends StatefulWidget {
  @override
  _QuizzState createState() => _QuizzState();
}

class _QuizzState extends State<Quizz> {
  //--------------------------------------------------------------
  //--------------------------------------------------------------
  //Change only this variable !
  int num_questions = 8; // set number of questions in the quiz
  //--------------------------------------------------------------
  //--------------------------------------------------------------
  var database;
  var questions;
  int curr_question_index = 0;
  int score = 0;
  bool first_init = true;
  bool loading = true;
  bool finshed = false;


  void set_next_question(){
      setState(() {
        if(this.curr_question_index == this.num_questions-1)
          this.finshed = true;
        else
          this.curr_question_index++;
      });
  }


  void init_State() async{
    this.questions = await this.database.get_random_questions(this.num_questions);
    this.curr_question_index = 0;
    this.score = 0;
    setState(() {
      this.first_init = false;
      this.loading = false;
    });
  }

  @override
  Widget build(BuildContext context){
    this.database = context.dependOnInheritedWidgetOfExactType<State_Management>().database;
    if(this.first_init) this.init_State();
    return main_body(body: (this.loading) ? Center(child: CircularProgressIndicator())
        :this.get_body(),title: "Quiz");
  }


Widget get_body(){
  return (this.finshed) ? Container(
    width: MediaQuery.of(context).size.width,
    constraints: BoxConstraints.expand(),
    decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage("img/Congrates.jpg"),
            fit: BoxFit.fill)),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children:[
        Text("You Scored ${this.score} out of ${this.num_questions}",
          style: TextStyle(
              color: Colors.red[700],
              fontSize: 30.0,
              fontWeight: FontWeight.w900
          ),
        ),
        SizedBox(height: 30.0),
        RaisedButton(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18.0),
              side: BorderSide(color: Colors.white10)
          ),
          child: Text("Take Another Quiz",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 30.0,
                  fontWeight: FontWeight.w600
              )),
          color: Colors.green,
          padding: EdgeInsets.all(20.0),
          onPressed: (){
            setState(() {
              this.finshed = false;
              this.first_init = true;
              this.loading = true;

            });
          },
        )
      ],
    ),
  ) :
  Container(
    color: Colors.yellow[300],
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        button(
            width: MediaQuery.of(context).size.width,
            text: "True",
            textColor: Colors.white,
            backgroundColor: Colors.green,
            onPress: (){
              if(this.questions[this.curr_question_index][1]) this.score++;
              setState(() {
                this.set_next_question();
              });
            }
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          color: Colors.yellow,
          padding: EdgeInsets.all(20.0),
          child: Text(this.questions[this.curr_question_index][0],
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 30.0,
            ),),
        ),
        button(
            width: MediaQuery.of(context).size.width,
            text: "False",
            textColor: Colors.black,
            backgroundColor: Colors.red,
            onPress: (){
              if(! this.questions[this.curr_question_index][1]) this.score++;
              setState(() {
                this.set_next_question();
              });
            }
        )
      ],
    ),
  );
}
}

Widget button({double width,String text,Color textColor,
  Color backgroundColor,Function onPress}){
  return ButtonTheme(
    minWidth: width,
    child: RaisedButton(
        child: Text(text,
            style: TextStyle(
              color: textColor,
              fontSize: width/8,
              fontWeight: FontWeight.w900,
            )
        ),
        color: backgroundColor,
        padding: EdgeInsets.all(50.0),
        onPressed: (){onPress();}
    ),
  );
}



