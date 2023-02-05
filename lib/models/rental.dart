class Rental {
  late String availableFrom;
  late String admin;
  late String availableTo;
  late String carname;
  late String description;
  late String imageUrl;
  late String price;
  late String rentalId;

  Rental(
      {required this.availableFrom,
      required this.admin,
      required this.availableTo,
      required this.carname,
      required this.description,
      required this.imageUrl,
      required this.rentalId});

  Rental.fromJson(Map<String, dynamic> json) {
    availableFrom = json["availableFrom"];
    admin = json["admin"];
    availableTo = json["availableTo"];
    carname = json["carname"];
    description = json["description"];
    imageUrl = json["imageUrl"];
    price = json["price"];
    rentalId = json["rentalId"];
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = Map<String, dynamic>();

    data["availableFrom"] = availableFrom;
    data["admin"] = admin;
    data["availableTo"] = availableTo;
    data["carname"] = carname;
    data["description"] = description;
    data["imageUrl"] = imageUrl;
    data["price"] = price;
    data["renatlId"] = rentalId;

    return data;
  }
}
