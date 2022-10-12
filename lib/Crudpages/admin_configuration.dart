import 'dart:io';
import 'dart:ui';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multiselect/multiselect.dart';
import 'package:restaurantapp/constantspages/transition.dart';
import '../constantspages/adminviewpage.dart';
//import 'package:path_provider/path_provider.dart';

class ConfigAdmin extends StatefulWidget {
  const ConfigAdmin({Key? key}) : super(key: key);

  @override
  State<ConfigAdmin> createState() => _ConfigAdminState();
}

class _ConfigAdminState extends State<ConfigAdmin> {
// navigation bar list

  int selectedIndex = 0;

  Widget _myContacts = Addfood();
  Widget _myEmails = AddCategory();
  Widget _myProfile = UserOrders();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text("config your items"),
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const HomepageforUserList()));
            },
            icon: Icon(Icons.close)),
        centerTitle: true,
      ),
      body: getBody(),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: this.selectedIndex,
        backgroundColor: Color.fromARGB(255, 182, 200, 204),
        selectedIconTheme:
            IconThemeData(color: Colors.red, opacity: 1.0, size: 45),
        unselectedIconTheme:
            IconThemeData(color: Colors.black45, opacity: 1.0, size: 25),
        selectedLabelStyle:
            TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
        unselectedLabelStyle:
            TextStyle(fontStyle: FontStyle.normal, fontSize: 18),
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.add,
            ),
            label: "Add food",

            // title: Text("Contacts"),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.add,
            ),
            label: "Add category",

            // title: Text("Emails"),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.food_bank_rounded,
            ),
            label: "users orders",
            // title: Text("Profile"),
          ),
        ],
        onTap: (int index) {
          onTapHandler(index);
        },
      ),
    );
  }

  Widget getBody() {
    if (selectedIndex == 0) {
      return _myContacts;
    } else if (selectedIndex == 1) {
      return _myEmails;
    } else {
      return _myProfile;
    }
  }

  void onTapHandler(int index) {
    setState(() {
      selectedIndex = index;
    });
  }
}

class Addfood extends StatefulWidget {
  const Addfood({Key? key}) : super(key: key);

  @override
  State<Addfood> createState() => _AddfoodState();
}

class _AddfoodState extends State<Addfood> {
  // food variable confiuration getting
  final nameCrontroller = TextEditingController();
  final priceCrontroller = TextEditingController();
  final totaldishCrontroller = TextEditingController();
  final imageCrontroller = TextEditingController();
  final detailsfoodCrontroller = TextEditingController();
  final int like = 0;

  // ignore: prefer_typing_uninitialized_variables

// food controller cleaner

  void cleanfields() {
    nameCrontroller.clear();
    priceCrontroller.clear();
    totaldishCrontroller.clear();
    imageCrontroller.clear();
    detailsfoodCrontroller.clear();
  }

  //

  // gallery image fille variable
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

    List<String> categories = [];
  // Methode to upload image on fire store
  FirebaseFirestore firestoreRef = FirebaseFirestore.instance;
  FirebaseStorage storageRef = FirebaseStorage.instance;
  String collectionName = "foods";

  bool _isLoading = false;

  // function to add dish categories to our data storage and dowload for cloud firestore

