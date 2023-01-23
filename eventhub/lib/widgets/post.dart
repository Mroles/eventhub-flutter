import 'package:cached_network_image/cached_network_image.dart';
import 'package:eventhub/screens/eventdetail.dart';
import 'package:eventhub/utils/functions.dart';
import 'package:flutter/material.dart';
import '../models/event.dart';

Widget post(Event event, BuildContext context) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: GestureDetector(
      onTap: () =>
          {navigateToPageLite(0, context, EventDetail(event: event), null)},
      child: Container(
        height: 410,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12.0),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  offset: const Offset(0, 5),
                  blurRadius: 3)
            ]),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                children: [
                  Column(
                    children: [
                      CircleAvatar(
                        backgroundImage:
                            NetworkImage("https://picsum.photos/200/300"),
                        radius: 30,
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: const [
                            Text(
                              "First Last",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              event.date == null ? "" : event.date!,
                              style:
                                  const TextStyle(fontWeight: FontWeight.w300),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  // Column(
                  //   crossAxisAlignment: CrossAxisAlignment.end,
                  //   children: [Icon(Icons.list)],
                  // )
                ],
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 10.0),
                child: Row(
                  children: [
                    Text(event.name == null ? "" : event.name!)
                    // Text("data")
                  ],
                ),
              ),
              Hero(
                tag: event,
                child: CachedNetworkImage(
                  height: 250,
                  imageUrl: event.image == null ? "" : event.image!,
                  imageBuilder: (context, imageProvider) => Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4.0),
                        image: DecorationImage(
                            image: imageProvider, fit: BoxFit.fill)),
                  ),
                  placeholder: (context, url) =>
                      const Center(child: CircularProgressIndicator()),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    // IconButton(
                    //   color: Colors.red,
                    //   onPressed: () {},
                    //   icon: Icon(Icons.favorite),
                    // ),
                    Icon(Icons.favorite),
                    Padding(padding: EdgeInsets.fromLTRB(0.0, 0.0, 4.0, 0.0)),
                    Text("3"),
                    Padding(padding: EdgeInsets.fromLTRB(0.0, 0.0, 12.0, 0.0)),
                    Icon(Icons.comment),
                    Padding(padding: EdgeInsets.fromLTRB(0.0, 0.0, 4.0, 0.0)),
                    Text("3")
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    ),
  );
}
