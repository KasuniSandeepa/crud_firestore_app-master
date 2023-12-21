import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crud_firestore_app/validators/database.dart';

class Item {
  final String id;
  final String title;

  // final String description;

  Item ({
    required this.id,
    required this.title,
  });

  // factory Item.fromJSON(Map<String, dynamic> data) {
  //   return Item(
  //     id: data['id'],
  //     title: data['title'],
  //   );
  // }





}
