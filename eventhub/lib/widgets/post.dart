import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

Widget post(BuildContext context) {
  // ignore: unnecessary_new
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Container(
      height: 410,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.0),
          boxShadow: [
            BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                offset: Offset(0, 5),
                blurRadius: 3)
          ]),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              children: [
                Column(
                  children: const [
                    CircleAvatar(
                      backgroundImage: AssetImage('assets/profile.png'),
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
                        children: const [
                          Text(
                            "date",
                            style: TextStyle(fontWeight: FontWeight.w300),
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
                children: const [Text("sxercdtfvgbyfvrtvbygnhuygtfr")],
              ),
            ),
            CachedNetworkImage(
              height: 250,
              imageUrl: "https://picsum.photos/200/300",
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
            Padding(
              padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: const [
                  Icon(
                    Icons.favorite,
                    color: Colors.red,
                  ),
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
  );
}
