import 'dart:math';

import 'package:flutter/material.dart';
import 'package:task3/Profile.dart';
import 'MapPage.dart';
import 'MainPage.dart';
import 'SearchPage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This is the root widget
  // of your application
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePAge(),
    );
  }
}

class HomePAge extends StatefulWidget {
  const HomePAge({Key? key}) : super(key: key);

  @override
  State<HomePAge> createState() => _HomePAgeState();
}

class _HomePAgeState extends State<HomePAge> with TickerProviderStateMixin {
  PageController pageController = PageController();
  List<Widget> pages = [MainPage(), SearchPage(), MapPage(), Profile()];
  int selectedIndexNav = 0;

  void onItemTap(int selectedItem) {
    pageController.jumpToPage(selectedItem);
  }

  void onPageChanged(int index) {
    setState(() {
      selectedIndexNav = index;
    });
  }

//______________________________________________________________________________
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: pageController,
        children: pages,
        onPageChanged: onPageChanged,
      ),
      bottomNavigationBar: BottomNavigationBar(
        showUnselectedLabels: false,
        showSelectedLabels: false,
        currentIndex: 0,
        onTap: onItemTap,
        items: [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.home_outlined,
                color: selectedIndexNav == 0
                    ? Color.fromARGB(255, 255, 160, 192)
                    : Color.fromARGB(255, 222, 218, 218),
              ),
              label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.search,
                color: selectedIndexNav == 1
                    ? Color.fromARGB(255, 255, 160, 192)
                    : Color.fromARGB(255, 222, 218, 218),
              ),
              label: "Map"),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.map_outlined,
                color: selectedIndexNav == 2
                    ? Color.fromARGB(255, 255, 160, 192)
                    : Color.fromARGB(255, 222, 218, 218),
              ),
              label: "Search"),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.person_outline,
                color: selectedIndexNav == 3
                    ? Color.fromARGB(255, 255, 160, 192)
                    : Color.fromARGB(255, 222, 218, 218),
              ),
              label: "profile"),
        ],
      ),
    );
  }

  //____________________________________________________________________________

}
