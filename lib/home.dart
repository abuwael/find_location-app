import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    Position? _currentLocation;
    late bool servisePermition = false;
    late LocationPermission permission;
    String _currentaddress = "";
    Future<Position> _getCurrentLocation() async {
      servisePermition = await Geolocator.isLocationServiceEnabled();
      if (!servisePermition) {
        permission = await Geolocator.checkPermission();
        if (permission == LocationPermission.denied) {
          permission = await Geolocator.requestPermission();
        } else if (permission == LocationPermission.denied) {
          return Future.error("");
        }
      }
      return await Geolocator.getCurrentPosition();
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Find Location"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              "Location cordinates",
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 15),
            const Text("Cordinates"),
            const SizedBox(height: 15),
            const Text(
              "Location Address",
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
            ),
            const Text("address"),
            const SizedBox(height: 25),
            ElevatedButton(
              onPressed: () async {
                _currentLocation = await _getCurrentLocation();
              },
              child: const Text("get location"),
            ),
          ],
        ),
      ),
    );
  }
}
