import 'package:flutter/material.dart';
import '../state_managment.dart';
import './Util/main_body.dart';
import './Util/form.dart';
import '../Database/question.dart';

class Add_Question_Screen extends StatefulWidget {
  @override
  _Add_Question_ScreenState createState() => _Add_Question_ScreenState();
}

class _Add_Question_ScreenState extends State<Add_Question_Screen> {
  var database;
  final form_key = GlobalKey<FormState>();
  TextEditingController question_controller = new TextEditingController();
  TextEditingController answer_controller = new TextEditingController();
  bool show_msg = false;

  @override
  Widget build(BuildContext context) {
    this.database = context.dependOnInheritedWidgetOfExactType<State_Management>().database;
    return main_body(body: this.get_body(),title: "Add New Question");
  }

  Widget get_body(){
    return Padding(
      padding: EdgeInsets.all(10),
      child: get_form(form_key, [
        get_form_text_input(
            maximumLines: 3,
            hint_text: "Question",
            icon: Icon(Icons.featured_play_list),
            validator: (value){
              if(value == "")
                return "Question is missing";
              if(value.length < 10)
                return "Question must be at least 10 character in size";
              if(value.length > 255)
                return "Question must be less than 256 character in size";
            },
            controller: this.question_controller
        ),
        get_form_text_input(
            maximumLines: 1,
            hint_text: "Answer",
            icon: Icon(Icons.question_answer),
            validator: (value){
              if(value == "")
                return "Answer is missing";
              if(value != "true" && value != "false")
                return "Invalid value";
            },
            controller: this.answer_controller
        ),
        SizedBox(height: 10),
        (this.show_msg) ? Text("Question is added successfuly",style: TextStyle(
          color: Colors.green[900], fontSize: 20)) : SizedBox(),
        SizedBox(height: 10),
        get_form_submit_button(title: "Add Question",on_press: () async{
          setState(() {
            this.show_msg = false;
          });
          if(form_key.currentState.validate()) {
            bool answer = (answer_controller.text == "true") ? true:false;
            Question question = new Question(null,this.question_controller.text,answer);
            await this.database.save(question);
            this.question_controller.text = "";
            this.answer_controller.text = "";
            setState((){
              this.show_msg = true;
            });
          }
        })
      ]),
    );
  }
}