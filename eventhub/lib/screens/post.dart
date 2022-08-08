import 'package:eventhub/screens/createpost.dart';
import 'package:eventhub/utils/functions.dart';
import 'package:eventhub/widgets/post.dart';
import 'package:flutter/material.dart';

class PostPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text("Posts")),
      ),
      body: post(context),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        child: const Icon(Icons.add),
        onPressed: () {
          navigateToPageLite(0, context, CreatePost());
        },
      ),
    );
  }
}
