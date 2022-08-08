import 'package:eventhub/screens/createpost.dart';
import 'package:eventhub/utils/functions.dart';
import 'package:eventhub/widgets/post.dart';
import 'package:flutter/material.dart';

class PostPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text("Posts"),
      //   backgroundColor: Colors.transparent,
      //   centerTitle: true,
      //   elevation: 0,
      // ),
      body: post(context),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.orange,
        child: const Icon(Icons.add),
        onPressed: () {
          navigateToPageLite(0, context, CreatePost());
        },
      ),
    );
  }
}
