
import 'package:flutter/material.dart';

class NewRowElevatedButtonWidget extends StatelessWidget {
  final IconData icom;
  final IconData icos;
  final Color iccolor;
  final Color ccolor;
  // final String title;
  final dynamic route;
  final dynamic route1;
  final double ht;
  final double wt;
  const NewRowElevatedButtonWidget({
    super.key, required this.icom, required this.route, required this.ht, required this.wt, required this.icos, required this.route1, required this.iccolor, required this.ccolor,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: ht,width: wt,
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(width: wt*.47,
            child: ElevatedButton(style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(ccolor)),onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (_)=>route));
            }, child:Icon(icom,color: iccolor,)),
          ),SizedBox(width: wt*.02,),
          SizedBox(width: wt*.47,
            child: ElevatedButton(style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(ccolor)),onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (_)=>route1));
            }, child:Icon(icos,color: iccolor,)),
          ),
        ],
      ),
    );
  }
}