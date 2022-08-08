import 'dart:io';
import 'package:eventhub/screens/maps.dart';
import 'package:provider/provider.dart';
import 'package:eventhub/providers/imageprovider.dart';
import 'package:eventhub/widgets/reusable.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CreatePost extends StatefulWidget {
  @override
  State<CreatePost> createState() => _CreatePostState();
}

class _CreatePostState extends State<CreatePost> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  File? image;
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
    String? lat = (prefs.getString("lat") ?? "");
    String? long = (prefs.getString("long") ?? "");

    setState(() {
      _locationController.text = locationName;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create Event"),
        backgroundColor: Colors.transparent,
        centerTitle: true,
        elevation: 0,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(left: 8.0, right: 8.0),
          child: ListView(
            children: [
              GestureDetector(
                  child: image == null
                      ? Container(
                          height: 200,
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: Colors.grey,
                                  width: 1.0,
                                  style: BorderStyle.solid)),
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
                              image: DecorationImage(
                                  fit: BoxFit.fill, image: FileImage(image!)))),
                  onTap: () async {
                    var selected = await context.read<ImageProv>().pickImage();
                    setState(() {
                      image = selected;
                    });
                  }),
              const SizedBox(height: 40.0),
              TextboxNoIcon(context, "Event Name", _eventNameController),
              const SizedBox(height: 40.0),
              TextFormField(
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Date",
                    labelStyle:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.w200)),
                controller: _dateController,
                readOnly: true,
                onTap: _pickDate,
              ),
              const SizedBox(height: 40.0),
              TextboxNoIcon(context, "Venue", _venueController),
              const SizedBox(height: 40.0),
              textArea(context, "Description", _descController),
              const SizedBox(height: 40.0),
              TextFormField(
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Location",
                    labelStyle:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.w200)),
                controller: _locationController,
                readOnly: true,
                onTap: () {
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
                            child: const Maps(),
                          ),
                        );
                      }).then((value) => {_setLocation()});
                },
              ),
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
