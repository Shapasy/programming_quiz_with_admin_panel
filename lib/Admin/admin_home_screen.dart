import 'package:flutter/material.dart';
import '../state_managment.dart';
import './Util/main_body.dart';
import '../Database/question.dart';



class Admin_Home extends StatefulWidget {
  @override
  _Admin_HomeState createState() => _Admin_HomeState();
}

class _Admin_HomeState extends State<Admin_Home> {
  var database;

  @override
  Widget build(BuildContext context){
    this.database = context.dependOnInheritedWidgetOfExactType<State_Management>().database;
    return main_body(body: this.get_body(),actions:[this.get_leading(),this.get_search()]);
  }


  Widget get_search(){
    return IconButton(
        onPressed:(){
          Navigator.pushNamed(context,"/admin/search_question");
        },
        icon: Icon(Icons.search,color: Colors.orange,size: 30)
    );
  }

  Widget get_leading(){
    return IconButton(
        onPressed:(){
          Navigator.popAndPushNamed(context,"/admin/add_question");
        },
        icon: Icon(Icons.add,color: Colors.orange,size: 30)
    );
  }


  Widget get_body() {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: FutureBuilder<List<Question>>(
          future: this.database.getQuestions(),
          builder: (BuildContext context, AsyncSnapshot<List<Question>> snapshot) {
            if (snapshot.hasData)
              return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (context,index){
                    var question = snapshot.data[index];
                    return this.question_card(context,snapshot.data,question);
                  }
              );
            return Center(child: CircularProgressIndicator());
          }),
    );
  }

  Widget question_card(BuildContext context,List questions,Question question){
    return Dismissible(
      key: UniqueKey(),
      onDismissed: (direction) async{
        await database.delete(question.id);
        Scaffold.of(context).showSnackBar(SnackBar(
        content: Text('Deleteted Successfully',style: TextStyle(color:Colors.green)),
        duration: Duration(milliseconds: 2000),
        ));
        if(questions.contains(question)){
          setState(() {
            questions.remove(question);
          });
        }
      },
      child: Container(
        color: Colors.grey[500],
        margin: EdgeInsets.only(bottom: 10
        ),
        child: ListTile(
          title: Text(question.question,style: TextStyle(
              color: Colors.blue[700],fontSize: 30
          )),
          subtitle: Text("-${question.answer}",style: TextStyle(
              color: (question.answer)?Colors.green[800]:Colors.red[800],fontSize: 20
          ),),
          onTap: (){
            Navigator.pushNamed(context,"/admin/update_question",arguments: question);
          },
        ),
      ),
    );
  }
}