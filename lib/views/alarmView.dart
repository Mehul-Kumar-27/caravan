// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:caravan/models/rental.dart';
import 'package:caravan/views/caravan/create_caravan.dart';
import 'package:caravan/views/profile.dart';
import 'package:caravan/views/rental/rental_form.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../auth/bloc/auth_bloc.dart';
import '../auth/bloc/auth_event.dart';
import '../global/global.dart';
import 'caravan/join_caravan.dart';

class AlarmView extends StatefulWidget {
  const AlarmView({super.key});

  @override
  State<AlarmView> createState() => _AlarmViewState();
}

class _AlarmViewState extends State<AlarmView> {
  String today = DateFormat.yMMMMd("en_US").format(DateTime.now());

  Stream? feeds;
  Future<Stream<QuerySnapshot>> getRental() async {
    return FirebaseFirestore.instance.collection("rental").snapshots();
  }

  getAllRental() {
    getRental().then((value) {
      setState(() {
        feeds = value;
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    getAllRental();
    super.initState();
  }

  int activeIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.deepPurple[600],
        actions: [
          Container(
            //decoration: BoxDecoration(color: Colors.blue),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                    onPressed: () {
                      context.read<AuthBloc>().add(const AuthEventLogOut());
                    },
                    icon: const Icon(Icons.login))
              ],
            ).px20(),
          )
        ],
      ),
      drawer: MyProfile(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.01,
            ),
            "Caravan ....."
                .text
                .textStyle(GoogleFonts.poppins(
                    fontSize: 30, fontWeight: FontWeight.w500))
                .make()
                .px16(),
            const SizedBox(
              height: 20,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 40,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey[300]),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.6,
                    child: TextField(
                      enabled: false,
                      decoration: InputDecoration(
                        hintText: "Search....",
                        hintStyle: GoogleFonts.poppins(
                          color: Colors.black54,
                        ),
                      ),
                    ),
                  ).px12(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: const [
                      Icon(
                        Icons.search,
                        color: Colors.black45,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Icon(
                        Icons.sort,
                        color: Colors.black45,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Icon(
                        Icons.more_vert,
                        color: Colors.black45,
                      )
                    ],
                  ),
                ],
              ),
            ).px8(),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.4,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.grey[300]),
              child: Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.02,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      "Top Deals !"
                          .text
                          .textStyle(GoogleFonts.poppins(
                            color: Colors.grey[800],
                            fontSize: 20,
                          ))
                          .make(),
                    ],
                  ).px16(),
                  Column(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.02,
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.3,
                        child: StreamBuilder(
                          stream: feeds,
                          builder: (context, AsyncSnapshot snapshot) {
                            return !snapshot.hasData
                                ? const Center(
                                    child: CircularProgressIndicator(),
                                  )
                                : CarouselSlider.builder(
                                    itemCount: snapshot.data.docs.length,
                                    itemBuilder: (context, index, realIndex) {
                                      Rental model = Rental.fromJson(
                                          snapshot.data.docs[index].data()!
                                              as Map<String, dynamic>);

                                      return RentalCar(model: model);
                                    },
                                    options: CarouselOptions(
                                      autoPlay: false,
                                      autoPlayInterval:
                                          const Duration(seconds: 3),
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.3,
                                      enlargeCenterPage: false,
                                      onPageChanged: (index, reason) {
                                        setState(() {
                                          activeIndex = index;
                                        });
                                      },
                                    ),
                                  );
                          },
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const RentalForm()));
              },
              child: Material(
                elevation: 10,
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.1,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.deepPurple[600]),
                  child: Row(
                    children: [
                      "Put your Car on rent !"
                          .text
                          .textStyle(GoogleFonts.poppins(
                              color: Colors.white,
                              fontSize: 17,
                              fontWeight: FontWeight.w600))
                          .make()
                          .px16(),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.09,
                      ),
                      Lottie.asset("assets/animations/caravan.json")
                    ],
                  ),
                ),
              ).px12(),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.05,
            ),
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Caravan()));
                  },
                  child: Material(
                    borderRadius: BorderRadius.circular(30),
                    elevation: 20,
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomLeft,
                              colors: [Colors.white, Colors.grey[300]!])),
                      height: MediaQuery.of(context).size.height * 0.14,
                      width: MediaQuery.of(context).size.width * 0.4,
                      child: Stack(children: [
                        Center(
                          child: Column(
                            children: [
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * .04,
                              ),
                              const Icon(
                                Icons.local_taxi_outlined,
                                color: Colors.black,
                              ),
                              "Create Caravan"
                                  .text
                                  .textStyle(GoogleFonts.itim(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold))
                                  .make()
                                  .px4(),
                            ],
                          ),
                        )
                      ]),
                    ),
                  ).px16(),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => JoinCaravan()));
                  },
                  child: Material(
                    borderRadius: BorderRadius.circular(30),
                    elevation: 20,
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomLeft,
                              colors: [Colors.white, Colors.grey[300]!])),
                      height: MediaQuery.of(context).size.height * 0.14,
                      width: MediaQuery.of(context).size.width * 0.4,
                      child: Stack(children: [
                        Center(
                          child: Column(
                            children: [
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * .04,
                              ),
                              const Icon(
                                Icons.handshake,
                                color: Colors.black,
                              ),
                              "Join Caravan"
                                  .text
                                  .textStyle(GoogleFonts.itim(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold))
                                  .make()
                                  .px4(),
                            ],
                          ),
                        )
                      ]),
                    ),
                  ).px16(),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget buildIndicator() => AnimatedSmoothIndicator(
        activeIndex: activeIndex,
        count: 8,
        effect: const SwapEffect(
            dotHeight: 10, dotWidth: 10, type: SwapType.yRotation),
      );
}

class RentalCar extends StatefulWidget {
  Rental model;
  RentalCar({
    Key? key,
    required this.model,
  }) : super(key: key);

  @override
  State<RentalCar> createState() => _RentalCarState();
}

class _RentalCarState extends State<RentalCar> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Material(
        borderRadius: BorderRadius.circular(40),
        color: Colors.grey[200],
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.3,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.24,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(40),
                  child: Image.network(
                    widget.model.imageUrl,
                    fit: BoxFit.fitWidth,
                    width: 300,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  widget.model.carname.text
                      .textStyle(GoogleFonts.poppins(fontSize: 15))
                      .make()
                ],
              )
            ],
          ),
        ),
      ).px8(),
    );
  }
}
