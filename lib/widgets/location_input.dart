import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import '../helpers/loctaion_helper.dart';
import '../screens/map_screen.dart';
import '../models/place.dart';

class Location_input extends StatefulWidget {
  Function selectedLocation;
  Location_input(this.selectedLocation);

  @override
  _Location_inputState createState() => _Location_inputState();
}

class _Location_inputState extends State<Location_input> {
  String _previewlocation;
  void _showPreview(double lat, double lng) {
    final staticBingMapImageUrl =
        Location_Bing_Helper.generateLocationPreviewImage(
            latitude: lat, longitude: lng);
    // final staticGoogleMapImageUrl =
    //     Location_Google_Helper.generateLocationPreviewImage(
    //         latitude: lat, longitude: lng);
    setState(() {
           _previewlocation = staticBingMapImageUrl;
          
    });
  }

  Future<void> _getlocation() async {
    try{
    final locData = await Location().getLocation();
    _showPreview(locData.latitude, locData.longitude);
    widget.selectedLocation(locData.latitude, locData.longitude);
  }catch(error){
    return;
  }}

  Future<void> _selectingMap() async {
    final _selectedLocation = await Navigator.of(context).push<LatLng>(
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: (ctx) => map_screen(
          isSelcting: true,
        ),
      ),
    );
    if (_selectedLocation == null) {
      return;
    }
    _showPreview(_selectedLocation.latitude, _selectedLocation.longitude);
    widget.selectedLocation(
        _selectedLocation.latitude, _selectedLocation.longitude);
    print('خط العرض${_selectedLocation.latitude}');
    print('خط الطول${_selectedLocation.longitude}');
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          child: _previewlocation == null
              ? Text(
                  'No Location Choosen',
                  textAlign: TextAlign.center,
                )
              : Image.network(
                  _previewlocation,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
          height: 170,
          width: double.infinity,
          alignment: Alignment.center,
          decoration:
              BoxDecoration(border: Border.all(color: Colors.black, width: 1)),
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FlatButton.icon(
              onPressed: _getlocation,
              icon: Icon(Icons.location_on),
              label: Text('current Location'),
              textColor: Theme.of(context).primaryColor,
            ),
            FlatButton.icon(
              onPressed: _selectingMap,
              icon: Icon(Icons.map),
              label: Text('Select on Map'),
              textColor: Theme.of(context).primaryColor,
            ),
          ],
        )
      ],
    );
  }
}
