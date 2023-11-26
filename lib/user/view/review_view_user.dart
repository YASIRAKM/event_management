import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eventmanagement/constants/color_constants.dart';
import 'package:eventmanagement/utils/common_appbar_user.dart';
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
    return Scaffold(
      backgroundColor: MyColorConst().backgroundColor,
      appBar: const CommonAppBarUser(clr: true, title1: 'Reviews'),
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
            return Padding(
              padding: EdgeInsets.only(top: ht * .03),
              child: ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {

                  return Card(
                    elevation: 0,
                    margin: EdgeInsets.only(
                        left: wt * .1, bottom: ht * .05, right: wt * .1),
                    child: Padding(
                      padding: EdgeInsets.only(top: ht * .02, left: wt * .05),
                      child: SizedBox(
                        height:  ht * .3,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            StreamBuilder(
                              stream: FirebaseFirestore.instance
                                  .collection("Users")
                                  .where("Id" "==" "${data[index]["userid"]}")
                                  .snapshots(),
                              builder: (context, snapshot) {
                                if (!snapshot.hasData && snapshot.hasError) {
                                  return const Text("error");
                                } else if (snapshot.hasData) {
                                  return Row(
                                    children: [
                                      SizedBox(
                                          width: wt * .2,
                                          child: Text(
                                              snapshot.data!.docs[0]["Name"],style: MyTextStyle().cmplnttxt,)),
                                      Text(snapshot.data!.docs[0]["E mail"],style: MyTextStyle().cmplnttxt,),
                                    ],
                                  );
                                } else {
                                  return const Text("has error");
                                }
                              },
                            ),
                            SizedBox(
                              height: ht * .02,
                            ),
                            RatingBarIndicator(
                              unratedColor: MyColorConst().unRatedColor,
                              itemBuilder: (context, index) {
                                return Icon(
                                  Icons.star,
                                  color: MyColorConst().ratingColor,
                                );
                              },
                              itemCount: 5,
                              itemSize: 25,
                              rating: data[index]["rating"],
                            ),
                            SizedBox(
                              height: ht * .02,
                            ),
                            Expanded(
                              child: SizedBox(
                                height: ht * .1,
                                child: Text("'${data[index]["review"]}'",style: MyTextStyle().cmplnttxt2),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            );
          } else {
            return const Text("error");
          }
        },
      ),
    );
  }
}
