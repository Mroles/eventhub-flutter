import 'dart:io';

import 'package:eventhub/widgets/reusable.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:eventhub/providers/imageprovider.dart';

class CreatePost extends StatefulWidget {
  @override
  State<CreatePost> createState() => _CreatePostState();
}

class _CreatePostState extends State<CreatePost> {
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
    File? image = context.watch<ImageProv>().imageDir;
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
                  child: Container(
                    child: image == null
                        ? const Center(child: Text("Pick Image"))
                        : Container(
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    fit: BoxFit.fill,
                                    image: FileImage(image)))),
                    height: 200,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4.0),
                        border: Border.all(
                            color: Colors.grey,
                            width: 2.0,
                            style: BorderStyle.solid)),
                  ),
                  onTap: () async {
                    // image = await pickImage();
                    await context.read<ImageProv>().pickImage();
                    print(image);
                    // setState(() {
                    //   image = thisImage;
                    // });
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
              textArea(context, "Description", _descController)
            ],
          ),
        ),
      ),
    );
  }
}

// Widget imageBox(BuildContext context, File? image) {
//   return image == null
//       ? const Center(
//           child: Text(
//             "Select Image",
//             style: TextStyle(fontWeight: FontWeight.w300, fontSize: 24.0),
//           ),
//         )
//       : Container(
//           decoration: BoxDecoration(
//               image:
//                   DecorationImage(fit: BoxFit.fill, image: FileImage(image))));
// }
