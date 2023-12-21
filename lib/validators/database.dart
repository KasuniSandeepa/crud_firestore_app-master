import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crud_firestore_app/screens/generation/item.dart';
import 'package:crud_firestore_app/screens/generation/qualities.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final CollectionReference _mainCollection = _firestore.collection('notes');

class Database{
  static String? userId;
  static List<Object?> itemsList = [];
  static List<Item> itemsArray = [];

  static Future<void> addItem({

  required String title,
  required String description
  })async{
        DocumentReference documentReference = _mainCollection.doc(userId).collection('item').doc();

        Map<String, dynamic> data = <String , dynamic>{
          'title' : title,
          'description': description,
        };

        await documentReference.set(data).whenComplete(() => print('Note item inserted to the database')).catchError((e)=> print(e));
  }

  static Future<void> updateItem({

    required String title,
    required String description,
    required String docId,
    })  async{
      DocumentReference documentReference = _mainCollection.doc(userId).collection('item').doc(docId);

      Map<String, dynamic> data = <String , dynamic>{
        'title' : title,
        'description': description,
      };

      await documentReference.set(data).whenComplete(() => print('Note item updated in the database')).catchError((e)=> print(e));

  }

  static Stream<QuerySnapshot> readItems(){
    CollectionReference notesItemCollection = _mainCollection.doc(userId).collection('item');

    return notesItemCollection.snapshots();
  }



  static Future<void> deleteItem({
    required String docId,
  }) async{
    DocumentReference documentReference = _mainCollection.doc(userId).collection('item').doc(docId);
    await documentReference.delete().whenComplete(() => print("Note item deleted from the database")).catchError((e) => print(e));
  }

  //Generation
  static Future<void> addGeneration({

    required String name,
    required String description,
    //required List<String> members
    required Map<dynamic,dynamic> members,
    required Map<dynamic,dynamic> strengths,
    //required List<Strength> strengths,
  })async{
    DocumentReference documentReference = _mainCollection.doc(userId).collection('generation').doc();

    Map<String, dynamic> data = <String , dynamic>{
      'name' : name,
      'description': description,
      'members': members,
      'strengths' : strengths
    };

    await documentReference.set(data).whenComplete(() => print('Generation inserted to the database')).catchError((e)=> print(e));
  }

  static Future<void> updateGeneration({

    required String name,
    required String description,
    required String docId,
    required Map<dynamic,dynamic> members,
    required Map<dynamic,dynamic> strengths,
  })  async{
    DocumentReference documentReference = _mainCollection.doc(userId).collection('generation').doc(docId);

    Map<String, dynamic> data = <String , dynamic>{
      'name' : name,
      'description': description,
      'members': members,
      'strengths' : strengths
    };

    await documentReference.set(data).whenComplete(() => print('Generation updated in the database')).catchError((e)=> print(e));

  }

  static Stream<QuerySnapshot> readGenerations(){
    CollectionReference generationItemsCollection = _mainCollection.doc(userId).collection('generation');

    return generationItemsCollection.snapshots();
  }

  static Future<void> deleteGeneration({
    required String docId,
  }) async{
    DocumentReference documentReference = _mainCollection.doc(userId).collection('generation').doc(docId);
    await documentReference.delete().whenComplete(() => print("Generation deleted from the database")).catchError((e) => print(e));
  }

  // static Future<void> getData() async {
  //
  //   // Get docs from collection reference
  //
  //
  //   CollectionReference notesItemCollection = _mainCollection.doc(userId).collection('item');
  //
  //   QuerySnapshot querySnapshot = await notesItemCollection.get();
  //
  //   // Get data from docs and convert map to List
  //
  //   final allData = querySnapshot.docs.map((doc) => doc.data()).toList();
  //
  //   querySnapshot.docs.
  //
  //   //final json = jsonEncode(allData);
  //  //   print(json);
  //
  //  //Iterable l = json.decode(response.body);
  //    //itemsArray = List<Item>.from(allData.map((model)=> Item.fromJSON(model)));
  //
  //   void queryValues() {
  //     Firestore.instance
  //         .collection('myCollection')
  //         .snapshots()
  //         .listen((snapshot) {
  //       double tempTotal = snapshot.documents.fold(0, (tot, doc) => tot + doc.data['amount']);
  //       setState(() {total = tempTotal;});
  //       debugPrint(total.toString());
  //     });
  //   }
  //
  //
  // }

  // static Future<List<Item>> getData() async {
  //   List<Item> entries = [];
  //   final numbers = [1,2,3];
  //   CollectionReference notesItemCollection = _mainCollection.doc(userId).collection('item');
  //   notesItemCollection.snapshots().forEach((element) {
  //     element.docs.forEach((element) {
  //   //  print(element.id);
  //       print('kasuni');
  //       //entries.add(Item(id: element.id, title: element.get('title')));
  //       entries.add(Item(id: 'kasuni', title: 'kasuni'));
  //       numbers.add(4);
  //
  //     });
  //   });
  //
  //
  //
  //   print(entries);
  //   print(numbers);
  //   return entries;
  // }

//   static Future<List<Item>>  getData() async {
//     List<Item> productName= [];
//
//     Stream<QuerySnapshot> productRef =  await _mainCollection.doc(userId).collection('item').snapshots();
//     productRef.forEach((field) {
//       field.docs.asMap().forEach((index, data) {
//       //  productName.add(field.docs[index]["name"]);
//
//         //print(field.docs[index].id);
//         productName.add(Item(id: field.docs[index].id, title: field.docs[index]["title"]));
//
//       });
//
// //      return productName;
//     });
//      return productName;
//
//   }

//   static Future<List<Item>>  getData() async {
//     List<Item> productName= [];
//
//     Stream<QuerySnapshot> productRef =  await _mainCollection.doc(userId).collection('item').snapshots();
// //     productRef.forEach((field) {
// //       field.docs.asMap().forEach((index, data) {
// //         //  productName.add(field.docs[index]["name"]);
// //
// //         //print(field.docs[index].id);
// //         productName.add(Item(id: field.docs[index].id, title: field.docs[index]["title"]));
// //
// //       });
// //
// // //      return productName;
// //     });
//
//     productRef.forEach((element) {
//       for(DocumentSnapshot item in element.docs){
//         var data = item.data;
//
//         productName.add(Item(i, title: title))
//       }
//
//     })
//     return productName;
//
//   }

}


