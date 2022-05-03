import 'dart:io';
import 'package:eventhub/screens/maps.dart';
import 'package:provider/provider.dart';
import 'package:eventhub/providers/imageprovider.dart';
import 'package:eventhub/widgets/reusable.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CreatePost extends StatefulWidget {
  @override
  State<CreatePost> createState() => _CreatePostState();
}

class _CreatePostState extends State<CreatePost> {
  File? image;
  DateTime pickedDate = DateTime.now();
  final _eventNameController = TextEditingController();
  final _dateController = TextEditingController();
  final _venueController = TextEditingController();
  final _descController = TextEditingController();

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
                    border: OutlineInputBorder(), hintText: "Date"),
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
                    hintText: "Location Coordinates"),
                controller: _dateController,
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
                      });
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
