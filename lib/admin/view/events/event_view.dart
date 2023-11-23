import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:eventmanagement/admin/controller/fetching_data.dart';
import 'package:eventmanagement/constants/color_constants.dart';
import 'package:eventmanagement/constants/text_style_constant.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import '../../../utils/common_appbar_admin.dart';
import '../admin_home_view.dart';
import 'event_image_view.dart';
import 'update_event_view.dart';

class EventView extends StatelessWidget {
  const EventView({super.key});


  @override
  Widget build(BuildContext context) {
    final ht = MediaQuery.sizeOf(context).height;
    final wt = MediaQuery.sizeOf(context).width;
    final FetchDataAdmin fetchData =Provider.of<FetchDataAdmin>(context);
    fetchData.fetchDataWithOutDoc("Event");


    return Scaffold(
      drawer:const Drawers(),
      appBar:const CommonAppbar(
          txt: 'Event', drawericon: Icons.menu, clrs: MyColorConst.color1),
      body: StreamBuilder(
        stream: fetchData.dataStream,
        // FirebaseFirestore.instance.collection("Event").snapshots(),
        builder: (BuildContext context, snapshot) {

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Lottie.asset("asset/lottie/Animation - 1698750195337.json");
          } else if (snapshot.hasError) {
            return const Text("Error");
          } else if (!snapshot.hasData) {
            return const Text("No Data");
          } else if (snapshot.hasData) {
            List<Map<String, dynamic>> data = snapshot.data!;
            List<String> imageUrls = [];
            return ListView.builder(
              itemBuilder: (context, index) {
                imageUrls.add(data[index]["URLlist"][0]);
                return Container(margin: EdgeInsets.only(right: wt*.05,left: wt*.05,top: ht*.02),
                  height: ht * .4,
                  width: wt * 1,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.fill,
                          image:
                          NetworkImage(imageUrls[index]))),
                          child: Column(
                            children: [
                //               CarouselSlider(items: data[index]["URL"], options: CarouselOptions(height: ht*2),
                // ),
                              Padding(
                                padding:  EdgeInsets.only(top: ht*.239757),
                                child: Card(shape: LinearBorder.top(),
                                  child: Row(
                                    children: [
                                      Container(height: ht*.15,width:wt*.75,decoration:const BoxDecoration() ,
                                      child: Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment.start,
                                                                children: [
                                                                  Text("${data[index]['Title']}",
                                                                      style: MyTextStyle().eventTitleText),
                                                                  Row(
                                                                    children: [
                                                                      Text("Rs. ${data[index]['price']}",
                                                                          style: MyTextStyle().eventTitleText),
                                                                      TextButton(onPressed: (){
                                                                        Navigator.push(context, MaterialPageRoute(builder: (_)=>EventImages(docId:data[index]['id'],)));
                                                                      },child: const Text('View Images'),)
                                                                    ],
                                                                  ),
                                                                  SizedBox(
                                                                    height: ht*.02,
                                                                  ),
                                                                  Expanded(flex: 1,
                                                                      child: Text(
                                                                    "${data[index]['Description']}",
                                                                    style: MyTextStyle().eventdesctext,
                                                                  )), ],),

                                      ),
                                  Column(crossAxisAlignment: CrossAxisAlignment.center,mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                        children: [
                                                          IconButton(
                                                              onPressed: () async {
                                                                Navigator.push(context, MaterialPageRoute(builder: (_)=>UpdateEventView(docId: data[index]['id'],)));
                                                              },
                                                              icon: Icon(
                                                                Icons.update,size: ht*.04,
                                                                color: MyColorConst.color1,
                                                              )),IconButton(
                                                              onPressed: () async {
                                                                await FirebaseFirestore.instance
                                                                    .collection("Event")
                                                                    .doc(data[index]['id'])
                                                                    .delete();
                                                              },
                                                              icon: Icon(size: ht*.04,
                                                                Icons.delete,
                                                                color: MyColorConst.color1,
                                                              )),
                                                        ],
                                                      ),
                                    ],
                                  ),
                                ),
                              ),

                            ],
                          ),
                );
              },
              itemCount: snapshot.data!.length,
            );
          } else {
            return const Text("error");
          }
        },
      ),
    );
  }
}
