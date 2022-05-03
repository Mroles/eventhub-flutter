import 'package:eventhub/providers/locationprovider.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart';
import 'package:provider/provider.dart';

class Maps extends StatefulWidget {
  const Maps({Key? key}) : super(key: key);

  @override
  _MapsState createState() => _MapsState();
}

class _MapsState extends State<Maps> {
  late GoogleMapController mapController;
  CameraPosition? cameraPosition;
  String location = "Location Name";

  final LatLng _center = const LatLng(6.0, 0.19);

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        TextField(
          decoration: const InputDecoration(
              prefixIcon: Icon(Icons.search),
              hintText: "Search Location",
              border: OutlineInputBorder(),
              fillColor: Colors.white,
              filled: true),
          onChanged: (value) =>
              context.read<LocationProvider>().searchPlaces(value),
        ),
        Expanded(
          child: Stack(children: [
            Container(
              width: double.infinity,
              //height: MediaQuery.of(context).size.height * 0.823,
              child: GoogleMap(
                zoomGesturesEnabled: true,
                onMapCreated: _onMapCreated,
                onCameraMove: (CameraPosition cameraPos) {
                  cameraPosition = cameraPos;
                },
                onCameraIdle: () async {
                  List<Placemark> placemarks = await placemarkFromCoordinates(
                      cameraPosition!.target.latitude,
                      cameraPosition!.target.longitude);
                  setState(() {
                    location = placemarks.first.administrativeArea.toString() +
                        ", " +
                        placemarks.first.street.toString();
                  });
                },
                initialCameraPosition:
                    CameraPosition(target: _center, zoom: 10.0),
              ),
            ),
            if (context.watch<LocationProvider>().searchResults.isNotEmpty)
              Container(
                height: MediaQuery.of(context).size.height,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.black.withOpacity(.5),
                    backgroundBlendMode: BlendMode.darken),
              ),
            if (context.watch<LocationProvider>().searchResults.isNotEmpty)
              Container(
                height: 300,
                child: ListView.builder(
                    itemCount:
                        context.watch<LocationProvider>().searchResults.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(
                            context
                                .watch<LocationProvider>()
                                .searchResults[index]
                                .description,
                            style: const TextStyle(color: Colors.white)),
                      );
                    }),
              ),
          ]),
        ),
      ]),
    );
  }
}
