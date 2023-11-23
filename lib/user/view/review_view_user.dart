import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:lottie/lottie.dart';

import '../../constants/text_style_constant.dart';

class RevViewUser extends StatelessWidget {
  const RevViewUser({super.key});

  @override
  Widget build(BuildContext context) {
    final ht = MediaQuery.sizeOf(context).height;
    final wt = MediaQuery.sizeOf(context).width;
    return Scaffold(appBar: AppBar(),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection("Review").snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: Lottie.asset(
                  height: 200,
                  width: 200,
                  repeat: true,
                  "asset/lottie/Animation - 1697785716628.json"),
            );
          } else if (snapshot.hasError) {
            return const Text("has Error");
          } else if (!snapshot.hasData) {
            return const Text("No Data");
          } else if (snapshot.hasData) {
            final data = snapshot.data!.docs;
            return ListView.builder(itemCount: data.length,itemBuilder: (context, index) {
              Card(elevation: 10,margin: EdgeInsets.only(top: ht*.01,right: wt*.05,left: wt*.05),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                child: Padding(
                  padding:  EdgeInsets.all(wt*.03),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,children: [
                   RatingBarIndicator(itemCount: 3,itemBuilder:(context, index) {
                     return const Icon(Icons.star,color: Colors.amber,);
                   }, ),

                    SizedBox(height: ht*.01,),
                    Expanded(child: Text(" '' ${data[index].data()["review"]} '' ",style: MyTextStyle().cmplnttxt2,overflow: TextOverflow.visible)),
                  ]),
                ),
              );
            },);
          } else {
            return const Text("error");
          }
        },
      ),
    );
  }
}