  _uploadFood() async {
    var uniqueKey = firestoreRef.collection(collectionName).doc();
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
        firestoreRef.collection(collectionName).doc(uniqueKey.id).set({
          "image": uploadPath,
          "like": like,
          "category": categories,
          "details": detailsfoodCrontroller.text,
          "name": nameCrontroller.text,
          "price": int.parse(priceCrontroller.text),
          "totaldish": int.parse(totaldishCrontroller.text),
        }).then((value) => _showMessage("plat ajouté avec succes!"));
      } else {
        _showMessage("Something while Uploading Image.");
      }
    });
  }

  // snackbarmessage

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

    return Container(
      padding: EdgeInsets.all(10),
      color: Color.fromARGB(255, 225, 231, 237),
      height: size.height,
      width: double.infinity,
      child: SingleChildScrollView(
        child: Form(
          key: _formkey,
          child: Column(
            children: [
              Text(
                "Enter data to configurate food for your customers!",
                style: TextStyle(
                    fontSize: 20, color: Color.fromARGB(255, 5, 4, 4)),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(width: 1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ListTile(
                  title: Row(
                    children: [
                      Text(
                        "Nom: ",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Expanded(
                          child: TextField(
                        controller: nameCrontroller,
                        decoration: InputDecoration(border: InputBorder.none),
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
                        decoration: InputDecoration(border: InputBorder.none),
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
                        decoration: InputDecoration(border: InputBorder.none),
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  child: Column(
                                    children: [
                                      IconButton(
                                        onPressed: () {
                                          imageSelectorCamera();
                                        },
                                        color: Colors.blue,
                                        icon: Icon(Icons.camera_alt_rounded),
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
                                        color:
                                            Color.fromARGB(255, 199, 236, 110),
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
                                      child: new Text(
                                      'Sorry nothing selected!!',
                                      style: TextStyle(fontSize: 12),
                                    ))
                                  : InkWell(
                                      onTap: () {
                                        print(image);
                                        Navigator.of(context)
                                            .push(MaterialPageRoute(
                                                builder: (context) => ImageSize(
                                                      imagesize: image as File,
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
                          child: TextField(
                        controller: detailsfoodCrontroller,
                        maxLines: 3,
                        decoration: InputDecoration(border: InputBorder.none),
                      ))
                    ],
                  ),
                ),
              ),

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
                      // FirebaseFirestore.instance.collection("foods").add({
                      //   "category": categories,
                      //   "details": detailsfoodCrontroller.text,
                      //   "image": imageCrontroller.value.text,
                      //   "name": nameCrontroller.text,
                      //   "price": int.parse(priceCrontroller.text),
                      //   "totaldish": int.parse(totaldishCrontroller.text),
                      // });

                     // print(image);

                      if (_formkey.currentState!.validate()) {
                        _uploadFood();
                       // cleanfields();
                       Navigator.pop(context);
                      }
                    },
                    child: Text("Add Food")),
              ),
              SizedBox(
                height: 5,
              ),
              //
              // the cancel button

              Container(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size.fromHeight(
                      40,
                    ),
                    primary: Colors.red,
                    textStyle: TextStyle(fontSize: 18),
                  ),
                  onPressed: () {
                    cleanfields();
                    Navigator.pop(context);
                  },
                  child: Text(
                    "Cancel",
                  ),
                ),
              ),

              // for the image file
            ],
          ),
        ),
      ),
    );
  }
}

// category adding page configuration
class AddCategory extends StatefulWidget {
  @override
  State<AddCategory> createState() => _AddCategoryState();
}

class _AddCategoryState extends State<AddCategory> {
  final namecategoryCrontroller = TextEditingController();
  final imagecategoryCrontroller = TextEditingController();

  // dialoge mesage function

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
              RaisedButton(
                  color: Colors.grey,
                  textColor: Colors.red,
                  child: Text("OK"),
                  onPressed: () {
                    Navigator.pop(context);
                  })
            ],
          );
        });
  }

// category field cleaner
  void cleanfieldscategory() {
    namecategoryCrontroller.clear();
    imagecategoryCrontroller.clear();
  }

  // gallery image fille variable
  late File? categoryimage = null;
  String imageName = "";

  // function to get gallery image

  Future imageSelectorGallery() async {
    try {
      final categoryimage = (await ImagePicker().pickImage(
        source: ImageSource.gallery,
      ));
      if (categoryimage == null) {
        return;
      }
      final imagepath = File(categoryimage.path);
      setState(() {
        this.categoryimage = imagepath;
        imageName = categoryimage.name.toString();
      });
    } catch (e) {
      print("Failled to pick image: $e");
    }
  }

  // function to get gallery image
  Future imageSelectorCamera() async {
    try {
      final categoryimage = (await ImagePicker().pickImage(
        source: ImageSource.camera,
      ));
      if (categoryimage == null) {
        return;
      }
      final imagepath = File(categoryimage.path);
      setState(() {
        this.categoryimage = imagepath;
        imageName = categoryimage.name.toString();
      });
    } catch (e) {
      print("Failled to pick image: $e");
    }
  }

  // Methode to upload image on fire store
  FirebaseFirestore firestoreRef = FirebaseFirestore.instance;
  FirebaseStorage storageRef = FirebaseStorage.instance;
  String collectionName = "Categories";

  bool _isLoading = false;

  // function to add dish categories to our data storage and dowload for cloud firestore

  _uploadCategoriesFood() async {
    var uniqueKey = firestoreRef.collection(collectionName).doc();
    String uploadFileName =
        DateTime.now().millisecondsSinceEpoch.toString() + ".jpg";
    Reference reference =
        storageRef.ref().child(collectionName).child(uploadFileName);
    UploadTask uploadTask = reference.putFile(categoryimage!);
    uploadTask.snapshotEvents.listen((event) {
      print(event.bytesTransferred.toString() +
          "\t" +
          event.totalBytes.toString());
    });

    await uploadTask.whenComplete(() async {
      var uploadPath = await uploadTask.snapshot.ref.getDownloadURL();

      // Now we will insert record inside Database Recording URL

      if (uploadPath.isNotEmpty) {
        firestoreRef.collection(collectionName).doc(uniqueKey.id).set({
          "image": uploadPath,
          "name": namecategoryCrontroller.text,
        }).then((value) => _showMessage("Record Inserted"));
      } else {
        _showMessage("Something while Uploading Image.");
      }
    });
  }

  // snackbarmessage

  _showMessage(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(msg),
      duration: Duration(seconds: 3),
    ));
  }

