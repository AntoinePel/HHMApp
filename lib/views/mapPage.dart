import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:dio/dio.dart';
import 'detailPage.dart';

class MapPage extends StatefulWidget {
  const MapPage({Key? key}) : super(key: key);

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  late GoogleMapController _mapController;
  Map<String, Marker> _countryMarkers = {};
  List countries = [];
  bool isSearching = false;

  getCountries() async {
    var response = await Dio().get('https://restcountries.com/v3.1/all');
    return response.data;
  }

  @override
  void initState() {
    getCountries().then((data) {
      setState(() {
        countries = data;
        _addMarkers();
      });
    });
    super.initState();
  }

  void _addMarkers() {
    for (var country in countries) {
      String countryName = country['name']['common'];
      List<double> latlng = country['latlng'].cast<double>();
      LatLng countryLocation = LatLng(latlng[0], latlng[1]);
      addMarker(countryName, countryLocation);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(0, 0),
          zoom: 4,
        ),
        onMapCreated: (controller) {
          _mapController = controller;
        },
        markers: _countryMarkers.values.toSet(),
      ),
    );
  }

  addMarker(String countryName, LatLng location) {
    var marker = Marker(
      markerId: MarkerId(countryName),
      position: location,
      onTap: () {
        _mapController.showMarkerInfoWindow(MarkerId(countryName));
      },
      infoWindow: InfoWindow(
        title: countryName,
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DetailPage(countryName),
            ),
          );
        },
      ),
    );

    _countryMarkers[countryName] = marker;
    setState(() {});
  }
}