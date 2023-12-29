import 'package:first_app/pages/home_page.dart';
import 'package:first_app/pages/order_page.dart';
import 'package:first_app/pages/wishlist_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  MyDrawer({super.key, required this.value1});
  final String value1;
  @override
  Widget build(BuildContext context) {
    final imageUrl =
        "https://purepng.com/public/uploads/medium/purepng.com-user-iconsymbolsiconsapple-iosiosios-8-iconsios-8-721522596134f28yc.png";
    return Drawer(
        child: Container(
      color: Colors.deepPurple,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
              padding: EdgeInsets.zero,
              child: UserAccountsDrawerHeader(
                margin: EdgeInsets.zero,
                accountName: Text(
                  "DNY",
                  style: TextStyle(color: Colors.white),
                ),
                accountEmail: Text(
                  "SomeOne@gmail.com",
                  style: TextStyle(color: Colors.white),
                ),
                decoration: BoxDecoration(color: Colors.deepPurple),
                currentAccountPicture: CircleAvatar(
                  backgroundImage: NetworkImage(imageUrl),
                ),
              )),
          InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomePage(value1: value1),
                  ));
            },
            child: ListTile(
                leading: Icon(
                  CupertinoIcons.home,
                  color: Colors.white,
                ),
                title: Text("Home",
                    textScaleFactor: 1.2,
                    style: TextStyle(color: Colors.white))),
          ),
          InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Wishlist(value1: value1),
                  ));
            },
            child: ListTile(
                leading: Icon(
                  CupertinoIcons.heart,
                  color: Colors.white,
                ),
                title: Text("Wishlist",
                    textScaleFactor: 1.2,
                    style: TextStyle(color: Colors.white))),
          ),
          InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Order(value1: value1),
                  ));
            },
            child: ListTile(
                leading: Icon(
                  CupertinoIcons.bag,
                  color: Colors.white,
                ),
                title: Text("My Orders",
                    textScaleFactor: 1.2,
                    style: TextStyle(color: Colors.white))),
          ),
          ListTile(
              leading: Icon(
                CupertinoIcons.profile_circled,
                color: Colors.white,
              ),
              title: Text("Profile",
                  textScaleFactor: 1.2, style: TextStyle(color: Colors.white))),
          ListTile(
              leading: Icon(
                CupertinoIcons.mail,
                color: Colors.white,
              ),
              title: Text("Email me",
                  textScaleFactor: 1.2, style: TextStyle(color: Colors.white))),
        ],
      ),
    ));
  }
}
