import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crud_firestore_app/screens/edit_screen.dart';
import 'package:crud_firestore_app/screens/generation/edit_screen.dart';
import 'package:crud_firestore_app/screens/generation/image_test.dart';
import 'package:crud_firestore_app/screens/generation/item.dart';
import 'package:crud_firestore_app/screens/generation/qualities.dart';
import 'package:crud_firestore_app/validators/database.dart';
import 'package:flutter/material.dart';

class GenerationList extends StatelessWidget {
  const GenerationList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: Database.readGenerations(),
      builder: (context, snapshot){
        if(snapshot.hasError){
          return Text("Something went wrong");
        }else if(snapshot.hasData || snapshot.data != null){
          return ListView.separated(
            separatorBuilder: (context, index) => SizedBox(height: 16.0),
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index){
              var generationInfo = snapshot.data!.docs[index].data() as Map<String, dynamic>;
              String docId = snapshot.data!.docs[index].id;
              String name = generationInfo['name'];
              String description = generationInfo['description'];
          // String members = generationInfo['members'].toString() ;
             List m = [];
            //final n = generationInfo['members'].toString().split(',');
             final List<Item> members = [];
             final List<Strength> strengths = [];

              final n = generationInfo['members'] as Map<dynamic,dynamic>;
              n.forEach((key, value) {
                print(key);
                print(value);
                members.add(Item(id: key, title: value));
              });


             // n.forEach((element) {
             //   print(element);
             //   final k = element.split(':');
             //   print("jj");
             //
             //   members.add(Item(id: k[0].trim().replaceAll(RegExp('[^A-Za-z0-9]'), ''), title: k[0].trim().replaceAll(RegExp('[^A-Za-z0-9]'), '')));
             //   print(k[0].trim());
             // });
              print('hhh');
             print(members);
            final strengthsList = generationInfo["strengths"] as Map<dynamic,dynamic>;
            strengthsList.forEach((key, value) {
              print(key);
              print(value);
              strengths.add(Strength(id: key, name: value));
            });

              //List members = [];

              return Ink(
                decoration: BoxDecoration(
                  color: Colors.blueGrey,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: ListTile(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) =>
                      //     EditGenerationScreen(
                      //   currentName: name,
                      //   currentDescription: description,
                      //   documentId: docId,
                      //   currentMembers: members,
                      //   currentStrengths: strengths,
                      // ),
                      ImageSliderTest()
                    ),
                  ),
                  title: Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: Text(
                      generationInfo['members'].toString(),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  subtitle: Text(
                    description,
                    maxLines: 1,
                    overflow:  TextOverflow.ellipsis,
                  ),
                ),
              );

            },

          );
        }
        return Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.orangeAccent),
          ),
        );
      },
    );
  }
}

