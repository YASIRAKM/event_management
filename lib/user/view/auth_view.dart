
import 'package:eventmanagement/constants/color_constants.dart';
import 'package:eventmanagement/constants/text_style_constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../main.dart';
import '../../utils/common_appbar_admin.dart';
import '../../utils/new_container_button.dart';
import '../../utils/new_txtfield_with_preffixicon.dart';
import '../controller/bool_controller.dart';
import '../controller/popup_menu_controller.dart';
import '../controller/user_controller_user.dart';
import '../model/popup_menu_model.dart';

class UserAuthenticationView extends StatelessWidget {
 final  GlobalKey<FormState> formK = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
 final  TextEditingController mailController = TextEditingController();
 final  TextEditingController phoneController = TextEditingController();
 final  TextEditingController districtController = TextEditingController();
 final   TextEditingController stateController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
 final  TextEditingController password1Controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final ht=MediaQuery.sizeOf(context).height;
    final wt=MediaQuery.sizeOf(context).width;
    return Scaffold(appBar: const CommonAppbar(txt:'Register', drawericon: CupertinoIcons.back, clrs: MyColorConst.color1),
      body: Stack(
        children: [
          Padding(
            padding: EdgeInsets.only(top: ht*.05),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding:  EdgeInsets.only(left: wt*.02),
                  child: Text(" Create an account",style: MyTextStyle().drawerHeaderText,),
                ),
                Padding(
                  padding:  EdgeInsets.only(left: wt*.07,top: ht*.005,bottom: ht*.005),
                  child: Text("Let's get started by filling the form",style: MyTextStyle().txtstyle2,),
                ),
              ],
            ),
          ),
          Consumer4<UserController, BooController, PopUpMenuController,
                  SelectedState>(
              builder: (context, userController, booController,
                  dropdownController, selectedState, child) {
            return Padding(
              padding: EdgeInsets.only(top: ht*.15, left: wt*.07, right: wt*.07),
              child: Form(
                key: formK,
                child: ListView(
                  children: [
                    TextFrmFieldWithPrefixIcon(
                      cntlr: nameController,
                      lbltxt: 'Name',
                      ics: Icons.person,
                      ht: ht*.07,
                      wt: wt*.5,
                      t: ht*.02,
                      ktypr: TextInputType.text,
                    ),
                    TextFrmFieldWithPrefixIcon(
                      ht: ht*.07,
                      wt: wt*.5,
                      t: ht*.01,
                      cntlr: mailController,
                      lbltxt: 'E mail',
                      ics: Icons.mail,
                      ktypr: TextInputType.emailAddress,
                    ),
                    TextFrmFieldWithPrefixIcon(
                      ht: ht*.07,
                      wt: wt*.5,
                      t: ht*.01,
                      cntlr: phoneController,
                      lbltxt: 'Phone no',
                      ics: Icons.phone,
                      ktypr: TextInputType.phone,
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: ht*.01),
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: MyColorConst().backgroundColor),
                            borderRadius: BorderRadius.circular(5)),
                        height: ht*.07,
                        width: wt*.5,
                        child: TextFormField(
                          validator: selectedState.selectedState != null
                              ?null:(value) {
                            if (value!.isEmpty) {
                              return 'please fill';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            label: selectedState.selectedState != null
                                ? Text(selectedState.selectedState!.name)
                                : Text("State",style: MyTextStyle().txtstyle2,),
                            prefixIcon: const Icon(CupertinoIcons.location_fill,color: MyColorConst.color1),
                            suffixIcon: PopupMenuButton<StateModel>(
                              iconSize: 20,
                              icon:const Icon(
                                Icons.arrow_drop_down,
                                color: MyColorConst.accentColor,
                              ),
                              itemBuilder: (context) {
                                return dropdownController.states.map((state) {
                                  return PopupMenuItem<StateModel>(
                                    value: state,
                                    child: Text(state.name),
                                  );
                                }).toList();
                              },
                              onSelected: (state) {
                                selectedState.selectState(state);
                              },
                            ),
                          ),
                        ),
                      ),
                    ),

                    TextFrmFieldWithPrefixIcon(
                      ht: ht*.07,
                      wt: wt*.5,
                      t: ht*.01,
                      cntlr: districtController,
                      lbltxt: ' District',
                      ics: Icons.pin_drop_outlined,
                      ktypr: TextInputType.streetAddress,
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: ht*.01),
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: MyColorConst().backgroundColor),
                            borderRadius: BorderRadius.circular(5)),
                        height: ht*.07,
                        width: wt*.5,
                        child: TextFormField(
                          keyboardType: TextInputType.visiblePassword,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'please fill';
                            }
                            return null;
                          },
                          controller: passwordController,
                          obscuringCharacter: "*",
                          obscureText: booController.isBool,
                          decoration: InputDecoration(
                              border: InputBorder.none,labelStyle: MyTextStyle().txtstyle2,
                              labelText: 'Password',
                              prefixIcon: const Icon(Icons.password,color: MyColorConst.color1,),
                              suffixIcon: booController.isBool
                                  ? IconButton(
                                      onPressed: () {
                                        booController.setLoggedIn(
                                            !booController.isBool);
                                      },
                                      icon:const Icon(CupertinoIcons.eye,))
                                  : IconButton(
                                      onPressed: () {
                                        booController.setLoggedIn(
                                            !booController.isBool);
                                      },
                                      icon:const Icon(CupertinoIcons.eye_slash))),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: ht*.01),
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: MyColorConst().backgroundColor),
                            borderRadius: BorderRadius.circular(5)),
                        height: ht*.07,
                        width: wt*.5,
                        child: TextFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'please fill';
                            }
                            return null;
                          },
                          controller: password1Controller,
                          obscuringCharacter: "*",
                          obscureText: true,
                          decoration: InputDecoration(
                            labelStyle: MyTextStyle().txtstyle2,
                            border: InputBorder.none,
                            labelText: 'Confirm Password',
                            prefixIcon: const Icon(Icons.password,color: MyColorConst.color1,),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding:  EdgeInsets.only(top: ht*.03,left: wt*.1,right: wt*.1),
                      child: elevatedButton(hght: ht*.05, wdth: wt*.3, cColor: MyColorConst.color1, r2: 2, r1: 2, r3: 2, r4: 2, onpressed: () {
                        String name = nameController.text;
                        String email = mailController.text;
                        int phone = phoneController.hashCode;
                        String district = districtController.text;
                        String state = selectedState.selectedState != null
                            ? selectedState.selectedState!.name
                            : stateController.text;
                        String password = passwordController.text;
                        if (formK.currentState!.validate()) {
                          if (passwordController.text == password1Controller.text) {
                            userController.registerUser(

                              name: name,
                              email: email,
                              phone: phone.toString(),
                              district: district,
                              state: state,
                              password: password,
                            );

                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => const MyHomePage()));
                          }
                        }
                      } , bColor: MyColorConst.color1, txt: 'Register', txtstyle: MyTextStyle().txtstyle5),
                    ),

                  ],
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}


