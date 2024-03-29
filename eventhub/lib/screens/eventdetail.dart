import 'package:cached_network_image/cached_network_image.dart';
import 'package:eventhub/models/event.dart';
import 'package:eventhub/screens/editpost.dart';
import 'package:eventhub/utils/eventscalls.dart';
import 'package:eventhub/utils/functions.dart';
import 'package:eventhub/widgets/reusable.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:map_launcher/map_launcher.dart';

class EventDetail extends StatefulWidget {
  final Event event;

  const EventDetail({Key? key, required this.event}) : super(key: key);

  @override
  State<EventDetail> createState() => _EventDetailState();
}

class _EventDetailState extends State<EventDetail> {
  refresh() {
    setState(() {
      getEvent(widget.event.id!);
    });
  }

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
                  stretch: true,
                  actions: [
                    IconButton(
                        onPressed: () {
                          navigateToPageLite(0, context,
                              EditPost(event: widget.event), refresh());
                        },
                        icon: const Icon(Icons.edit)),
                    IconButton(onPressed: () {}, icon: const Icon(Icons.delete))
                  ],
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
                    style: const TextStyle(fontSize: 15.0),
                  ),
                  sizedBox(5.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                        icon: const Icon(
                          Icons.favorite,
                          size: 45.0,
                          color: Color.fromARGB(255, 197, 23, 11),
                        ),
                        onPressed: () {},
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.directions,
                          size: 45.0,
                          color: (Colors.green),
                        ),
                        onPressed: () async {
                          final availableMaps = await MapLauncher.installedMaps;

                          await availableMaps.first.showMarker(
                              coords: Coords(6.0, 0.19), title: "title");
                        },
                      ),
                    ],
                  ),
                  Text(widget.event.description!)
                ],
              ),
            )));
  }
}
