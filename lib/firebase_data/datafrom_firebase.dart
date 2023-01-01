import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'dart:async';

import 'package:restaurantapp/constantspages/transition.dart';

import 'editdish.dart';

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
                child: Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      clipBehavior: Clip.antiAlias,
                      width: 50,
                      height: 50,
                      child: Image.network(
                        categories["image"],
                        fit: BoxFit.cover,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        categories["name"],
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w400),
                      ),
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
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      clipBehavior: Clip.antiAlias,
                      width: 50,
                      height: 50,
                      // width: size.width / 5,
                      // height: size.height * 0.06,
                      child: Image.network(
                        categories["image"],
                        fit: BoxFit.cover,
                      ),
                    ),
                    Text(
                      categories["name"],
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Row(
                      children: [
                        IconButton(
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
                            size: 30,
                          ),
                          style: TextButton.styleFrom(
                            foregroundColor: Colors.red,
                          ),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.edit,
                            color: Color.fromARGB(255, 244, 54, 165),
                            size: 30,
                          ),
                          style: TextButton.styleFrom(
                            foregroundColor: Colors.red,
                          ),
                        ),
                      ],
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
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
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
                            Text(
                              "Prix:  ${dish["price"].toString()} FCFA",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w700),
                            ),
                            Text(
                              "Nombre de plat: ${dish["totaldish"].toString()}",
                              style: TextStyle(
                                  fontWeight: FontWeight.w400, fontSize: 18),
                            ),
                            TextButton.icon(
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
                              style: TextButton.styleFrom(
                                backgroundColor: Colors.grey,
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(10.0))),
                              ),
                            ),
                            Container(
                              width: size.width * 0.32,
                              child: TextButton(
                                onPressed: () {},
                                child: const Text(
                                  "Commander",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                                style: TextButton.styleFrom(
                                  foregroundColor: Colors.white,
                                  backgroundColor: Colors.orange,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20.0))),
                                ),
                              ),
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
    // print(dishn);
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
          appBar: AppBar(
            title: Text(" Details of ${dishn["name"]}"),
            centerTitle: true,
            backgroundColor: Color.fromARGB(255, 252, 126, 117),
            elevation: 0.0,
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
                        label: Text("Prix:  ${dishn["price"].toString()} FCFA"),
                        backgroundColor: Colors.yellow.shade600,
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 40),
                        child: Row(
                          children: [
                            IconButton(
                              onPressed: () {
                                // print(iddocn);
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
                      Text("nombre de plat:",
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
                    "A propos de ${dishn["name"]} :",
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
                    padding: EdgeInsets.all(15),
                    child: TextButton(
                      onPressed: () {},
                      child: const Text(
                        "Commander",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.orange,
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.0))),
                      ),
                    ),
                  ),

                  Container(
                    color: Colors.grey.shade200,
                    // height: size.height * 0.2,
                    padding: EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Commenter le plat",
                                style: TextStyle(
                                    color: Colors.blue,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                              Icon(
                                Icons.comment,
                                color: Colors.blue,
                              )
                            ],
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Color.fromARGB(255, 165, 165, 165),
                          ),
                          child: TextFormField(
                            controller: commentfoodCrontroller,
                            keyboardType: TextInputType.multiline,
                            maxLines: 4,
                            style: TextStyle(color: Colors.white),
                            autofocus: false,
                            autocorrect: true,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.all(20),
                              fillColor: Color.fromARGB(255, 39, 230, 22),
                              hintText: "Entrer votre commentaire...",
                              hintStyle: TextStyle(color: Colors.white),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 1, color: Colors.redAccent),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 12, right: 12, top: 8, bottom: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                          onPressed: () {},
                          child: Text(
                            "Annuler",
                            style: TextStyle(
                                fontSize: 22,
                                color: Color.fromARGB(255, 197, 77, 2)),
                          ),
                        ),
                        TextButton.icon(
                          onPressed: () {},
                          label: Text(
                            "Envoyer",
                            style: TextStyle(
                              fontSize: 23,
                              color: Color.fromARGB(255, 9, 134, 236),
                            ),
                          ),
                          icon: Icon(
                            Icons.send,
                            textDirection: TextDirection.ltr,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ])),
    );
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // first column
                        Container(
                          width: size.width / 3,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                dish["name"],
                                style: TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                              SizedBox(height: 10),
                              SizedBox(
                                width: size.width / 3,
                                height: size.height * 0.13,
                                child: Image.network(
                                  dish["image"],
                                  fit: BoxFit.cover,
                                ),
                              ),
                              SizedBox(height: 10),
                            ],
                          ),
                        ),
                        // seconde column
                        SizedBox(
                          width: 12,
                        ),
                        Container(
                          // color: Colors.black,
                          width: size.width / 3,
                          child: Column(
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
                        ),
                        SizedBox(
                          width: 14,
                        ),
                        Column(
                          children: [
                            TextButton.icon(
                              onPressed: () {
                                _showMessage(
                                    "Voullez-vous vraiment supprimer ce plat?",
                                    document.id);
                                if (confirmation) {
                                  confirmation = true;
                                }
                              },
                              icon: Icon(Icons.delete),
                              label: Text(
                                "Delete",
                                style: TextStyle(fontSize: 17),
                              ),
                              style: TextButton.styleFrom(
                                backgroundColor: Colors.red,
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(15.0))),
                              ),
                            ),
                            TextButton.icon(
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => EditDish(
                                          iddoc: document.id,
                                          dish: document.data()
                                              as Map<String, dynamic>,
                                        )));
                              },
                              icon: Icon(Icons.edit_sharp),
                              label:
                                  Text("Edit", style: TextStyle(fontSize: 17)),
                              style: TextButton.styleFrom(
                                backgroundColor:
                                    Color.fromARGB(255, 233, 62, 119),
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(10.0))),
                              ),
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
                TextButton(
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
                TextButton(
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

