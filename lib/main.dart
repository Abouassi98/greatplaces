import 'package:flutter/material.dart';
import './screens/place_list.dart';
import 'package:provider/provider.dart';
import './provider/great_places.dart';
import './screens/add_place.dart';
import './screens/place_detail.dart';
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: GreatPlaces(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Great Places',
        theme: ThemeData(
          primarySwatch: Colors.indigo,
          accentColor: Colors.amber,
        ),
        home: place_list(),
        routes: {
          add_place.routedname: (ctx) => add_place(),
          Place_detail.routedname:(ctx)=>Place_detail(),
        },
      ),
    );
  }
}
