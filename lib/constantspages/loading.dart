import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatefulWidget {
  const Loading({ Key? key }) : super(key: key);

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       resizeToAvoidBottomInset: false,
      body: Padding(padding: EdgeInsets.symmetric(vertical: 100, horizontal: 100.0),
      child: Column(
        children: [
          Image.asset("images/pakistani food.jpeg",height: 200.0, width: 200.0,),
          SizedBox(height: 10.0,),
          SpinKitChasingDots(
            color: Colors.red,
            size: 50,
          )
        ],
      ),),
      
    );
  }
}
