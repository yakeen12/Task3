import 'dart:math';
import 'package:flutter/material.dart';
import 'package:task3/EventsScreen.dart';
import 'package:task3/NewsScreen.dart';
import 'package:task3/WeatherScreen.dart';
import 'CustomSearchDelegate.dart';
import 'package:auto_size_text/auto_size_text.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => MainPageState();
}

class MainPageState extends State<MainPage> with TickerProviderStateMixin {
  late TabController controller;

  int toggle = 1;
  late AnimationController _con;

  @override
  void initState() {
    super.initState();
    _con =
        AnimationController(vsync: this, duration: Duration(milliseconds: 375));

    controller = TabController(length: 3, vsync: this);
    controller.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: (AppBar(
            backgroundColor: Colors.white,
            title: customSearchBar(),
            bottom: TabBar(
                labelColor: Color.fromARGB(255, 255, 160, 192),
                unselectedLabelColor: Color.fromARGB(255, 222, 218, 218),
                tabs: [
                  // Tried to make it a list of tabs so the code will be shorter
                  // But i got an error cuz of the controller.
                  Tab(
                    child: Text(
                      "News",
                      style:
                          TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Tab(
                    child: Text(
                      "Events",
                      style:
                          TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Tab(
                    child: AutoSizeText(
                      "Weather",
                      maxLines: 1,
                      style:
                          TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
                    ),
                  ),
                ]),
          )),
          body: TabBarView(children: [
            NewsScreen(),
            EventsScreen(),
            WeatherScreen(),
          ]),
        ),
      ),
    );
  }

  Widget customSearchBar() {
    return Container(
      height: 100,
      width: double.infinity,
      margin: EdgeInsets.only(bottom: 20),
      alignment: Alignment(-1, 0),
      child: AnimatedContainer(
        duration: Duration(milliseconds: 375),
        height: 48,
        width: (toggle == 0) ? 48 : 1000,
        curve: Curves.easeOut,
        decoration: BoxDecoration(
            color: Color.fromARGB(255, 235, 234, 234),
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                  color: Colors.black26,
                  spreadRadius: -10,
                  blurRadius: 10,
                  offset: Offset(0, 10))
            ]),
        child: Stack(
          children: [
            AnimatedPositioned(
              child: AnimatedOpacity(
                duration: Duration(milliseconds: 200),
                opacity: (toggle == 0) ? 0 : 1,
                child: Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 219, 218, 218),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: AnimatedBuilder(
                    child: Icon(
                      Icons.mic,
                      size: 20,
                    ),
                    builder: (context, widget) {
                      return Transform.rotate(
                        angle: _con.value * 2 * pi,
                        child: widget,
                      );
                    },
                    animation: _con,
                  ),
                ),
              ),
              duration: Duration(milliseconds: 375),
              top: 6,
              right: 7,
              curve: Curves.easeOut,
            ),
            AnimatedPositioned(
              duration: Duration(milliseconds: 375),
              left: (toggle == 0) ? 20 : 40,
              top: 13,
              curve: Curves.easeOut,
              child: AnimatedOpacity(
                duration: Duration(milliseconds: 200),
                opacity: (toggle == 0) ? 0 : 1,
                child: Container(
                  height: 23,
                  width: 180,
                  child: TextField(
                    onTap: () {
                      showSearch(
                          context: context,
                          // delegate to customize the search bar
                          delegate: CustomSearchDelegate());
                    },
                    cursorRadius: Radius.circular(10),
                    cursorWidth: 2,
                    cursorColor: Colors.black,
                    decoration: InputDecoration(
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        labelText: "search",
                        labelStyle: TextStyle(
                            color: Color(0xff5b5b5b),
                            fontSize: 17,
                            fontWeight: FontWeight.w500),
                        alignLabelWithHint: true,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide.none)),
                  ),
                ),
              ),
            ),
            Material(
              color: Color.fromARGB(255, 235, 234, 234),
              borderRadius: BorderRadius.circular(30),
              child: IconButton(
                  onPressed: () {
                    setState(() {
                      if (toggle == 0) {
                        toggle = 1;
                        _con.forward();
                      } else {
                        toggle = 0;
                        _con.reverse();
                      }
                    });
                  },
                  icon: Icon(
                    Icons.search,
                    size: 18,
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
