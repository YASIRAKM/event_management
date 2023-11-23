import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class NeColumnTxtField extends StatelessWidget {
  const NeColumnTxtField({
    super.key,
    required this.Header,
    required this.ics,
    required this.lbl,
    required this.txtsl,
    required this.clr,
    required this.cntrlr,
    required this.head, required this.htxtsl, required this.docid,
  });

  final TextEditingController cntrlr;
  final String docid;

  final Color clr;
  final TextStyle txtsl;
  final TextStyle htxtsl;
  final String Header;
  final String lbl;
  final String head;

  final IconData ics;

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(Header,style: htxtsl,),
        TextField(
          controller: cntrlr,
          decoration: InputDecoration(
              border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(0)),
              labelStyle: txtsl,
              labelText: lbl,
              prefixIcon: Icon(
                ics,
                color: clr,
              ),
              suffixIcon: IconButton(
                icon: Icon(
                  Icons.update,
                  color: clr,
                ),
                onPressed: () async {
                  await FirebaseFirestore.instance
                      .collection("Users")
                      .doc(docid)
                      .update({"$head": cntrlr.text});
                },
              )),
        )
      ],
    );
  }
}