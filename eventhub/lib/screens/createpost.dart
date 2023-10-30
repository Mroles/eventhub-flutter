import 'dart:io';
import 'package:eventhub/screens/maps.dart';
import 'package:eventhub/utils/eventscalls.dart';
import 'package:eventhub/widgets/button.dart';
import 'package:eventhub/widgets/datefield.dart';
import 'package:eventhub/widgets/textbox.dart';
import 'package:provider/provider.dart';
import 'package:eventhub/providers/imageprovider.dart';
import 'package:eventhub/widgets/reusable.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../globals.dart';

class CreatePost extends StatefulWidget {
  @override
  State<CreatePost> createState() => _CreatePostState();
}

class _CreatePostState extends State<CreatePost> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  bool _isLoading = false;
  String imageLink = "";
  String lat = "";
  String long = "";
  File? image;
  File? selected;
  DateTime pickedDate = DateTime.now();
  final _eventNameController = TextEditingController();
  final _dateController = TextEditingController();
  final _venueController = TextEditingController();
  final _descController = TextEditingController();
  final _locationController = TextEditingController();

  _pickDate() async {
    DateTime? date = await showDatePicker(
        context: context,
        initialDate: pickedDate,
        firstDate: DateTime.now(),
        lastDate: DateTime(DateTime.now().year + 5));

    if (date != null) {
      setState(() {
        _dateController.text = DateFormat("yyyy-MM-dd").format(date);
      });
    }
  }

  _setLocation() async {
    final SharedPreferences prefs = await _prefs;
    String? locationName = (prefs.getString("location") ?? "");
    lat = (prefs.getString("lat") ?? "");
    long = (prefs.getString("long") ?? "");

    setState(() {
      _locationController.text = locationName;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create Event"),
        backgroundColor: Colors.black,
        centerTitle: true,
        elevation: 0,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(left: 8.0, right: 8.0),
          child: ListView(
            children: [
              sizedBox(30.0),
              GestureDetector(
                  child: image == null
                      ? Container(
                          height: 200,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(18.0),
                              color: tertiaryColorLight,
                              border: Border.all(
                                  color: Colors.grey,
                                  width: 1.0,
                                  style: BorderStyle.none)),
                          child: const Center(
                            child: Text(
                              "Select Image",
                              style: TextStyle(
                                  fontWeight: FontWeight.w300, fontSize: 24.0),
                            ),
                          ),
                        )
                      : Container(
                          height: 200,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(18.0),
                              image: DecorationImage(
                                  fit: BoxFit.fill, image: FileImage(image!)))),
                  onTap: () async {
                    selected = await context.read<ImageProv>().pickImage();

                    setState(() {
                      image = selected;
                    });
                  }),
              sizedBox(30.0),
              TextboxNoIcon(context, "Event Name", _eventNameController),
              sizedBox(30.0),
              // TextFormField(
              //   decoration: const InputDecoration(
              //       border: OutlineInputBorder(),
              //       labelText: "Date",
              //       labelStyle:
              //           TextStyle(fontSize: 18, fontWeight: FontWeight.w200)),
              //   controller: _dateController,
              //   readOnly: true,
              //   onTap: _pickDate,
              // ),
              DateField(
                  onPressed: _pickDate,
                  labelText: "Date",
                  controller: _dateController),
              sizedBox(30.0),
              TextboxNoIcon(context, "Venue", _venueController),
              sizedBox(30.0),
              textArea(context, "Description", _descController),
              sizedBox(30.0),
              // TextFormField(
              //   decoration: const InputDecoration(
              //       contentPadding: EdgeInsets.only(left: 15.0),
              //       border: InputBorder.none,
              //       iconColor: secondaryColorLight,
              //       hintStyle: TextStyle(
              //         color: secondaryColorLight,
              //       ),
              //       prefixIconColor: secondaryColorLight,
              //       labelText: "Get Location from Map",
              //       labelStyle: TextStyle(color: secondaryColorLight)),
              //   controller: _locationController,
              //   readOnly: true,
              //   onTap: () {
              //     showModalBottomSheet(
              //         enableDrag: false,
              //         isScrollControlled: true,
              //         shape: RoundedRectangleBorder(
              //             borderRadius: BorderRadius.circular(8.0)),
              //         context: context,
              //         builder: (BuildContext context) {
              //           return FractionallySizedBox(
              //             heightFactor: 0.9,
              //             child: Container(
              //               decoration: BoxDecoration(
              //                   borderRadius: BorderRadius.circular(8.0)),
              //               height: MediaQuery.of(context).size.height,
              //               child: const Maps(latitude: "", longitude: ""),
              //             ),
              //           );
              //         }).then((value) => {_setLocation()});
              //   },
              // ),

              TextBoxNoIconClass(
                  labeltext: "Location from Map",
                  controller: _locationController,
                  onPressed: () {
                    showModalBottomSheet(
                        enableDrag: false,
                        isScrollControlled: true,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0)),
                        context: context,
                        builder: (BuildContext context) {
                          return FractionallySizedBox(
                            heightFactor: 0.9,
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8.0)),
                              height: MediaQuery.of(context).size.height,
                              child: const Maps(latitude: "", longitude: ""),
                            ),
                          );
                        }).then((value) => {_setLocation()});
                  }),

              sizedBox(30.0),
              // ElevatedButton(
              //     style: ElevatedButton.styleFrom(
              //         minimumSize: const Size.fromHeight(50)),
              //     child: _isLoading
              //         ? const CircularProgressIndicator()
              //         : const Text("Create Event"),
              //     onPressed: () async {
              //       setState(() {
              //         _isLoading = true;
              //       });

              //       imageLink = await uploadImage(selected!);
              //       postEvent(
              //           context,
              //           _eventNameController.text,
              //           _dateController.text,
              //           _venueController.text,
              //           _descController.text,
              //           imageLink,
              //           lat,
              //           long,
              //           "7ce84732-687b-4df5-b492-940d8489c688",
              //           DateTime.now().toString(),
              //           _locationController.text);

              //       setState(() {
              //         _isLoading = false;
              //       });
              //     }),
              CustomButtonSecondary(
                  widget: _isLoading ? loader(0.6) : const Text("Create Event"),
                  onPressed: () async {
                    setState(() {
                      _isLoading = true;
                    });

                    imageLink = await uploadImage(selected!);
                    postEvent(
                        context,
                        _eventNameController.text,
                        _dateController.text,
                        _venueController.text,
                        _descController.text,
                        imageLink,
                        lat,
                        long,
                        "7ce84732-687b-4df5-b492-940d8489c688",
                        DateTime.now().toString(),
                        _locationController.text);

                    setState(() {
                      _isLoading = false;
                    });
                  }),
              sizedBox(40.0),
            ],
          ),
        ),
      ),
    );
  }
}

Widget imageBox(BuildContext context, File? image) {
  return image == null
      ? const Center(
          child: Text(
            "Select Image",
            style: TextStyle(fontWeight: FontWeight.w300, fontSize: 24.0),
          ),
        )
      : Container(
          decoration: BoxDecoration(
              image:
                  DecorationImage(fit: BoxFit.fill, image: FileImage(image))));
}
