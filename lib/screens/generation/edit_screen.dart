import 'package:crud_firestore_app/screens/app_bar.dart';
import 'package:crud_firestore_app/screens/edit_item_form.dart';
import 'package:crud_firestore_app/screens/generation/edit_generation_form.dart';
import 'package:crud_firestore_app/screens/generation/item.dart';
import 'package:crud_firestore_app/screens/generation/qualities.dart';
import 'package:crud_firestore_app/validators/database.dart';
import 'package:flutter/material.dart';

class EditGenerationScreen extends StatefulWidget {
  final String currentName;
  final String currentDescription;
  final String documentId;
  final List<Item>  currentMembers;
  final List<Strength>  currentStrengths;

  EditGenerationScreen({
    required this.currentName,
    required this.currentDescription,
    required this.documentId,
    required this.currentMembers,
    required this.currentStrengths,
  });

  @override
  _EditGenerationScreenState createState() => _EditGenerationScreenState();
}

class _EditGenerationScreenState extends State<EditGenerationScreen> {
  final FocusNode _nameFocusNode = FocusNode();
  final FocusNode _descriptionFocusNode = FocusNode();

  bool _isDeleting = false;


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        _nameFocusNode.unfocus();
        _descriptionFocusNode.unfocus();
      },
      child: Scaffold(
          backgroundColor: Color(0xFF2C384A),
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Color(0xFF2C384A),
            title: AppBarTitle(
              sectionName: 'CRUD',
            ),
            actions: [
              _isDeleting
                  ? Padding(
                padding: const EdgeInsets.only(top: 10.0,bottom: 10.0,right: 16.0),
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                    Colors.redAccent,
                  ),
                  strokeWidth: 3,
                ),
              ) : IconButton(
                  onPressed: () async{
                    setState(() {
                      _isDeleting = true;
                    });
                    await Database.deleteGeneration(
                      docId: widget.documentId,
                    );
                    setState(() {
                      _isDeleting = false;
                    });
                    Navigator.of(context).pop();
                  },
                  icon: Icon(Icons.delete_forever, color: Colors.redAccent, size: 32,)
              )
            ],
          ),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(
                left: 16.0,
                right: 16.0,
                bottom: 20.0,
              ),
              child: EditGenerationForm(
                documentId: widget.documentId,
                nameFocusNode: _nameFocusNode,
                descriptionFocusNode: _descriptionFocusNode,
                currentName: widget.currentName,
                currentDescription: widget.currentDescription,
                currentMembers: widget.currentMembers,
                currentStrengths: widget.currentStrengths,
              ),
            ),
          )
      ),
    );
  }
}