import 'dart:io';

import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multiselect/multiselect.dart';

import '../Crudpages/admin_configuration.dart';

class EditDish extends StatefulWidget {
  @override
  String iddoc;
  Map<String, dynamic> dish;

  EditDish({required this.iddoc, required this.dish});

  @override
  State<EditDish> createState() => _EditDishState(this.iddoc, this.dish);
}

class _EditDishState extends State<EditDish> {
  String iddocedit;
  Map<String, dynamic> dishedit;

  _EditDishState(this.iddocedit, this.dishedit);

  final _nameCrontroller = TextEditingController();
  final priceCrontroller = TextEditingController();
  final totaldishCrontroller = TextEditingController();
  final imageCrontroller = TextEditingController();
  final detailsfoodCrontroller = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // Step 2 <- SEE HERE
    _nameCrontroller.text = dishedit['name'].toString();
    priceCrontroller.text = dishedit['price'].toString();
    totaldishCrontroller.text = dishedit['totaldish'].toString();
    imageCrontroller.text = dishedit['image'];
    detailsfoodCrontroller.text = dishedit['details'];
  }

  void cleanfields() {
    _nameCrontroller.clear();
    priceCrontroller.clear();
    totaldishCrontroller.clear();
    imageCrontroller.clear();
    detailsfoodCrontroller.clear();
  }

  late File? image = null;
  String imageName = "";

  // function to get gallery image

  Future imageSelectorGallery() async {
    try {
      final image = (await ImagePicker().pickImage(
        source: ImageSource.gallery,
      ));
      if (image == null) {
        return;
      }
      final imagepath = File(image.path);
      setState(() {
        this.image = imagepath;
        imageName = image.name.toString();
      });
    } catch (e) {
      print("Failled to pick image: $e");
    }
  }

  // function to get gallery image
  Future imageSelectorCamera() async {
    try {
      final image = (await ImagePicker().pickImage(
        source: ImageSource.camera,
      ));
      if (image == null) {
        return;
      }
      final imagepath = File(image.path);
      setState(() => this.image = imagepath);
    } catch (e) {
      print("Failled to pick image: $e");
    }
  }

