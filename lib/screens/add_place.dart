import 'dart:io';
import 'package:provider/provider.dart';
import '../provider/great_places.dart';
import 'package:flutter/material.dart';
import '../widgets/image_input.dart';
import '../widgets/location_input.dart';
import '../models/place.dart';

class add_place extends StatefulWidget {
  static const routedname = '/add_place';
  @override
  _add_placeState createState() => _add_placeState();
}

class _add_placeState extends State<add_place> {
  TextEditingController _controller = TextEditingController();
  File _pickedImage;
  PlaceLocation _pickedlocation;
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }

  void _selectedImage(File pickedImage) {
    _pickedImage = pickedImage;
  }

  void _selectedLocation(double lat, double lng) {
    _pickedlocation = PlaceLocation(latitude: lat, longitude: lng);
  }

  void _saveplace() {
    if (_controller.text.isEmpty ||
        _pickedImage == null ||
        _pickedlocation == null) {
      return;
    }
    Provider.of<GreatPlaces>(context, listen: false)
        .addplace(_controller.text, _pickedImage, _pickedlocation);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add a new Place'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Tilte',
                      ),
                      controller: _controller,
                      validator: (value) {
                        if (value.length < 4) {
                          return 'ده اسم امك هو اللي من 3 حروف يلا كبره شويه';
                        }
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    image_input(_selectedImage),
                    SizedBox(
                      height: 10,
                    ),
                    Location_input(_selectedLocation),
                  ],
                ),
              ),
            ),
          ),
          RaisedButton.icon(
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            color: Theme.of(context).accentColor,
            icon: (Icon(
              Icons.add,
            )),
            label: Text('Add Place'),
            onPressed: _saveplace,
          )
        ],
      ),
    );
  }
}
