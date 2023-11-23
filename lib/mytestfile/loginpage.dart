import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class TestLogin extends StatefulWidget {
  const TestLogin({super.key});

  @override
  State<TestLogin> createState() => _TestLoginState();
}

class _TestLoginState extends State<TestLogin> {
  TextEditingController cntrl1 = TextEditingController();
  TextEditingController cntrl2 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(),
      body: Column(
        children: [
          TextFormField(
            controller: cntrl1,
          ),
          TextFormField(
            controller: cntrl2,
          ),
          ElevatedButton(
              onPressed: () async {
                final ref = await FirebaseAuth.instance
                    .signInWithEmailAndPassword(
                        email: cntrl1.text, password: cntrl2.text);
                User? user = ref.user;

                if (user!.uid == "ieR1Jk99K2etvcgu33hbm8lyfWs2") {
                  Fluttertoast.showToast(msg: "OK");
                } else {
                  Fluttertoast.showToast(msg: "error");
                }
              },
              child: Text("login"))
        ],
      ),
    );
  }
}
