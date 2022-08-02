import 'dart:math';

import 'package:flutter/material.dart';

import 'CustomSearchDelegate.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> with TickerProviderStateMixin {
  int toggle = 1;
  late AnimationController _con;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _con =
        AnimationController(vsync: this, duration: Duration(milliseconds: 375));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: customSearchBar(),
          backgroundColor: Color.fromARGB(255, 255, 160, 192)),
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
