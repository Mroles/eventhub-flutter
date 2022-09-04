import 'package:eventhub/providers/locationprovider.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Maps extends StatefulWidget {
  final String longitude;
  final String latitude;
  const Maps({Key? key, required this.longitude, required this.latitude})
      : super(key: key);

  @override
  _MapsState createState() => _MapsState();
}

class _MapsState extends State<Maps> {
  late GoogleMapController mapController;
  CameraPosition? cameraPosition;
  String location = "Location Name";
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  double lat = 6.0;
  double long = 0.19;
  LatLng _center = LatLng(6.0, 0.19);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    if (widget.latitude != "" && widget.longitude != "") {
      lat = double.parse(widget.latitude);
      long = double.parse(widget.longitude);
    }

    _center = LatLng(lat, long);
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
    print(_center);
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
            Center(
              child: Image.asset("assets/picker.png", width: 35, height: 35),
            ),
            Positioned(
                bottom: 100,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    child: Container(
                        width: MediaQuery.of(context).size.width - 40,
                        child: ListTile(
                          // leading: Image.asset(
                          //   "assets/picker.png",
                          //   width: 25,
                          // ),
                          title: Text(
                            location,
                            style: const TextStyle(fontSize: 18),
                          ),
                          trailing: IconButton(
                              onPressed: () => {
                                    _prefs.then((SharedPreferences prefs) {
                                      prefs.setString("location", location);
                                      prefs.setString(
                                          "lat",
                                          cameraPosition!.target.latitude
                                              .toString());
                                      prefs.setString(
                                          "long",
                                          cameraPosition!.target.longitude
                                              .toString());
                                    }),
                                    Navigator.pop(context)
                                  },
                              icon:
                                  Icon(Icons.location_pin, color: Colors.red)),
                          dense: true,
                        )),
                  ),
                )),
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
