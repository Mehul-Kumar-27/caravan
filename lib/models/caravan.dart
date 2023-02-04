class Post {
  late String caravanId;
  late String admin;
  late String time;
  late String date;
  late String destination;
  late String source;
  late String price;
  late String passenger;

  Post(
      {required this.caravanId,
      required this.admin,
      required this.date,
      required this.destination,
      required this.source,
      required this.time,
      required this.price,
      required this.passenger});

  Post.fromJson(Map<String, dynamic> json) {
    caravanId = json["caravanId"];
    admin = json["admin"];
    time = json["time"];
    date = json["date"];
    destination = json["destination"];
    source = json["source"];
    price = json["price"];
    passenger = json["passenger"];
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = Map<String, dynamic>();

    data["caravanId"] = caravanId;
    data["admin"] = admin;
    data["time"] = time;
    data["date"] = date;
    data["destination"] = destination;
    data["source"] = source;
    data["price"] = price;
    data["passenger"] = passenger;

    return data;
  }
}
