import 'package:flutter/material.dart';

Form get_form(GlobalKey<FormState> form_key,List<Widget> childern){
  if(childern == null)
    return null;
  return Form(
      key: form_key,
      child: SingleChildScrollView(
        child: Column(
          children: childern,
        ),
      )
  );
}

Container get_form_text_input({String hint_text:"", validator:null,
  is_password: false, TextEditingController controller: null,
  Icon icon:null,Widget suffixIcon,focus:false,maximumLines:6}){
  return Container(
    padding: EdgeInsets.fromLTRB(10,4,10,4),
    margin: EdgeInsets.fromLTRB(0,10.0,0,0),
    decoration: BoxDecoration(
        color: Colors.brown,
        borderRadius: BorderRadius.all(Radius.circular(20.2))
    ),
    child: TextFormField(
      autofocus: focus,
      keyboardType: TextInputType.multiline,
      minLines: 1,
      maxLines: maximumLines,
      obscureText: is_password,
      decoration: InputDecoration(
          hintText: hint_text,
          prefixIcon: icon, suffixIcon: suffixIcon,
          enabledBorder: InputBorder.none
      ),
      validator: validator,
      controller: controller,

    ),
  );
}

Widget get_form_submit_button({title:"Submit", on_press:null}){
  return ButtonTheme(
    minWidth: 1000.0,
    child: RaisedButton(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18.0),
          side: BorderSide(color: Colors.white10)
      ),
      color: Colors.greenAccent[700],
      child: Container(
        padding: EdgeInsets.all(20.0),
        child: Text(title,style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold
        )),
      ),
      onPressed: on_press,
    ),
  );
}