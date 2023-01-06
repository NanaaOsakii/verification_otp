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



  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;


    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location services are disabled. Please enable the services')));
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Location permissions are denied')));
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location permissions are permanently denied, we cannot request permissions.')));
      return false;
    }
    return true;
  }

  Future<void> _getCurrentPosition() async {
    final hasPermission = await _handleLocationPermission();


    if (!hasPermission) return;
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) {
      setState(() => _currentPosition = position);
      _getAddressFromLatLng(_currentPosition!);
    }).catchError((e) {
      debugPrint(e);
    });
  }

  Future<void> _getAddressFromLatLng(Position position) async {
    await placemarkFromCoordinates(
        _currentPosition!.latitude, _currentPosition!.longitude)
        .then((List<Placemark> placemarks) {
      Placemark place = placemarks[0];
      setState(() {
        _currentAddress =
        '${place.street}, ${place.subLocality}, ${place.subAdministrativeArea}, ${place.postalCode}';
      });
    }).catchError((e) {
      debugPrint(e);
    });
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      extendBodyBehindAppBar: true,
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
        margin: EdgeInsets.only(left: 25, right: 25),
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
                    Text(
                      "ADDRESS  1",
                      style: TextStyle(color: Colors.grey),
                    ),
                    Text(' ${_currentPosition?.latitude ?? ""}'),
                    Text(' ${_currentPosition?.longitude ?? ""}'),
                    Text(' ${_currentAddress ?? ""}'),
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
                      onPressed: _getCurrentPosition,
                      child: const Text("Get Your Current Location",) ,

                      style: ElevatedButton.styleFrom(
                          primary: Colors.blueAccent[200],
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10))),
                    ),
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