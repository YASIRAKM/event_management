import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eventmanagement/utils/common_appbar_admin.dart';
import 'package:eventmanagement/constants/color_constants.dart';
import 'package:eventmanagement/constants/text_style_constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import '../../controller/fetching_data.dart';
import '../admin_home_view.dart';
import 'user_details.dart';

class Users extends StatelessWidget {
  const Users({super.key});

  @override
  Widget build(BuildContext context) {
    final ht = MediaQuery.sizeOf(context).height;
    final wt = MediaQuery.sizeOf(context).width;
    final FetchDataAdmin fetchData =Provider.of<FetchDataAdmin>(context);
    fetchData.fetchDataWithOutDoc("Users");
    return Scaffold(
        backgroundColor: MyColorConst().backgroundColor,
        drawer: const Drawers(),
        appBar: const CommonAppbar(
            txt: 'Users List',
            drawericon: Icons.menu,
            clrs: MyColorConst.color1),
        body: StreamBuilder(
          stream:fetchData.dataStream,
          // FirebaseFirestore.instance.collection("Users").snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: Lottie.asset(
                    height: 200,
                    width: 200,
                    repeat: true,
                    "asset/lottie/Animation - 1698750195337.json"),
              );
            } else if (snapshot.hasError) {
              return const Text("has Error");
            } else if (!snapshot.hasData) {
              return const Text("No Data");
            } else if (snapshot.hasData) {
              final data = snapshot.data!;
              return Padding(
                padding: EdgeInsets.only(top: ht * .06),
                child: ListView.separated(
                    itemBuilder: (context, index) {
                      return Card(
                        margin:
                            EdgeInsets.only(left: wt * .05, right: wt * .05),
                        child: Row(
                          children: [
                            SizedBox(
                              width: wt * .03,
                            ),
                            SizedBox(
                              child: SizedBox(
                                  height: ht * .1,
                                  child: CircleAvatar(
                                      radius: ht * .03,
                                    child: Icon(
                                      Icons.person,
                                      size: ht * .05,
                                    )

                                  )),
                            ),
                            SizedBox(
                              width: wt * .05,
                            ),
                            SizedBox(
                              width: wt * .5,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(data[index]["Name"],
                                      style: MyTextStyle().drawerText),
                                  SizedBox(
                                    height: ht * .01,
                                  ),
                                  Text(
                                    data[index]["E mail"],
                                    style: MyTextStyle().txtstyle1,
                                  )
                                ],
                              ),
                            ),
                            IconButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) => SingleUser(
                                                uid: data[index]['id'],
                                              )));
                                },
                                icon: Icon(
                                  CupertinoIcons.eye,
                                  size: ht * .03,
                                  color: MyColorConst.color1,
                                ))
                          ],
                        ),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const Divider();
                    },
                    itemCount: data.length),
              );
            } else {
              return const Text("Error");
            }
          },
        ));
  }
}
