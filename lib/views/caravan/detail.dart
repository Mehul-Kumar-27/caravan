// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:unicons/unicons.dart';
import 'package:velocity_x/velocity_x.dart';

import 'package:caravan/global/global.dart';
import 'package:caravan/models/caravan.dart';
import 'package:caravan/models/request.dart';

class CaravanDetail extends StatefulWidget {
  Post model;
  bool requestSent;
  CaravanDetail({
    Key? key,
    required this.model,
    required this.requestSent,
  }) : super(key: key);

  @override
  State<CaravanDetail> createState() => _CaravanDetailState();
}

class _CaravanDetailState extends State<CaravanDetail> {
  TimeOfDay _time = TimeOfDay.now();
  TextEditingController source = TextEditingController();
  TextEditingController destination = TextEditingController();
  TextEditingController date = TextEditingController();
  TextEditingController time = TextEditingController();
  TextEditingController price = TextEditingController();
  TextEditingController passenger = TextEditingController();

  late bool sendRequest ;

  String requestId = DateTime.now().millisecondsSinceEpoch.toString();
  Future sentRequestToAdmin() async {
    FirebaseFirestore.instance
        .collection("user")
        .doc(widget.model.admin)
        .collection("caravan")
        .doc(widget.model.caravanId)
        .collection("request")
        .doc(requestId)
        .set({
      "userId": sharedPreferences!.getString("uid"),
      "requestId": requestId,
      "admin": widget.model.admin,
      "caravanId": widget.model.caravanId,
      "username": sharedPreferences!.getString("name"),
    });
  }

  Future sentRequest() async {
    FirebaseFirestore.instance
        .collection("carvan")
        .doc(widget.model.caravanId)
        .collection("request")
        .doc(requestId)
        .set({
      "userId": sharedPreferences!.getString("uid"),
      "requestId": requestId,
      "admin": widget.model.admin,
      "caravanId": widget.model.caravanId,
      "username": sharedPreferences!.getString("name"),
    });
  }

  Future sentRequestCopyToUser() async {
    FirebaseFirestore.instance
        .collection("user")
        .doc(sharedPreferences!.getString("uid"))
        .collection("request")
        .doc(requestId)
        .set({
      "userId": sharedPreferences!.getString("uid"),
      "requestId": requestId,
      "admin": widget.model.admin,
      "caravanId": widget.model.caravanId,
      "username": sharedPreferences!.getString("name"),
    });
  }

