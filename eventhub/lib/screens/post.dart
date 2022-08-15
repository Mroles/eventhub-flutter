import 'package:animations/animations.dart';
import 'package:eventhub/models/event.dart';
import 'package:eventhub/screens/createpost.dart';
import 'package:eventhub/utils/eventscalls.dart';
import 'package:eventhub/utils/functions.dart';
import 'package:eventhub/widgets/listviewbuilder.dart';
import 'package:eventhub/widgets/post.dart';
import 'package:flutter/material.dart';

class PostPage extends StatefulWidget {
  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  Future<List<Event>?>? events = getEvents();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        FutureBuilder<List<Event>?>(
            future: events,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                print(snapshot.error);
                return Center(child: Text("Error"));
              } else if (snapshot.connectionState != ConnectionState.done) {
                return const Center(child: CircularProgressIndicator());
              } else {
                if (snapshot.hasData) {
                  final eves = snapshot.data;
                  //  return Center(child: Text("data"));
                  return listViewBuilder(eves!);
                } else {
                  return const Center(child: Text("Nothing to show"));
                }
              }
            }),

        // post(context),
        Padding(
          padding: const EdgeInsets.fromLTRB(0.0, 0.0, 8.0, 12.0),
          child: Align(
            alignment: Alignment.bottomRight,
            child: OpenContainer(
              transitionDuration: const Duration(milliseconds: 500),
              closedShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0)),
              closedBuilder: (BuildContext _, VoidCallback openContainer) {
                return FloatingActionButton(
                  //  backgroundColor: Colors.transparent,
                  onPressed: openContainer,
                  child: const Icon(Icons.add),
                  elevation: 12.0,
                );
              },
              openBuilder: (BuildContext _, VoidCallback openContainer) {
                return CreatePost();
              },
            ),
          ),
        )
      ],
    )

        //post(context),
        // floatingActionButton: FloatingActionButton(
        //   backgroundColor: Colors.orange,
        //   child: const Icon(Icons.add),
        //   onPressed: () {
        //    // navigateToPageLite(0, context, CreatePost());
        //   },
        // ),

        );
  }
}
