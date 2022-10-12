import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'dart:async';

import 'package:restaurantapp/constantspages/transition.dart';

class Category extends StatefulWidget {
  const Category({Key? key}) : super(key: key);

  @override
  State<Category> createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  final Stream<QuerySnapshot> categoryStream =
      FirebaseFirestore.instance.collection("Categories").snapshots();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return StreamBuilder<QuerySnapshot>(
        stream: categoryStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text("Something went wrong");
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text("Loading");
          }
          return ListView(
            scrollDirection: Axis.horizontal,
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              Map<String, dynamic> categories =
                  document.data()! as Map<String, dynamic>;
              return Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    SizedBox(
                      width: size.width / 3,
                      height: size.height * 0.1,
                      child: Image.network(
                        categories["image"],
                        fit: BoxFit.cover,
                      ),
                    ),
                    Text(
                      categories["name"],
                      style: TextStyle(fontSize: 20),
                    ),
                  ],
                ),
              );
            }).toList(),
          );
        });
  }
}

// get category for admin

class CategoryAdmin extends StatefulWidget {
  const CategoryAdmin({Key? key}) : super(key: key);

  @override
  State<CategoryAdmin> createState() => _CategoryAdminState();
}

class _CategoryAdminState extends State<CategoryAdmin> {
  final Stream<QuerySnapshot> categoryStream =
      FirebaseFirestore.instance.collection("Categories").snapshots();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return StreamBuilder<QuerySnapshot>(
        stream: categoryStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text("Something went wrong");
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text("Loading");
          }
          return ListView(
            scrollDirection: Axis.horizontal,
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              Map<String, dynamic> categories =
                  document.data()! as Map<String, dynamic>;
              return Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                child: Column(
                  children: [
                    SizedBox(
                      width: size.width / 3,
                      height: size.height * 0.1,
                      child: Image.network(
                        categories["image"],
                        fit: BoxFit.cover,
                      ),
                    ),
                    Text(
                      categories["name"],
                      style: TextStyle(fontSize: 20),
                    ),
                    FlatButton.icon(
                      onPressed: () {
                        var i;
                        for (i in categories.values) {
                          print(i);
                        }
                        FirebaseFirestore.instance
                            .collection("Categories")
                            .doc(document.id)
                            .delete();
                      },
                      icon: Icon(
                        Icons.delete,
                        color: Colors.red,
                      ),
                      label: Text("Delete"),
                    ),
                  ],
                ),
              );
            }).toList(),
          );
        });
  }
}

// get the of dish for user

class DishlistforUser extends StatefulWidget {
  const DishlistforUser({Key? key}) : super(key: key);

  @override
  State<DishlistforUser> createState() => _DishlistforUserState();
}

class _DishlistforUserState extends State<DishlistforUser> {
  late Map<String, dynamic> dish;
  late String idDoc;

  final Stream<QuerySnapshot> userdishStream =
      FirebaseFirestore.instance.collection("foods").snapshots();

  void showdetails(String docID) {
    try {
      FirebaseFirestore.instance.collection("foods").doc(docID);
      final Stream<QuerySnapshot> streem =
          FirebaseFirestore.instance.collection("foods").snapshots();
      // Navigator.of(context).push(MaterialPageRoute(
      //     builder: (context) => DishlistdetailsforUser(
      //           // docID,
      //           // detailstraim: streem,
      //           // id: docID,
      //         )));
    } catch (e) {
      print("eurro");
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return StreamBuilder<QuerySnapshot>(
        stream: userdishStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text("Something went wrong");
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text("Loading");
          }
          return ListView(
            scrollDirection: Axis.vertical,
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              dish = document.data()! as Map<String, dynamic>;
              // print(document.reference.path);
              idDoc = document.reference.path;
              // FirebaseFirestore.instance
              //     .collection('foods')
              //     .doc(document.reference.path)
              //     .get();
              return Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  // global colunm dish
                  children: [
                    Row(
                      children: [
                        // first column
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              dish["name"],
                              style: TextStyle(
                                fontSize: 18,
                              ),
                            ),
                            SizedBox(height: 10),
                            InkWell(
                              onTap: () {
                                // print("taper");
                                // print(document.id);
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) =>
                                        DishlistdetailsforUser(
                                          iddoc: document.id,
                                          dish: document.data()
                                              as Map<String, dynamic>,
                                        )));
                              },
                              child: SizedBox(
                                width: size.width / 2,
                                height: 120,
                                child: Image.network(
                                  dish["image"],
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            SizedBox(height: 10),
                          ],
                        ),
                        // seconde column
                        SizedBox(
                          width: 20,
                        ),
                        Column(
                          children: [
                            Container(
                              width: size.width * 0.37,
                              child: FlatButton(
                                onPressed: () {},
                                child: Text(
                                  "Command",
                                  style: TextStyle(color: Colors.white),
                                ),
                                color: Colors.green.shade400,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(20.0))),
                              ),
                            ),
                            Chip(
                              label: Text(
                                  "Price:  ${dish["price"].toString()} FCFA"),
                              backgroundColor:
                                  Color.fromARGB(255, 236, 225, 172),
                            ),
                            SizedBox(height: 5),
                            Text(
                                "number of dish: ${dish["totaldish"].toString()}"),
                            FlatButton.icon(
                              onPressed: () {
                                // print(dish);
                                print(document.id);
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) =>
                                        DishlistdetailsforUser(
                                          iddoc: document.id,
                                          dish: document.data()
                                              as Map<String, dynamic>,
                                        )));
                              },
                              icon: Icon(Icons.breakfast_dining),
                              label: Text("more details"),
                              color: Color.fromARGB(255, 175, 177, 175),
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.0))),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Divider(
                      height: 10,
                      thickness: 3,
                      color: Colors.black12,
                      indent: 5,
                      endIndent: 5,
                    )
                  ],
                ),
              );
            }).toList(),
          );
        });
  }
}

