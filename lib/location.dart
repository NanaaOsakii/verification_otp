import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';




class MyLocation extends StatefulWidget {
  const MyLocation({Key? key}) : super(key: key);

  @override
  State<MyLocation> createState() => _MyLocationState();


}

class _MyLocationState extends State<MyLocation> {
  String? _currentAddress;
  Position? _currentPosition;
  TextEditingController countryController = TextEditingController();
  String location ='Null, Press Button';
  String Address = '';
  Future<Position> _getGeoLocationPosition() async {
    bool serviceEnabled;
    LocationPermission permission;
    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      await Geolocator.openLocationSettings();
      return Future.error('Location services are disabled.');
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  }
  Future<void> GetAddressFromLatLong(Position position)async {
    List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);
    print(placemarks);
    Placemark place = placemarks[0];
    ' ${place.postalCode}, ${place.country}';
    setState(()  {
    });
  }

  Future<void> _getAddressFromLatLng(Position position) async {
    await placemarkFromCoordinates(
        _currentPosition!.latitude, _currentPosition!.longitude)
        .then((List<Placemark> placemarks) {
      Placemark place = placemarks[0];
      setState(() {
        _currentAddress =
        ' ${place.postalCode}, ${place.country}';
      });
    }).catchError((e) {
      debugPrint(e);
    });
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            Navigator.pushNamedAndRemoveUntil(
              context,
              'phone',
                  (route) => false,
            );
          },
          icon: Icon(
            Icons.arrow_back_ios_rounded,
            color: Colors.black,
          ),
        ),
        elevation: 0,
      ),

      body: Container(
        margin: EdgeInsets.only(left: 2, right: 2),
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Column(

            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("images/h.png",
                width: 100,
                height:80,
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                "MY LOCATION", textAlign: TextAlign.center,
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold,color: Colors.blueAccent[200],),
              ),
              SizedBox(
                height: 30,
              ),

              Container(
                height: 55,
                decoration: BoxDecoration(

                    border: Border.all(width: 1, color: Colors.grey),
                    borderRadius: BorderRadius.circular(10)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    SizedBox(
                      width: 10,
                    ),
                    SizedBox(
                      width: 5,
                      child: TextField(
                        controller: countryController,
                        keyboardType: TextInputType.streetAddress,
                        decoration: InputDecoration(
                          border: InputBorder.none
                        ),
                      ),
                    ),

                    Text('${Address}'),



                  ],
                ),
              ),

              Container(

                height: 55,
                decoration: BoxDecoration(
                    border: Border.all(width: 1 , color: Colors.grey),
                    borderRadius: BorderRadius.circular(10)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 10,
                    ),
                    SizedBox(
                      width: 5,
                      child: TextField(
                        controller: countryController,
                        keyboardType: TextInputType.streetAddress,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    Text(
                      "ADDRESS 2  : ",
                      style: TextStyle(color: Colors.grey),
                    ),

                    const SizedBox(height: 32),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: TextField(
                        keyboardType: TextInputType.streetAddress,
                        decoration: InputDecoration(
                          border: InputBorder.none,

                        ),
                      ),),
                  ],
                ),
              ),

              Container(

                height: 55,
                decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Colors.grey),
                    borderRadius: BorderRadius.circular(10)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 10,
                    ),
                    SizedBox(
                      width: 5,
                      child: TextField(
                        controller: countryController,
                        keyboardType: TextInputType.streetAddress,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    Text(
                      "TOWN/CITY :",
                      style: TextStyle(color: Colors.grey),
                    ),
                    const SizedBox(height: 32),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: TextField(
                        keyboardType: TextInputType.streetAddress,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                        ),
                      ),),
                  ],
                ),
              ),

              Container(

                height: 55,
                decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Colors.grey),
                    borderRadius: BorderRadius.circular(10)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 10,
                    ),
                    SizedBox(
                      width: 5,
                      child: TextField(
                        controller: countryController,
                        keyboardType: TextInputType.streetAddress,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    Text(
                      "COUNTRY    :",
                      style: TextStyle(color: Colors.grey),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: TextField(
                        keyboardType: TextInputType.streetAddress,
                        decoration: InputDecoration(
                          border: InputBorder.none,

                        ),
                      ),),
                  ],
                ),
              ),

              Container(
                height: 55,
                decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Colors.grey),
                    borderRadius: BorderRadius.circular(10)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 10,
                    ),
                    SizedBox(
                      width: 5,
                      child: TextField(
                        controller: countryController,
                        keyboardType: TextInputType.streetAddress,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    Text(
                      "POST CODE :",
                      style: TextStyle(color: Colors.grey),
                    ),

                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: TextField(
                        keyboardType: TextInputType.streetAddress,
                        decoration: InputDecoration(
                          border: InputBorder.none,

                        ),
                      ),),
                  ],
                ),
              ),

              Container(
                child: Column(

                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 10,
                    ),

                    SizedBox(
                      width: double.infinity, height: 45,
                      child: ElevatedButton(
                          onPressed: () async{
                            Position position = await _getGeoLocationPosition();
                            location ='Lat: ${position.latitude} , Long: ${position.longitude}';
                            GetAddressFromLatLong(position);
                          }, child: Text('Get Location'))
                   ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),

              Row(

                children: [

                  TextButton(
                    onPressed: () {
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        'googlemap',
                            (route) => false,
                      );
                    },

                    child: Text(
                      " Google Map?",
                      style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),
                    ),


                  ),
                ],
              ),
              SizedBox(
                height: 60,
              ),
              Column(
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        'succes',
                            (route) => false,
                      );
                    },

                    child: Icon(
                      Icons.arrow_forward_ios_rounded,
                      color: Colors.black,

                    ),
                  ),
                ],

              ),
            ],
          ),
        ),
      ),
    );
  }
}