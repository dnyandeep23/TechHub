// ignore_for_file: avoid_print

import 'package:firebase_database/firebase_database.dart';
import 'package:first_app/core/store.dart';
import 'package:first_app/models/cart.dart';
import 'package:first_app/pages/cart_page.dart';
import "package:first_app/widgets/drawer.dart";
import "package:first_app/widgets/themes.dart";
import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";
import 'package:first_app/models/catelog.dart';
import "package:flutter/services.dart";
import 'dart:convert';
import 'package:velocity_x/velocity_x.dart';
import 'package:http/http.dart' as http;

import '../utils/routes.dart';
import "../widgets/item_widget.dart";
import '../widgets/home_widgets/catalog_header.dart';
import '../widgets/home_widgets/catalog_list.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.value1});
  final String value1;
  @override
  State<HomePage> createState() => _HomePageState(value1: value1);
}

class _HomePageState extends State<HomePage> {
  _HomePageState({required this.value1});
  final String value1;
  int days = 2;
  String name = "Dnyan";
  final url = "https://api.jsonbin.io/v3/b/64c139ec8e4aa6225ec4f105";
  // Map<String, String> headers = {
  //   'User-Agent': '\$2b\$10\$6TKJ8ByLeU.J7LSEnOGRm.i9/6FVNdcUQRbNrPsGOmfxs80e9UPwS',  // Replace with your desired user-agent header
  //   'Authorization': 'Bearer \$2b\$10\$fpmZY7ZNKM0DbM6fEWASQ.WvHNlaeUk2qIb6SRzaPxzpgbhfKehS.',  // Replace with any authorization header you need
  //   // Add other headers as needed
  // };

  void initState() {
    super.initState();
    loadData();
  }

  loadData() async {
    print("entered");

    final ref = FirebaseDatabase.instance.ref();
    final event = await ref.child('products').once(DatabaseEventType.value);

    final data = event.snapshot.value;
    print(data);

// Ensure that data is a non-null Map<String, dynamic> or handle the case where it's not
    if (data != null) {
      print("Data is not null");
      print("Type of data: ${data.runtimeType}");

      // Ensure that data is a list
      if (data is List<Object?>) {
        final List<Item> items = [];

        for (var element in data) {
          // print(element);
          // Check if the element is a Map
          if (element is Map<Object?, Object?>) {
            // Check if the required keys are present in the map
            if (element.containsKey('id') &&
                element.containsKey('name') &&
                element.containsKey('price') &&
                element.containsKey('image') &&
                element.containsKey('desc') &&
                element.containsKey('color')) {
              print("ee");
              print(element);
              // Check the types of the values
              if (element['id'] is int && element['price'] is int) {
                items.add(Item.fromMap(Map<String, dynamic>.from(element)));
              } else {
                print("Invalid data types for element: $element");
                // Handle the case where the data types are incorrect
              }
            } else {
              print("Incomplete data format for element: $element");
              // Handle the case where the map is missing required keys
            }
          } else {
            print("Invalid data format for element: $element");
            // Handle the case where the element is not a Map if needed
          }
        }

        // Now, 'items' is a list of Item objects
        print(items);

        // You can assign 'items' to CatalogModel.items or use it as needed
        CatalogModel.items = items;

        setState(() {});
      } else {
        print("Data is not of type List<Object>");
        // Handle the case where data is not a List if needed
      }
    } else {
      print("Data is null");
      // Handle the case where data is null if needed
    }

// Specify the type or cast 'username' to Map<String, dynamic>

    await Future.delayed(Duration(seconds: 2));

    // final response = await http.get(Uri.parse(url));
    // final catalogJson = response.body;
    // // final catalogJson = await rootBundle.loadString("assets/files/catalog.json");
    // final decodedData = jsonDecode(catalogJson);
    // print(decodedData);
    // final productsData = decodedData["record"]["products"];
    // print(productsData);
    // CatalogModel.items = List.from(username)
    //     .map<Item>((item) => Item.fromMap(item))
    //     .toList();
    // setState(() {});
    // print(productsData);
    // print(products);
  }

  @override
  Widget build(BuildContext context) {
    final _cart = (VxState.store as MyStore).cart;

    return Scaffold(
      backgroundColor:
          context.cardColor, // no vx -- Theme.of(context).cardColor
      floatingActionButton: VxBuilder(
        mutations: const {RemoveMutation, AddMutation},
        builder: (ctx, status, _) => FloatingActionButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => CartPage(value1: value1)));
          },
          backgroundColor: context.theme.highlightColor,
          child: Icon(CupertinoIcons.cart),
        ).badge(
            color: Vx.indigo900,
            size: 22,
            count: _cart.items.length,
            textStyle:
                TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
      ),
      body: SafeArea(
        child: Container(
          padding: Vx.m32,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CatalogHeader(),
              if (CatalogModel.items != null && CatalogModel.items.isNotEmpty)
                CatalogList(
                  value1: value1,
                ).py16().expand()
              else
                CircularProgressIndicator().centered().expand(),
            ],
          ),
        ),
      ),
      drawer: MyDrawer(
        value1: value1,
      ),
    );

    // final dummyList = List.generate(10, (index) => CatalogModel.items[0]);
    // return Scaffold(

    // // appBar: AppBar(
    // //   title: Text('My App',),
    // //   // backgroundColor: Colors.white,
    // //   // elevation: 0.0,
    // //   // iconTheme: IconThemeData(color:Colors.black),
    // //   // titleTextStyle: TextStyle(color:Colors.black),
    // // ),
    // body: Padding(
    //   padding: const EdgeInsets.all(16.0),
    //   // child: (CatalogModel.items != null &&  CatalogModel.items.isNotEmpty) ?ListView.builder(
    //   //   itemCount: CatalogModel.items.length, itemBuilder: ( context, index) {
    //   //     return ItemWidget(item: CatalogModel.items[index],);
    //   // },
    //   // ): Center(
    //   //   child: CircularProgressIndicator(),
    //   // ),
    //   child: (CatalogModel.items != null &&  CatalogModel.items.isNotEmpty) ?
    //       GridView.builder(
    //           gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,
    //           mainAxisSpacing: 16,crossAxisSpacing: 16),
    //           itemBuilder: (context, index) {
    //             final item = CatalogModel.items[index];
    //             return Card(
    //               clipBehavior: Clip.antiAlias,
    //                 shape: RoundedRectangleBorder(
    //                   borderRadius: BorderRadius.circular(10)
    //                 ),
    //                 child: GridTile(
    //                     header: Container(
    //                         child: Text(item.name , style: TextStyle(color: Colors.white),),
    //                       padding: EdgeInsets.all(12),
    //                       decoration: BoxDecoration(
    //                         color:Colors.deepPurple
    //                       ),),
    //
    //                     child: Image.network(item.image),
    //                     footer:Container(
    //                       child:  Text("\$ ${item.price.toString()}" , style: TextStyle(color: Colors.white, ),),
    //                       padding: EdgeInsets.all(12),
    //                       decoration: BoxDecoration(
    //                           color:Colors.black
    //                       ),),
    //                 ));
    //           },
    //           itemCount: CatalogModel.items.length,
    //
    //       )
    //       : Center(
    //     child: CircularProgressIndicator(),
    //   ),
    // ),
    // drawer: MyDrawer(),
    // );
  }
}
