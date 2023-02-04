import 'package:caravan/views/caravan/create_caravan.dart';
import 'package:caravan/views/profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';

import 'package:velocity_x/velocity_x.dart';

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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
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
      body: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.03,
          ),
          Material(
            borderRadius: BorderRadius.circular(30),
            elevation: 20,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.24,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Colors.lightGreenAccent[100]!,
                        Colors.lightGreenAccent[400]!
                      ])),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.02,
                      ),
                      today.text
                          .textStyle(GoogleFonts.roboto(
                              fontSize: 20, fontWeight: FontWeight.w400))
                          .make(),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.04,
                      ),
                      "Caravan, provides"
                          .text
                          .textStyle(GoogleFonts.itim(
                              fontSize: 20, fontWeight: FontWeight.bold))
                          .make(),
                      "Sustainable Solutions !"
                          .text
                          .textStyle(GoogleFonts.itim(
                              fontSize: 20, fontWeight: FontWeight.bold))
                          .make(),
                    ],
                  ).px8(),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.1,
                    child: Lottie.asset("assets/animations/environment.json"),
                  ).px8(),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.03,
                  ),
                ],
              ),
            ).p12(),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.08,
          ),

          // Create Caravan
          // Join Caravan
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
                              height: MediaQuery.of(context).size.height * .04,
                            ),
                            const Icon(
                              Icons.local_taxi_outlined,
                              color: Colors.black,
                            ),
                            "Create Caravan"
                                .text
                                .textStyle(GoogleFonts.itim(
                                    fontSize: 20, fontWeight: FontWeight.bold))
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
                              height: MediaQuery.of(context).size.height * .04,
                            ),
                            const Icon(
                              Icons.handshake,
                              color: Colors.black,
                            ),
                            "Join Caravan"
                                .text
                                .textStyle(GoogleFonts.itim(
                                    fontSize: 20, fontWeight: FontWeight.bold))
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
    );
  }
}