// Edit function by upload food

  List<String> categories = [];
  // Methode to upload image on fire store
  FirebaseFirestore firestoreRef = FirebaseFirestore.instance;
  FirebaseStorage storageRef = FirebaseStorage.instance;
  String collectionName = "foods";

  bool _isLoading = false;

  // function to add dish categories to our data storage and dowload for cloud firestore

  _updateFood() async {
    var uniqueKey = firestoreRef.collection(collectionName).doc(iddocedit);
    String uploadFileName =
        DateTime.now().millisecondsSinceEpoch.toString() + ".jpg";
    Reference reference =
        storageRef.ref().child(collectionName).child(uploadFileName);
    UploadTask uploadTask = reference.putFile(image!);
    uploadTask.snapshotEvents.listen((event) {
      print(event.bytesTransferred.toString() +
          "\t" +
          event.totalBytes.toString());
    });

    await uploadTask.whenComplete(() async {
      var uploadPath = await uploadTask.snapshot.ref.getDownloadURL();

      // Now we will insert record inside Database Recording URL

      if (uploadPath.isNotEmpty) {

        uniqueKey.update({
          
          "category": categories,
          "details": detailsfoodCrontroller.text,
          "name": _nameCrontroller.text,
          "price": int.parse(priceCrontroller.text),
          "totaldish": int.parse(totaldishCrontroller.text),
        }).then((value) => _showMessage("plat modifier avec succes!"));
      } else {
        _showMessage("Something while Uploading Image.");
      }
    });
  }

  _showMessage(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(msg),
      duration: Duration(seconds: 3),
    ));
  }

  final _formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
        appBar: AppBar(
          title: Text("Modification"),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          // controller: controller,
          child: Container(
            padding: EdgeInsets.all(10),
            color: Color.fromARGB(255, 225, 231, 237),
            height: size.height,
            width: double.infinity,
            child: Form(
              key: _formkey,
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(width: 1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ListTile(
                      title: Row(
                        children: [
                          // ElevatedButton(
                          //     onPressed: () {
                          //       print(iddocedit);
                          //     },
                          //     child: Text("voir le contenue")),
                          Text(
                            "Nom: ",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Expanded(
                              child: TextFormField(
                            controller: _nameCrontroller,
                            // initialValue: "dishedit['name']",
                            decoration:
                                InputDecoration(border: InputBorder.none),
                          ))
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  // the price
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(width: 1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ListTile(
                      title: Row(
                        children: [
                          Text(
                            "Price: ",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Expanded(
                              child: TextField(
                            controller: priceCrontroller,
                            keyboardType: TextInputType.number,
                            decoration:
                                InputDecoration(border: InputBorder.none),
                          ))
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  //total food

                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(width: 1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ListTile(
                      title: Row(
                        children: [
                          Text(
                            "Total food: ",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Expanded(
                              child: TextField(
                            controller: totaldishCrontroller,
                            keyboardType: TextInputType.number,
                            decoration:
                                InputDecoration(border: InputBorder.none),
                          ))
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  // foodimage
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(width: 1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ListTile(
                      title: Row(
                        children: [
                          Text(
                            "Food image: ",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Expanded(
                            child: Row(
                              children: [
                                Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      child: Column(
                                        children: [
                                          IconButton(
                                            onPressed: () {
                                              imageSelectorCamera();
                                            },
                                            color: Colors.blue,
                                            icon:
                                                Icon(Icons.camera_alt_rounded),
                                          ),
                                          Text(
                                            "Camera",
                                            style: TextStyle(fontSize: 10),
                                          ),
                                        ],
                                      ),
                                    ),
                                    // gallery button
                                    Container(
                                      child: Column(
                                        children: [
                                          IconButton(
                                            onPressed: () {
                                              imageSelectorGallery();
                                            },
                                            color: Color.fromARGB(
                                                255, 199, 236, 110),
                                            icon: Icon(
                                              Icons.browse_gallery,
                                            ),
                                          ),
                                          Text(
                                            "Gallery",
                                            style: TextStyle(fontSize: 10),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                SizedBox(
                                  height: size.height / 6,
                                  width: size.width * 0.4,
                                  child: image == null
                                      ? Center(
                                          child:
                                              Image.network(dishedit['image']))
                                      : InkWell(
                                          onTap: () {
                                            print(image);
                                            Navigator.of(context).push(
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        ImageSize(
                                                          imagesize:
                                                              image as File,
                                                        )));
                                          },
                                          child: Image.file(image!,
                                              fit: BoxFit.cover)),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  //image box

                  SizedBox(
                    height: 10,
                  ),
                  // comment
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(width: 1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ListTile(
                      title: Row(
                        children: [
                          Text(
                            "Detail food: ",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Expanded(
                              child: TextFormField(
                            controller: detailsfoodCrontroller,
                            // initialValue: "detail edit",
                            maxLines: 3,
                            decoration:
                                InputDecoration(border: InputBorder.none),
                          ))
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 20,),
                  // food category
                  DropDownMultiSelect(
                      options: ["Riz", "Foutou", "Crudité"],
                      selectedValues: categories,
                      onChanged: (List<String> x) {
                        setState(() {
                          categories = x;
                        });
                      },
                      whenEmpty: "Select food category"),

                      SizedBox(height: 20,),
                  //Add button
                  Container(
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size.fromHeight(
                            50,
                          ),
                          textStyle: TextStyle(fontSize: 18),
                        ),
                        onPressed: () {
                          

                          if (_formkey.currentState!.validate()) {
                            // _updateFood();

                           firestoreRef.collection(collectionName).doc(iddocedit).update({
                              
                              "category": categories,
                              "details": detailsfoodCrontroller.text,
                              "name": _nameCrontroller.text,
                              "price": int.parse(priceCrontroller.text),
                              "totaldish": int.parse(totaldishCrontroller.text),
                            });
                          } 
                      
                            // cleanfields();
                            Navigator.pop(context);
                          },
                        
                        child: Text("Confirmer")),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
