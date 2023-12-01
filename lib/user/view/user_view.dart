import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eventmanagement/constants/color_constants.dart';
import 'package:eventmanagement/constants/text_style_constant.dart';
import 'package:eventmanagement/utils/new_raw_text_userview.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controller/userid_controller.dart';
class UserCView extends StatelessWidget {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _mailController = TextEditingController();
  final TextEditingController _phone = TextEditingController();
  final TextEditingController _dist = TextEditingController();
  final TextEditingController _state = TextEditingController();

  UserCView({super.key});

  @override
  Widget build(BuildContext context) {
    final ht =MediaQuery.sizeOf(context).height;
    final wt =MediaQuery.sizeOf(context).width;
    final idController = Provider.of<UserIdController>(context, listen: false);

    return Scaffold(

      body: StreamBuilder(
        stream:FirebaseFirestore.instance.collection("Users")
            .where("Id" "==" "${idController.id.toString()}").snapshots(),
        builder: (context, snapshot) {

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Text("Error");
          } else {
            var data = snapshot.data!.docs[0];
            Map<String, dynamic> dat= data.data();
            return Padding(
              padding: EdgeInsets.only(left:wt*.05,right: wt*.05,top: ht*.01 ),
              child: ListView(
                children: [
                  CircleAvatar(radius: wt*.15,child:const Icon(Icons.person),),
                  NeColumnTxtField(
                    Header: 'Name',
                    lbl: dat["Name"],
                    ics: Icons.person,
                    txtsl: MyTextStyle().txtstyle3,
                    clr: MyColorConst().userAppbargradient1,
                    cntrlr: _nameController,
                    head: 'Name', htxtsl: MyTextStyle().txtstyle4, docid: data.id,
                  ),
                  NeColumnTxtField(docid: data.id,
                    Header: 'E mail',
                    lbl: dat["E mail"],
                    ics: Icons.person,
                    txtsl: MyTextStyle().txtstyle3,
                    clr: MyColorConst().userAppbargradient1,
                    cntrlr: _mailController,
                    head: 'E mail',htxtsl: MyTextStyle().txtstyle4,
                  ),NeColumnTxtField(docid: data.id,
                    Header:'Phone no',
                    lbl: dat["Phone no"],
                    ics: Icons.person,
                    txtsl: MyTextStyle().txtstyle3,
                    clr: MyColorConst().userAppbargradient1,
                    cntrlr: _phone,
                    head: 'Phone no',htxtsl: MyTextStyle().txtstyle4,
                  ),
                  NeColumnTxtField(docid: data.id,
                    Header:'District',
                    lbl: dat["District"],
                    ics: Icons.person,
                    txtsl: MyTextStyle().txtstyle3,
                    clr: MyColorConst().userAppbargradient1,
                    cntrlr: _dist,
                    head: 'District',htxtsl: MyTextStyle().txtstyle4,
                  ),NeColumnTxtField(docid: data.id,
                    Header: 'State',
                    lbl: dat['State'],
                    ics: Icons.person,
                    txtsl: MyTextStyle().txtstyle3,
                    clr: MyColorConst().userAppbargradient1,
                    cntrlr: _state,
                    head: 'State', htxtsl: MyTextStyle().txtstyle4,
                  ),

                ],
              ),
            );
          }
        },
      ),
    );
  }
}


