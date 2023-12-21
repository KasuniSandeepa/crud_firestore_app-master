import 'package:crud_firestore_app/custom_form_field.dart';
import 'package:crud_firestore_app/validators/database.dart';
import 'package:crud_firestore_app/validators/validator.dart';
import 'package:flutter/material.dart';

class EditItemForm extends StatefulWidget {
  final String documentId;
  final String currentTitle;
  final String currentDescription;
  final FocusNode titleFocusNode;
  final FocusNode descriptionFocusNode;

  const EditItemForm({
    required this.documentId,
    required this.currentTitle,
    required this.currentDescription,
    required this.titleFocusNode,
    required this.descriptionFocusNode,
  });

  @override
  _EditItemFormState createState() => _EditItemFormState();
}

class _EditItemFormState extends State<EditItemForm> {
  final _addItemFormKey = GlobalKey<FormState>();
  bool _isProcessing = false;

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  String updateTitle = "";
  String updateDescription = "";

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: _addItemFormKey,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 8.0,right: 8.0,bottom: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 24.0),
                  Text(
                    "Title",
                    style: TextStyle(
                        color: Colors.yellow,
                        fontSize: 22.0,
                        letterSpacing: 1,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                  SizedBox(height: 8.0),
                  CustomFormField(
                    initialValue: widget.currentTitle,
                    isLabelEnabled: false,
                    controller: _titleController,
                    focusNode: widget.titleFocusNode,
                    keyboardType: TextInputType.text,
                    inputAction: TextInputAction.next,
                    label:'Title',
                    hint: 'Write tour title',
                    validator: (value) {
                      Validator.validateField(
                          value: value
                      );
                      updateTitle = value;
                    },
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    "Description",
                    style: TextStyle(
                        color: Colors.yellow,
                        fontSize: 22.0,
                        letterSpacing: 1,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                  SizedBox(height: 8.0),
                  CustomFormField(
                    initialValue: widget.currentDescription,
                    maxLines: 10,
                    isLabelEnabled: false,
                    controller: _descriptionController,
                    focusNode: widget.descriptionFocusNode,
                    keyboardType: TextInputType.text,
                    inputAction: TextInputAction.next,
                    label:'Description',
                    hint: 'Write tour description',
                    validator: (value) {
                      Validator.validateField(
                          value: value
                      );
                      updateDescription = value;
                    },
                  ),
                ],
              ),
            ),
            _isProcessing
                ? Padding(
              padding: const EdgeInsets.all(16.0),
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.orangeAccent),
              ),
            ) : Container(
              width: double.maxFinite,
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.orangeAccent),
                  shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      )
                  ),
                ),
                onPressed: () async{
                  widget.titleFocusNode.unfocus();
                  widget.descriptionFocusNode.unfocus();
                  if(_addItemFormKey.currentState!.validate()){
                    setState(() {
                      _isProcessing = true;
                    });

                    await Database.updateItem(title: updateTitle, description: updateDescription, docId: widget.documentId);

                    setState(() {
                      _isProcessing = false;
                    });
                    Navigator.of(context).pop();
                  }
                },
                child: Padding(
                  padding: EdgeInsets.only(top: 16.0,bottom: 16.0),
                  child: Text(
                    'Update Data',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueGrey,
                      letterSpacing: 2,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}