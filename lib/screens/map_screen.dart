import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../models/place.dart';

class map_screen extends StatefulWidget {
  @override
  final PlaceLocation intialLocation;
  final bool isSelcting;
  map_screen(
      {this.intialLocation =
          const PlaceLocation(latitude: 30.7982042, longitude: 31.0067025),
      this.isSelcting = false});
  _map_screenState createState() => _map_screenState();
}

class _map_screenState extends State<map_screen> {
  LatLng _pickedLocation;
  void _selectedPosition(LatLng position) {
    setState(() {
      _pickedLocation = position;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('your Map'),
        actions: <Widget>[
          widget.isSelcting
              ? IconButton(
                  icon: Icon(Icons.check),
                  onPressed: _pickedLocation == null
                      ? null
                      : () {
                          Navigator.of(context).pop(_pickedLocation);
                        },
                )
              : Icon(Icons.check,color: Colors.grey,),
        ],
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
            target: LatLng(widget.intialLocation.latitude,
                widget.intialLocation.longitude),
            zoom: 16),
        onTap: widget.isSelcting ? _selectedPosition : null,
        markers: (_pickedLocation == null && widget.isSelcting)
            ? null
            : {
                Marker(
                  markerId: MarkerId('m1'),
                  position: _pickedLocation ??
                      LatLng(widget.intialLocation.latitude,
                          widget.intialLocation.longitude),
                ),
              },
      ),
    );
  }
}
