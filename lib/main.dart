import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import './constantspages/apres_appbar.dart';
import 'package:firebase_core/firebase_core.dart';
import './constantspages/background.dart';
import './constantspages/transition.dart';
import 'package:dio/dio.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // var dio = Dio();
  // final response = await dio.get('https://google.com');
  // print(response.data);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Restaurant App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: <String, WidgetBuilder>{
        "ContenueDynamic": (BuildContext context) => ContenueDynamic(),
      },
      home: const MyHomePage(title: 'vew your restaurant menu'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controler;
  late Animation<double> animation;

  starTimer() async {
    Duration duration = Duration(seconds: 10);
    return Timer(duration, navigatePage);
  }

  void navigatePage() =>
      Navigator.of(context).pushReplacementNamed('ContenueDynamic');
    

  @override
  void initState() {
    super.initState();
    _controler = AnimationController(
        duration: Duration(milliseconds: 4000), vsync: this);
    animation = Tween<double>(begin: 0.0, end: 0.9).animate(_controler)
      ..addListener(() {
        setState(() {});
      });
    _controler.forward();
    starTimer();
  }

  void dispose() {
    _controler.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: (() => FocusScope.of(context).requestFocus(FocusNode())),
      child: Scaffold(
        backgroundColor: Colors.white,
        // appBar: AppBar(
        //   elevation: 0,
        //   title: Text(widget.title),
        //   centerTitle: true,
        //   leading: Icon(Icons.account_circle),
        //   backgroundColor: Colors.blue[500],
        // ),
        body: Stack(
          children: [
            background("images/restorant/télécharger (2).jpeg"),
            colorsbackgroud(),
            SafeArea(
                child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 0.0),
              child: Center(
                child: Column(
                  children: [
                    SizedBox(
                      height: 155,
                    ),
                    transition("Wellcome to your best restaurant application",
                        _controler),
                    image("images/logo/logoFood.png"),
                    SizedBox(
                      height: size.height * 0.055 ,
                    ),
                    Stack(
                      children: [
                        ClipPath(
                          child: ClipPath(
                            clipper: DisignCircle1(),
                            child: Container(
                              width: double.infinity,
                              height: size.height / 4,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                image: DecorationImage(
                                    alignment: Alignment.topRight,
                                    image: AssetImage(
                                        "images/restorant/RizCrevette.png"),
                                    fit: BoxFit.cover),
                              ),
                              child: Opacity(
                                opacity: 0.2,
                                child: Container(
                                  width: double.infinity,
                                  height: size.height,
                                  decoration: BoxDecoration(
                                    //gradient: LinearGradient(colors: 0xffF82727),
                                    color: Color(0xffF82727),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ))
          ],
        ),

        // SingleChildScrollView(
        //   child: Column(
        //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //     children: [
        //       ContenueDynamic(),
        //     ],
        //   ),
        // ),
      ),
    );
  }
}

// cliper class declaration

class DisignCircle1 extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    // TODO: implement getClip
    var path = Path();

    path.moveTo(size.width, 15);
    //path.lineTo(size.width / 1.1, -size.height / 6);
    path.quadraticBezierTo(
        size.width / 3, -size.height / 4, size.width / 4, size.height);
    path.lineTo(size.width, size.height);

    // path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    // TODO: implement shouldReclip
    return true;
  }
}

// for categories getting


