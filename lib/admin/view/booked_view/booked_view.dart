
import 'package:eventmanagement/utils/common_appbar_admin.dart';
import 'package:eventmanagement/constants/color_constants.dart';
import 'package:eventmanagement/constants/text_style_constant.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../../../utils/new_row_icon_txt.dart';
import '../../controller/fetching_data.dart';
import '../admin_home_view.dart';
import 'booked_detailed.dart';

class BookedView extends StatelessWidget {
  const BookedView({super.key});

  @override
  Widget build(BuildContext context) {
    final ht = MediaQuery.sizeOf(context).height;
    final wt = MediaQuery.sizeOf(context).width;
    final FetchDataAdmin fetchData =Provider.of<FetchDataAdmin>(context);
    fetchData.fetchDataWithOutDoc("Booking");
    return Scaffold(
      backgroundColor: MyColorConst().backgroundColor,
      appBar:const  CommonAppbar(
          txt: 'Bookings', drawericon: Icons.menu, clrs: MyColorConst.color1),
      drawer: const  Drawers(),
      body: StreamBuilder(
        stream:fetchData.dataStream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Lottie.asset("asset/lottie/Animation - 1698750195337.json");
          } else if (snapshot.hasError) {
            return const Text("Error");
          } else if (!snapshot.hasData) {
            return const Text("No Data");
          } else if (snapshot.hasData) {
            return Stack(
              children: [
                ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    Map<String, dynamic> events =
                        snapshot.data![index]["event"];

                    return Container(
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      height: ht * .32,
                      child: Card(
                        margin: EdgeInsets.only(
                            left: wt * .05, right: wt * .05, top: ht * .02),
                        child: Stack(
                          children: [
                            Container(
                              height: ht * .2,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  image: DecorationImage(
                                      fit: BoxFit.fill,
                                      image: NetworkImage(events["URLlist"][0]))),
                            ),
                            Positioned(
                              top: ht * .15,left:-wt*.00001,
                              child: Card(margin: EdgeInsets.only(right: wt*.2),
                                child: Container(
                                  height: ht * .15,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20)),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        events["Title"],
                                        style: MyTextStyle().txtstyle4,
                                      ),

                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          NewRowICOnTxtWidget(w: wt*.5,
                                            ics: FontAwesomeIcons.streetView,
                                            txt: snapshot.data![index]
                                                ["Place"],
                                            clr: MyColorConst.color1,
                                            txtstl: MyTextStyle().txtstyle4, h: ht*.05,
                                          ),
                                          NewRowICOnTxtWidget(
                                            ics: FontAwesomeIcons.calendarDays,
                                            txt: snapshot.data![index]
                                                ["date"],
                                            clr: MyColorConst.color1,
                                            txtstl: MyTextStyle().txtstyle4, w: wt*.4, h: ht*.05,
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          NewRowICOnTxtWidget(
                                            ics: FontAwesomeIcons
                                                .indianRupeeSign,
                                            txt: snapshot.data![index]
                                                ["Total"],
                                            clr: MyColorConst.color1,
                                            txtstl: MyTextStyle().txtstyle4, w: wt*.5, h: ht*.05,
                                          ),
                                          IconButton(
                                              onPressed: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (_) =>
                                                            BookedEvent(
                                                              docId: snapshot
                                                                  .data!
                                                                  [index]
                                                                  ['id'],
                                                            )));
                                              },
                                              icon: Row(
                                                children: [
                                                 const  Icon(
                                                    Icons.forward,
                                                    color: MyColorConst.color2,
                                                  ),
                                                  Text("View Details",
                                                      style: MyTextStyle()
                                                          .txtstyle2)
                                                ],
                                              )),
                                        ],
                                      ),

                                    ],
                                  ),
                                ),
                              ),
                            ),

                          ],
                        ),
                      ),
                    );
                  },
                ),
              ],
            );
          } else {
            return const Text("error");
          }
        },
      ),
    );
  }
}