// get user dish details in statefull

class DishlistdetailsforUser extends StatefulWidget {
  @override
  String iddoc;
  Map<String, dynamic> dish;
  // final Stream<QuerySnapshot> detailstraim;

  DishlistdetailsforUser({required this.dish, required this.iddoc});

  State<DishlistdetailsforUser> createState() =>
      _DishlistdetailsforUserState(this.iddoc, this.dish);
}

class _DishlistdetailsforUserState extends State<DishlistdetailsforUser> {
  final commentfoodCrontroller = TextEditingController();

  void addlike(String docID, int likes) {
    var newlike = likes + 1;
    try {
      FirebaseFirestore.instance.collection("foods").doc(docID).update({
        "like": newlike,
      }).then((value) => print("donnée a jour"));
      setState(() {
        dishn["like"];
      });
    } catch (e) {
      print(e.toString());
    }
  }

  String iddocn;
  Map<String, dynamic> dishn;
  // final Stream<QuerySnapshot> detailstraim;

  _DishlistdetailsforUserState(this.iddocn, this.dishn);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    print(dishn);
    return Scaffold(
        appBar: AppBar(
          title: Text(" Details of ${dishn["name"]}"),
          centerTitle: true,
        ),
        body: ListView(scrollDirection: Axis.vertical, children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              // global colunm dish
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      dishn["name"],
                      style: TextStyle(
                        fontSize: 30,
                        color: Colors.red,
                      ),
                    ),
                    SizedBox(height: 10),
                    SizedBox(
                      width: double.infinity,
                      height: size.height / 3,
                      child: Image.network(
                        dishn["image"],
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(height: 10),
                  ],
                ),
                // seconde column
                SizedBox(
                  width: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Chip(
                      label: Text("Price:  ${dishn["price"].toString()} FCFA"),
                      backgroundColor: Colors.yellow.shade600,
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 40),
                      child: Column(
                        children: [
                          IconButton(
                            onPressed: () {
                              print(iddocn);
                              addlike(iddocn, dishn["like"]);
                            },
                            icon: Icon(
                              Icons.favorite,
                              color: Colors.pink,
                              size: 25,
                            ),
                          ),
                          Text(
                            "Like: ${dishn["like"].toString()}",
                            style: TextStyle(
                                fontSize: 20,
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 10),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("number of dish:",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)),
                    Text(
                      " ${dishn["totaldish"].toString()}",
                      style: TextStyle(
                          fontSize: 25,
                          color: Colors.red,
                          fontFamily: "Impact"),
                    ),
                  ],
                ),
                Divider(
                  height: 20,
                  indent: 27,
                  thickness: 2,
                  endIndent: 27,
                ),
                Text(
                  "About ${dishn["name"]} specificity :",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                      fontFamilyFallback: ["Impact", "Time New Romain"],
                      color: Colors.blue.shade600),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  dishn["details"],
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
                Divider(
                  height: 20,
                  indent: 27,
                  thickness: 2,
                  endIndent: 27,
                ),

                Container(
                  width: size.width / 2,
                  child: FlatButton(
                    onPressed: () {},
                    child: Text(
                      "Command",
                      style: TextStyle(color: Colors.white),
                    ),
                    color: Colors.green.shade400,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20.0))),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(width: 1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ListTile(
                    title: Row(
                      children: [
                        Text("Comment this food: "),
                        Expanded(
                            child: TextField(
                          controller: commentfoodCrontroller,
                          maxLines: 4,
                          decoration: InputDecoration(border: InputBorder.none),
                        )),
                        SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    FlatButton.icon(
                      onPressed: () {},
                      label: Text(
                        "Send",
                        style: TextStyle(fontSize: 23),
                      ),
                      textColor: Color.fromARGB(255, 9, 114, 185),
                      icon: Icon(
                        Icons.send,
                        textDirection: TextDirection.ltr,
                      ),
                    ),
                    FlatButton(
                      onPressed: () {},
                      child: Text(
                        "Cancel",
                        style: TextStyle(fontSize: 22),
                      ),
                      textColor: Color.fromARGB(255, 197, 77, 2),
                    ),
                  ],
                ),
              ],
            ),
          )
        ]));
  }
}

