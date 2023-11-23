import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eventmanagement/utils//common_appbar_admin.dart';
import 'package:eventmanagement/admin/view/booked_view/booked_view.dart';
import 'package:eventmanagement/constants/color_constants.dart';
import 'package:eventmanagement/constants/text_style_constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../../../utils/new_row_icon_txt.dart';
import '../../controller/fetching_data.dart';

class BookedEvent extends StatelessWidget {
  final String docid;

  const BookedEvent({super.key, required this.docid});

  @override
  Widget build(BuildContext context) {
    final ht = MediaQuery.sizeOf(context).height;
    final wt = MediaQuery.sizeOf(context).width;
    final FetchDataAdmin fetchData = Provider.of<FetchDataAdmin>(context);
    fetchData.fetchDataWithDocument("Booking", docid);
    return Scaffold(
        appBar: const CommonAppbar(
            txt: 'Booked',
            drawericon: CupertinoIcons.back,
            clrs: MyColorConst.color1),
        body: Padding(
          padding: EdgeInsets.only(top: ht * .03),
          child: Card(
            margin: EdgeInsets.only(
                left: wt * .05,
                right: wt * .05,
                top: ht * .03,
                bottom: ht * .1),
            child: StreamBuilder(
              stream: fetchData.dataStream2,
              // FirebaseFirestore.instance
              //     .collection("Booking")
              //     .doc(docid)
              //     .snapshots(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasError) {
                  return const Text('error');
                } else if (!snapshot.hasData) {
                  return const Text("no data");
                } else if (snapshot.hasData) {
                  Map<String, dynamic> events = snapshot.data["event"];
                  // List<Map<String, dynamic>> mapList = snapshot.data!.map((DocumentSnapshot document) {
                  //   return document.data() as Map<String, dynamic>;
                  // }).toList();
                  List services = snapshot.data["services"];
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Card(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                                height: ht * .15,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        fit: BoxFit.fill,
                                        image: NetworkImage(
                                            events["URLlist"][0])))),
                            Text(events["Title"],
                                style: MyTextStyle().txtstyle4),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  FontAwesomeIcons.indianRupeeSign,
                                  color: MyColorConst.color1,
                                ),
                                Text(events["price"],
                                    style: MyTextStyle().txtstyle4),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding:  EdgeInsets.only(left: wt*.01),
                        child: SizedBox(height: ht*.075,
                          child: StreamBuilder(stream: FirebaseFirestore.instance.collection("Users").where("Id" "==" "${snapshot.data["userid"]}").snapshots(), builder: (context, snapshot) {
                            return Column(crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(snapshot.data!.docs[0]["Name"],style: MyTextStyle().txtstyle4),
                                    Text(snapshot.data!.docs[0]["E mail"],style: MyTextStyle().txtstyle4),
                                  ],
                                ),
                                Text(snapshot.data!.docs[0]["Phone no"],style: MyTextStyle().txtstyle4),
                              ],
                            );

                          },),
                        ),
                      ),
                      SizedBox(height: ht*.025,),
                      Text(
                        "Services Booked :",
                        style: MyTextStyle().txtstyle4,
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: wt * .03, right: wt * .03, top: ht * .01),
                        child: SizedBox(
                            height: ht * .2,
                            child: CarouselSlider.builder(
                                itemCount: services.length,
                                itemBuilder: (context, index, realIndex) {
                                  return Column(children: [
                                    Container(
                                      height: ht * .13,
                                      width: wt * .3,
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                              fit: BoxFit.fill,
                                              image: NetworkImage(
                                                  services[index]["URL"]))),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          left: wt * .15, top: ht * .03),
                                      child: Row(
                                        children: [
                                          SizedBox(
                                            width: wt * .25,
                                            child: Text(
                                              services[index]["Service"],
                                              style: MyTextStyle().txtstyle2,
                                            ),
                                          ),
                                          Icon(
                                              FontAwesomeIcons
                                                  .indianRupeeSign,
                                              size: wt * .04),
                                          Text(
                                              services[index]["Price"]
                                                  .toString(),
                                              style: MyTextStyle().txtstyle2),
                                        ],
                                      ),
                                    )
                                  ]);
                                },
                                options: CarouselOptions(autoPlay: true,autoPlayAnimationDuration: const Duration(seconds: 1),
                                    height: ht * .19,
                                  autoPlayInterval:const  Duration(seconds: 3),
                                  enlargeFactor: .2,
                                  aspectRatio: .3,
                                  enableInfiniteScroll: true,
                                ))),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: ht * .03, left: wt * .05),
                        child: Row(
                          children: [
                            NewRowICOnTxtWidget(
                              ics: FontAwesomeIcons.streetView,
                              txt: snapshot.data["Place"],
                              clr: MyColorConst.color1,
                              txtstl: MyTextStyle().txtstyle4,
                              w: wt * .5,
                              h: ht * .05,
                            ),
                            NewRowICOnTxtWidget(
                              ics: Icons.date_range,
                              txt: snapshot.data["date"],
                              clr: MyColorConst.color1,
                              txtstl: MyTextStyle().txtstyle4,
                              w: wt * .35,
                              h: ht * .05,
                            )
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Total :",
                              style: MyTextStyle().drawerHeaderText),
                          NewRowICOnTxtWidget(
                            ics: FontAwesomeIcons.indianRupeeSign,
                            txt: snapshot.data["Total"],
                            clr: MyColorConst.color1,
                            txtstl: MyTextStyle().txtstyle4,
                            w: wt * .35,
                            h: ht * .05,
                          )
                        ],
                      ),
                    ],
                  );
                } else {
                  return const Text("error");
                }
                // return Container(decoration: BoxDecoration(image: DecorationImage(image: NetworkImage(events["URL"]))),);
              },
            ),
          ),
        ));
  }
}
