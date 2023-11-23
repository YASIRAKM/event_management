import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eventmanagement/utils/common_appbar_admin.dart';
import 'package:eventmanagement/admin/controller/admin_creeating_updating_firebase.dart';
import 'package:eventmanagement/admin/view/admin_home_view.dart';
import 'package:eventmanagement/constants/color_constants.dart';
import 'package:eventmanagement/constants/text_style_constant.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../controller/fetching_data.dart';

class ComplaintViewAdmin extends StatelessWidget {
  const ComplaintViewAdmin({super.key});


  @override
  Widget build(BuildContext context) {
    final ht =MediaQuery.sizeOf(context).height;
    final wt =MediaQuery.sizeOf(context).width;
    final FetchDataAdmin fetchData =Provider.of<FetchDataAdmin>(context);
    fetchData.fetchDataWithOutDoc("Complaint");
    return Scaffold(drawer:const Drawers(),
      backgroundColor: MyColorConst().backgroundColor,
      appBar: const CommonAppbar(txt: 'Complaints', drawericon: Icons.menu, clrs: MyColorConst.color1),
      body: StreamBuilder(
        stream: fetchData.dataStream,
        // FirebaseFirestore.instance.collection("Complaint").snapshots(),
        builder: (BuildContext context,  snapshot) {
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
            final  data = snapshot.data!;
            return ListView.builder(padding: EdgeInsets.only(top: ht*.02),
              itemBuilder: (context, index) {
                return Consumer<AddUpdate>(
                  builder: (context, deleteComplaint, child)  {
                    return Card(elevation: 0,margin: EdgeInsets.only(top: ht*.01,right: wt*.05,left: wt*.05),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      child: Padding(
                        padding:  EdgeInsets.all(wt*.03),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,children: [
                          Row(children: [
                            SizedBox(width:wt*.4,child: Text(data[index]["Name"],style: MyTextStyle().cmplnttxt,)),
                            Text("${data[index]["Mail"]}",style: MyTextStyle().cmplnttxt,)
                          ],),
                          SizedBox(height: ht*.01,),
                          Text("${data[index]["Subject"]}",style: MyTextStyle().cmplnttxt,),
                          SizedBox(height: ht*.01,),
                          Row(
                            children: [
                              Expanded(child: Text(" '' ${data[index]["Content"]} '' ",style: MyTextStyle().cmplnttxt2,overflow: TextOverflow.visible)),
                              IconButton(onPressed: (){
                                deleteComplaint.deleteData("Complaint",data[index]["id"]);
                              }, icon: const Icon(Icons.delete
                              ))
                            ],
                          ),

                        ]),
                      ),
                    );
                  }
                );
              },
              itemCount: data.length,
            );
          } else {
            return const Text("error");
          }
        },
      ),
    );
  }
}
