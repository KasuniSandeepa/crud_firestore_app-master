import 'package:crud_firestore_app/screens/add_screen.dart';
import 'package:crud_firestore_app/screens/app_bar.dart';
import 'package:crud_firestore_app/screens/generation/add_generation_screen.dart';
import 'package:crud_firestore_app/screens/generation/generation_list.dart';
import 'package:crud_firestore_app/screens/generation/item.dart';
import 'package:crud_firestore_app/screens/item_list.dart';
import 'package:crud_firestore_app/validators/database.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF2C384A),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color(0xFF2C384A),
        title: AppBarTitle(
          sectionName: 'CRUD'
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
                builder: (context) => AddGenerationScreen(),
            )
          );


         //List<Item> items = Database.getData();
         //print(items);




         // print(items.length);
         // items.forEach((element) {
         //   print('hhh');
         //   print(element.title);
         // });

        },
        backgroundColor: Colors.orangeAccent,
        child: Icon(
          Icons.add,
          color: Colors.white,
          size: 32,
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 20.0),
          child: GenerationList(),
        ),
      ),
    );
  }
}
