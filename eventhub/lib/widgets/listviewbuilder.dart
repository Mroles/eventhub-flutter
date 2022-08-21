import 'package:eventhub/widgets/post.dart';
import 'package:flutter/material.dart';
import '../models/event.dart';

Widget listViewBuilder(List<Event> events, ScrollController scrollController) {
  return ListView.builder(
    // key: const PageStorageKey<String>("events"),
    controller: scrollController,
    itemCount: events.length,
    itemBuilder: (BuildContext context, int index) {
      final event = events[index];

      if (index < events.length) {
        return post(event);
      } else {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }
    },
  );
}
