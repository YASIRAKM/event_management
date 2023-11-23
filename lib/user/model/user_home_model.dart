
class Event {
  final String title;
  final String description;
  final List imageUrl;
  final String price;


  Event(  {
    required this.price,
    required this.title,
    required this.description,
    required this.imageUrl,
  });
}