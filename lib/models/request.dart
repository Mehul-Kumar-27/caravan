class Request {
  late String caravanId;
  late String admin;
  late String requestId;
  late String userId;
  late String username;

  Request(
      {required this.caravanId,
      required this.admin,
      required this.userId,
      required this.requestId,
      required this.username});

  Request.fromJson(Map<String, dynamic> json) {
    caravanId = json["caravanId"];
    admin = json["admin"];
    requestId = json["requestId"];
    userId = json["userId"];
    username = json["username"];
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = Map<String, dynamic>();

    data["caravanId"] = caravanId;
    data["admin"] = admin;
    data["requestId"] = requestId;
    data["userId"] = userId;
    data["username"] = username;

    return data;
  }
}
