import 'package:flutter/material.dart';
import 'package:restaurantapp/Crudpages/admin_panel.dart';
import '../firebase_data/datafrom_firebase.dart';
import '../main.dart';
import '../constantspages/background.dart';
import '../constantspages/adminviewpage.dart';

class UserHomePage extends StatelessWidget {
  const UserHomePage({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Restaurant App',
      // theme: ThemeData(
      //   primarySwatch: Colors.,
      // ),
      home: const UserAcceuil(),
    );
  }
}

class UserAcceuil extends StatefulWidget {
  const UserAcceuil({Key? key}) : super(key: key);

  @override
  State<UserAcceuil> createState() => _UserAcceuilState();
}

class _UserAcceuilState extends State<UserAcceuil> {
  @override
  Widget build(BuildContext context) {
    var scaffoldKey = GlobalKey<ScaffoldState>();
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text("you're welcome!"),

        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 239, 11, 11),
        foregroundColor: Colors.black,
        elevation: 0.0,
        // elevation: 0.0,
        leading: IconButton(
          onPressed: () {
            scaffoldKey.currentState?.openDrawer();
          },
          icon: Icon(
            Icons.menu,
            size: 40,
            color: Color.fromARGB(255, 255, 255, 255),
          ),
        ),
        actions: [
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.settings,
                size: 32,
                color: Colors.grey.shade800,
              )),
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.account_circle,
              size: 45,
              color: Color.fromARGB(255, 255, 255, 255),
            ),
          ),
          SizedBox(
              width: 6,

              )
        ],
      ),
      // user drawer menu
      drawer: Container(
        child: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              const DrawerHeader(
                decoration: BoxDecoration(
                  color: Color(0xff3B3086),
                ),
                child: Icon(
                  Icons.account_circle,
                  color: Colors.white,
                  size: 100,
                ),
              ),
              ListTile(
                leading: Icon(Icons.home),
                title: const Text('Home'),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => UserAcceuil()));
                },
              ),
              ListTile(
                  leading: Icon(Icons.book_rounded),
                  title: const Text('Admin mode'),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => HomepageforUserList()));
                  }),
              ListTile(
                  leading: Icon(Icons.calculate),
                  title: const Text('Mon resultat'),
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => UserAcceuil()));
                  }),
              ListTile(
                leading: Icon(Icons.offline_bolt_rounded),
                title: const Text('Deconnexion'),
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        content: Text('Voulez vous vraiment vous deconnectez?'),
                        actions: [
                          new TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => UserAcceuil()));
                              },
                              child: Text(
                                'Non',
                                style: TextStyle(
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                          new TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => UserAcceuil()));
                              },
                              child: Text(
                                'Oui',
                                style: TextStyle(
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          )
                        ],
                      );
                    },
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.car_rental_rounded),
                title: const Text('Localisation de mon centre'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.settings),
                title: const Text('Parametres'),
                onTap: () {
                  Navigator.pop(context);
                },
              )
            ],
          ),
        ),
      ),

      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            // the expanded
            Container(
              child: Column(
                children: [
                  // text container widget
                  Container(
                    alignment: Alignment.topLeft,
                    padding: EdgeInsets.only(left: 10, top: 20),
                    // this column is for the text container
                    child: Column(
                      children: [
                        Text(
                          "Choose the",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              fontSize: 20, fontStyle: FontStyle.italic),
                        ),
                        Text(
                          "food you love",
                          style: TextStyle(
                              fontSize: 25,
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ), //end text container column
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  // second container
                  Container(
                    padding: EdgeInsets.only(
                      left: 20,
                      right: 20,
                    ),
                    width: size.width / 1.3,
                    height: size.height * 0.06,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(width: 0),
                        boxShadow: [
                          BoxShadow(
                            offset: Offset(1, 5),
                            blurRadius: 30,
                            color: Colors.grey.shade600,
                          ),
                        ],
                        borderRadius: BorderRadius.circular(40)),
                    child: TextField(
                      decoration: InputDecoration(
                        labelText: "Search your food",
                        labelStyle: TextStyle(fontSize: 18),
                        border: InputBorder.none,
                        suffixIcon: IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.search, size: 30),
                        ),
                        suffixIconColor: Colors.grey.shade700,
                      ),
                    ),
                  ),
                ],
              ),
              width: double.infinity,
              height: size.height * 0.26,
              decoration: BoxDecoration(
                // image: DecorationImage(
                //   image: AssetImage("images/restorant/télécharger (2).jpeg"),
                //   fit: BoxFit.fill,
                // ),

                gradient: getusercolor(),
              ),
            ),

            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.only(left: 20),
                  child: Text("Categories",
                      style: TextStyle(
                        fontSize: 22,
                        color: Colors.red.shade700,
                      )),
                ),
              ],
            ),

            // to get liste of category from firebase
            Container(
              color: Color.fromARGB(255, 245, 243, 243),
              height: size.height * 0.18,
              width: double.infinity,
              child: Category(),
            ),

            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.only(left: 20),
                  child: Text(
                    "Dish list",
                    style: TextStyle(
                        fontSize: 20, color: Color.fromARGB(255, 209, 27, 27)),
                    textAlign: TextAlign.left,
                  ),
                ),
              ],
            ),

            Container(
              color: Color.fromARGB(255, 255, 255, 255),
              height: size.height - (size.height * 0.19 + size.height * 0.2),
              width: double.infinity,
              child: DishlistforUser(),
              //DishlistforUser()
            ),
            //Color.fromARGB(255, 223, 162, 162)
          ],
        ),
      ),
    );
  }
}
