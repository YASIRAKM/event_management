import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eventmanagement/admin/view/admin_home_view.dart';
import 'package:eventmanagement/constants/color_constants.dart';
import 'package:eventmanagement/utils/common_appbar_admin.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../../constants/text_style_constant.dart';
import '../controller/admin_creeating_updating_firebase.dart';
import '../controller/fetching_data.dart';

class ReviewViewAdmin extends StatelessWidget {
  const ReviewViewAdmin({super.key});

  @override
  Widget build(BuildContext context) {
    final ht = MediaQuery.sizeOf(context).height;
    final wt = MediaQuery.sizeOf(context).width;
    return  Scaffold(backgroundColor: MyColorConst().backgroundColor,
      drawer: const Drawers(),
      appBar:const  CommonAppbar(txt: 'Reviews', drawericon: CupertinoIcons.back, clrs: MyColorConst.color1,),
      body:Consumer2<FetchDataAdmin,AddUpdate>(
        builder: (context, fetchData,deleteData, child){
          fetchData.fetchDataWithOutDoc("Review");
          return StreamBuilder(stream:fetchData.dataStream , builder: (context, AsyncSnapshot snapshot) {
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
              final List <Map<String,dynamic>> data = snapshot.data;

              return Padding(
                padding: EdgeInsets.only(top: ht * .03),
                child: ListView.builder(
                  itemCount:data.length ,
                  itemBuilder: (context, index) {

                    return Card(
                      elevation: 0,
                      margin: EdgeInsets.only(
                          left: wt * .1, bottom: ht * .05, right: wt * .1),
                      child: Padding(
                        padding: EdgeInsets.only(top: ht * .02, left: wt * .05),
                        child: SizedBox(
                          height:  ht * .3,
                          child: Column(

                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              StreamBuilder(
                                stream: FirebaseFirestore.instance
                                    .collection("Users")
                                    .where("Id" "==" "${data[index]["userid"]}")
                                    .snapshots(),
                                builder: (context, snapshot) {
                                  if (!snapshot.hasData && snapshot.hasError) {
                                    return const Text("error");
                                  } else if (snapshot.hasData) {
                                    return Row(
                                      children: [
                                        SizedBox(
                                            width: wt * .25,
                                            child: Text(
                                              snapshot.data!.docs[0]["Name"],style: MyTextStyle().cmplnttxt,)),
                                        Text(snapshot.data!.docs[0]["E mail"],style: MyTextStyle().cmplnttxt,),
                                      ],
                                    );
                                  } else {
                                    return const Text("has error");
                                  }
                                },
                              ),
                              SizedBox(
                                height: ht * .03,
                              ),
                              RatingBarIndicator(
                                unratedColor: MyColorConst().unRatedColor,
                                itemBuilder: (context, index) {
                                  return Icon(
                                    Icons.star,
                                    color: MyColorConst().ratingColor,
                                  );
                                },
                                itemCount: 5,
                                itemSize: 25,
                                rating: data[index]["rating"],
                              ),
                              SizedBox(
                                height: ht * .02,
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: SizedBox(
                                      height: ht * .1,
                                      child: Text("'${data[index]["review"]}'",style: MyTextStyle().cmplnttxt2),
                                    ),
                                  ),
                                  Padding(
                                    padding:  EdgeInsets.only(top: ht*.1),
                                    child: IconButton(onPressed: (){
                                      deleteData.deleteData("Review", data[index]["id"]);


                                    }, icon:const Icon(Icons.delete) ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              );
            } else {
              return const Text("error");
            }

          },);
        }
      ),
    );
  }
}
