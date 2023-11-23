import 'package:checkout_screen_ui/checkout_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:eventmanagement/user/view/user_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'user_home.dart';

class PaymentView extends StatelessWidget {
  final String name;
  final int price;
  final String userid;
  final String docId;

 const PaymentView(
      {super.key,
      required this.name,
      required this.price,
      required this.userid,
      required this.docId});



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CheckoutPage(
        priceItems: [
          PriceItem(name: name, quantity: 1, totalPriceCents: price)
        ],
        payToName: 'Event',
        displayTestData: true,
        onCardPay: (p0) {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (_) => const UserHomeView()));
        },
        displayEmail: true,
        displayCashPay: true,
        displayNativePay: true,
        payBtnKey: GlobalKey(),
      ),
    );
  }
}
