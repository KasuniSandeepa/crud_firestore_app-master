import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crud_firestore_app/custom_form_field.dart';
import 'package:crud_firestore_app/screens/generation/qualities.dart';
import 'package:crud_firestore_app/validators/database.dart';
import 'package:crud_firestore_app/validators/validator.dart';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:giff_dialog/giff_dialog.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

import 'item.dart';

class AddGenerationForm extends StatefulWidget {
  final FocusNode nameFocusNode;
  final FocusNode descriptionFocusNode;
  final FocusNode membersFocusNode;

  // const AddGenerationForm({Key? key}) : super(key: key);

  const AddGenerationForm({
    required this.nameFocusNode,
    required this.descriptionFocusNode,
    required this.membersFocusNode,
  });

  @override
  _AddGenerationFormState createState() => _AddGenerationFormState();
}

class _AddGenerationFormState extends State<AddGenerationForm> {
  final _addGenerationFormKey = GlobalKey<FormState>();
  late List<MultiSelectItem> itemsarray = [];

  bool _isProcessing = false;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _membersController = TextEditingController();

  String getName = '';
  String getDescription = '';

  //List<String> getMembers = [];
  //late Map<Item,dynamic> getMembers;
  var getMembers = new Map<dynamic, dynamic>();
  var getStrengths = new Map<dynamic, dynamic>();

  //var getStrengths = new List<Strength>();
  //List<Strength> getStrengths = [];
  late Future<List<Item>> items;
  List<Item> goods = [];

  //late List<MultiSelectItem> _items = [];
  List<Item> _selectedItems = [];
  List<Strength> _selectedStrengths = [];

  // List<MultiSelectItem<Item>> _items = this.goods.map((e) => MultiSelectItem(e,e.title)).toList();
  // @override
  // initState() {
  //   // TODO: implement initState
  //   fetch();
  //   super.initState();
  //
  // }

//   void fetch() async{
// //     goods = await Database.getData();
// // print(goods);
// //
// //       itemsarray = goods.map((item) => MultiSelectItem<Item>(item, item.title))
// //           .toList();
// //
// //       print(itemsarray);
//
//     Stream<QuerySnapshot> productRef = await Database.readItems();
//     productRef.forEach((field) {
//       field.docs.asMap().forEach((index, data) {
//         //  productName.add(field.docs[index]["name"]);
//
//         //print(field.docs[index].id);
//         goods.add(Item(id: field.docs[index].id, title: field.docs[index]["title"]));
//
//       });
//
//     //  print(goods);
// //      return productName;
//     });
//
//     print("fdsfd");
//     print(goods);
//   }

  // List<MultiSelectItem<Item>>

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
          key: _addGenerationFormKey,
          child: Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Name',
                      style: TextStyle(
                        color: Colors.yellow,
                        fontSize: 22.0,
                        letterSpacing: 1,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8.0),
                    // CustomFormField(
                    //   initialValue: "",
                    //   isLabelEnabled: false,
                    //   controller: _nameController,
                    //   focusNode: widget.nameFocusNode,
                    //   keyboardType: TextInputType.text,
                    //   inputAction: TextInputAction.next,
                    //   validator: (value) {
                    //     Validator.validateField(
                    //       value: value,
                    //     );
                    //
                    //     getName = value;
                    //   },
                    //   label: 'Name',
                    //   hint: 'Write Generation Name',
                    // ),
                    TextField(
                      inputFormatters: [CurrencyTextInputFormatter( locale: 'ko',
                        decimalDigits: 2,
                        symbol: 'Rs ',)],
                      keyboardType: TextInputType.number,
                    ),
                    SizedBox(height: 8.0),
                    StreamBuilder<QuerySnapshot>(
                      stream: Database.readItems(),
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          return Text("Something went wrong");
                        } else if (snapshot.hasData || snapshot.data != null) {
                          return ListView.builder(
                            shrinkWrap: true,
                            //separatorBuilder: (context, index) => SizedBox(height: 16.0),
                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: (context, index) {
                              var noteInfo = snapshot.data!.docs[index].data()
                                  as Map<String, dynamic>;
                              String docId = snapshot.data!.docs[index].id;
                              String title = noteInfo['title'];
                              String description = noteInfo['description'];
                              goods.add(Item(id: docId, title: title));

                              return Text("");
                            },
                          );
                        }
                        return Center(
                          child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(
                                Colors.orangeAccent),
                          ),
                        );
                      },
                    ),
                    MultiSelectDialogField(
                        items: goods
                            .map((e) => MultiSelectItem(e, e.title))
                            .toList(),
                        title: Text("Animals"),
                        selectedColor: Colors.blue,
                        searchable: true,
                        decoration: BoxDecoration(
                            color: Colors.blue.withOpacity(0.1),
                            borderRadius: BorderRadius.all(Radius.circular(40)),
                            border: Border.all(
                              color: Colors.blue,
                              width: 2,
                            )),
                        buttonIcon: Icon(
                          Icons.pets,
                          color: Colors.blue,
                        ),
                        buttonText: Text(
                          "Favorite Animals",
                          style: TextStyle(
                            color: Colors.blue[800],
                            fontSize: 16,
                          ),
                        ),
                        onConfirm: (results) {
                          _selectedItems = results.cast<Item>();
                          setState(() {
                            _selectedItems = _selectedItems;
                          });

                          _selectedItems.forEach((element) {
                            //getMembers.add(element.title);
                            getMembers.addAll({element.id: element.title});
                          });
                        },
                        chipDisplay: MultiSelectChipDisplay(
                          onTap: (value) {
                            setState(() {
                              _selectedItems.remove(value);
                            });
                          },
                        )),
                    MultiSelectBottomSheetField(
                      initialChildSize: 0.4,
                      listType: MultiSelectListType.CHIP,
                      searchable: true,
                      buttonText: Text("Strengths"),
                      title: Text("Strengths"),
                      backgroundColor: Colors.white,
                      items: Strength.strengths
                          .map((e) => MultiSelectItem(e, e.name))
                          .toList(),
                      onConfirm: (values) {
                        _selectedStrengths = values.cast<Strength>();
                        setState(() {
                          _selectedStrengths = _selectedStrengths;
                        });
                        _selectedStrengths.forEach((element) {
                          getStrengths.addAll({element.id: element.name});
                        });
                        getStrengths.forEach((key, value) {
                          print("hhh" + key);
                          print("vvv" + value);
                        });
                      },
                      chipDisplay: MultiSelectChipDisplay(
                        onTap: (value) {
                          setState(() {
                            _selectedStrengths.remove(value);
                          });
                        },
                      ),
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
                          //widget.billNameFocusNode.unfocus();
                          //widget.accountNumberFocusNode.unfocus();

                          // if (_addItemFormKey.currentState!.validate()) {
                          //   setState(() {
                          //     _isProcessing = true;
                          //   });
                          //   await BillPaymentDatabase.addBill(
                          //       billName: getBillName,
                          //       accountNumber: getAccountNumber);
                          //   setState(() {
                          //     _isProcessing = false;
                          //   });
                          //   _showMyDialog();
                          //   // Navigator.of(context).pop();
                          //
                          // }
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
