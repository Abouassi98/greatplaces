import 'package:http/http.dart' as http;
import 'dart:convert';

//const Google_Api_Key = 'AIzaSyCu-jBboiBDBqLqh7lhVp8mzLT6jKk6Bfo';
const Bing_Api_Key =
    'At2H7sKiAYFiIM5FvZI9BcH6laBLt-vUQsYyv12cvB49N2RqLMtGFZ5aVstjRZIV';

// class Location_Google_Helper {
//   static String generateLocationPreviewImage(
//       {double latitude, double longitude}) {
//     return 'https://maps.googleapis.com/maps/api/staticmap?center=&$latitude,$longitude&zoom=16&size=600x300&maptype=roadmap&markers=color:red%7Clabel:A%7C$latitude,$longitude&key=$Google_Api_Key';
//   }

//   static Future<String> getlocation({double lat, double lng}) async {
//     final url =
//         'https://maps.googleapis.com/maps/api/geocode/json?latlng=$lat,$lng&key=$Google_Api_Key';

//     final response = await http.get(url);
//     return json.decode(response.body)['results'][0]['formatted_address'];
//   }
// }

class Location_Bing_Helper {
  static String generateLocationPreviewImage(
      {double latitude, double longitude}) {
    return 'http://dev.virtualearth.net/REST/v1/Imagery/Map/Road/$latitude,$longitude/16?mapSize=500,500&pp=$latitude,$longitude;66&mapLayer=Basemap,Buildings&key=$Bing_Api_Key ';
  }

  static Future<String> getlocation({double lat, double lng}) async {
    final url =
        'http://dev.virtualearth.net/REST/v1/locationrecog/$lat,$lng?key=$Bing_Api_Key&includeEntityTypes=address&output=json';
    final response = await http.get(url);
    return json.decode(response.body)['resourceSets'][0]['resources'][0]['addressOfLocation'][0]['formattedAddress'];
  }
}
