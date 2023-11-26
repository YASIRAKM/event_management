import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eventmanagement/constants/color_constants.dart';
import 'package:eventmanagement/constants/text_style_constant.dart';
import 'package:eventmanagement/user/controller/servie_select_controller.dart';
import 'package:eventmanagement/user/view/payment_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import '../../utils/common_appbar_user.dart';


class CheckOutView extends StatelessWidget {
  final String docId;
  final bool checkout;

  const CheckOutView({Key? key, required this.docId, required this.checkout})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ht = MediaQuery.sizeOf(context).height;
    final wt = MediaQuery.sizeOf(context).width;
    final checkOutController = Provider.of<ServiceSelectController>(context);
    final Map<String, dynamic> events = {};
    final List<dynamic> listOfMaps = [];

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: CommonAppBarUser(
        title1: checkout ? 'Checkout' : 'Order Details',
        clr: true,
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("Booking")
            .doc(docId)
            .snapshots(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text("has error"));
          } else if (!snapshot.hasData) {
            return const Center(child: Text("no data"));
          } else if (snapshot.hasData) {
            events.addAll(snapshot.data!["event"]);
            List image = events["URLlist"];
            listOfMaps.addAll(snapshot.data!.get('services') as List<dynamic>);
            checkOutController.calculateTotal(events, listOfMaps);

            return Card(
              elevation: 1,
              margin: EdgeInsets.only(
                  top: checkout ? ht * .15 : ht * .2,
                  left: wt * .03,
                  right: wt * .03,
                  bottom: checkout ? ht * .11 : ht * .11),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        top: ht * .02, left: wt * .02, right: wt * .02),
                    child: Card(
                      elevation: 1,
                      color: MyColorConst().card2,
                      child: Row(
                        children: [
                          SizedBox(
                            width: wt * .02,
                          ),
                          SizedBox(
                            width: wt * .64,
                            height: ht * .12,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  events["Title"],
                                  style: MyTextStyle().chckttxt2,
                                ),
                                Row(
                                  children: [
                                    const Icon(
                                      FontAwesomeIcons.indianRupeeSign,
                                      color: MyColorConst.color1,
                                    ),
                                    Text(
                                      events["price"].toString(),
                                      style: MyTextStyle().chckttxt2,
                                    ),
                                  ],
                                ),
                                Text(
                                  snapshot.data["Place"],
                                  style: MyTextStyle().chckttxt2,
                                ),
                                Text(snapshot.data!["date"],
                                    style: MyTextStyle().chckttxt2),
                              ],
                            ),
                          ),
                          Image(
                              filterQuality: FilterQuality.high,
                              height: ht * .15,
                              width: wt * .2,
                              image: NetworkImage(image[0]),
                              fit: BoxFit.cover),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: wt * .03),
                    child: Text(
                      "Services Opted:",
                      style: MyTextStyle().txtstyle4,
                    ),
                  ),
                  SizedBox(
                    height: ht * .3,
                    child: Card(
                        elevation: 0,
                        margin: EdgeInsets.only(
                            top: 0, left: wt * .15, right: wt * .15),
                        child: CarouselSlider.builder(
                            itemCount: listOfMaps.length,
                            itemBuilder: (context, index, realIndex) {
                              return Container(
                                decoration: BoxDecoration(border: Border.all()),
                                margin: EdgeInsets.only(
                                    left: wt * .02, bottom: ht * .02),
                                child: Column(
                                  children: [
                                    Image(
                                        fit: BoxFit.cover,
                                        height: ht * .15,
                                        width: wt * .3,
                                        image: NetworkImage(
                                            listOfMaps[index]["URL"])),
                                    Text(listOfMaps[index]["Service"]),
                                  ],
                                ),
                              );
                            },
                            options: CarouselOptions(
                                height: ht * .2,
                                autoPlayAnimationDuration:
                                    const Duration(seconds: 2),
                                enlargeStrategy:
                                    CenterPageEnlargeStrategy.height,
                                animateToClosest: true,
                                autoPlay: listOfMaps.length == 1 ? false : true,
                                viewportFraction: 1,
                                aspectRatio: .2,
                                enlargeFactor: .5))),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        top: ht * .03, left: wt * .06, right: wt * .2),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Total Amount :", style: MyTextStyle().txtstyle4),
                        const Icon(
                          FontAwesomeIcons.indianRupeeSign,
                          color: MyColorConst.color1,
                          size: 15,
                        ),
                        Text(
                          checkOutController.total.toString(),
                          style: MyTextStyle().txtstyle4,
                        ),
                      ],
                    ),
                  ),
                  checkout
                      ? Padding(
                          padding:
                              EdgeInsets.only(top: ht * .05, left: wt * .35),
                          child: ElevatedButton(
                            onPressed: () async {
                              final navigator = Navigator.of(context);
                              // await FirebaseFirestore.instance
                              //     .collection("Booking")
                              //     .doc(docId)
                              //     .update({
                              //   "Total": checkOutController.total.toString()
                              // });
                              navigator.pushReplacement(MaterialPageRoute(builder: (_)=>PaymentView(
                                price: checkOutController.total
                                    .toInt(),
                                name: events["Title"],
                                userid: snapshot.data!["userid"],
                                docId: snapshot.data!.id,
                              )));

                            },
                            child: const Text("Checkout"),
                          ),
                        )
                      : Padding(
                          padding:
                              EdgeInsets.only(top: ht * .03, left: wt * .35),
                          child: ElevatedButton(
                              onPressed: () async {
                                await FirebaseFirestore.instance
                                    .collection("Booking")
                                    .doc(docId)
                                    .delete();
                                Navigator.pop(context);
                              },
                              child: const Text("Cancel")),
                        ),


                ],
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
