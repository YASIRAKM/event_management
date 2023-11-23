class CheckOutModel {
  num total =0;

  void calculateTotal(Map<String, dynamic> events, List<dynamic> listOfMaps) {
    try{
    num totalSum =num.parse(events["price"]);
    for (var map in listOfMaps) {
      totalSum += map["Price"];
    }
    total = totalSum;}
        catch(e){
      print(e);
        }
  }
}