// form key declaration
  final _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
        padding: EdgeInsets.all(10),
        color: Color.fromARGB(255, 235, 237, 240),
        height: size.height,
        width: double.infinity,
        child: Column(children: [
          Text(
            "Enter data to configurate food categories for your customers!",
            style:
                TextStyle(fontSize: 20, color: Color.fromARGB(255, 84, 46, 46)),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 20,
          ),
          // category form verification
          Form(
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
                          Text(
                            "Name: ",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Expanded(
                              child: TextFormField(
                            validator: (value) => value!.isEmpty
                                ? "Please Enter category name"
                                : null,
                            onSaved: (val) => setState(() {
                              val = namecategoryCrontroller.text;
                            }),
                            controller: namecategoryCrontroller,
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
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(width: 1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ListTile(
                      title: Row(
                        children: [
                          Text(
                            "Image: ",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            width: 10,
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
                                  width: size.width * 0.45,
                                  child: categoryimage == null
                                      ? Center(
                                          child: new Text(
                                          'Sorry nothing selected!!',
                                          style: TextStyle(fontSize: 12),
                                        ))
                                      : InkWell(
                                          onTap: () {
                                            print(categoryimage);
                                            print(imageName);
                                            Navigator.of(context).push(
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        ImageSize(
                                                          imagesize:
                                                              categoryimage
                                                                  as File,
                                                        )));
                                          },
                                          child: Image.file(categoryimage!,
                                              fit: BoxFit.cover)),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  // category add button
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size.fromHeight(
                          50,
                        ),
                        textStyle: TextStyle(fontSize: 20),
                      ),
                      onPressed: () {
                        print(categoryimage);
                        if (_formkey.currentState!.validate()) {
                          // FirebaseFirestore.instance
                          //     .collection("Categories")
                          //     .add({
                          //   "image": categoryimage.toString(),
                          //   "name": namecategoryCrontroller.text,
                          // });
                          _uploadCategoriesFood();

                          //dialog("categorie de plats",
                          //    "Ajout effectué avec succes!");
                          // cleanfieldscategory();
                          Navigator.pop(context);
                        }
                      },
                      child: Text("Add Category")),
                  SizedBox(
                    height: 10,
                  ),
                  // category cancel button

                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size.fromHeight(
                        40,
                      ),
                      primary: Colors.red,
                      textStyle: TextStyle(fontSize: 20),
                    ),
                    onPressed: () {
                      // if (_formkey.currentState!.validate()) {
                      //   Navigator.pop(context);
                      // }
                      cleanfieldscategory();
                    },
                    child: Text(
                      "Cancel",
                    ),
                  ),
                ],
              )),
        ]));
  }
}

class UserOrders extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text("commandes"));
  }
}

// to view the image on her big form

class ImageSize extends StatelessWidget {
  File imagesize;
  ImageSize({required this.imagesize});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text("Food Image"),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: Container(
          child: Center(
              child: Image.file(
        imagesize,
        fit: BoxFit.cover,
        width: size.width,
        height: size.height,
      ))),
    );
  }
}
