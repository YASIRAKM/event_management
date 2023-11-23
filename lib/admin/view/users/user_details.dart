import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eventmanagement/utils/common_appbar_admin.dart';
import 'package:eventmanagement/constants/color_constants.dart';
import 'package:eventmanagement/constants/text_style_constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../../../utils/new_detail_view_txt.dart';
import '../../controller/fetching_data.dart';

class SingleUser extends StatelessWidget {
  final String uid;

  const SingleUser({super.key, required this.uid});

  @override
  Widget build(BuildContext context) {
    final ht = MediaQuery.sizeOf(context).height;
    final wt = MediaQuery.sizeOf(context).width;
    final FetchDataAdmin fetchData = Provider.of<FetchDataAdmin>(context);
    fetchData.fetchDataWithDocument("Users", uid);
    return Scaffold(
        backgroundColor: MyColorConst().backgroundColor,
        appBar: const CommonAppbar(
            txt: 'User Details',
            drawericon: CupertinoIcons.back,
            clrs: MyColorConst.color1),
        body: Stack(
          children: [
            Padding(
              padding: EdgeInsets.only(top: ht * .35),
              child: Container(
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(30),
                          topLeft: Radius.circular(30)))),
            ),
            StreamBuilder(
              stream:fetchData.dataStream2,
              // FirebaseFirestore.instance
              //     .collection("Users")
              //     .doc(Uid)
              //     .snapshots(),
              builder: (context, snapshot) {
                Map<String, dynamic>? userData = snapshot.data!;
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
                  return Padding(
                    padding: EdgeInsets.only(top: ht * .15, left: 40),
                    child: SizedBox(
                      width: wt * .8,
                      height: ht * .6,
                      child: Card(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            NewDetailedText(
                                wt: wt,
                                ht: ht,
                                title: 'Name',
                                val: userData["Name"]),
                            NewDetailedText(
                                wt: wt,
                                ht: ht,
                                title: 'E-mail',
                                val: userData["E mail"]),
                            NewDetailedText(
                                wt: wt,
                                ht: ht,
                                title: 'Phone no',
                                val: userData["Phone no"]),
                            NewDetailedText(
                                wt: wt,
                                ht: ht,
                                title: 'State',
                                val: userData["State"]),
                            NewDetailedText(
                                wt: wt,
                                ht: ht,
                                title: 'District',
                                val:userData["District"]),
                          ],
                        ),
                      ),
                    ),
                  );
                } else {
                  return const Text("Error");
                }
              },
            ),
          ],
        ));
  }
}
