import 'package:flutter/material.dart';
import '../state_managment.dart';
import '../Database/question.dart';
import './Util/main_body.dart';
import './Util/form.dart';

class Search_Question_Screen extends StatefulWidget {
  @override
  _Search_Question_ScreenState createState() => _Search_Question_ScreenState();
}

class _Search_Question_ScreenState extends State<Search_Question_Screen> {
  var database;
  final form_key = GlobalKey<FormState>();
  TextEditingController id_controller = new TextEditingController();
  Question question;
  bool show_result = false;
  bool show_err_msg = false;


  @override
  Widget build(BuildContext context) {
    this.database = context.dependOnInheritedWidgetOfExactType<State_Management>().database;
    return main_body(title: "Search For Question",body: this.get_body());
  }


  Widget get_body(){
    return Container(
      padding: EdgeInsets.all(10),
      child: get_form(form_key, [
        get_form_text_input(
            maximumLines: 1,
            hint_text: "Question ID",
            icon: Icon(Icons.search),
            validator: (value){
              if(value == "")
                return "ID is missing";
              try{
                int.parse(value);
              }catch(e){
                return "ID must be integer";
              }
            },
            controller: this.id_controller
        ),
        SizedBox(height: 5),
        (this.show_err_msg) ? Text("Invalid ID",style: TextStyle(
          color: Colors.red[800],fontSize: 20
        )):SizedBox(),
        SizedBox(height: 5),
        get_form_submit_button(title: "Search For Question",on_press: () async{
          setState(() {
            this.show_result = false;
            this.show_err_msg = false;
          });
          if(this.form_key.currentState.validate()){
            try{
              this.question = await this.database.view(new Question(int.parse(this.id_controller.text),null,null));
              setState(() {
                this.show_result = true;
              });
            }catch(E){
              setState(() {
                this.show_err_msg = true;
              });
            }
          }
        }),
        (this.show_result) ? Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 5),
              Divider(color: Colors.brown,thickness: 2,),
              SizedBox(height: 5),
              this.get_title("Question"),
              this.get_sub_title(this.question.question),
              this.get_title("Answer"),
              this.get_sub_title("${this.question.answer}")
            ],
          ),
        ):SizedBox()
      ]),
    );
  }

  Widget get_title(String title){
    return Text(title,style: TextStyle(color: Colors.deepPurple,
        fontSize: 30,fontWeight: FontWeight.w700));
  }

  Widget get_sub_title(String title){
    return Text(title,style: TextStyle(color: Colors.black,
        fontSize: 20,fontWeight: FontWeight.w500));
  }

}





