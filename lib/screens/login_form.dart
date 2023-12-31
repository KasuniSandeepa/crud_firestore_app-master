import 'dart:convert';

import 'package:crud_firestore_app/custom_form_field.dart';
import 'package:crud_firestore_app/screens/home.dart';
import 'package:crud_firestore_app/validators/database.dart';
import 'package:crud_firestore_app/validators/validator.dart';
import 'package:flutter/material.dart';

import '../api/request.dart';

class LoginForm extends StatefulWidget {
  final FocusNode focusNode;
  const LoginForm({
    Key? key,
    required this.focusNode,
  }) : super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final TextEditingController _uidController = TextEditingController();

  final _loginFormKey = GlobalKey<FormState>();

  String getId = "";

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _loginFormKey,
      child: Column(
        children: [
          Padding(
              padding: const EdgeInsets.only(left: 8.0,right: 8.0,bottom: 24.0),
              child: Column(
                children: [
                  CustomFormField(
                    isObscure: true,
                    initialValue: "",
                    controller: _uidController,
                      focusNode: widget.focusNode,
                      keyboardType: TextInputType.text,
                      inputAction: TextInputAction.done,
                      label:'Unique User Id',
                      hint: 'Enter your unique identifier',
                      validator: (value) {
                        Validator.validateField(
                          value: value,
                        );

                        getId = value;
                      },
                  ),
                ],
              ),
          ),
          Padding(
              padding: EdgeInsets.only(left: 0.0,right: 0.0),
            child: Container(
              width: double.maxFinite,
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.orangeAccent),
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                onPressed: () async {
                    // widget.focusNode.unfocus();
                    //
                    // if(_loginFormKey.currentState!.validate()){
                    //  Database.userId = 'kasuni';
                    //
                    //   Navigator.of(context).pushReplacement(
                    //     MaterialPageRoute(builder: (context)=>HomeScreen(),
                    //     ),
                    //   );
                    // }
                  getData('http://192.168.8.118:5000/');
                //  print(data);
                  //var decodedData = jsonDecode(data);
                  //print(decodedData['query']);
                },
                child: Padding(
                  padding:EdgeInsets.only(top: 16.0,bottom: 16.0) ,
                  child: Text(
                    'Login',
                  style: TextStyle(
                      fontSize : 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueGrey,
                      letterSpacing: 2,
                  ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