  bool isuploading = false;
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomLeft,
              colors: [Colors.white, Colors.white]),
        ),
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.05,
            ),
            isuploading
                ? const LinearProgressIndicator(
                    color: Colors.indigo,
                  )
                : Container(),
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Icon(
                    Icons.arrow_back,
                    color: Colors.indigo,
                    size: 25,
                  ),
                )
              ],
            ).px8(),
            "Caravan ID: ${widget.model.caravanId}"
                .text
                .textStyle(GoogleFonts.poppins(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.indigo))
                .make(),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            GestureDetector(
              onTap: () async {
                setState(() {
                  sendRequest = true;
                });
                await sentRequestToAdmin();
                await sentRequest();
                await sentRequestCopyToUser();
              },
              child: Container(
                height: MediaQuery.of(context).size.height * 0.08,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.indigo),
                child: Center(
                  child: sendRequest
                      ? "Your Request has been sent !"
                          .text
                          .textStyle(GoogleFonts.poppins(
                              fontSize: 17,
                              fontWeight: FontWeight.w600,
                              color: Colors.white))
                          .make()
                      : "Send Join Request"
                          .text
                          .textStyle(GoogleFonts.poppins(
                              fontSize: 17,
                              fontWeight: FontWeight.w600,
                              color: Colors.white))
                          .make(),
                ),
              ).px12(),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "Source",
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.bold,
                    fontSize: (15),
                    color: Colors.deepPurple,
                  ),
                ).px16().py2(),
              ],
            ),
            SizedBox(
              height: (50),
              child: TextField(
                controller: source,
                style: const TextStyle(color: Colors.black),
                enableSuggestions: false,
                enabled: false,
                autocorrect: false,
                keyboardType: TextInputType.name,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.blue[100],
                  hintStyle: GoogleFonts.poppins(
                    color: Colors.black54,
                  ),
                  prefixIcon: const Icon(
                    Icons.location_on,
                    color: Colors.black,
                  ),
                  hintText: 'Source of Journey ...',
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular((6.94)),
                    ),
                  ),
                ),
                onChanged: ((value) {
                  setState(() {});
                }),
              ),
            ).px8(),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "Destination",
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.bold,
                    fontSize: (15),
                    color: Colors.deepPurple,
                  ),
                ).px16().py2(),
              ],
            ),
            SizedBox(
              height: (50),
              child: TextField(
                enabled: false,
                controller: destination,
                style: const TextStyle(color: Colors.black),
                enableSuggestions: false,
                autocorrect: false,
                keyboardType: TextInputType.name,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.blue[100],
                  hintStyle: GoogleFonts.poppins(
                    color: Colors.black54,
                  ),
                  prefixIcon: const Icon(
                    Icons.location_on,
                    color: Colors.black,
                  ),
                  hintText: 'Destination of Journey ...',
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular((6.94)),
                    ),
                  ),
                ),
                onChanged: ((value) {
                  setState(() {});
                }),
              ),
            ).px8(),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Date",
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.bold,
                            fontSize: (15),
                            color: Colors.deepPurple,
                          ),
                        ).px16().py2(),
                      ],
                    ),
                    SizedBox(
                      height: (50),
                      width: MediaQuery.of(context).size.width * 0.45,
                      child: TextField(
                        controller: date,
                        style: const TextStyle(color: Colors.black),
                        enableSuggestions: false,
                        enabled: false,
                        autocorrect: false,
                        keyboardType: TextInputType.name,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.blue[100],
                          hintStyle: GoogleFonts.poppins(
                            color: Colors.black54,
                          ),
                          prefixIcon: const Icon(
                            Icons.calendar_month_sharp,
                            color: Colors.black,
                          ),
                          hintText: 'Source of Journey ...',
                          border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular((6.94)),
                            ),
                          ),
                        ),
                        onChanged: ((value) {
                          setState(() {});
                        }),
                      ),
                    ).px8(),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Time",
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.bold,
                            fontSize: (15),
                            color: Colors.deepPurple,
                          ),
                        ).px16().py2(),
                      ],
                    ),
                    SizedBox(
                      height: (50),
                      width: MediaQuery.of(context).size.width * 0.45,
                      child: TextField(
                        controller: time,
                        style: const TextStyle(color: Colors.black),
                        enableSuggestions: false,
                        enabled: false,
                        autocorrect: false,
                        keyboardType: TextInputType.name,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.blue[100],
                          hintStyle: GoogleFonts.poppins(
                            color: Colors.black54,
                          ),
                          prefixIcon: const Icon(
                            Icons.timelapse,
                            color: Colors.black,
                          ),
                          hintText: 'Source of Journey ...',
                          border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular((6.94)),
                            ),
                          ),
                        ),
                        onChanged: ((value) {
                          setState(() {});
                        }),
                      ),
                    ).px8(),
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Cost per head",
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.bold,
                            fontSize: (15),
                            color: Colors.deepPurple,
                          ),
                        ).px16().py2(),
                      ],
                    ),
                    SizedBox(
                      height: (50),
                      width: MediaQuery.of(context).size.width * 0.45,
                      child: TextField(
                        controller: price,
                        style: const TextStyle(color: Colors.black),
                        enableSuggestions: false,
                        enabled: false,
                        autocorrect: false,
                        keyboardType: TextInputType.name,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.blue[100],
                          hintStyle: GoogleFonts.poppins(
                            color: Colors.black54,
                          ),
                          prefixIcon: const Icon(
                            Icons.monetization_on,
                            color: Colors.black,
                          ),
                          hintText: 'Source of Journey ...',
                          border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular((6.94)),
                            ),
                          ),
                        ),
                        onChanged: ((value) {
                          setState(() {});
                        }),
                      ),
                    ).px8(),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "No of Passengers",
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.bold,
                            fontSize: (15),
                            color: Colors.deepPurple,
                          ),
                        ).px16().py2(),
                      ],
                    ),
                    SizedBox(
                      height: (50),
                      width: MediaQuery.of(context).size.width * 0.45,
                      child: TextField(
                        controller: passenger,
                        style: const TextStyle(color: Colors.black),
                        enableSuggestions: false,
                        enabled: false,
                        autocorrect: false,
                        keyboardType: TextInputType.name,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.blue[100],
                          hintStyle: GoogleFonts.poppins(
                            color: Colors.black54,
                          ),
                          prefixIcon: const Icon(
                            Icons.person,
                            color: Colors.black,
                          ),
                          hintText: 'Source of Journey ...',
                          border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular((6.94)),
                            ),
                          ),
                        ),
                        onChanged: ((value) {
                          setState(() {});
                        }),
                      ),
                    ).px8(),
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                "Current Queue"
                    .text
                    .textStyle(GoogleFonts.poppins(
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey[700]))
                    .make(),
              ],
            ).px20(),
            Expanded(
                child: StreamBuilder(
              stream: feeds,
              builder: (context, AsyncSnapshot snapshot) {
                return !snapshot.hasData
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : ListView.builder(
                        shrinkWrap: true,
                        itemCount: snapshot.data.docs.length,
                        itemBuilder: (context, index) {
                          print(snapshot.data.docs.length);
                          Request request_model = Request.fromJson(
                              snapshot.data!.docs[index].data()!
                                  as Map<String, dynamic>);

                          return GestureDetector(
                            child: QueueRequest(
                              model: request_model,
                            ),
                          );
                        });
              },
            )),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    setState(() {
      sendRequest = widget.requestSent;
    });
    // TODO: implement initState
    getQueueRequest();
    source = TextEditingController(text: widget.model.source);
    destination = TextEditingController(text: widget.model.destination);
    date = TextEditingController(text: widget.model.date);
    time = TextEditingController(text: widget.model.time);
    price = TextEditingController(text: widget.model.price);
    passenger = TextEditingController(text: widget.model.passenger);

    super.initState();
  }

  Stream? feeds;

  Future<Stream<QuerySnapshot>> getQueue() async {
    return FirebaseFirestore.instance
        .collection("carvan")
        .doc(widget.model.caravanId)
        .collection("request")
        .snapshots();
  }

  getQueueRequest() async {
    await getQueue().then((value) {
      setState(() {
        feeds = value;
      });
    });
  }
}

class QueueRequest extends StatefulWidget {
  Request model;
  QueueRequest({
    Key? key,
    required this.model,
  }) : super(key: key);

  @override
  State<QueueRequest> createState() => _QueueRequestState();
}

class _QueueRequestState extends State<QueueRequest> {
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Icon(
            Icons.person,
            size: 20,
            color: Colors.purpleAccent[700],
          ),
          const SizedBox(
            width: 40,
          ),
          widget.model.username.text
              .textStyle(GoogleFonts.poppins(
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey[700]))
              .make(),
        ],
      ),
    ).px12();
  }
}
