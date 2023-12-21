import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crud_firestore_app/custom_form_field.dart';
import 'package:crud_firestore_app/screens/generation/item.dart';
import 'package:crud_firestore_app/screens/generation/qualities.dart';
import 'package:crud_firestore_app/validators/database.dart';
import 'package:crud_firestore_app/validators/validator.dart';
import 'package:flutter/material.dart';
import 'package:multi_select_flutter/bottom_sheet/multi_select_bottom_sheet_field.dart';
import 'package:multi_select_flutter/chip_display/multi_select_chip_display.dart';
import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';

class EditGenerationForm extends StatefulWidget {
  final String documentId;
  final String currentName;
  final String currentDescription;
  final FocusNode nameFocusNode;
  final FocusNode descriptionFocusNode;
  final  List<Item> currentMembers;
  final  List<Strength> currentStrengths;

  const EditGenerationForm({
    required this.documentId,
    required this.currentName,
    required this.currentDescription,
    required this.nameFocusNode,
    required this.descriptionFocusNode,
    required this.currentMembers,
    required this.currentStrengths
  });

  @override
  _EditGenerationFormState createState() => _EditGenerationFormState();
}

class _EditGenerationFormState extends State<EditGenerationForm> {
  final _addItemFormKey = GlobalKey<FormState>();
  bool _isProcessing = false;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  String updateName = "";
  String updateDescription = "";

  String getName = '';
  String getDescription = '';
  //List<String> getMembers = [];
  //late Map<Item,dynamic> getMembers;
  var getMembers = new Map<dynamic, dynamic>();
  var getStrengths = new Map<dynamic, dynamic>();
  late Future<List<Item>> items;
  List<Item> goods = [];
  //late List<MultiSelectItem> _items = [];
  List<Item> _selectedItems = [];
  List<Strength> _selectedStrengths = [];
  List<Item> _initialItems = [];


  @override
  void initState() {
    // TODO: implement initState
    print("kkkkkk");
    print(widget.currentMembers.length);

    // goods.forEach((element) {
    //   if(widget.currentMembers.contains(element)){
    //     _selectedItems.add(element);
    //   }
    // });
   //_selectedItems = await goods[0] as List<Item>;
    print("kasuni");
    Strength.strengths.forEach((element) {
      widget.currentStrengths.forEach((cs) {
        if(cs.id == element.id){
          _selectedStrengths.add(element);
        }
      });
    });

    print(_selectedItems);
    print(widget.currentMembers);
    //_initialItems = widget.currentMembers as List<Item>;
    super.initState();

  }

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
                    initialValue: widget.currentName,
                    isLabelEnabled: false,
                    controller: _nameController,
                    focusNode: widget.nameFocusNode,
                    keyboardType: TextInputType.text,
                    inputAction: TextInputAction.next,
                    label:'Name',
                    hint: 'Write tour title',
                    validator: (value) {
                      Validator.validateField(
                          value: value
                      );
                      updateName = value;
                    },
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
                            print("hiii");
                            widget.currentMembers.forEach((element) {
                                      goods.forEach((member) {
                                        if(element.id == member.id){
                                          print("yes");
                                          _selectedItems.add(member);
                                        }
                                      });
                            });
                            print(docId);
                            // if(widget.currentMembers.contains(Item(id: docId, title: title))){
                            //   print("yess");
                            //   _selectedItems.add(goods.last);
                            // }
                            // goods.forEach((element) {
                            //   if(widget.currentMembers.contains(element)){
                            //     _selectedItems.add(element);
                            //   }
                            // });
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

                      items: goods.map((e) => MultiSelectItem(e,e.title )).toList(),
                      title: Text("Animals"),
                      selectedColor: Colors.blue,
                      searchable: true,
                      initialValue: _selectedItems,

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
                        _selectedItems.forEach((element) {
                          //getMembers.add(element.title);
                          getMembers.addAll({
                            element.id : element.title
                          });
                        });
                        setState(() {
                          _selectedItems = _selectedItems;

                        });

                      },

                      chipDisplay: MultiSelectChipDisplay(
                      //items: _selectedItems.map((e) => MultiSelectItem(e,e.title )).toList(),

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
                    initialValue: _selectedStrengths,
                    buttonText: Text("Strengths"),
                    title: Text("Strengths"),
                    backgroundColor: Colors.white,
                    items: Strength.strengths.map((e) => MultiSelectItem(e,e.name)).toList(),
                    onConfirm: (values) {
                      _selectedStrengths = values.cast<Strength>();
                      setState(() {
                        _selectedStrengths = _selectedStrengths;
                      });
                      _selectedStrengths.forEach((element) {
                        getStrengths.addAll({
                          element.id : element.name
                        });
                      });
                      getStrengths.forEach((key, value) {
                        print("hhh"+key);
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
                  widget.nameFocusNode.unfocus();
                  widget.descriptionFocusNode.unfocus();
                  if(_addItemFormKey.currentState!.validate()){
                    setState(() {
                      _isProcessing = true;
                    });

                    await Database.updateGeneration(name: updateName, description: updateDescription, docId: widget.documentId, strengths: getStrengths, members: getMembers);

                    setState(() {
                      _isProcessing = false;
                    });
                    Navigator.of(context).pop();
                  }
                },
                child: Padding(
                  padding: EdgeInsets.only(top: 16.0,bottom: 16.0),
                  child: Text(
                    'Update Generation',
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