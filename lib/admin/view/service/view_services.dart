import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eventmanagement/admin/view/Service/update_service.dart';
import 'package:eventmanagement/constants/color_constants.dart';
import 'package:eventmanagement/constants/text_style_constant.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../../controller/fetching_data.dart';
import '../admin_home_view.dart';

class ServsView extends StatelessWidget {
  const ServsView({super.key});

  @override
  Widget build(BuildContext context) {
    final ht = MediaQuery.sizeOf(context).height;
    final wt = MediaQuery.sizeOf(context).width;
    final FetchDataAdmin fetchData = Provider.of<FetchDataAdmin>(context);
    fetchData.fetchDataWithOutDoc("Services");
    return Scaffold(
      drawer: const Drawers(),
      body: StreamBuilder(
        stream: fetchData.dataStream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Lottie.network(
                "https://lottiefiles.com/animations/material-loading-pKFC2ykpSm");
          } else if (snapshot.hasError) {
            return const Text("has error");
          } else if (!snapshot.hasData) {
            return const Text("no data");
          } else if (snapshot.hasData) {
            final data = snapshot.data!;
            return ListView.builder(
                itemBuilder: (context, index) {
                  return Container(
                      margin: EdgeInsets.only(
                          left: wt * .1, right: wt * .1, bottom: ht * .02),
                      height: ht * .3,
                      width: wt * .3,
                      decoration: BoxDecoration(
                          color: Colors.black,
                          image: DecorationImage(
                              fit: BoxFit.fill,
                              image: NetworkImage(data[index]["URL"]))),
                      child: Padding(
                        padding: EdgeInsets.only(top: ht * .17),
                        child: Container(
                          height: ht * .001,
                          color: Colors.white,
                          child: Row(
                            children: [
                              SizedBox(
                                width: wt * .65,
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      top: ht * .01, left: wt * .03),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(data[index]["Service"],
                                          style: MyTextStyle().txtstyle2),
                                      SizedBox(height: ht * .02),
                                      Text(
                                          "Rs. ${data[index]["Price"].toString()}",
                                          style: MyTextStyle().txtstyle2)
                                    ],
                                  ),
                                ),
                              ),
                              Column(
                                children: [
                                  IconButton(
                                      onPressed: () async {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (_) =>
                                                    UpdateAdminService(
                                                      docId: data[index]['id'],
                                                    )));
                                      },
                                      icon: const Icon(
                                        Icons.update,
                                        color: MyColorConst.color1,
                                      )),
                                  IconButton(
                                      onPressed: () async {
                                        await FirebaseFirestore.instance
                                            .collection("services")
                                            .doc(snapshot.data![index]['id'])
                                            .delete();
                                      },
                                      icon: const Icon(
                                        Icons.delete,
                                        color: MyColorConst.color1,
                                      )),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ));
                },
                itemCount: data.length);
          } else {
            return const Text("error");
          }
        },
      ),
    );
  }
}
