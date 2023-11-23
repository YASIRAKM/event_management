import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../../controller/fetching_data.dart';

class EventImages extends StatelessWidget {
  final String docId;

  const EventImages({super.key, required this.docId});




  @override
  Widget build(BuildContext context) {
    final FetchDataAdmin fetchData =Provider.of<FetchDataAdmin>(context);
    fetchData.fetchDataWithDocument("Event",docId);
    return Scaffold(appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: StreamBuilder(
          stream:fetchData.dataStream2,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Lottie.asset("asset/lottie/Animation - 1698750195337.json");
            } else if (snapshot.hasError) {
              return const Text("Error");
            } else if (!snapshot.hasData) {
              return const Text("No Data");
            } else if (snapshot.hasData) {
              Map<String, dynamic>? eventData = snapshot.data!;
              List<dynamic>? yourList = eventData['URLlist'];
              return CarouselSlider.builder(itemCount: yourList!.length, itemBuilder: (context, index, realIndex) {
                return Image.network(yourList[index].toString(),fit: BoxFit.cover,);
              }, options: CarouselOptions(height: 600
              ));
            } else {
              return const Text("ERROR");
            }
          },
        ),
      ),
    );
  }
}
