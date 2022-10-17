import 'package:flutter/material.dart';
import 'package:restaurantapp/Crudpages/admin_panel.dart';
import '../authpages/login.dart';
import '../authpages/register.dart';

import '../constantspages/apres_appbar.dart';

class ContenueDynamic extends StatefulWidget {
  const ContenueDynamic({Key? key}) : super(key: key);

  @override
  State<ContenueDynamic> createState() => _ContenueDynamicState();
}

class _ContenueDynamicState extends State<ContenueDynamic> {
  Color couleurRegister = Colors.grey.shade200;
  Color couleurLogin = Colors.red;
  Color logintextcolor = Colors.black;
  Color registertextcolor = Colors.black;

// function alowing to get login part
  bool valeur = false;
  void retourLogin() {
    setState(() {
      valeur = false;
    });
  }

// function alowing to get Register part
  void retourResiter() {
    setState(() {
      valeur = true;
    });
  }

  // function to view admin page

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: size.height,
              child: Stack(
                children: [
                  ClipPath(
                    clipper: DisignCircle(),
                    child: Container(
                      width: double.infinity,
                      height: size.height / 2.2,
                      decoration: BoxDecoration(
                        color: Colors.red,
                        image: DecorationImage(
                            image: AssetImage("images/pakistani food.jpeg"),
                            fit: BoxFit.cover),
                      ),
                      child: Opacity(
                        opacity: 0.4,
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

                  // Container(
                  //   width: double.infinity,
                  //   height: size.height * 0.30,
                  //   decoration: BoxDecoration(
                  //     color: Colors.red,
                  //     borderRadius: BorderRadius.only(
                  //       bottomLeft: Radius.circular(40),
                  //       bottomRight: Radius.elliptical(60, 100),
                  //     ),
                  //     image: DecorationImage(
                  //         image: AssetImage("images/Queues de boeuf.jpeg"),
                  //         fit: BoxFit.cover),
                  //   ),
                  //   child: Opacity(
                  //     opacity: 0.4,
                  //     child: Container(
                  //       width: double.infinity,
                  //       height: size.height * 0.23,
                  //       decoration: BoxDecoration(
                  //         //gradient: LinearGradient(colors: 0xffF82727),
                  //         color: Color(0xffF82727),
                  //         borderRadius: BorderRadius.only(
                  //           bottomLeft: Radius.circular(40),
                  //           bottomRight: Radius.elliptical(60, 100),
                  //         ),
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  //position for the  title
                  Positioned(
                    child: Container(
                      padding: EdgeInsets.only(top: 60),
                      width: double.infinity,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "the best restaurant",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              fontFamily: "Script MT",
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),

                  // position for connexion box
                  Positioned(
                    bottom: size.height * 0.2,
                    left: size.width * 0.01,
                    right: size.width * 0.03,
                    top: size.height * 0.16,
                    child: Container(
                      child: Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                  width: 1, color: Colors.grey.shade300),
                            ),
                            margin: EdgeInsets.only(top: 35),
                            height: 39,
                            width: 220,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width: 100,
                                  child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                    foregroundColor: logintextcolor,
                                    backgroundColor: couleurLogin,
                                    elevation: 0,
                                    shape: StadiumBorder(),
                                  ),
                                   
                                    onPressed: () {
                                      setState(() {
                                        retourLogin();
                                        if (!valeur) {
                                          logintextcolor = Colors.white;
                                          registertextcolor = Colors.red;
                                          couleurLogin = Colors.red;
                                          couleurRegister =
                                              Colors.grey.shade200;
                                        }
                                      });
                                    },
                                    child: Text("Log in"),
                                  ),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Container(
                                  width: 100,
                                  child: ElevatedButton(
                                     style: ElevatedButton.styleFrom(
                                    foregroundColor: registertextcolor,
                                    backgroundColor: couleurRegister,
                                    elevation: 0,
                                    shape: StadiumBorder(),
                                  ),
                                    // color: couleurRegister,
                                    // hoverElevation: 20,
                                    // elevation: 0,
                                    // textColor: registertextcolor,
                                    // shape: StadiumBorder(),
                                    onPressed: () {
                                      setState(() {
                                        retourResiter();

                                        if (valeur) {
                                          logintextcolor = Colors.red;
                                          registertextcolor = Colors.white;
                                          couleurRegister = Colors.red;
                                          couleurLogin = Colors.grey.shade200;
                                        }
                                      });
                                    },
                                    child: Text("Sign up"),
                                  ),
                                )
                              ],
                            ),
                          ),
                          !valeur ? Login() : Register(),
                        ],
                      ),
                      margin: EdgeInsets.symmetric(horizontal: 30.0),
                      height: size.height * 0.6,
                      decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(40),
                          boxShadow: [
                            BoxShadow(
                              offset: Offset(0, 10),
                              blurRadius: 20,
                              color: Colors.grey.shade600,
                            ),
                          ]),
                    ),
                  ),
                  // the last image buildding
                  SizedBox(
                    height: 200,
                  ),
                  Positioned(
                    top: size.height - size.height / 6,
                    left: size.width - size.width / 2.5,
                    right: -size.width * 0.30,
                    bottom: -size.height * 0.001,
                    child: InkWell(
                      onDoubleTap: () {
                        print("clicker");
                        var route = MaterialPageRoute(
                            builder: (BuildContext context) => AdminAcceuil());

                        Navigator.of(context).push(route);
                      },
                      child: Container(
                        width: size.width / 3,
                        height: size.height / 6,
                        decoration: BoxDecoration(
                            // color: Colors.black,
                            //color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(100),
                              // topRight: Radius.circular(80),
                            ),
                            image: DecorationImage(
                                image: AssetImage("images/tomatesalade.png"),
                                fit: BoxFit.cover),
                            boxShadow: [
                              BoxShadow(
                                offset: Offset(0, 10),
                                blurRadius: 20,
                                spreadRadius: -20,
                                color: Color.fromARGB(255, 244, 120, 120),
                              ),
                            ]),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      // floatingActionButton: FloatingActionButton.extended(
      //   onPressed: () {
      //     var route = MaterialPageRoute(
      //         builder: (BuildContext context) => AdminAcceuil());

      //     Navigator.of(context).push(route);
      //   },
      //   label: Text("Admin!"),
      //   icon: Icon(Icons.account_box),
      //   tooltip: "Admin Usingpanel",
      //   backgroundColor: Color.fromARGB(255, 54, 165, 244),

      //   // shape: Border(top: BorderSide),
      // ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
    );
  }
}

//

// masque button
// Visibility(
//   child: FlatButton(
//       onPressed: () {
//         print("ca marche bien");
//       },
//       child: Text("")),
//   visible: true,
// ),

// cliper class declaration

class DisignCircle extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    // TODO: implement getClip
    var path = Path();
    path.lineTo(0, size.height - 110);
    path.quadraticBezierTo(size.width / 5, size.height - 20,
        size.width - (size.width / 3), size.height - 42);

    path.quadraticBezierTo(
        size.width - 10, size.height - 100, size.width, size.height - 230);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    // TODO: implement shouldReclip
    return true;
  }
}
