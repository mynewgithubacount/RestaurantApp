import 'package:flutter/material.dart';
import '../constantspages/apres_appbar.dart';
import '../authpages/principleadminLogin.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Restaurant App',
      // theme: ThemeData(
      //   primarySwatch: Colors.,
      // ),
      home: const AdminAcceuil(),
    );
  }
}

class AdminAcceuil extends StatefulWidget {
  const AdminAcceuil({
    Key? key,
  }) : super(key: key);

  @override
  State<AdminAcceuil> createState() => _AdminAcceuilState();
}

class _AdminAcceuilState extends State<AdminAcceuil> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0.0,
        leading: IconButton(
          onPressed: () {
            // var route = MaterialPageRoute(
            //     builder: (BuildContext context) => ContenueDynamic());

            // Navigator.of(context).push(route);
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.close,
            size: 35,
          ),
        ),
      ),
      body: Container(
        color: Colors.blue,
        child: Stack(
          children: [
            Center(
              child: Container(
                margin: EdgeInsets.only(left: 5, right: 5),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      "Welcome to admin panel",
                      style: TextStyle(
                          fontSize: 30,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                    AdminP_login(),
                  ],
                ),
                width: double.infinity,
                height: size.height * 0.3,
                color: Colors.red,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
