import 'package:eventmanagement/admin/model/authmodel.dart';
import 'package:eventmanagement/constants/color_constants.dart';
import 'package:eventmanagement/constants/text_style_constant.dart';
import 'package:eventmanagement/user/controller/popup_menu_controller.dart';
import 'package:eventmanagement/user/controller/userid_controller.dart';
import 'package:eventmanagement/user/view/auth_view.dart';
import 'package:eventmanagement/user/view/user_home.dart';
import 'package:eventmanagement/utils/new_container_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';



import 'admin/controller/add_image.dart';
import 'admin/controller/admin_creeating_updating_firebase.dart';
import 'admin/controller/fetching_data.dart';
import 'admin/view/admin_home_view.dart';
import 'firebase_options.dart';
import 'login_controller.dart';
import 'user/controller/bool_controller.dart';
import 'user/controller/checkout_controller.dart';
import 'user/controller/servie_select_controller.dart';
import 'user/controller/user_controller_user.dart';
import 'user/controller/user_home_controller.dart';

import 'user/controller/value_changing_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => FetchDataAdmin()),
    ChangeNotifierProvider(create: (context) => AddPhoto()),
    ChangeNotifierProvider(create: (context) => AddUpdate()),
    ChangeNotifierProvider(create: (context) => LoginController()),
    ChangeNotifierProvider(create: (context) => UserIdController()),
    ChangeNotifierProvider(create: (context) => UserController()),
    ChangeNotifierProvider(create: (context) => ServiceSelectController()),
    ChangeNotifierProvider(create: (context) => BooController()),
    ChangeNotifierProvider(create: (context) => ValueChanger()),
    ChangeNotifierProvider(create: (context) => PopUpMenuController()),
    ChangeNotifierProvider(create: (context) => SelectedState()),
    ChangeNotifierProvider(create: (context) => EventController()),
    ChangeNotifierProvider(create: (context) => CheckOutController()),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        debugShowCheckedModeBanner: false,
        home:
        const MyHomePage());
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    super.key,
  });

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    Provider.of<LoginController>(context).autoLogin(context);
    final ht = MediaQuery.sizeOf(context).height;
    final wt = MediaQuery.sizeOf(context).width;
    GlobalKey<FormState> formK = GlobalKey<FormState>();

    return Scaffold(
        appBar: AppBar(
          backgroundColor: MyColorConst.color1,
          title: Text("Login", style: MyTextStyle().appBarText),
          leading: const Text(""),
        ),
        body: Stack(
          children: [
            Padding(
              padding: EdgeInsets.only(left: wt * .1),
              child: SizedBox(
                height: ht * .4,
                width: wt * 1,
                child: Lottie.asset("asset/lottie/loginanimation.json"),
              ),
            ),
            Padding(
              padding:
                  EdgeInsets.only(top: ht * .35, left: wt * .1, right: wt * .1),
              child: Form(
                  key: formK,
                  child: Consumer2<LoginController, BooController>(
                      builder: (context, controller, controller2, child) {
                    return ListView(
                      children: [
                        TextFormField(
                          controller: controller.emailController,
                          decoration:
                              const InputDecoration(labelText: 'E mail'),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Please Fill";
                            }
                            return null;
                          },
                        ),

                        TextFormField(
                          obscuringCharacter: "*",
                          obscureText: controller2.isBool,
                          controller: controller.passwordController,
                          decoration: InputDecoration(
                              labelText: 'Password',
                              suffixIcon: controller2.isBool
                                  ? IconButton(
                                      onPressed: () {
                                        controller2
                                            .setLoggedIn(!controller2.isBool);
                                      },
                                      icon: const Icon(FontAwesomeIcons.eye))
                                  : IconButton(
                                      onPressed: () {
                                        controller2
                                            .setLoggedIn(!controller2.isBool);
                                      },
                                      icon: const Icon(FontAwesomeIcons.eyeSlash))),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Please Fill";
                            }
                            return null;
                          },
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              left: wt * .2, top: ht * .04, right: wt * .2),
                          child: elevatedButton(
                            hght: ht * .05,
                            wdth: wt * .0003,
                            bColor: Colors.yellow,
                            cColor: Colors.red,
                            r1: ht * .03,
                            r2: ht * .03,
                            r3: ht * .03,
                            r4: ht * .03,
                            txt: 'Login',
                            onpressed: () {
                              if (formK.currentState!.validate()) {
                                controller.login(context);
                              }
                            },
                            txtstyle:const TextStyle(color: MyColorConst.color1),
                          ),
                        ),
                        Padding(
                          padding:
                              EdgeInsets.only(top: ht * .01, left: wt * .02),
                          child: TextButton(
                              onPressed: () {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          UserAuthenticationView(),
                                    ));
                              },
                              child: const Text(
                                "Don't have an account!!",
                                style: TextStyle(
                                    decoration: TextDecoration.underline,
                                    decorationColor: MyColorConst.color1,
                                    color: MyColorConst.color1),
                              )),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 20, left: 50, right: 50),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                  width: wt * .15,
                                  height: ht * .05,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: MyColorConst.color2),
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(ht * .02),
                                          bottomRight:
                                              Radius.circular(ht * .02))),
                                  child:const Icon(
                                    FontAwesomeIcons.google,
                                    color: MyColorConst.color1,
                                  )),
                              const Text(
                                'or',
                                style: TextStyle(
                                    fontSize: 18,
                                    fontFamily: 'Poppins-Regular',
                                    color: Colors.pinkAccent),
                              ),
                              Container(
                                  width: wt * .15,
                                  height: ht * .05,
                                  decoration: BoxDecoration(
                                      border:
                                          Border.all(color: Colors.pinkAccent),
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(ht * .02),
                                          bottomRight:
                                              Radius.circular(ht * .02))),
                                  child: const Icon(
                                    FontAwesomeIcons.facebook,
                                    color: MyColorConst.color1,
                                  )),
                            ],
                          ),
                        )
                      ],
                    );
                  })),
            ),
          ],
        ));
  }
}
