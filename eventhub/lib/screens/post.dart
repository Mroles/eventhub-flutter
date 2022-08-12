import 'package:animations/animations.dart';
import 'package:eventhub/screens/createpost.dart';
import 'package:eventhub/utils/functions.dart';
import 'package:eventhub/widgets/post.dart';
import 'package:flutter/material.dart';

class PostPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Posts"),
          backgroundColor: Colors.transparent,
          centerTitle: true,
          elevation: 0,
        ),
        body: Stack(
          children: [
            post(context),
            Padding(
              padding: const EdgeInsets.fromLTRB(0.0, 0.0, 8.0, 12.0),
              child: Align(
                alignment: Alignment.bottomRight,
                child: OpenContainer(
                  transitionDuration: Duration(milliseconds: 500),
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
