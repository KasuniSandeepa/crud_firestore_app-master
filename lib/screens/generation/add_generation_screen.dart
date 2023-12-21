import 'package:crud_firestore_app/screens/add_item_form.dart';
import 'package:crud_firestore_app/screens/app_bar.dart';
import 'package:crud_firestore_app/screens/generation/add_generation_form.dart';
import 'package:flutter/material.dart';

class AddGenerationScreen extends StatelessWidget {

  final FocusNode _nameFocusNode = FocusNode();
  final FocusNode _descriptionFocusNode = FocusNode();
  final FocusNode _membersFocusNode = FocusNode();



  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        _nameFocusNode.unfocus();
        _descriptionFocusNode.unfocus();
        _membersFocusNode.unfocus();
      },
      child: Scaffold(
        backgroundColor: Color(0xFF2C384A),
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Color(0xFF2C384A),
          title: AppBarTitle(
              sectionName: 'Add Generation'
          ),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 20.0),
            child: AddGenerationForm(
                nameFocusNode  : _nameFocusNode,
                descriptionFocusNode : _descriptionFocusNode,
                membersFocusNode : _membersFocusNode,
            ),
          ),
        ),
      ),
    );
  }
}
