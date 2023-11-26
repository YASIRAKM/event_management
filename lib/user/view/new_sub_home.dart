import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eventmanagement/constants/color_constants.dart';
import 'package:eventmanagement/constants/text_style_constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controller/userid_controller.dart';
import 'service_select.dart';

class SubHome extends StatelessWidget {
  const SubHome({super.key});

  @override
  Widget build(BuildContext context) {
    final ht = MediaQuery.sizeOf(context).height;
    final wt = MediaQuery.sizeOf(context).width;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(),
        child: StreamBuilder(
          stream: FirebaseFirestore.instance.collection("Event").snapshots(),
          builder: (context, snapshot) {
            List<String> imageUrls = [];
            for (QueryDocumentSnapshot<Map<String, dynamic>> document
                in snapshot.data!.docs) {
              List<dynamic>? documentImageUrls = document['URLlist'];
              if (documentImageUrls != null && documentImageUrls.isNotEmpty) {
                imageUrls.add(documentImageUrls[0]);
              }
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return const Center(
                child: Text("has error"),
              );
            } else if (!snapshot.hasData) {
              return const Center(
                child: Text("Has No Data "),
              );
            } else if (snapshot.hasData) {
              return Stack(
                children: [
                  // Text("Welcome :"),
                  Padding(
                    padding: EdgeInsets.only(top: ht * .15),
                    child: CarouselSlider.builder(
                        itemCount: imageUrls.length,
                        itemBuilder: (context, index, realIndex) {
                          return Card(
                            margin: EdgeInsets.only(bottom: ht * .03),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(0)),
                            child: Container(
                              height: ht * .25,
                              width: wt * .9,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(0),
                                  image: DecorationImage(
                                      scale: 5,
                                      fit: BoxFit.fill,
                                      image: NetworkImage(imageUrls[index]))),
                              child: Padding(
                                padding: EdgeInsets.only(
                                    top: ht * .15, left: wt * .01),
                                child: Text(
                                  snapshot.data!.docs[index]["Description"],
                                  overflow: TextOverflow.fade,
                                  style: MyTextStyle().imgetitle,
                                ),
                              ),
                            ),
                          );
                        },
                        options: CarouselOptions(
                            enableInfiniteScroll: true,
                            viewportFraction: 1,
                            height: ht * .27,
                            enlargeStrategy: CenterPageEnlargeStrategy.zoom,
                            pauseAutoPlayOnTouch: true,
                            animateToClosest: true,
                            autoPlay: true,
                            aspectRatio: .1,
                            autoPlayCurve: Curves.linear,
                            enlargeCenterPage: true,
                            enlargeFactor: .6,
                            autoPlayInterval: const Duration(seconds: 5),
                            scrollPhysics: const ClampingScrollPhysics())),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        top: ht * .4, left: wt * .03, right: wt * .03),
                    child: const Divider(
                      thickness: 2,
                      color: Colors.blue,
                    ),
                  ),

                  Padding(
                    padding: EdgeInsets.only(
                        top: ht * .32, left: wt * .05, right: wt * .05),
                    child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2, crossAxisSpacing: ht * .02),
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => ServiceSelect(
                                          uid: snapshot.data!.docs[index].id,
                                          title: snapshot.data!.docs[index]
                                              .data()["Title"],
                                        )));
                          },
                          child: Card(
                            margin: EdgeInsets.only(bottom: ht * .03),
                            elevation: 1,
                            color: MyColorConst().card1,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            child: Column(
                              children: [
                                Image(
                                    fit: BoxFit.cover,
                                    width: wt * .5,
                                    height: ht * .13,
                                    image: NetworkImage(imageUrls[index])),
                                Column(
                                  children: [
                                    Text(
                                        snapshot.data!.docs[index]
                                            .data()["Title"],
                                        style: MyTextStyle().subhometitle),
                                    Padding(
                                      padding:
                                          EdgeInsets.only(left: wt * .12),
                                      child: Row(
                                        children: [
                                          Text("Price :",
                                              style:
                                                  MyTextStyle().subhomeprice),
                                          Text(
                                              snapshot.data!.docs[index]
                                                  .data()["price"],
                                              style:
                                                  MyTextStyle().subhomeprice),
                                        ],
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        );
                      },
                      itemCount: snapshot.data!.docs.length,
                    ),
                  )
                ],
              );
            } else {
              return const Text("error");
            }
          },
        ),
      ),
    );
  }
}
