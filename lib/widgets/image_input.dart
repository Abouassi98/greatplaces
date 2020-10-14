import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart'as syspath;
class image_input extends StatefulWidget {
 final Function selectedImage;
 image_input(this.selectedImage);
  @override
  _image_inputState createState() => _image_inputState();
}

class _image_inputState extends State<image_input> {
  File _imagefile;
  final ImagePicker _picker = ImagePicker();
  Future<void>_takeapicture()async{
    final imagefile=await _picker.getImage(source: ImageSource.camera,maxWidth: 600);
    if(imagefile==null){
      return;
    }
    setState(() {
      _imagefile = File(imagefile.path);
    });
    final appDir=await syspath.getApplicationDocumentsDirectory();
    final filename=path.basename(_imagefile.path);
  final savedImage= await  _imagefile.copy('${appDir.path}/$filename');
  widget.selectedImage(savedImage);
  }
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          alignment: Alignment.center,
          width: 150,
          height: 100,
          decoration: BoxDecoration(
            border: Border.all(width: 2, color: Colors.grey),
          ),
          child: _imagefile != null
              ? Image.file(_imagefile,width: double.infinity,fit: BoxFit.cover,)
              : Text('Not Image Taken',textAlign: TextAlign.center,),
        ),
        SizedBox(width: 10,),
        Expanded(
                  child: FlatButton.icon(textColor: Theme.of(context).primaryColor,
            onPressed:_takeapicture,
            icon: Icon(Icons.camera),
            label: Text('Take a picture'),
          ),
        ),
      ],
    );
  }
}
//  Row(
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       children: <Widget>[
//                         Container(
//                           alignment: Alignment.center,
//                           height: MediaQuery.of(context).size.height*0.25,
//                           width: MediaQuery.of(context).size.width*0.5,
//                           margin: EdgeInsets.only(top: 18, right: 10),
//                           decoration: BoxDecoration(
//                             border: Border.all(color: Colors.grey, width: 2),
//                           ),
//                           child: _imagefile==null
//                               ? Text('Enter a photo')
//                               :
//                                    Image.file(_imagefile,width: double.infinity,fit: BoxFit.cover),
                                 
                                
//                         ),
//                         Expanded(
//                           child: FlatButton.icon(
//                             textColor: Theme.of(context).primaryColor,
//                             onPressed: _takeaPicture,
//                             icon: Icon(
//                               Icons.camera,
//                             ),
//                             label: Text(
//                               'Take a picture',
//                             ),