
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'admin/view/admin_home_view.dart';
import 'login_model.dart';
import 'user/view/user_home.dart';

class LoginController extends ChangeNotifier {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  late UserModel user;
  late  String id ;
  // final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future autoLogin(BuildContext context)async{
    final sh = await SharedPreferences.getInstance();
    var temp = sh.getBool("log")??false;
    var uid = sh.getString("userid");
    if(temp){
      Navigator.push(context, MaterialPageRoute(builder: (_)=>UserHomeView()));
    }
  }

  Future login(BuildContext context) async {
    try {
      final authRef = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);
      User? user = authRef.user;
      id = user!.uid;
      final sh = await SharedPreferences.getInstance();
      sh.setString("userid", user.uid);


      if (user!.uid == "ieR1Jk99K2etvcgu33hbm8lyfWs2") {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (_) => AdminHome()));
      } else {

        sh.setBool("log", true);
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => UserHomeView( )));
      }
      notifyListeners();
    } on FirebaseAuthException catch (e) {
      print(e);
    }
  }
  logout()async{
    await FirebaseAuth.instance.signOut();
    final pref = await SharedPreferences.getInstance();
    pref.setBool("log", false);
    notifyListeners();
  }
  googleSignup()async{
    await FirebaseAuth.instance.signInWithProvider(GoogleAuthProvider());
  }
}



