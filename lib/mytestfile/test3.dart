// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
//
// class FirestoreCheckboxList extends StatefulWidget {
//   @override
//   _FirestoreCheckboxListState createState() => _FirestoreCheckboxListState();
// }
//
// class _FirestoreCheckboxListState extends State<FirestoreCheckboxList> {
//   final FirebaseFirestore firestore = FirebaseFirestore.instance;
//   final CollectionReference itemsCollection =
//       FirebaseFirestore.instance.collection('Services');
//
//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder<QuerySnapshot>(
//       stream: itemsCollection.snapshots(),
//       builder: (context, snapshot) {
//         if (!snapshot.hasData) {
//           return CircularProgressIndicator();
//         } else {
//           final items = snapshot.data!.docs;
//           return ListView.builder(
//             itemCount: items.length,
//             itemBuilder: (context, index) {
//               final item = items[index];
//               final bool isChecked = item['checked'] ?? false;
//
//               return Container(
//                 child: CheckboxListTile(
//                   title: Text(item['Service']),
//                   value: isChecked,
//                   onChanged: (bool? value) {
//                     itemsCollection.doc(item.id).update({'checked': value!});
//                   },
//                 ),
//               );
//             },
//           );
//         }
//       },
//     );
//   }
// }


