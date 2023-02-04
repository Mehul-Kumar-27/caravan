import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:velocity_x/velocity_x.dart';

import '../global/global.dart';

class MyProfile extends StatefulWidget {
  const MyProfile({super.key});

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  @override
  Widget build(BuildContext context) {
    double totalHeight = MediaQuery.of(context).size.height;
    double firstContainerHeight = totalHeight * 0.5;
    double secondContainerHeight = totalHeight - firstContainerHeight;
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * .4,
              child: Stack(children: [
                Container(
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/images/p02q_rf7s_191031.jpg"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Stack(children: [
                  Column(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.3,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 300,
                            height: 70,
                            decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(30),
                                    topRight: Radius.circular(30))),
                            child: Column(
                              children: [
                                Container(
                                  height: MediaQuery.of(context).size.height *
                                      0.057,
                                ),
                                Flexible(
                                  child:
                                      "${sharedPreferences!.getString("name")}"
                                          .text
                                          .color(Colors.black)
                                          .extraBold
                                          .overflow(TextOverflow.clip)
                                          .make(),
                                )
                              ],
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                  Column(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.23,
                      ),
                      Center(
                        child: Material(
                          elevation: 10,
                          borderRadius: BorderRadius.circular(100.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(100.0),
                            child: Container(
                              height: 90.0,
                              width: 90.0,
                              color: Colors.blue,
                              child: const Icon(
                                Icons.person,
                                color: Colors.white,
                                size: 80,
                                shadows: <Shadow>[
                                  Shadow(color: Colors.white, blurRadius: 10.0)
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                ])
              ]),
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.567,
              width: MediaQuery.of(context).size.width,
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.037,
                  ),
                  "Email: ${sharedPreferences!.getString("email")}"
                      .text
                      .extraBold
                      .make(),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.037,
                  ),
                  Row(
                    children: [
                      "Your Vechile"
                          .text
                          .textStyle(GoogleFonts.poppins(
                              fontSize: 20,
                              color: Colors.grey,
                              fontWeight: FontWeight.bold))
                          .make(),
                      const SizedBox(
                        width: 20,
                      ),
                      
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.037,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.35,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                "Mahindra KXUV"
                                    .text
                                    .textStyle(GoogleFonts.itim(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold))
                                    .make(),
                                "RJ201234"
                                    .text
                                    .textStyle(GoogleFonts.itim(
                                        fontSize: 17,
                                        fontWeight: FontWeight.w500))
                                    .make()
                              ],
                            ),
                            Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                height:
                                    MediaQuery.of(context).size.height * 0.15,
                                child: Material(
                                  elevation: 15,
                                  borderRadius: BorderRadius.circular(30),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(30),
                                    child: const Image(
                                      image:
                                          AssetImage("assets/images/car.jfif"),
                                    ),
                                  ),
                                )),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ).px16(),
            )
          ],
        ),
      ),
    );
  }
}
