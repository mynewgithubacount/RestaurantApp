import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../constantspages/userpagevew.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formkey = GlobalKey<FormState>();

  // String email_usernam = "";
  // String password = "";
// login input variable declaration
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();

  void cleanloginfields() {
    emailcontroller.clear();
    passwordcontroller.clear();
  }

  bool loading = false;
  bool obscure = true;

  // pop up method

  Future<Null> dialog(String title, String desc) async {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return SimpleDialog(
            title: Text(title,
                textScaleFactor: 1.4,
                style: TextStyle(color: Color.fromARGB(255, 229, 50, 22))),
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
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                    primary: Colors.white, // foreground
                    backgroundColor: Colors.green,
                    
                  ),
                      child: Text("Try again"),
                      onPressed: () {
                        Navigator.pop(context);
                      }),
                ],
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 20, right: 20, top: 40),
      child: Form(
        key: _formkey,
        child: Column(
          children: [
            TextFormField(
              decoration: InputDecoration(
                labelText: "Enter email",
                icon: Icon(
                  Icons.mail,
                  color: Colors.red,
                  size: 25,
                ),
              ),
              keyboardType: TextInputType.emailAddress,
              validator: (val) {
                if (val!.length == 0) {
                  return "Please, Enter your mail ";
                }
                if (!RegExp("^[a-zA-Z0-9+_,-]+@[a-zA-Z0-9,-]+.[a-z]")
                    .hasMatch(val)) {
                  return " Please enter a valid email";
                } else {
                  return null;
                }
              },

              onSaved: (val) => setState(() {
                emailcontroller = emailcontroller;
              }),
              // to get user enter email
              controller: emailcontroller,
              autocorrect: true,
              autofocus: false,
            ),
            TextFormField(
              decoration: InputDecoration(
                labelText: "Password",
                icon: Icon(
                  Icons.lock,
                  color: Colors.red,
                  size: 25,
                ),
                suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        obscure = !obscure;
                      });
                    },
                    icon: Icon(
                        obscure ? Icons.visibility_off : Icons.visibility)),
              ),
              keyboardType: TextInputType.text,
              obscureText: obscure,
              autofocus: false,
              // to get the user enter password
              controller: passwordcontroller,
              validator: (val) => (val!.length == 0 || val.length < 6)
                  ? ((val.length == 0
                      ? "Please,enter your password"
                      : val.length < 6
                          ? "Password shoold be long than it"
                          : null))
                  : null,
              onSaved: (val) => setState(() {
                passwordcontroller = passwordcontroller;
              }),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(onPressed: () {}, child: Text("password forgot?")),
              ],
            ),
            Container(
              width: 180,
              child: TextButton(
                onPressed: () {
                  if (_formkey.currentState!.validate()) {
                    FirebaseAuth.instance
                        .signInWithEmailAndPassword(
                            email: emailcontroller.text,
                            password: passwordcontroller.text)
                        .then((value) {
                      cleanloginfields();
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const UserAcceuil()));
                    }).onError((error, stackTrace) {
                      dialog("incorrects enter information!!!!!", "???????");
                    });
                  }
                },
                style: TextButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.red,
                   shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ), 
                ),
                child: Text(
                  "Confirm",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      wordSpacing: 10),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
