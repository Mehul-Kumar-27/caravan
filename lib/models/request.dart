class Request {
  late String caravanId;
  late String admin;
  late String requestId;
  late String userId;


  Request(
      {required this.caravanId,
      required this.admin,
      required this.userId,
      required this.requestId
});

  Request.fromJson(Map<String, dynamic> json) {
    caravanId = json["caravanId"];
    admin = json["admin"];
    requestId = json["requestId"];
    userId = json["userId"];

  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = Map<String, dynamic>();

    data["caravanId"] = caravanId;
    data["admin"] = admin;
    data["requestId"] = requestId;
    data["userId"] = userId;
   

    return data;
  }
}
