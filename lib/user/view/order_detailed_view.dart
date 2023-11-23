// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:lottie/lottie.dart';
// import 'package:provider/provider.dart';
//
// import '../controller/checkout_controller.dart';
//
// // class OrderDetailed extends StatelessWidget {
//   final String uid;
//
//   const OrderDetailed({super.key, required this.uid});
//
//   @override
//   Widget build(BuildContext context) {
//     final checkOutController = Provider.of<CheckOutController>(context);
//     final Map<String, dynamic> events = {};
//     final List<dynamic> listOfMaps = [];
//     return Scaffold(
//       body: StreamBuilder(
//         stream: FirebaseFirestore.instance
//             .collection("Booking")
//             .doc(uid)
//             .snapshots(),
//         builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Lottie.asset("asset/lottie/Animation - 1698750195337.json");
//           } else if (snapshot.hasError) {
//             return const Text("Error");
//           } else if (!snapshot.hasData) {
//             return const Text("No Data");
//           } else if (snapshot.hasData) {
//             events.addAll(snapshot.data!["event"]);
//             listOfMaps.addAll(snapshot.data!.get('services') as List<dynamic>);
//             checkOutController.updateTotal(events, listOfMaps);
//
//             return Stack(children: [
//               Column(
//                 children: [
//                   Text(snapshot.data!["date"]),
//                   Text(events["Price"].toString()),
//                   Text(events["Title"]),
//                   Image(height: 30, image: NetworkImage(events["URL"])),
//                 ],
//               ),
//               Padding(
//                 padding: const EdgeInsets.only(top: 100),
//                 child: ListView.builder(
//                   itemBuilder: (context, index) {
//                     return Column(
//                       children: [
//                         Text(listOfMaps[index]["Service"]),
//                         Text(listOfMaps[index]["Price"].toString()),
//                       ],
//                     );
//                   },
//                   itemCount: listOfMaps.length,
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.only(top: 700),
//                 child: Text(checkOutController.total.toString()),
//               ),
//             ]);
//           } else {
//             return const Text("error");
//           }
//         },
//       ),
//     );
//   }
// }
