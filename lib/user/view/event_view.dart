import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eventmanagement/utils//common_appbar_user.dart';
import 'package:eventmanagement/utils//new_row_icon_txt.dart';
import 'package:eventmanagement/utils//new_container_button.dart';
import 'package:eventmanagement/constants/color_constants.dart';
import 'package:eventmanagement/constants/text_style_constant.dart';
import 'package:eventmanagement/user/controller/servie_select_controller.dart';
import 'package:eventmanagement/user/controller/userid_controller.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:provider/provider.dart';
import 'checkout_page.dart';

class ServiceSelectUser extends StatelessWidget {
  final String uid;

  final List serv;

  ServiceSelectUser({super.key, required this.uid, required this.serv});

  final GlobalKey<FormState> formK = GlobalKey<FormState>();
  final TextEditingController suggestController = TextEditingController();

  // Map eve={};

  @override
  Widget build(BuildContext context) {
    final ht = MediaQuery.sizeOf(context).height;
    final wt = MediaQuery.sizeOf(context).width;
    Map<String, dynamic> mapData = {};
    return Scaffold(
      backgroundColor: MyColorConst().backgroundColor,
      extendBodyBehindAppBar: false,
      appBar: const CommonAppBarUser(
        title1: 'Confirm Order',
        clr: true,
      ),
      body: Consumer2<ServiceSelectController, UserIdController>(
        builder: (BuildContext context, serviceSelect, userIdController,
            Widget? child) {
          return SingleChildScrollView(
            child: Card(
              elevation: 1,
              margin: EdgeInsets.only(
                  left: wt * .05,
                  right: wt * .05,
                  top: ht * .03,
                  bottom: ht * .06),
              child: Column(
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection("Event")
                        .doc(uid)
                        .snapshots(),
                    builder: (context, snapshot) {
                      if(snapshot.connectionState==ConnectionState.waiting){
                        return const Center(child: CircularProgressIndicator(),);
                      }
                      if(snapshot.hasError){
                        return  const Text("has error");
                      }
                      if(snapshot.hasData) {
                        mapData = snapshot.data!.data() as Map<String, dynamic>;
                        return Padding(
                          padding: EdgeInsets.only(left: wt * .01),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Event you booked : ",
                                  style: MyTextStyle().txtstyle4),
                              Padding(
                                padding: EdgeInsets.only(top: ht * .02),
                                child: Column(
                                  children: [
                                    NewRowICOnTxtWidget(
                                      w: wt,
                                      ics: Icons.event,
                                      txt: snapshot.data!["Title"],
                                      clr: MyColorConst().cardTXT,
                                      txtstl: MyTextStyle().imgetitle,
                                      h: ht * .05,
                                    ),
                                    NewRowICOnTxtWidget(
                                        w: wt,
                                        h: ht * .05,
                                        ics: FontAwesomeIcons.indianRupeeSign,
                                        txt: snapshot.data!["price"],
                                        clr: MyColorConst().cardTXT,
                                        txtstl: MyTextStyle().imgetitle),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      }
                      else{
                        return const  Center(child: Text("error"),);
                      }
                    },
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: ht * .02),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(ht * .05),
                          topLeft: Radius.circular(ht * .05),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding:
                                EdgeInsets.only(left: wt * .02, top: ht * .01),
                            child: Text(
                              "Services you booked : ",
                              style: MyTextStyle().txtstyle4,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: ht * .01),
                            child: SizedBox(
                                height: ht * .15,
                                width: wt * .9,
                                child: CarouselSlider.builder(
                                    itemCount: serv.length,
                                    itemBuilder: (context, index, realIndex) {
                                      return Container(
                                        decoration:
                                            BoxDecoration(border: Border.all()),
                                        margin: EdgeInsets.only(
                                            left: wt * .02, bottom: ht * .02),
                                        child: Column(
                                          children: [
                                            Image(
                                                fit: BoxFit.cover,
                                                height: ht * .09,
                                                width: wt * .3,
                                                image: NetworkImage(
                                                    serv[index]["URL"])),
                                            Text(serv[index]["Service"]),
                                          ],
                                        ),
                                      );
                                    },
                                    options: CarouselOptions(
                                        height: ht * .15,
                                        autoPlayAnimationDuration:
                                            const Duration(seconds: 2),
                                        enlargeStrategy:
                                            CenterPageEnlargeStrategy.height,
                                        autoPlay:
                                            serv.length == 1 ? false : true,
                                        viewportFraction: .7,
                                        aspectRatio: .2,
                                        enlargeFactor: .5))),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: wt * .03),
                            child: Text(
                              "Choose Date and place",
                              style: MyTextStyle().txtstyle4,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                left: wt * .02, right: wt * .02, top: ht * .01),
                            child: Form(
                              key: formK,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: ht * .09,
                                    width: wt * .9,
                                    child: TextFormField(
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return "Date is must";
                                          }
                                          return null;
                                        },
                                        controller:
                                            serviceSelect.dateController,
                                        decoration: InputDecoration(
                                            labelText: serviceSelect
                                                    .dateController.text.isEmpty
                                                ? "Pick your date"
                                                : serviceSelect
                                                    .dateController.text,
                                            border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(0)),
                                            suffixIcon: IconButton(
                                              icon: const Icon(
                                                  Icons.calendar_month),
                                              onPressed: () {
                                                serviceSelect
                                                    .selectDate(context);
                                              },
                                            ))),
                                  ),
                                  TextFormField(
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'enter the location';
                                      }
                                      return null;
                                    },
                                    controller: serviceSelect.placeController,
                                    decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(0)),
                                        prefixIcon: const Icon(
                                            FontAwesomeIcons.streetView),
                                        labelText: "Place"),
                                  ),
                                  SizedBox(height: ht * .01),
                                  TextField(
                                    controller: suggestController,
                                    keyboardType: TextInputType.text,
                                    decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(0)),
                                        prefixIcon:
                                            const Icon(FontAwesomeIcons.pen),
                                        labelText: "Any Suggestion"),
                                  )
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsets.only(left: wt * .34, top: ht * .01),
                            child: elevatedButton(
                                hght: ht * .06,
                                wdth: wt * .3,
                                cColor: MyColorConst.color1,
                                r2: 25,
                                r1: 25,
                                r3: 25,
                                r4: 25,
                                onpressed: () async {
                                  final navigator = Navigator.of(context);
                                  userIdController.getSharedValue();
                                  serviceSelect.calculateTotal(
                                      mapData, serviceSelect.chkBox2);

                                  final db = await FirebaseFirestore.instance
                                      .collection("Booking")
                                      .add({
                                    "date": serviceSelect.dateController.text,
                                    "event": mapData,
                                    "services": serviceSelect.chkBox2,
                                    "Total": serviceSelect.total.toString(),
                                    "userid": userIdController.id.toString(),
                                    "Place": serviceSelect.placeController.text,
                                    "Suggest": suggestController.text
                                  });
                                  navigator.push(MaterialPageRoute(
                                      builder: (_) => CheckOutView(
                                            docId: db.id,
                                            checkout: true,
                                          )));
                                  serviceSelect.dateController.clear();
                                  serviceSelect.placeController.clear();
                                  suggestController.clear();
                                  serviceSelect.chkBox2.clear();
                                },
                                bColor: MyColorConst.color1,
                                txt: 'Confirm',
                                txtstyle: MyTextStyle().txtstyle1),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
