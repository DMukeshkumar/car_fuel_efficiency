import 'dart:async';
import 'package:car_fuel_efficiency/utils/utils_methods.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:car_fuel_efficiency/models/speedometer_model.dart';
import 'package:location/location.dart' hide LocationAccuracy;


class provider with ChangeNotifier {

  Speedometer _speedometer =
  new Speedometer(currentSpeed: 0, time0_48: 0, time48_0: 0);

  Speedometer get speedometer => _speedometer;
  Stopwatch _stopwatch = Stopwatch();
  final Geolocator _geolocator = Geolocator();

  //Method to check location service status and location permission status
  Future<bool> checkLocationServiceAndPermissionStatus() async {
    Location location = new Location();
    bool _isLocationServiceEnabled;
    LocationPermission permission = await Geolocator.requestPermission();
    PermissionStatus _permissionGranted;
    _isLocationServiceEnabled = await location.serviceEnabled();
    if (!_isLocationServiceEnabled) {
      _isLocationServiceEnabled = await location.requestService();
      if (!_isLocationServiceEnabled) {
        showErrorToast(
            "EcoDrive require enabling the location service to be able to measure the vehicle speed");
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        showErrorToast(
            "EcoDrive requires the location permission to be able to measure the vehicle speed");
      }
    }
    return _isLocationServiceEnabled &&
        _permissionGranted == PermissionStatus.granted;
  }

  void updateSpeed(Position position) {
    double speed = (position.speed) * 3.6;

    _speedometer.currentSpeed = speed/1.609;

    if (speed >= SPEED_0 || speed <= SPEED_48) {
      checkSpeedAndMeasureTimeWhileInRange(speed);
    }
    if (speed < SPEED_0 || speed > SPEED_48) {
      checkSpeedAndMeasureTimeWhileOutOfRange(speed);
    }

    print("current speed is : " + speed.toString());
    print("time10_30 is : " + speedometer.time0_48.toString());
    print("time30_10 is : " + speedometer.time48_0.toString());

    notifyListeners();
  }

  //Method to get the vehicle speed updates
  getSpeedUpdates() async {
    if (await checkLocationServiceAndPermissionStatus()) {
      var accuracy = await Geolocator.getLocationAccuracy();
      //LocationOptions options =
      //LocationOptions(accuracy: LocationAccuracy.high, distanceFilter: 10);
      final LocationSettings locationSettings = LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 10,
      );

          StreamSubscription<Position> positionStream = Geolocator.getPositionStream(locationSettings: locationSettings).
      listen((Position? position) {
        //updateSpeed(LocationSettings);
        print(position == null ? 'Unknown' : '${position.latitude.toString()}, ${position.longitude.toString()}');
      });

    }
  }

  void checkSpeedAndMeasureTimeWhileInRange(double vehicleSpeed) {
    if (vehicleSpeed >= SPEED_0) {
      //check if the vehicle speed was less than 10 KMH
      if (speedometer.range == LESS_0) {
        speedometer.range = FROM_0_TO_48;
        _stopwatch.start();
        speedometer.time0_48 = _stopwatch.elapsed.inSeconds;
      }
      //check if the vehicle speed was in the range from 10 to 30
      else if (speedometer.range == FROM_0_TO_48) {
        //update the time on the screen accordingly (time10_30)
        speedometer.time0_48 = _stopwatch.elapsed.inSeconds;
      }
    }

    if (vehicleSpeed <= SPEED_48) {
      //check if the vehicle speed was more than 30 KMH
      if (speedometer.range == OVER_48) {
        speedometer.range = FROM_48_TO_0;
        _stopwatch.start();
        speedometer.time48_0 = _stopwatch.elapsed.inSeconds;
        //check if the vehicle speed from 30 to 10
      } else if (speedometer.range == FROM_48_TO_0) {
        speedometer.time48_0 = _stopwatch.elapsed.inSeconds;
      }
    }
  }

  void checkSpeedAndMeasureTimeWhileOutOfRange(double vehicleSpeed) {
    //check if the vehicle speed is less than 10 KMH
    if (vehicleSpeed < SPEED_0) {
      //check if the vehicle speed was in the range from 30_10 KMH
      if (speedometer.range == FROM_48_TO_0) {
        speedometer.range = LESS_0;
        _stopwatch.stop();
        //update the time on the screen accordingly (time10_30)
        speedometer.time48_0 = _stopwatch.elapsed.inSeconds;
        _stopwatch.reset();
      }
      //check if the vehicle speed was in the range from 10 to 30
      else if (speedometer.range == FROM_0_TO_48) {
        speedometer.range = LESS_0;
        //reset the stopwatch since the vehicle speed is Less than 10 KMH (Out Of ange)
        _stopwatch.reset();
        speedometer.time0_48 = _stopwatch.elapsed.inSeconds;
      }
    }

    //check if the vehicle speed is more than 30 KMH
    if (vehicleSpeed > SPEED_48) {
      //check if the vehicle speed was in the range from 10_30 KMH
      if (speedometer.range == FROM_0_TO_48) {
        speedometer.range = OVER_48;
        _stopwatch.stop();
        //update the time on the screen accordingly (time10_30)
        speedometer.time0_48 = _stopwatch.elapsed.inSeconds;
        //reset the stopwatch since the vehicle speed is more than 30 KMH (Out Of ange)
        _stopwatch.reset();
      }
      //check if the vehicle speed was in the range from 48_0 KMH
      else if (speedometer.range == FROM_48_TO_0) {
        speedometer.range = OVER_48;
        //reset the stopwatch since the vehicle speed is more than 30 KMH (Out Of ange)
        _stopwatch.reset();
        speedometer.time48_0 = _stopwatch.elapsed.inSeconds;
      }
    }
  }
}
