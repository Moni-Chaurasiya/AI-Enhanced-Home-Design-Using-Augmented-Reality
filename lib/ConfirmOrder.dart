import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:url_launcher/url_launcher.dart';

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  Position? _currentPosition;

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  _getCurrentLocation() async {
    final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    setState(() {
      _currentPosition = position;
    });
  }

  _launchMaps() async {
    final url =
        'https://www.google.com/maps/search/?api=1&query=${_currentPosition?.latitude},${_currentPosition?.longitude}';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Map Screen'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Latitude: ${_currentPosition?.latitude}',
            ),
            Text(
              'Longitude: ${_currentPosition?.longitude}',
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _launchMaps,
              child: Text('Open Maps'),
            ),
          ],
        ),
      ),
    );
  }
}