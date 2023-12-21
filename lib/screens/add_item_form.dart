import 'package:crud_firestore_app/custom_form_field.dart';
import 'package:crud_firestore_app/validators/database.dart';
import 'package:crud_firestore_app/validators/validator.dart';
import 'package:flutter/material.dart';

class AddItemForm extends StatefulWidget {
  final FocusNode titleFocusNode;
  final FocusNode descriptionFocusNode;

  const AddItemForm({
    required this.titleFocusNode,
    required this.descriptionFocusNode,
  });

  @override
  _AddItemFormState createState() => _AddItemFormState();
}

class _AddItemFormState extends State<AddItemForm> {
  final _addItemFormKey = GlobalKey<FormState>();

  bool _isProcessing = false;

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  String getTitle = '';
  String getDescription = '';

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
          key: _addItemFormKey,
          child: Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 24.0),
                    Text(
                      'Title',
                      style: TextStyle(
                        color: Colors.yellow,
                        fontSize: 22.0,
                        letterSpacing: 1,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8.0),
                    CustomFormField(
                      initialValue: "",
                      isLabelEnabled: false,
                      controller: _titleController,
                      focusNode: widget.titleFocusNode,
                      keyboardType: TextInputType.text,
                      inputAction: TextInputAction.next,
                      validator: (value) {
                        Validator.validateField(
                          value: value,
                        );

                        getTitle = value;
                      },
                      label: 'Title',
                      hint: 'Write Your Title',
                    ),
                    SizedBox(height: 24.0),
                    Text(
                      'Description',
                      style: TextStyle(
                        color: Colors.yellow,
                        fontSize: 22.0,
                        letterSpacing: 1,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8.0),
                    CustomFormField(
                      initialValue: "",
                      maxLines: 10,
                      isLabelEnabled: false,
                      controller: _descriptionController,
                      focusNode: widget.descriptionFocusNode,
                      keyboardType: TextInputType.text,
                      inputAction: TextInputAction.next,
                      validator: (value) {
                        Validator.validateField(
                          value: value,
                        );

                        getDescription = value;
                      },
                      label: 'Description',
                      hint: 'Write Your Description',
                    ),
                  ],
                ),
              ),
              _isProcessing
                  ? Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: CircularProgressIndicator(
                        valueColor:
                            AlwaysStoppedAnimation<Color>(Colors.orangeAccent),
                      ),
                    )
                  : Container(
                      width: double.maxFinite,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                              Color.fromRGBO(253, 198, 13, 1)),
                          shape:
                              MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          )),
                        ),
                        onPressed: () async {
                          // widget.billNameFocusNode.unfocus();
                          // widget.accountNumberFocusNode.unfocus();

                          if (_addItemFormKey.currentState!.validate()) {
                            setState(() {
                              _isProcessing = true;
                            });
                            //await BillPaymentDatabase.addBill(billName: getBillName, accountNumber: getAccountNumber);
                            setState(() {
                              _isProcessing = false;
                            });
                            //_showMyDialog();
                            // Navigator.of(context).pop();

                          }
                        },
                        child: const Padding(
                          padding: EdgeInsets.only(top: 16.0, bottom: 16.0),
                          child: Text(
                            'Save',
                            style: TextStyle(
                              fontSize: 19,
                              fontWeight: FontWeight.bold,
                              color: Colors.black45,
                              letterSpacing: 2,
                            ),
                          ),
                        ),
                      ),
                    )
            ],
          )),
    );
  }
}
