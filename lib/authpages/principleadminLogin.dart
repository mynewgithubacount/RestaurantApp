import 'package:flutter/material.dart';
import '../constantspages/adminviewpage.dart';

class AdminP_login extends StatefulWidget {
  const AdminP_login({Key? key}) : super(key: key);

  @override
  State<AdminP_login> createState() => _AdminP_loginState();
}

TextEditingController codecontroller = TextEditingController();

class _AdminP_loginState extends State<AdminP_login> {
  final _formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    TextEditingController admincode = TextEditingController();
    Size size = MediaQuery.of(context).size;
    return Form(
      key: _formkey,
      child: Container(
        color: Color.fromARGB(255, 243, 234, 233),
        margin: EdgeInsets.symmetric(horizontal: 20),
        height: size.height * 0.1,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: size.width / 2,
              child: TextFormField(
                obscureText: true,
                validator: (value) =>
                    value!.length == 0 ? "veillez entrer code d'acces!" : null,
                decoration: InputDecoration(
                  focusColor: Colors.white,
                  prefixIconColor: Colors.white,
                  fillColor: Color.fromARGB(255, 19, 19, 19),
                  prefixIcon: Icon(
                    Icons.lock_open,
                    size: 40,
                  ),
                  hintText: "your code",
                  hintStyle: TextStyle(fontSize: 20),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(width: 5),
                    borderRadius: BorderRadius.circular(40),
                  ),
                ),
                controller: codecontroller,
              ),
            ),
            TextButton(
                onPressed: () {
                  if (_formkey.currentState!.validate() &&
                      codecontroller.text == "pourmoi") {
                    var route = MaterialPageRoute(
                        builder: (BuildContext context) =>
                            HomepageforUserList());

                    Navigator.of(context).push(route);
                    codecontroller.clear();
                  }
                },
                child: Text(
                  "NEXT",
                  style: TextStyle(
                      fontFamily: "Impact",
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                      color: Color.fromARGB(255, 7, 58, 227)),
                )),
          ],
        ),
      ),
    );
  }
}
