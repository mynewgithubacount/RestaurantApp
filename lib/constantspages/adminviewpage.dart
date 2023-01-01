import 'package:flutter/material.dart';
import 'package:restaurantapp/Crudpages/admin_panel.dart';
import '../Crudpages/admin_configuration.dart';
import '../firebase_data/datafrom_firebase.dart';
import '../constantspages/userpagevew.dart';
import '../constantspages/apres_appbar.dart';

class HomepageforUserList extends StatelessWidget {
  const HomepageforUserList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var scaffoldKey = GlobalKey<ScaffoldState>();
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            scaffoldKey.currentState?.openDrawer();
          },
          icon: Icon(Icons.menu, size: 35),
        ),
        title: Text("Your items list"),
        centerTitle: true,
        actions: [
          TextButton.icon(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const ConfigAdmin()));
              },
              icon: Icon(Icons.add_box, size: 35),
              label: Text("New item"),
              style: TextButton.styleFrom(
                foregroundColor: Colors.white,
              ),),
        
        ],
        // bottom: ,
        elevation: 0.0,
        // toolbarHeight: size.height*0.1,
      ),
      // MENU
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
                      MaterialPageRoute(builder: (context) => ConfigAdmin()));
                },
              ),
              ListTile(
                  leading: Icon(Icons.book_rounded),
                  title: const Text('Users mode views'),
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) =>UserHomePage() ));
                  }),
              ListTile(
                  leading: Icon(Icons.calculate),
                  title: const Text('Mon resultat'),
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => ConfigAdmin()));
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
                               Navigator.pop(context);
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
                                        builder: (context) => ContenueDynamic()));
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
          
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Categories",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              color: Colors.white,
              width: double.infinity,
              height: size.height * 0.15,
              child: CategoryAdmin(),
            ),
            Divider(
              indent: 5,
              endIndent: 5,
              thickness: 1,
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 6.0),
              child: Text(
                "The dish",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
                color: Colors.white,
                height: size.height * 0.6,
                width: double.infinity,
                child: DishforAdminview()),
          ],
        ),
      ),
    );
  }
}
