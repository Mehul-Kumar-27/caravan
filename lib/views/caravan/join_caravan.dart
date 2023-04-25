// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:caravan/global/global.dart';
import 'package:caravan/views/caravan/detail.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../models/caravan.dart';

class JoinCaravan extends StatefulWidget {
  const JoinCaravan({super.key});

  @override
  State<JoinCaravan> createState() => _JoinCaravanState();
}

class _JoinCaravanState extends State<JoinCaravan> {
  Stream? feeds;

  Future<Stream<QuerySnapshot>> getCaravan() async {
    return FirebaseFirestore.instance.collection("carvan").snapshots();
  }

  @override
  void initState() {
    // TODO: implement initState
    getAllCaravan();
    super.initState();
  }

  getAllCaravan() {
    getCaravan().then((value) {
      setState(() {
        feeds = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(
            height: 30,
          ),
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
          const SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              "Join Caravan !"
                  .text
                  .textStyle(GoogleFonts.poppins(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.deepPurple[700]))
                  .make()
                  .px24(),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              "Join any caaravan that suit's you !"
                  .text
                  .textStyle(GoogleFonts.poppins(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey))
                  .make()
                  .px24(),
            ],
          ),
          const Divider(
            thickness: 1,
            color: Colors.indigo,
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: 40,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10), color: Colors.grey),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: const [
                Icon(
                  Icons.sort,
                  color: Colors.white,
                ),
                Icon(
                  Icons.more_vert,
                  color: Colors.white,
                )
              ],
            ),
          ).px8(),
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
                        Post model = Post.fromJson(snapshot.data!.docs[index]
                            .data()! as Map<String, dynamic>);
                        return GestureDetector(
                          child: PostDesign(
                            model: model,
                            index: index,
                          ),
                        );
                      });
            },
          )),
          const SizedBox(
            height: 30,
          )
        ],
      ),
    );
  }
}

class PostDesign extends StatefulWidget {
  Post model;
  int index;

  PostDesign({
    Key? key,
    required this.model,
    required this.index,
  }) : super(key: key);

  @override
  State<PostDesign> createState() => _PostDesignState();
}

// 0 -> purple
// 1 -> red
// 2 -> green
// 3 -> pink
// 4 -> blue

class _PostDesignState extends State<PostDesign> {
  bool requestSent = false;
  Stream? request;
  Future getRequest() async {
    return FirebaseFirestore.instance
        .collection("carvan")
        .doc(widget.model.caravanId)
        .collection("request")
        .where("userId", isEqualTo: sharedPreferences!.getString("uid"))
        .get()
        .then((QuerySnapshot snapshot) {
      if (snapshot.docs.isNotEmpty) {
        setState(() {
          requestSent = true;
        });
      }
    });
  }

  getUserRequest() {
    getRequest();
  }

  @override
  void initState() {
    // TODO: implement initState
    getUserRequest();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    int index = widget.index;
    int remainder = index % 5;
    Color dashColor;

    if (remainder == 0) {
      dashColor = Colors.purpleAccent[700]!;
    } else if (remainder == 1) {
      dashColor = Colors.redAccent[400]!;
    } else if (remainder == 2) {
      dashColor = Colors.greenAccent[400]!;
    } else if (remainder == 3) {
      dashColor = Colors.pinkAccent[100]!;
    } else {
      dashColor = Colors.indigoAccent[700]!;
    }
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => CaravanDetail(
                      model: widget.model,
                      requestSent: requestSent,
                    )));
      },
      child: Container(
        height: 120,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: const LinearGradient(
                colors: [Colors.white, Colors.white, Colors.white],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight)),
        child: Row(
          children: [
            const SizedBox(
              width: 10,
            ),
            Container(
              height: 80,
              width: 10,
              color: dashColor,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.09,
            ),
            SizedBox(
              width: 280,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  "Source: ${widget.model.source}"
                      .text
                      .textStyle(GoogleFonts.poppins(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey[600]))
                      .make(),
                  "Destination: ${widget.model.destination}"
                      .text
                      .textStyle(GoogleFonts.poppins(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey[600]))
                      .make(),
                  "Date: ${widget.model.date}"
                      .text
                      .textStyle(GoogleFonts.poppins(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey[600]))
                      .make(),
                  "Time: ${widget.model.time}"
                      .text
                      .textStyle(GoogleFonts.poppins(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey[600]))
                      .make()
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: const [Icon(Icons.arrow_forward_ios)],
            )
          ],
        ),
      ).p12(),
    );
  }
}
