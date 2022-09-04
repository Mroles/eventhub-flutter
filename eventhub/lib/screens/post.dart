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

class _PostPageState extends State<PostPage>
    with AutomaticKeepAliveClientMixin<PostPage> {
  int page = 1;
  bool hasMore = true;
  Future<List<Event>?>? events;

  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    events = getEvents(page);
    super.initState();

    _scrollController.addListener(() async {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        await fetchMore(await events);
      }
    });
  }

  fetchMore(List<Event>? events) async {
    page++;
    var newEvents = await getEvents(page);
    if (newEvents!.isNotEmpty) {
      setState(() {
        page++;
        print("Page: " + page.toString());
        events?.addAll(newEvents);
      });
    }
  }

  Future<void> refresh() async {
    setState(() {
      page = 1;
      events = getEvents(page);
    });
  }

  // @override
  // void setState(VoidCallback fn) {
  //   // TODO: implement setState
  //   super.setState(fn);
  //   page++;
  //   print("SetState: " + page.toString());
  //   events = getEvents(page);
  // }

  @override
  void dispose() {
    // TODO: implement dispose
    _scrollController.dispose();
    super.dispose();
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        RefreshIndicator(
          onRefresh: () => refresh(),
          child: FutureBuilder<List<Event>?>(
              key: const PageStorageKey("futureBuilder"),
              future: events,
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  print(snapshot.error);
                  return const Center(child: Text("Error"));
                } else if (snapshot.connectionState != ConnectionState.done) {
                  return const Center(child: CircularProgressIndicator());
                } else {
                  if (snapshot.hasData) {
                    final eves = snapshot.data;
                    //  return Center(child: Text("data"));
                    return listViewBuilder(eves!, _scrollController);
                  } else {
                    return const Center(child: Text("Nothing to show"));
                  }
                }
              }),
        ),

        // post(context),
        Padding(
          padding: const EdgeInsets.fromLTRB(0.0, 0.0, 8.0, 75.0),
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
