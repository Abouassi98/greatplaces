import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/great_places.dart';
import './map_screen.dart';

class Place_detail extends StatelessWidget {
  static const routedname='/Place_detail';
  @override
  Widget build(BuildContext context) {
    final id = ModalRoute.of(context).settings.arguments;
    final selectedPlaces =
        Provider.of<GreatPlaces>(context, listen: false).findById(id);
    return Scaffold(
      appBar: AppBar(
        title: Text(selectedPlaces.title),
      ),
      body: Column(
        children: [
          Container(
            height: 250,
            child: Image.file(selectedPlaces.image),
            width: double.infinity,
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            selectedPlaces.title,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20, color: Colors.grey),
          ),
          SizedBox(
            height: 10,
          ),
          FlatButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  fullscreenDialog: true,
                  builder: (ctx) => map_screen(
                    isSelcting: false,
                    intialLocation: selectedPlaces.location,
                  ),

                ),

              );
            },
            child: Text('View on Map'),
          )
        ],
      ),
    );
  }
}
