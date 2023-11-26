import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eventmanagement/constants/text_style_constant.dart';
import 'package:eventmanagement/user/controller/userid_controller.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';


import 'checkout_page.dart';


class OrderView extends StatelessWidget {
  const OrderView({super.key});

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> events = {};
    final ht = MediaQuery.sizeOf(context).height;
    final wt = MediaQuery.sizeOf(context).width;
    return Scaffold(
      backgroundColor: Colors.black12,
      body: Consumer<UserIdController>(
          builder: (context, userIdController, child) {
        return StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection("Booking")
              .where("userid"
                  "=="
                  "${userIdController.id.toString()}")
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Lottie.asset(
                  "asset/lottie/Animation - 1698750195337.json");
            } else if (snapshot.hasError) {
              return const Text("Error");
            } else if (!snapshot.hasData) {
              return const Text("No Data");
            } else if (snapshot.hasData) {
              final documents = snapshot.data!.docs;

              return Stack(
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: ht * .16, left: wt * .04),
                    child:
                        Text("MY BOOKINGS :", style: MyTextStyle().imgetitle),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: ht * .08),
                    child: ListView.builder(
                      itemCount: documents.length,
                      itemBuilder: (context, index) {
                        final String id = documents[index].id;
                        events.addAll(documents[index].data()["event"]);

                        return Padding(
                          padding: EdgeInsets.only(
                              top: ht * .02, left: wt * .04, right: wt * .04),
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => CheckOutView(
                                            docId: id,
                                            checkout: false,
                                          )));
                            },
                            child: Card(
                              margin: const EdgeInsets.only(),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5)),
                              child: Row(children: [
                                Padding(
                                  padding: EdgeInsets.only(left: wt * .02),
                                  child:
                                      // Text(events["URLlist"][0].toString())
                                      Image(
                                          fit: BoxFit.fill,
                                          height: ht * .1,
                                          width: wt * .2,
                                          image: NetworkImage(
                                              events["URLlist"][0])),
                                ),

                                SizedBox(
                                  height: ht * .15,
                                  child: Padding(
                                    padding: EdgeInsets.only(top: ht * .03),
                                    child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding:  EdgeInsets.only(left: wt*.05),
                                          child: Text(
                                            events["Title"],
                                            style: MyTextStyle().txtstyle4,
                                          ),
                                        ),
                                        SizedBox(
                                          height: ht * .02,
                                        ),
                                        Padding(
                                          padding:
                                              EdgeInsets.only(left: wt * .05),
                                          child: Row(
                                            children: [
                                              Text(
                                                  "Rs . ${snapshot.data!.docs[index].data()["Total"].toString()}",
                                                  style:
                                                      MyTextStyle().dashText),
                                              SizedBox(
                                                width: wt * .02,
                                              ),
                                              Text(
                                                "Date : ${snapshot.data!.docs[index].data()["date"]}",
                                                style: MyTextStyle().dashText,
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),

                                // subtitle: Text(events["Place"]),
                              ]),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              );
            } else {
              return const Text("error");
            }
          },
        );
      }),
    );
  }
}
