import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:programming_quiz/User/util/main_body.dart';
import '../Admin/Util/form.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  BuildContext context;
  String username;
  final form_key = GlobalKey<FormState>();
  TextEditingController username_controller = new TextEditingController();
  SharedPreferences preferences;
  bool is_loading = true;


  @override
  void initState() {
    super.initState();
    call_init();
  }

  void call_init() async{
    this.preferences = await SharedPreferences.getInstance();
    setState((){
      this.username = this.preferences.get("username") ?? "User";;
      this.is_loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    this.context = context;
    return main_body(leading: this.get_leading(),body:(this.is_loading)?
        Center(child: CircularProgressIndicator()):this.get_body());
  }

  Widget get_leading(){
    return IconButton(
        onPressed: (){Navigator.pushNamed(this.context,'/admin');},
        icon: Icon(Icons.admin_panel_settings_sharp,color: Colors.indigo,size: 30)
    );
  }

  Widget get_body(){
    return Container(
      width: (1.0/0.0),
      padding: EdgeInsets.all(5),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          this.get_header(),
          Divider(color: Colors.greenAccent,thickness: 2),
          SizedBox(height: 30),
          Image(image:AssetImage('img/icon.webp'),width: 120),
          Image(image:AssetImage('img/logo.png'),width: 400),
          SizedBox(height: 25),
          this.get_button(title: "Take Quiz",on_press: (){
            Navigator.pushNamed(this.context,'/quiz');
          }),
          SizedBox(height: 15),
          this.get_button(title: "How it work",on_press: (){
              Navigator.pushNamed(this.context,'/how_work');
          }),
        ],
      ),
    );
  }

  Widget get_header(){
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text("Welcome, ",style: TextStyle(color: Colors.green[500],
                  fontSize: 30,fontWeight: FontWeight.bold)),
              Text(this.username,style: TextStyle(color: Colors.black,
                  fontSize: 25,fontWeight: FontWeight.bold))
            ],
          ),
          IconButton(icon: Icon(Icons.settings,color: Colors.lightBlue),
              onPressed: (){
                this.username_controller.text = "";
                showModalBottomSheet(
                    context: this.context,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(top: Radius.circular(25.0))),
                    backgroundColor: Colors.brown[300],
                    isScrollControlled: true,
                    builder: (_) => Padding(
                        padding: EdgeInsets.symmetric(horizontal: 18),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Padding(
                                padding: EdgeInsets.only(
                                    bottom: MediaQuery.of(context).viewInsets.bottom),
                                child: get_form(form_key, [
                                  get_form_text_input(
                                    maximumLines:1,
                                    suffixIcon: this.get_header_suffix(),
                                      focus: true,
                                      hint_text: "New Username",
                                      icon: Icon(Icons.account_circle),
                                      validator: (value){
                                        if(value == "")
                                          return "New username is missing";
                                        else if(value.length < 5)
                                          return "Username must be at least 5 character";
                                        else if(value.length > 10)
                                          return "Username must be less than 11 characters";
                                      },
                                      controller: username_controller
                                  ),
                                ])
                            ),
                            SizedBox(height: 10)
                          ],
                        )
                    )
                );
              })
        ],
      )
    );
  }

  Widget get_header_suffix(){
    return IconButton(icon: Icon(Icons.edit,size: 30), onPressed:() async{
      if(this.form_key.currentState.validate()){
        this.preferences = await SharedPreferences.getInstance();
        await this.preferences.setString("username",this.username_controller.text);
        setState((){
          this.username = this.username_controller.text;
          this.username_controller.text = "";
        });
        Navigator.of(context).pop();
      }
    });
  }

  Widget get_button({String title,on_press}){
    return SizedBox(
      width: 1/0,
      child: RaisedButton(
          color: Colors.green[500],
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18.0),
              side: BorderSide(color: Colors.white10)
          ),
          padding: EdgeInsets.symmetric(vertical: 15,horizontal: 15),
          child: Text(title,style: TextStyle(
            color: Colors.white,fontSize: 30,fontWeight: FontWeight.bold
          )),
          onPressed: (){on_press();}
      ),
    );
  }
}


