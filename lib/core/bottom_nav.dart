import 'package:flutter/material.dart';
import 'package:notify_location/view/home_page.dart';

class BottomNaviWidet extends StatefulWidget {
  const BottomNaviWidet({super.key});
  static const routePath = '/';

  @override
  State<BottomNaviWidet> createState() => _BottomNaviWidetState();
}

class _BottomNaviWidetState extends State<BottomNaviWidet> {
  int selectedIndex = 2;
  final PageController controller = PageController(initialPage: 2);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: PageView(
        controller: controller,
        onPageChanged: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
        children: const [
          Scaffold(),
          Scaffold(),
          HomePage(),
          Scaffold(),
          Scaffold(),
        ],
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 10,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: BottomNavigationBar(
          backgroundColor: Colors.transparent,
          selectedItemColor: const Color.fromARGB(255, 0, 221, 173),
          unselectedItemColor: const Color.fromARGB(255, 10, 10, 10),
          currentIndex: selectedIndex,
          showSelectedLabels: true,
          showUnselectedLabels: true,
          onTap: (index) {
            setState(() {
              selectedIndex = index;
              controller.jumpToPage(index);
            });
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              label: '',
            ),
            BottomNavigationBarItem(icon: Icon(Icons.window), label: ''),
            BottomNavigationBarItem(
              icon: Icon(Icons.handshake_outlined),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.file_open_outlined),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_2_outlined),
              label: '',
            ),
          ],
        ),
      ),
    );
  }
}
