
//import 'package:geolocator/geolocator.dart';

class Location{

  double? lon;
  double? lat;

  Future<void> getCurrentLocation() async{
    try{


    // Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best);
    // lon = position.longitude;
    // lat = position.latitude;

    }
    catch(e){
      print(e);
    }
  }
}