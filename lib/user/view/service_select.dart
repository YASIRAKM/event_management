import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eventmanagement/utils//common_appbar_user.dart';
import 'package:eventmanagement/utils//new_container_button.dart';
import 'package:eventmanagement/constants/color_constants.dart';
import 'package:eventmanagement/constants/text_style_constant.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controller/servie_select_controller.dart';
import 'event_view.dart';

class ServiceSelect extends StatelessWidget {
  final String title;
  final String uid;

  const ServiceSelect({super.key, required this.uid, required this.title});

  @override
  Widget build(BuildContext context) {
    final ht = MediaQuery.sizeOf(context).height;
    final wt = MediaQuery.sizeOf(context).width;
    return Scaffold(
      appBar: const CommonAppBarUser(
        title1: 'Select Service',
        clr: true,
      ),
      body: ListView(
        children: [
          Padding(
            padding: EdgeInsets.only(top: ht * .03, left: wt * .08),
            child: Expanded(
                child: Text(
              "Choose Services for ${title.toString()} :",
              style: MyTextStyle().drawerText,
            )),
          ),
          Consumer<ServiceSelectController>(
              builder: (context, serviceSelect, child) {
            return Column(
              children: [
                StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection("Services")
                      .snapshots(),
                  builder: (context, snapshot) {
                    if(snapshot.connectionState==ConnectionState.waiting){
                      return const Center(child: CircularProgressIndicator(),);
                    }
                    if(snapshot.hasError){
                      return  const Text("has error");
                    }
                    if(snapshot.hasData) {
                      final data = snapshot.data!.docs;
                      return Padding(
                        padding: EdgeInsets.only(
                            top: ht * .01, left: wt * .05, right: wt * .05),
                        child: Card(
                          child: SizedBox(
                            height: ht * .5,
                            width: wt,
                            child: ListView.builder(
                              itemBuilder: (context, index) {
                                serviceSelect.chkBox1
                                    .add(snapshot.data!.docs[index].data());
                                bool isSelected = serviceSelect.chkBox2
                                    .contains(serviceSelect.chkBox1[index]);
                                return Padding(
                                  padding: EdgeInsets.only(
                                      top: ht * .01,
                                      left: wt * .01,
                                      right: wt * .01),
                                  child: Container(
                                    width: wt * .6,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.rectangle,
                                        borderRadius: BorderRadius.circular(2),
                                        border: Border.all(
                                            color: Colors.black)),
                                    child: ListTile(
                                      shape: LinearBorder.start(
                                          side: const BorderSide(width: 2)),
                                      leading: Container(
                                        decoration: BoxDecoration(
                                            border:
                                            Border.all(color: Colors.black)),
                                        height: ht * .1,
                                        width: wt * .2,
                                        child: Padding(
                                          padding: EdgeInsets.all(ht * .002),
                                          child: Image.network(
                                              data[index]["URL"],
                                              fit: BoxFit.cover),
                                        ),
                                      ),
                                      title: Text(data[index]["Service"],
                                          style: MyTextStyle().txtstyle4),
                                      subtitle: Text(
                                          data[index]["Price"].toString(),
                                          style: MyTextStyle().txtstyle4),
                                      trailing: Checkbox(
                                        value: isSelected,
                                        onChanged: (bool? value) {
                                          serviceSelect.toggleSelect(
                                              serviceSelect.chkBox1[index]);
                                        },
                                      ),
                                    ),
                                  ),
                                );
                              },
                              itemCount: snapshot.data!.docs.length,
                            ),
                          ),
                        ),
                      );
                    }
                    else{
                      return const  Center(child: Text("error"));
                    }
                  },
                ),
                Padding(
                  padding: EdgeInsets.only(left: wt * .05, right: wt * .05),
                  child: SizedBox(
                    height: ht * .1,
                    width: wt,
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3),
                      itemBuilder: (context, index) {
                        final gridList = serviceSelect.chkBox2[index];
                        dynamic serviceName =
                            serviceSelect.chkBox2[index]["Service"];
                        return Card(
                          color: MyColorConst().backgroundColor,
                          margin: EdgeInsets.only(
                              top: ht * .01, bottom: ht * .08, right: wt * .02),
                          child: Row(
                            children: [
                              Expanded(
                                  child: Text(
                                serviceName.toString(),
                                style: MyTextStyle().chckttxt2,
                              )),
                              IconButton(
                                  onPressed: () {
                                    serviceSelect.deleteButton(gridList);
                                  },
                                  icon: const Icon(
                                    Icons.cancel,
                                    color: MyColorConst.color1,
                                  ))
                            ],
                          ),
                        );
                      },
                      itemCount: serviceSelect.chkBox2.length,
                    ),
                  ),
                ),
                elevatedButton(
                    hght: ht * .05,
                    wdth: wt * .32,
                    cColor: MyColorConst.color2,
                    r2: 35,
                    r1: 35,
                    r3: 35,
                    r4: 35,
                    onpressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => ServiceSelectUser(
                                    uid: uid,
                                    serv: serviceSelect.chkBox2,
                                  )));

                    },
                    bColor: MyColorConst.color2,
                    txt: 'Confirm',
                    txtstyle: MyTextStyle().txtstyle4)
              ],
            );
          }),
        ],
      ),
    );
  }
}
