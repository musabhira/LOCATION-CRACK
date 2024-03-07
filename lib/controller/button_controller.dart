import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:notify_location/controller/location_provider.dart';
import 'package:notify_location/main.dart';
import 'package:notify_location/model/button_model.dart';

Future<bool> isLocationEnabled() async {
  return await Geolocator.isLocationServiceEnabled();
}

Future<bool> requestLocationPermission() async {
  var permission = await Geolocator.checkPermission();
  String messageToShow;
  bool isPermissionGranted = true;

  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      messageToShow = 'Location permission denied';
      isPermissionGranted = false;
    } else {
      messageToShow = 'Location permission granted';
    }
  } else {
    messageToShow = 'Location permission already granted';
  }

  if (permission == LocationPermission.deniedForever) {
    messageToShow = 'Location denied forever';
    isPermissionGranted = false;
  }

  MyApp.scaffoldMessangerKey.currentState!.showSnackBar(
    SnackBar(
      content: Text(messageToShow),
    ),
  );

  return isPermissionGranted;
}

List<ButtonModel> buttonList = [
  ButtonModel(
    buttonName: 'Request Location Permission',
    buttonColor: const Color.fromARGB(255, 0, 221, 173),
    onTap: (ref, context) async {
      /// Check if location service is enabled
      if (await isLocationEnabled()) {
        /// Check if the app has permission
        if (await requestLocationPermission()) {
          // ignore: avoid_print
          print('Location permission granted');
        } else {
          // ignore: avoid_print
          print('Location permission denied');
        }
      } else {
        // ignore: avoid_print
        print('Location not enabled');
      }
    },
  ),
  ButtonModel(
    buttonName: 'Request Notification Permission',
    buttonColor: const Color.fromARGB(255, 0, 221, 173),
    onTap: (ref, context) {
      // ignore: avoid_print
      print("Hellow");
      AwesomeNotifications().requestPermissionToSendNotifications();
    },
  ),
  ButtonModel(
    buttonName: 'Start Location Update',
    buttonColor: const Color.fromARGB(255, 0, 221, 173),
    onTap: (ref, context) async {
      if (await requestLocationPermission()) {
        /// Check if the app has permission
        showDialog(
          // ignore: use_build_context_synchronously
          context: context,
          builder: ((context) {
            return AlertDialog(
              title: const Text('Alert'),
              content: const Text('Are you sure'),
              actions: [
                TextButton(
                    onPressed: (() {
                      Navigator.pop(context);
                    }),
                    child: const Text('No')),
                TextButton(
                  onPressed: () {
                    ref.read(locationProvider.notifier).startLocationPolling();
                    AwesomeNotifications().createNotification(
                      content: NotificationContent(
                        id: 10,
                        channelKey: 'location-update',
                        actionType: ActionType.Default,
                        title: 'Location update started',
                      ),
                    );
                    Navigator.pop(context);
                  },
                  child: const Text('Yes'),
                )
              ],
            );
          }),
        );
      } else {
        showDialog(
          context: context,
          builder: ((context) {
            return const AlertDialog(
              title: Text('Alert'),
              content: Text('Place Enable Location permission'),
            );
          }),
        );
      }
    },
  ),
  ButtonModel(
    buttonName: 'Stop Location Update',
    buttonColor: const Color.fromARGB(255, 0, 221, 173),
    onTap: (ref, context) {
      ref.read(locationProvider.notifier).stopLocationPolling();
      AwesomeNotifications().createNotification(
        content: NotificationContent(
          id: 11,
          channelKey: 'location-update',
          actionType: ActionType.Default,
          title: 'Location update stoped',
        ),
      );
    },
  ),
  ButtonModel(
    buttonName: 'Location Cracking',
    buttonColor: const Color.fromARGB(255, 0, 221, 173),
    onTap: (ref, context) {
      ref.read(locationProvider.notifier).stopLocationPolling();
      AwesomeNotifications().createNotification(
        content: NotificationContent(
          id: 11,
          channelKey: 'Location Cracking',
          actionType: ActionType.Default,
          title: 'LOCation Crack',
        ),
      );
    },
  ),
];
