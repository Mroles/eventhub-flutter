import 'package:eventhub/widgets/post.dart';
import 'package:flutter/material.dart';
import '../models/event.dart';

Widget listViewBuilder(List<Event> events) {
  return ListView.builder(
    itemCount: events.length,
    itemBuilder: (BuildContext context, int index) {
      final event = events[index];
      return post(event);
    },
  );
}
