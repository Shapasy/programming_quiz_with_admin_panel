import 'package:flutter/material.dart';
import 'package:programming_quiz/User/util/main_body.dart';


class HowWork extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return main_body(body: this.get_body(),title: "How it work");
  }

  Widget get_body(){
      return Container(
        padding: EdgeInsets.all(5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(child: Image(image:AssetImage('img/logo.png'),width: 300)),
            Divider(color: Colors.greenAccent,thickness: 2),
            get_sub_title("There are 8 question per quiz"),
            get_sub_title("Questions are randomly generated"),
            get_sub_title("Take as many quizzes as you want"),
            get_sub_title("Enjoy and challenge your friends"),
          ],
        ),
      );
  }

  Widget get_sub_title(String title){
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: Text("🔹${title}",style: TextStyle(
        color: Colors.orange[800],fontSize: 20,fontWeight: FontWeight.bold
      )),
    );
  }

}




