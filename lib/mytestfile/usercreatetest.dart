// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
//
// import '../main.dart';
//
// class UserModel {
//   String name;
//   String email;
//   String phone;
//   String district;
//   String state;
//   String password;
//
//   UserModel({
//     required this.name,
//     required this.email,
//     required this.phone,
//     required this.district,
//     required this.state,
//     required this.password,
//   });
// }
//
//
// class UserController extends ChangeNotifier {
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//
//   Future<void> registerUser({
//     required String name,
//     required String email,
//     required String phone,
//     required String district,
//     required String state,
//     required String password,
//
//   }) async {
//     try {
//       final authResult = await _auth.createUserWithEmailAndPassword(
//         email: email,
//         password: password,
//       );
//
//       final user = authResult.user;
//
//       if (user != null) {
//         await _firestore.collection("Users").add({
//           "Id": user.uid,
//           "Name": name,
//           "E mail": email,
//           "Phone no": phone,
//           "District": district,
//           "State": state,
//           "Password": password,
//         });
//
//
//         notifyListeners();
//       }
//     } catch (e) {
//       // Handle registration error
//       print(e);
//     }
//   }
// }
//
// class UserAuthentication1 extends StatelessWidget {
//   GlobalKey<FormState> formk = GlobalKey<FormState>();
//   TextEditingController namec = TextEditingController();
//   TextEditingController mailc = TextEditingController();
//   TextEditingController phonec = TextEditingController();
//   TextEditingController districtc = TextEditingController();
//   TextEditingController statec = TextEditingController();
//   TextEditingController passwordc = TextEditingController();
//   TextEditingController password1c = TextEditingController();
//   bool isobsc = false;
//   @override
//   Widget build(BuildContext context) {
//     final controller = Provider.of<UserController>(context);
//     final controller1=Provider.of<BooController>(context);
//
//     return Scaffold(
//       body: Form(
//         child: ListView(
//           children: [NewftxtformfieldWidget(
//             cntlr: namec,
//             lbltxt: 'Name', ics: Icons.person,
//           ),
//             NewftxtformfieldWidget(
//                 cntlr: mailc, lbltxt: 'E mail', ics: Icons.mail),
//             NewftxtformfieldWidget(
//                 cntlr: phonec, lbltxt: 'Phone no', ics: Icons.phone),
//             NewftxtformfieldWidget(cntlr: districtc,
//                 lbltxt: ' District',
//                 ics: Icons.pin_drop_outlined),
//             NewftxtformfieldWidget(cntlr: statec,
//                 lbltxt: 'State',
//                 ics: Icons.location_searching),
//             TextFormField(
//               validator: (value) {
//                 if (value!.isEmpty) {
//                   return 'please fill';
//                 }
//                 return null;
//               },
//               controller: passwordc,
//               obscuringCharacter: "*",
//               obscureText: isobsc,
//               decoration: InputDecoration(labelText: 'Password',
//                   prefixIcon: Icon(Icons.password),
//                   suffixIcon: controller1._userModel.isBool? IconButton(onPressed: () {
//
//                      controller1.setLoggedIn(!controller1._userModel.isBool);
//
//                   }, icon: Icon(CupertinoIcons.eye)) :IconButton(onPressed: (){
//
//                     controller1.setLoggedIn(!controller1._userModel.isBool);
//
//                   }, icon: Icon(CupertinoIcons.eye_slash))),),
//             TextFormField(
//               validator: (value) {
//                 if (value!.isEmpty) {
//                   return 'please fill';
//                 }
//                 return null;
//               },
//               controller: password1c,
//               obscuringCharacter: "*",
//               obscureText: true,
//               decoration: InputDecoration(labelText: 'Confirm Password',
//                 prefixIcon: Icon(Icons.password),),),
//
//
//             ElevatedButton(
//               onPressed: () async {
//                 // Collect user input
//                 String name = namec.text;
//                 String email = mailc.text;
//                 String phone = phonec.text;
//                 String district = districtc.text;
//                 String state = statec.text;
//                 String password = passwordc.text;
//
//                 // Call the controller to register the user
//                 await controller.registerUser(
//                   name: name,
//                   email: email,
//                   phone: phone,
//                   district: district,
//                   state: state,
//                   password: password,
//                 );
//
//                Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=>MyHomePage(title: '')));
//               },
//               child: Text("Register"),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// class BoolModel {
//   bool isBool= false;
//
// }
// class BooController extends ChangeNotifier {
//   BoolModel _userModel = BoolModel();
//
//
//   void setLoggedIn(bool value) {
//     _userModel.isBool = value;
//     notifyListeners();
//   }
//
//
// }