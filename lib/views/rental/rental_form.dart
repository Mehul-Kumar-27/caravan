import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart' as fStorage;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../global/global.dart';

class RentalForm extends StatefulWidget {
  const RentalForm({super.key});

  @override
  State<RentalForm> createState() => _RentalFormState();
}

class _RentalFormState extends State<RentalForm> {
  @override
  TextEditingController _carname = TextEditingController();
  TextEditingController _description = TextEditingController();
  TextEditingController _authorController = TextEditingController();
  String type = "";
  String category = "";

  late DateTime _selectedDate;
  String dateText = "";
  late String time;
  XFile? imageXfile;
  final ImagePicker _picker = ImagePicker();
  Future<void> _getImage() async {
    imageXfile = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      imageXfile;
    });
  }

  String bookImageUrl = "";

  uploadImage() async {
    String fileName = DateTime.now().millisecondsSinceEpoch.toString();
    fStorage.Reference reference =
        fStorage.FirebaseStorage.instance.ref().child("Seller").child(fileName);

    fStorage.UploadTask uploadTask = reference.putFile(File(imageXfile!.path));

    fStorage.TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() {});

    await taskSnapshot.ref.getDownloadURL().then((url) {
      bookImageUrl = url;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _selectedDate = DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    String availableFromDate = "";
    String availableToDate = "";
    return SafeArea(
      child: Scaffold(
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(color: Colors.white),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Material(
                      elevation: 10,
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.937,
                        height: MediaQuery.of(context).size.height * 0.1,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.deepPurple[600]),
                        child: Row(
                          children: [
                            IconButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                icon: const Icon(
                                  CupertinoIcons.arrow_left_circle,
                                  color: Colors.white,
                                  size: 28,
                                )),
                            "Put your Car on rent !"
                                .text
                                .textStyle(GoogleFonts.poppins(
                                    color: Colors.white,
                                    fontSize: 17,
                                    fontWeight: FontWeight.w600))
                                .make()
                                .px16(),
                            Lottie.asset("assets/animations/caravan.json")
                          ],
                        ),
                      ),
                    ).px12(),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    creatingGroup
                        ? const LinearProgressIndicator()
                        : Container(),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () {
                            _getImage();
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CircleAvatar(
                                  radius:
                                      MediaQuery.of(context).size.width * 0.1,
                                  backgroundColor: Colors.grey[600],
                                  backgroundImage: imageXfile == null
                                      ? null
                                      : FileImage(File(imageXfile!.path)),
                                  child: imageXfile == null
                                      ? Icon(
                                          Icons.add_a_photo_outlined,
                                          size: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.1,
                                          color: Colors.white,
                                        )
                                      : null),
                              const SizedBox(
                                height: 10,
                              ),
                              "Choose the picture".text.make()
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    label("Car Name"),
                    const SizedBox(
                      height: 20,
                    ),
                    carName(),
                    const SizedBox(
                      height: 30,
                    ),
                    label("Price per Hour"),
                    const SizedBox(
                      height: 12,
                    ),
                    pricePerHour(),
                    const SizedBox(
                      height: 25,
                    ),
                    label("Description"),
                    const SizedBox(
                      height: 12,
                    ),
                    description(),
                    const SizedBox(
                      width: 25,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            "Available from Date".text.make(),
                            IconButton(
                                onPressed: () async {
                                  final selectedDate = await showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(2010),
                                    lastDate: DateTime(2030),
                                  );
                                  setState(() {
                                    availableFromDate = selectedDate
                                        .toString()
                                        .replaceAll('''00:00:00.000''', "");
                                  });
                                },
                                icon: const Icon(Icons.calendar_month)),
                            "Select Date".text.make()
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            "Available to Date".text.make(),
                            IconButton(
                                onPressed: () async {
                                  final selectedDate = await showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(2010),
                                    lastDate: DateTime(2030),
                                  );
                                  setState(() {
                                    availableToDate = selectedDate
                                        .toString()
                                        .replaceAll('''00:00:00.000''', "");
                                  });
                                },
                                icon: const Icon(Icons.calendar_month)),
                            "Select Date".text.make()
                          ],
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    button(),
                    const SizedBox(
                      height: 50,
                    ),
                  ],
                ).px16()
              ],
            ),
          ),
        ),
      ),
    );
  }

  String groupId = DateTime.now().millisecondsSinceEpoch.toString();

  Future createGroupForUser() async {
    FirebaseFirestore.instance
        .collection("user")
        .doc(sharedPreferences!.getString("uid"))
        .collection("groups")
        .add({
      "category": category,
      "description": _description.text,
      "authorName": _authorController.text,
      "bookName": _carname.text,
      "groupId": groupId,
      "admin": sharedPreferences!.getString("uid"),
      "bookUrl": bookImageUrl
    });
  }

  Future createGroupForEveryOne() async {
    FirebaseFirestore.instance.collection("groups").add({
      "category": category,
      "description": _description.text,
      "authorName": _authorController.text,
      "bookName": _carname.text,
      "groupId": groupId,
      "admin": sharedPreferences!.getString("uid"),
      "bookUrl": bookImageUrl
    });
  }

  bool creatingGroup = false;

  Widget button() {
    return InkWell(
      onTap: () async {
        setState(() {
          creatingGroup = true;
        });
        await uploadImage();
        await createGroupForUser();
        await createGroupForEveryOne().then((value) {
          Navigator.pop(context);
        });
      },
      child: Container(
        height: 56,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: const LinearGradient(
              colors: [Color(0xff8a32f1), Color(0xffad32f9)]),
        ),
        child: const Center(
            child: Text(
          "Create",
          style: TextStyle(
              color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600),
        )),
      ),
    );
  }

  Widget description() {
    return Container(
      height: 155,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 56, 47, 47),
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextFormField(
        controller: _description,
        maxLines: null,
        style: const TextStyle(
          color: Colors.white70,
          fontSize: 17,
        ),
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: "Description",
          hintStyle: TextStyle(color: Colors.grey[500], fontSize: 17),
          contentPadding: EdgeInsets.only(left: 20, right: 20),
        ),
      ),
    ).py12();
  }

  Widget categorySelect(String label, int color) {
    return InkWell(
      onTap: () {
        setState(() {
          category = label;
        });
      },
      child: Chip(
        backgroundColor: category == label ? Colors.green : Color(color),
        label: Text(
          label,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 17,
          ),
        ),
        labelPadding: EdgeInsets.symmetric(horizontal: 17, vertical: 3.8),
      ),
    );
  }

  Widget pricePerHour() {
    return Container(
      height: 55,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 56, 47, 47),
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextFormField(
        controller: _authorController,
        style: const TextStyle(
          color: Colors.white70,
          fontSize: 17,
        ),
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: "Price per hour",
          hintStyle: TextStyle(color: Colors.grey[500], fontSize: 17),
          contentPadding: EdgeInsets.only(left: 20, right: 20),
        ),
      ),
    );
  }

  Widget carName() {
    return Container(
      height: 55,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 56, 47, 47),
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextFormField(
        controller: _carname,
        style: const TextStyle(
          color: Colors.white70,
          fontSize: 17,
        ),
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: "Name Of Car",
          hintStyle: TextStyle(color: Colors.grey[500], fontSize: 17),
          contentPadding: EdgeInsets.only(left: 20, right: 20),
        ),
      ),
    );
  }

  Widget label(String label) {
    return Text(label,
        style: TextStyle(
          color: Colors.indigo[900]!,
          fontWeight: FontWeight.w600,
          fontSize: 16.5,
          letterSpacing: 0.2,
        ));
  }
}
