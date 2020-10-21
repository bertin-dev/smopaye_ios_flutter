import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final String emptyValidatorText;
  final TextEditingController controller;
  final Function onSavedFunc;
  final TextInputType keyboardType;
  final IconData icon;
  final Function validator;
  final Function onChangedFunc;
  final int maxLength;
  final Color labelColor;

  const CustomTextField({
    Key key,
    this.hintText,
    @required this.emptyValidatorText,
    @required this.controller,
    this.onSavedFunc,
    this.keyboardType,
    this.icon,
    this.validator,
    this.onChangedFunc, 
    this.maxLength,
    this.labelColor
  });
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        primaryColor: Color(0xff039BE5),

      ),
      child: maxLength != null ? TextFormField(
        style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18.0, color: Color(0xff039BE5)), 
        cursorColor: Color(0xff039BE5),      
        maxLength: maxLength,                                       
        keyboardType: this.keyboardType,
        decoration: InputDecoration(
          suffixIcon: Icon(this.icon, color: Color(0xff039BE5),),
          labelText: this.hintText,
          labelStyle: TextStyle(fontWeight: FontWeight.w400, fontSize: 18.0, color: this.labelColor),
          //prefixIcon: Icon(icon, /*color: Color(0xff039BE5)*/),
          //hintText: this.hintText,
          //filled: true,
          //fillColor: Color.fromRGBO(255, 255, 255, 0.7), 
          //contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 5.0),
          enabledBorder:UnderlineInputBorder(
            borderSide: BorderSide(color: Color(0xff039BE5), width: 2.3, style: BorderStyle.solid)
          )
        ),
        validator: this.validator,
        controller: controller,
        onChanged: this.onChangedFunc,
        onSaved: this.onSavedFunc,
      )
      :
      TextFormField(     
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0, color: Color(0xff039BE5)),                                  
        keyboardType: this.keyboardType,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(0.0),
          labelText: this.hintText,
          labelStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0, color: this.labelColor),
          //filled: true,
          //fillColor: Color.fromRGBO(255, 255, 255, 0.7), 
          //contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 5.0),
          enabledBorder:UnderlineInputBorder(
            borderSide: BorderSide(color: Color(0xff039BE5), width: 2.0, style: BorderStyle.solid)
          )
        ),
        validator: this.validator,
        controller: controller,
        onChanged: this.onChangedFunc,
        onSaved: this.onSavedFunc,
      )
      ,
    );
  }
}