class DishforAdminview extends StatefulWidget {
  const DishforAdminview({Key? key}) : super(key: key);

  @override
  State<DishforAdminview> createState() => _DishforAdminviewState();
}

class _DishforAdminviewState extends State<DishforAdminview> {
  final Stream<QuerySnapshot> categoryStream =
      FirebaseFirestore.instance.collection("foods").snapshots();
//the snackbar view

  bool confirmation = false;

  late int duree = 10;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return StreamBuilder<QuerySnapshot>(
        stream: categoryStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text("Something went wrong");
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text("Loading...");
          }
          return ListView(
            scrollDirection: Axis.vertical,
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              Map<String, dynamic> dish =
                  document.data()! as Map<String, dynamic>;
              return Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  // global colunm dish
                  children: [
                    Row(
                      children: [
                        // first column
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              dish["name"],
                              style: TextStyle(
                                fontSize: 18,
                              ),
                            ),
                            SizedBox(height: 10),
                            SizedBox(
                              width: size.width / 2,
                              height: size.height * 0.2,
                              child: Image.network(
                                dish["image"],
                                fit: BoxFit.cover,
                              ),
                            ),
                            SizedBox(height: 10),
                          ],
                        ),
                        // seconde column
                        SizedBox(
                          width: 20,
                        ),
                        Column(
                          children: [
                            Chip(
                              label: Text(
                                  "Price:  ${dish["price"].toString()} FCFA"),
                              backgroundColor: Colors.yellow.shade600,
                            ),
                            SizedBox(height: 10),
                            Text(
                                "number of dish: ${dish["totaldish"].toString()}"),
                          ],
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        FlatButton.icon(
                          onPressed: () {
                            _showMessage(
                                "Voullez-vous vraiment supprimer ce plat?",
                                document.id);
                            if (confirmation) {
                              confirmation = true;
                            }
                          },
                          icon: Icon(Icons.delete),
                          label: Text("Delete"),
                          color: Colors.red,
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15.0))),
                        ),
                        FlatButton.icon(
                          onPressed: () {},
                          icon: Icon(Icons.update),
                          label: Text("Update"),
                          color: Colors.yellow.shade200,
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0))),
                        ),
                      ],
                    ),
                    Divider(
                      height: 10,
                      thickness: 3,
                      color: Colors.black12,
                      indent: 5,
                      endIndent: 5,
                    )
                  ],
                ),
              );
            }).toList(),
          );
        });
  }

  // function to change the snackbar duration

  int dureUpdate(int valeur) {
    duree = valeur;
    return duree;
  }

  _showMessage(String msg, String docId) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      elevation: 20.0,
      backgroundColor: Color.fromARGB(255, 0, 0, 0),
      content: Container(
        height: 70,
        child: Column(
          children: [
            Text(msg),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                FlatButton(
                    onPressed: () {
                      setState(() {
                        dureUpdate(1);
                      });
                      print(duree);

                      // Navigator.pop(context);
                    },
                    child: Text(
                      "Non",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 255, 177, 171)),
                    )),
                FlatButton(
                    onPressed: () {
                      FirebaseFirestore.instance
                          .collection("foods")
                          .doc(docId)
                          .delete();
                      setState(() {
                        dureUpdate(2);
                      });
                    },
                    child: Text("Oui",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 154, 243, 255)))),
              ],
            )
          ],
        ),
      ),
      duration: Duration(seconds: duree),
    ));
  }
}

// methode2
// get the of dish list for user by other methode

class UserFoodList extends StatefulWidget {
  const UserFoodList({Key? key}) : super(key: key);

  @override
  State<UserFoodList> createState() => _UserFoodListState();
}

class _UserFoodListState extends State<UserFoodList> {
  Future getFoods() async {
    var firestore = FirebaseStorage.instance;
    QuerySnapshot qn =
        await FirebaseFirestore.instance.collection("foods").get();
    return qn.docs;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: FutureBuilder(
      future: getFoods(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: Text("Laoding..."),
          );
        } else {
          return ListView.builder(
              itemCount: (snapshot.data as QuerySnapshot).docs.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text(
                      (snapshot.data! as QuerySnapshot).docs[index]['name']),
                  subtitle: Text(
                      (snapshot.data! as QuerySnapshot).docs[index]['image']),
                );
              });
        }
      },
    ));
  }
}

// get the of dish details for user by other methode

class UserFoodDetails extends StatefulWidget {
  const UserFoodDetails({Key? key}) : super(key: key);

  @override
  State<UserFoodDetails> createState() => _UserFoodDetailsState();
}

class _UserFoodDetailsState extends State<UserFoodDetails> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}


/////////////  another methode to get data from firestore
///
///
///

