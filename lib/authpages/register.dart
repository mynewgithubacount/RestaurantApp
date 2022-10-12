import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../constantspages/apres_appbar.dart';
import '../authpages/login.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  TextEditingController usernamecontroller = TextEditingController();
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  TextEditingController passwordvalidatecontroller = TextEditingController();

  void cleansignupfields() {
    usernamecontroller.clear();
    emailcontroller.clear();
    passwordcontroller.clear();
    passwordvalidatecontroller.clear();
  }

  final _formkey = GlobalKey<FormState>();
  // to build the pop up message

  Future<Null> dialog(String title, String desc) async {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return SimpleDialog(
            title: Text(title,
                textScaleFactor: 1.4,
                style: TextStyle(color: Color.fromARGB(255, 32, 204, 17))),
            contentPadding: EdgeInsets.all(10.0),
            children: [
              Text(
                desc,
                style: TextStyle(fontStyle: FontStyle.normal, fontSize: 20),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  RaisedButton(
                      color: Colors.green,
                      textColor: Colors.white,
                      child: Text("YES"),
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const ContenueDynamic()));
                      }),
                  RaisedButton(
                      color: Colors.grey,
                      textColor: Colors.red,
                      child: Text("NO"),
                      onPressed: () {
                        Navigator.pop(context);
                      })
                ],
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 20, right: 20),
      child: Form(
        key: _formkey,
        child: Column(
          children: [
            // TextFormField(
            //   decoration: InputDecoration(
            //     labelText: "UserName",
            //     icon: Icon(
            //       Icons.person,
            //       color: Colors.red,
            //       size: 25,
            //     ),
            //   ),
            //   // to get user username
            //   controller: usernamecontroller,
            //   validator: (val) =>
            //       val!.isEmpty ? "Please, enter a userName" : null,
            //   onChanged: (val) => usernamecontroller = usernamecontroller,
            // ),
            //
            TextFormField(
              decoration: InputDecoration(
                labelText: "Email",
                icon: Icon(
                  Icons.mail,
                  color: Colors.red,
                  size: 25,
                ),
              ),
              // to get user email
              controller: emailcontroller,
              keyboardType: TextInputType.emailAddress,

              validator: (val) =>
                  val!.isEmpty ? "Please, enter your mail" : null,
              onChanged: (val) => emailcontroller = emailcontroller,
            ),
            //
            TextFormField(
              decoration: InputDecoration(
                labelText: "Password",
                icon: Icon(
                  Icons.lock_open,
                  color: Colors.red,
                  size: 25,
                ),
              ),
              // to get user password
              controller: passwordcontroller,

              validator: (val) => val!.length < 6
                  ? "Please, enter a password >= 6 symbols, "
                  : null,
              onChanged: (val) => passwordcontroller = passwordcontroller,
            ),
            //
            TextFormField(
              decoration: InputDecoration(
                labelText: "Confirm Password",
                icon: Icon(
                  Icons.lock,
                  color: Colors.red,
                  size: 25,
                ),
              ),
              controller: passwordvalidatecontroller,
              validator: (val) =>
                  passwordvalidatecontroller.text != passwordcontroller.text
                      ? "Incorrect password"
                      : null,
              onChanged: (val) =>
                  passwordvalidatecontroller = passwordvalidatecontroller,
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              width: 180,
              child: FlatButton(
                onPressed: () {
                  if (_formkey.currentState!.validate()) {
                    FirebaseAuth.instance
                        .createUserWithEmailAndPassword(
                            email: emailcontroller.text,
                            password: passwordcontroller.text)
                        .then((value) {
                      cleansignupfields();
                      print("Created New Account");
                      dialog("Count created successfully!!",
                          "Do you want to log in now?");

                      // Navigator.of(context).push(MaterialPageRoute(
                      //     builder: (context) => const UserAcceuil()));
                    }).onError((error, stackTrace) {
                      print("Error ${error.toString()}");
                    });
                  }
                },
                color: Colors.red,
                textColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Text(
                  "Validate",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      wordSpacing: 10),
                ),
              ),
            ),
            Text("or"),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                    color: Colors.blue[500],
                    iconSize: 30,
                    onPressed: () {},
                    icon: Icon(
                      Icons.facebook,
                    )),
                IconButton(
                    color: Colors.blue[500],
                    iconSize: 30,
                    onPressed: () {},
                    icon: Icon(
                      MdiIcons.twitter,
                    )),
                IconButton(
                  iconSize: 30,
                  color: Colors.blue[500],
                  icon: new Icon(
                    MdiIcons.googlePlus,
                  ),
                  onPressed: () {},
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
