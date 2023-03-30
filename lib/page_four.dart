import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class LocationPage extends StatefulWidget {
  const LocationPage({super.key});

  @override
  State<LocationPage> createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
  String location = "";

  @override
  void initState() {
    super.initState();
    requestLocationPermission();
  }

  void requestLocationPermission() async {
    final permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      location = "denied";
    } else if (permission == LocationPermission.deniedForever) {
      location = "denied-forever";
    } else {
      // Permission granted, proceed to get location
      getLocation();
    }
  }

  void getLocation() async {
    try {
      final position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      setState(() {
        location = 'Latitude:'.tr() +
            position.latitude.toString() +
            ', Longitude:'.tr() +
            position.longitude.toString();
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: const Text('Data Collector').tr()),
        backgroundColor: Colors.green,
      ),
      body: Center(
        child: location == ""
            ? const CircularProgressIndicator()
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(location),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      requestLocationPermission();
                    },
                    child: const Text('Get Location').tr(),
                  ),
                ],
              ),
      ),
    );
  }
}
