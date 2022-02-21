import 'package:flutter/material.dart';
import 'items.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Welcome Screen",
      home: WelcomeScreen(),
    );
  }
}

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreen createState() => _WelcomeScreen();
}

class _WelcomeScreen extends State<WelcomeScreen> {
  List<Widget> slides = items
      .map((item) => Container(
            padding: EdgeInsets.symmetric(horizontal: 18.0),
            child: Column(
              children: <Widget>[
                Flexible(
                  flex: 1,
                  fit: FlexFit.tight,
                  child: Image.asset(
                    item['image'],
                    fit: BoxFit.fitWidth,
                    width: 220.0,
                    alignment: Alignment.bottomCenter,
                  ),
                ),
                Flexible(
                    flex: 1,
                    fit: FlexFit.tight,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 30.0),
                      child: Column(
                        children: <Widget>[
                          Text(
                            item["header"],
                            style: TextStyle(
                              fontSize: 50.0,
                              fontWeight: FontWeight.w300,
                              color: Colors.blue,
                              height: 2.0,
                            ),
                          ),
                          Text(
                            item['description'],
                            style: TextStyle(
                                color: Colors.black,
                                letterSpacing: 1.2,
                                fontSize: 16.0,
                                height: 1.3),
                            textAlign: TextAlign.center,
                          )
                        ],
                      ),
                    ))
              ],
            ),
          ))
      .toList();

  List<Widget> indicator() => List<Widget>.generate(
      slides.length,
      (index) => Container(
            margin: EdgeInsets.symmetric(horizontal: 3.0),
            height: 10.0,
            width: 10.0,
            decoration: BoxDecoration(
                color: currentPage.round() == index
                    ? Color(0XFF256075)
                    : Color(0XFF256075).withOpacity(0.2),
                borderRadius: BorderRadius.circular(10.0)),
          ));
  double currentPage = 0.0;
  final _pageViewController = PageController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Stack(
          children: <Widget>[
            PageView.builder(
                controller: _pageViewController,
                itemCount: slides.length,
                itemBuilder: (BuildContext context, int index) {
                  _pageViewController.addListener(() {
                    setState(() {
                      currentPage = _pageViewController.page!;
                    });
                  });
                  return slides[index];
                }),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 40.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: indicator(),
                ),
              ),
            )
          ],
        ),
      ),
      onDrawerChanged: (isOpened) {},
    );
  }
}
