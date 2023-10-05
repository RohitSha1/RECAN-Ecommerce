import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMapScreen extends StatefulWidget {
  const GoogleMapScreen({Key? key}) : super(key: key);

  @override
  State<GoogleMapScreen> createState() => _GoogleMapScreenState();
}

class _GoogleMapScreenState extends State<GoogleMapScreen> {
  GoogleMapController? mapController;
  Set<Marker> markers ={};
  LatLng myLocation = const LatLng(27.7060698, 85.3299096);
  @override
  void initState(){
    markers.add(
      Marker(
        markerId: MarkerId(myLocation.toString()),
        position: myLocation,
        infoWindow: const InfoWindow(
          title: 'Recan Office',
          snippet: 'Nearby Softwarica College',
        ),
        icon: BitmapDescriptor.defaultMarker,
      ),
      );
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Recan Office Location'),
        backgroundColor: const Color.fromARGB(255, 7, 75, 223),
      ),
      body: GoogleMap(
        zoomGesturesEnabled: true,
        initialCameraPosition: CameraPosition(
          target: myLocation,
          zoom: 14,
        ),
        markers: markers, //markers to show on map
        mapType: MapType.normal, //map type
        
        onMapCreated: (controller) {
          setState(() {
            mapController = controller;
          });
        },
        
        ),
        
      );
    
  }
}