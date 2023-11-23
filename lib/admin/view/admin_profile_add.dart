import 'package:eventmanagement/utils//common_appbar_admin.dart';
import 'package:eventmanagement/utils//new_container_button.dart';
import 'package:eventmanagement/admin/controller/add_image.dart';
import 'package:eventmanagement/admin/view/admin_home_view.dart';
import 'package:eventmanagement/constants/color_constants.dart';
import 'package:eventmanagement/constants/text_style_constant.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../utils/new_txtfield.dart';


class AdminProfile extends StatefulWidget {
  const AdminProfile({super.key});

  @override
  State<AdminProfile> createState() => _AdminProfileState();
}

class _AdminProfileState extends State<AdminProfile> {
  TextEditingController  nameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController companyController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController mailController = TextEditingController();
  var imgs;

  @override
  Widget build(BuildContext context) {
    final ht = MediaQuery.sizeOf(context).height;
    final wt = MediaQuery.sizeOf(context).width;

    return Scaffold(backgroundColor: MyColorConst().backgroundColor,
      appBar:const CommonAppbar(txt: 'Profile', drawericon: Icons.menu, clrs: MyColorConst.color1),
      drawer: const Drawers(),
      body: Consumer<AddPhoto>(
        builder: (context, addPhoto, child) {
          return SingleChildScrollView(
            padding: EdgeInsets.only(top: ht * .06, left: wt * .1),
            child: Column(
              children: [
                Stack(
                  children: [
                    imgs == null
                        ? CircleAvatar(
                            radius: wt * .2,
                            child: Icon(
                              Icons.person,
                              size: ht * .07,
                            ))
                        : CircleAvatar(
                            backgroundImage: NetworkImage(imgs),
                            radius: wt * .2,
                          ),
                    Positioned(
                      top: ht * .14,
                      left: wt * .3,
                      child: CircleAvatar(
                        radius: wt * .05,
                        child: InkWell(
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return Padding(
                                    padding: EdgeInsets.only(top: ht*.3),
                                    child: Column(
                                      children: [
                                        elevatedButton(
                                            hght: ht * .06,
                                            wdth: wt * .35,
                                            cColor: MyColorConst().color3,
                                            r2: 0,
                                            r1: 0,
                                            r3: 0,
                                            r4: 0,
                                            onpressed: () async {
                                              addPhoto.uploadImage1();
                                              final db = await SharedPreferences
                                                  .getInstance();
                                              final img = db.getString('url');
                                              setState(() {
                                                imgs = img.toString();
                                              });
                                            },
                                            bColor: MyColorConst().cmplttxt1,
                                            txt: 'Camera',
                                            txtstyle: MyTextStyle().txtstyle2),SizedBox(height: ht*.02,)
                                        ,elevatedButton(
                                            hght: ht * .06,
                                            wdth: wt * .35,
                                            cColor: MyColorConst().color3,
                                            r2: 0,
                                            r1: 0,
                                            r3: 0,
                                            r4: 0,
                                            onpressed: () async {
                                              addPhoto.uploadImageC();
                                              final db = await SharedPreferences
                                                  .getInstance();
                                              final img = db.getString('url');
                                              setState(() {
                                                imgs = img.toString();
                                              });
                                            },
                                            bColor: MyColorConst().cmplttxt1,
                                            txt: 'Gallery',
                                            txtstyle: MyTextStyle().txtstyle2),
                                      ],
                                    ),
                                  );
                                },
                              );
                            },
                            child: Icon(FontAwesomeIcons.plus,
                                size: wt * .07, color: MyColorConst().backgroundColor)),
                      ),
                    ),
                  ],
                ),SizedBox(height: ht*.02,),
                TxtField(
                  title: 'Name :',
                  h: ht * .07,
                  w: wt * .8,
                  cntrlr: nameController,
                  ics: FontAwesomeIcons.person,
                  suffixpress: () {},
                  kybrd: TextInputType.text,
                  upd: false,
                ),SizedBox(height: ht*.02,),
                TxtField(
                  title: 'E-mail :',
                  h: ht * .07,
                  w: wt * .8,
                  cntrlr: mailController,
                  ics: Icons.mail,
                  suffixpress: () {},
                  kybrd: TextInputType.emailAddress,
                  upd: false,
                ),SizedBox(height: ht*.02,),
                TxtField(
                  title: 'Phone :',
                  h: ht * .07,
                  w: wt * .8,
                  cntrlr: phoneController,
                  ics: Icons.call,
                  suffixpress: () {},
                  kybrd: TextInputType.number,
                  upd: false,
                ),SizedBox(height: ht*.02,),
                TxtField(
                  title: 'Company Name',
                  h: ht * .07,
                  w: wt * .8,
                  cntrlr: companyController,
                  ics: FontAwesomeIcons.building,
                  suffixpress: () {},
                  kybrd: TextInputType.text,
                  upd: false,
                ),SizedBox(height: ht*.02,),
                TxtField(
                  title: 'Address',
                  h: ht * .07,
                  w: wt * .8,
                  cntrlr: addressController,
                  ics: FontAwesomeIcons.addressCard,
                  suffixpress: () {},
                  kybrd: TextInputType.streetAddress,
                  upd: false,
                ),SizedBox(height: ht*.02,),
                elevatedButton(
                  hght: ht * .04,
                  onpressed: () {},
                  txtstyle: MyTextStyle().txtstyle1,
                  txt: 'Add Details',
                  r4: 0,
                  r3: 0,
                  r2: 0,
                  r1: 0,
                  cColor: MyColorConst.color1,
                  bColor: MyColorConst.color1,
                  wdth: wt * .4,
                )
              ],
            ),
          );
        }
      ),
    );
  }
}
