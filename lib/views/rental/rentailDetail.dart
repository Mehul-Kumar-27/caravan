import 'package:caravan/models/rental.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:velocity_x/velocity_x.dart';

class RentailDetail extends StatefulWidget {
  Rental model;
  RentailDetail({
    Key? key,
    required this.model,
  }) : super(key: key);

  @override
  State<RentailDetail> createState() => _RentailDetailState();
}

class _RentailDetailState extends State<RentailDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Material(
            borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20)),
            elevation: 20,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.3,
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20)),
              ),
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20)),
                child: Image.network(
                  widget.model.imageUrl,
                  fit: BoxFit.fill,
                  height: MediaQuery.of(context).size.height * 0.15,
                ),
              ),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.04,
          ),
          const Divider(
            thickness: 2,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                "Car Name",
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.bold,
                  fontSize: (15),
                  color: Colors.deepPurple,
                ),
              ).px16().py2(),
            ],
          ),
          widget.model.carname.text
              .textStyle(GoogleFonts.poppins(
                  fontSize: 15,
                  color: Colors.black,
                  fontWeight: FontWeight.w600))
              .make()
              .px16(),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                "Price Per Hour",
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.bold,
                  fontSize: (15),
                  color: Colors.deepPurple,
                ),
              ).px16().py2(),
            ],
          ),
          widget.model.price.text
              .textStyle(GoogleFonts.poppins(
                  fontSize: 15,
                  color: Colors.black,
                  fontWeight: FontWeight.w600))
              .make()
              .px16(),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                "Description",
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.bold,
                  fontSize: (15),
                  color: Colors.deepPurple,
                ),
              ).px16().py2(),
            ],
          ),
          widget.model.description.text
              .textStyle(GoogleFonts.poppins(
                  fontSize: 15,
                  color: Colors.black,
                  fontWeight: FontWeight.w600))
              .overflow(TextOverflow.clip)
              .make()
              .px16(),
          const SizedBox(
            height: 30,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                children: [
                  "Available form"
                      .text
                      .textStyle(
                        GoogleFonts.poppins(
                          fontWeight: FontWeight.bold,
                          fontSize: (15),
                          color: Colors.deepPurple,
                        ),
                      )
                      .make(),
                  const Icon(Icons.calendar_month),
                  widget.model.availableFrom.text.make()
                ],
              ),
              Column(
                children: const [
                  Icon(Icons.arrow_forward_rounded),
                  Icon(Icons.arrow_back_rounded),
                ],
              ),
              Column(
                children: [
                  "Available till"
                      .text
                      .textStyle(
                        GoogleFonts.poppins(
                          fontWeight: FontWeight.bold,
                          fontSize: (15),
                          color: Colors.deepPurple,
                        ),
                      )
                      .make(),
                  const Icon(Icons.calendar_month),
                  widget.model.availableTo.text.make()
                ],
              )
            ],
          ).px16().py8()
        ],
      ),
    );
  }
}
