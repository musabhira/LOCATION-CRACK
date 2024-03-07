import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notify_location/controller/button_controller.dart';
import 'package:notify_location/controller/location_provider.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            title: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 40),
              child: Text(
                'LOcATION cRAcK',
                style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
              ),
            ),
          ),
          drawer: Drawer(
            backgroundColor: const Color.fromARGB(255, 0, 221, 173),
            width: MediaQuery.of(context).size.width * 0.8,
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                const DrawerHeader(
                  curve: Curves.easeIn,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(width: 10),
                          Text(
                            'LOcATION cRAck',
                            style: TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ],
                      ),
                      Text(
                        'Ready To go',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ],
                  ),
                ),
                ListTile(
                  leading:
                      const Icon(Icons.home, size: 24, color: Colors.white),
                  title: const Text(
                    'Home',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.receipt_long_outlined,
                      size: 24, color: Colors.white),
                  title: const Text(
                    'New Resume',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                  onTap: () {},
                ),
                ListTile(
                  leading:
                      const Icon(Icons.list, size: 24, color: Colors.white),
                  title: const Text(
                    'Location Cracker',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                  onTap: () {},
                ),
                ListTile(
                  leading: const RotationTransition(
                    turns: AlwaysStoppedAnimation(180 / 360),
                    child: Icon(
                      Icons.logout,
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                  title: const Text(
                    'Logout',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Are you sure?'),
                          content: const Text('Would you like to logout?'),
                          actions: [
                            TextButton(
                              child: const Text('Cancel'),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                            TextButton(
                              child: const Text('Logout'),
                              onPressed: () {
                                // Perform logout action
                              },
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Color.fromARGB(255, 3, 66, 82),
                            Color(0xff222222),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                      child: Column(
                        children: [
                          GridView.builder(
                            shrinkWrap: true,
                            gridDelegate:
                                const SliverGridDelegateWithMaxCrossAxisExtent(
                              maxCrossAxisExtent: 500,
                              mainAxisExtent: 70,
                            ),
                            itemCount: buttonList.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 24,
                                  vertical: 12,
                                ),
                                child: InkWell(
                                  onTap: () =>
                                      buttonList[index].onTap(ref, context),
                                  child: Container(
                                    height: 70,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      color: buttonList[index].buttonColor,
                                    ),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          buttonList[index].buttonName,
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.sizeOf(context).height,
                  child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithMaxCrossAxisExtent(
                      mainAxisExtent: 70,
                      maxCrossAxisExtent: 500,
                    ),
                    itemCount: ref.watch(locationProvider).location.length,
                    itemBuilder: (context, index) {
                      final data = ref.watch(locationProvider).location[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24, vertical: 4),
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: const Color.fromARGB(255, 0, 221, 173),
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Tracking ${index + 1}",
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Lat :${data.lat.toString()}",
                                  ),
                                  Text(
                                    "Lng :${data.lon.toString()}",
                                  ),
                                  Text(
                                    "Speed : ${data.speed.toStringAsFixed(0)}m",
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
