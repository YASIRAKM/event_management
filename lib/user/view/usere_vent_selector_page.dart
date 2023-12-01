import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:eventmanagement/constants/color_constants.dart';
import 'package:eventmanagement/constants/text_style_constant.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../utils/new_row_icon_txt.dart';

import '../controller/user_home_controller.dart';
import '../controller/value_changing_controller.dart';

import 'service_select.dart';

class UsereventSelect extends StatelessWidget {
  const UsereventSelect({super.key});

  @override
  Widget build(BuildContext context) {
    final ht = MediaQuery.sizeOf(context).height;
    final wt = MediaQuery.sizeOf(context).width;

    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text("Select Event", style: MyTextStyle().drawerHeaderText),
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection("Event").snapshots(),
          builder: (context, snapshot) {
            if(snapshot.connectionState==ConnectionState.waiting){
              return const Center(child: CircularProgressIndicator(),);
            }
            return Consumer< UserBasicController>(
              builder: (context, valueChanger, _) {
                if (snapshot.hasError) {
                  return const  Center(
                    child:CircularProgressIndicator(),
                  );
                } else {
                  final image =snapshot.data!.docs[valueChanger.current]["URLlist"][0];
                      // eventController.events[valueChanger.current].imageUrl[0];

                  return Stack(
                    children: [
                      Column(
                        children: [
                          Image(
                              fit: BoxFit.cover,
                              height: ht,
                              width: wt,
                              image: NetworkImage(image)),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: ht * .375),
                        child: CarouselSlider.builder(
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index, realIndex) {
                            final event = snapshot.data!.docs[index];
                            var imageList = event["URLlist"];
                            return InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => ServiceSelect(
                                              uid:
                                                  snapshot.data!.docs[index].id,
                                              title: event["Title"],
                                            )));
                              },
                              child: Container(
                                width: wt * .7,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                    border:
                                        Border.all(color: Colors.transparent)),
                                child: Card(
                                  margin: EdgeInsets.only(
                                      right: wt * .02,
                                      left: wt * .02,
                                      top: ht * .01,
                                      bottom: ht * .01),
                                  shadowColor: Colors.black,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: Wrap(
                                      children: [
                                        CarouselSlider.builder(
                                            itemCount: imageList.length,
                                            itemBuilder:
                                                (context, index, realIndex) {
                                              return Image(
                                                  fit: BoxFit.cover,
                                                  height: ht * .3,
                                                  width: wt * .5,
                                                  image: NetworkImage(
                                                      imageList[index]));
                                            },
                                            options: CarouselOptions(
                                                height: ht * .3,
                                                enlargeStrategy:
                                                    CenterPageEnlargeStrategy
                                                        .height,
                                                pauseAutoPlayOnTouch: true,
                                                animateToClosest: true,
                                                aspectRatio: .6,
                                                autoPlayCurve: Curves.linear,
                                                enlargeCenterPage: true,
                                                enlargeFactor: .5,
                                                autoPlayInterval:
                                                    const Duration(seconds: 1),
                                                scrollPhysics:
                                                   const ClampingScrollPhysics())),
                                        // Image(
                                        //     fit: BoxFit.cover,
                                        //     height: ht*.3,
                                        //     width: wt*.8,
                                        //     image: NetworkImage(
                                        //       event.imageUrl,
                                        //     )),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  left: wt * .02,
                                                  top: ht * .02),
                                              child: SizedBox(
                                                width: null,
                                                child: Wrap(
                                                  children: [
                                                    NewRowICOnTxtWidget(
                                                      txt: event["Title"],
                                                      ics: Icons.event,
                                                      clr: MyColorConst()
                                                          .userAppbargradient3,
                                                      txtstl: MyTextStyle()
                                                          .txtstyle4,
                                                      w: wt * .9,
                                                      h: ht * .05,
                                                    ),
                                                    SizedBox(
                                                      height: ht * .05,
                                                    ),
                                                    NewRowICOnTxtWidget(
                                                        txt: event["price"],
                                                        ics: Icons
                                                            .currency_rupee_sharp,
                                                        clr: MyColorConst()
                                                            .userAppbargradient3,
                                                        txtstl: MyTextStyle()
                                                            .txtstyle4,
                                                        w: wt * .9,
                                                        h: ht * .05),
                                                    SizedBox(
                                                      height: ht * .05,
                                                    ),
                                                    NewRowICOnTxtWidget(
                                                        txt: event["Description"],
                                                        ics: Icons.description,
                                                        clr: MyColorConst()
                                                            .userAppbargradient3,
                                                        txtstl: MyTextStyle()
                                                            .txtstyle2,
                                                        w: wt,
                                                        h: ht * .1),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                          options: CarouselOptions(
                              enableInfiniteScroll: true,
                              onPageChanged: (index, reason) {
                                valueChanger.updateCurrent(index);
                              },
                              viewportFraction: .8,
                              height: ht*.6,
                              enlargeStrategy: CenterPageEnlargeStrategy.height,
                              pauseAutoPlayOnTouch: true,
                              animateToClosest: true,
                              aspectRatio: .6,
                              autoPlayCurve: Curves.linear,
                              enlargeCenterPage: true,
                              enlargeFactor: .5,
                              autoPlayInterval: const Duration(seconds: 5),
                              scrollPhysics: const ClampingScrollPhysics()),
                        ),
                      ),
                    ],
                  );
                }
              },
            );

          }),
    );
  }
}
