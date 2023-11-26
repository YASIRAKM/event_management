
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
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
  Future<UserCredential?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleSignInAccount =
      await GoogleSignIn().signIn();

      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;

        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken,
        );

        return await FirebaseAuth.instance.signInWithCredential(credential);
      }
    } catch (e) {
      print(e);
      return null;
    }
    notifyListeners();
  }
  Future<UserCredential?> signInWithFacebook() async {
    try {
      final LoginResult loginResult = await FacebookAuth.instance.login();
      if (loginResult.status == LoginStatus.success) {
        final AuthCredential facebookCredential =
        FacebookAuthProvider.credential(loginResult.accessToken!.token);
        return await FirebaseAuth.instance.signInWithCredential(facebookCredential);
      }
    } catch (e) {
      print('Error signing in with Facebook: $e');
      return null;
    }
    notifyListeners();
  }
}



