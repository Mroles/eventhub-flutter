import 'package:cached_network_image/cached_network_image.dart';
import 'package:eventhub/models/event.dart';
import 'package:eventhub/utils/functions.dart';
import 'package:eventhub/widgets/reusable.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EventDetail extends StatefulWidget {
  final Event event;

  EventDetail({Key? key, required this.event}) : super(key: key);

  @override
  State<EventDetail> createState() => _EventDetailState();
}

class _EventDetailState extends State<EventDetail> {
  var format = DateFormat("ddd, dd MMM, yyyy");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: NestedScrollView(
            headerSliverBuilder: (BuildContext context, innerBoxIsScrolled) {
              return <Widget>[
                SliverAppBar(
                  expandedHeight: 350.0,
                  floating: true,
                  backgroundColor: Colors.transparent,
                  flexibleSpace: FlexibleSpaceBar(
                      background: Hero(
                    tag: widget.event,
                    child: CachedNetworkImage(
                      height: 450,
                      imageUrl: widget.event.image!,
                      imageBuilder: (context, imageProvider) => Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4.0),
                            image: DecorationImage(
                                image: imageProvider, fit: BoxFit.fill)),
                      ),
                      placeholder: (context, url) =>
                          const Center(child: CircularProgressIndicator()),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    ),
                  )),
                )
              ];
            },
            body: Padding(
              padding: const EdgeInsets.fromLTRB(8.0, 0.0, 0.0, 8.0),
              child: ListView(
                children: [
                  Text(
                    widget.event.name!,
                    style: const TextStyle(
                        fontSize: 30.0, fontWeight: FontWeight.bold),
                  ),
                  sizedBox(5.0),
                  Text(
                    formatDate(widget.event.date!),
                    style: TextStyle(fontSize: 15.0),
                  ),
                  sizedBox(5.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Icon(
                        Icons.favorite,
                        size: 45.0,
                        color: Color.fromARGB(255, 197, 23, 11),
                      ),
                      Icon(
                        Icons.directions,
                        size: 45.0,
                        color: Colors.green,
                      ),
                    ],
                  ),
                  Text(widget.event.description!)
                ],
              ),
            )));
  }
}
