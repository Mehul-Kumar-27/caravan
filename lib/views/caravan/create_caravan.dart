import 'package:caravan/global/global.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:unicons/unicons.dart';
import 'package:velocity_x/velocity_x.dart';

class Caravan extends StatefulWidget {
  const Caravan({super.key});

  @override
  State<Caravan> createState() => _CaravanState();
}

class _CaravanState extends State<Caravan> {
  TimeOfDay _time = TimeOfDay.now();
  TextEditingController source = TextEditingController();
  TextEditingController destination = TextEditingController();
  TextEditingController price = TextEditingController();
  TextEditingController passenger = TextEditingController();
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
            "Create new Caravan !"
                .text
                .textStyle(GoogleFonts.poppins(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.indigo))
                .make(),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.05,
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
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () async {
                    final selectedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2010),
                      lastDate: DateTime(2030),
                    );
                    setState(() {
                      date = selectedDate
                          .toString()
                          .replaceAll('''00:00:00.000''', "");
                    });
                    print(selectedDate
                        .toString()
                        .replaceAll('''00:00:00.000''', ""));
                    //   },
                  },
                  child: Material(
                    borderRadius: BorderRadius.circular(10),
                    elevation: 10,
                    child: Container(
                      height: 50,
                      width: 100,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.grey[200]),
                      child: Column(
                        children: [
                          Icon(
                            Icons.date_range,
                            color: Colors.purple[700],
                          ),
                          "Choose Date"
                              .text
                              .textStyle(GoogleFonts.poppins(
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.indigo))
                              .make(),
                        ],
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () async {
                    final TimeOfDay? selectedTime = await showTimePicker(
                      context: context,
                      initialTime: _time,
                    );

                    if (selectedTime != null && selectedTime != _time) {
                      setState(() {
                        time = selectedTime
                            .toString()
                            .replaceAll("TimeOfDay(", "")
                            .replaceAll(")", "");
                      });
                    }
                  },
                  child: Material(
                    elevation: 10,
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      height: 50,
                      width: 100,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.grey[200]),
                      child: Column(
                        children: [
                          Icon(
                            Icons.timelapse,
                            color: Colors.purple[700],
                          ),
                          "Choose Time"
                              .text
                              .textStyle(GoogleFonts.poppins(
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.indigo))
                              .make(),
                        ],
                      ),
                    ),
                  ),
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
                        enabled: true,
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
                          hintText: 'Cost per head ...',
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
                        enabled: true,
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
                          hintText: 'No of passengers ...',
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
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.1,
            ),
            GestureDetector(
              onTap: () async {
                setState(() {
                  isuploading = true;
                });
                await uploadToAll();
                await uploadForUser().then((value) {
                  setState(() {
                    Navigator.pop(context);
                  });
                });
              },
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    gradient: const LinearGradient(
                        colors: [Colors.indigo, Colors.purpleAccent])),
                width: MediaQuery.of(context).size.width * 0.7,
                height: MediaQuery.of(context).size.height * 0.07,
                child: Center(
                    child: "Create"
                        .text
                        .textStyle(GoogleFonts.poppins(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            color: Colors.white))
                        .make()),
              ),
            )
          ],
        ),
      ),
    );
  }

  String caravanId = DateTime.now().millisecondsSinceEpoch.toString();
  String date = "";
  String time = "";
  Future uploadToAll() async {
    FirebaseFirestore.instance.collection("carvan").doc(caravanId).set({
      "caravanId": caravanId,
      "source": source.text,
      "destination": destination.text,
      "date": date,
      "time": time,
      "admin": sharedPreferences!.getString("uid"),
      "price": price.text,
      "passenger": passenger.text
    });
  }

  Future uploadForUser() async {
    FirebaseFirestore.instance
        .collection("user")
        .doc(sharedPreferences!.getString("uid"))
        .collection("caravan")
        .doc(caravanId)
        .set({
      "caravanId": caravanId,
      "source": source.text,
      "destination": destination.text,
      "date": date,
      "time": time,
      "admin": sharedPreferences!.getString("uid"),
      "price": price.text,
      "passenger": passenger.text
    });
  }
}
