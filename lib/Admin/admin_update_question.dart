import 'package:flutter/material.dart';
import '../state_managment.dart';
import './Util/main_body.dart';
import './Util/form.dart';
import '../Database/question.dart';


class Admin_Update_Question extends StatefulWidget {
  @override
  _Admin_Update_QuestionState createState() => _Admin_Update_QuestionState();
}

class _Admin_Update_QuestionState extends State<Admin_Update_Question> {

  var database;
  var question;
  final form_key = GlobalKey<FormState>();
  TextEditingController question_controller = new TextEditingController();
  TextEditingController answer_controller = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    this.database = context.dependOnInheritedWidgetOfExactType<State_Management>().database;
    this.question = ModalRoute.of(context).settings.arguments;
    this.question_controller.text = this.question.question;
    this.answer_controller.text = "${this.question.answer}";
    return main_body(body: this.get_body(),title: "Update Question");
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
        SizedBox(height: 20),
        get_form_submit_button(title: "Update Question",on_press: () async{
          if(form_key.currentState.validate()){
            bool answer = (answer_controller.text == "true") ? true:false;
            Question question = new Question(this.question.id,this.question_controller.text,answer);
            await this.database.update(question);
            Navigator.pop(context);
            Navigator.pop(context);
            Navigator.pushNamed(context,"/admin");
          }
        })
      ]),
    );
  }

}



