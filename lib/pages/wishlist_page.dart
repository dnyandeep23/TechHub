import 'package:firebase_database/firebase_database.dart';
import 'package:first_app/models/catelog.dart';
import 'package:first_app/widgets/drawer.dart';
import 'package:first_app/widgets/home_widgets/catalog_list.dart';

import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class Wishlist extends StatefulWidget {
  const Wishlist({super.key, required this.value1});
  final String value1;

  @override
  State<Wishlist> createState() => _WishlistState(value1: value1);
}

class _WishlistState extends State<Wishlist> {
  _WishlistState({required this.value1});
  final String value1;
  void initState() {
    super.initState();
    CatalogModel.items = List.empty();
    loadData();
  }

  loadData() async {
    print("entered");
    final List<Item> items = [];
    final ref = FirebaseDatabase.instance.ref();
    final event =
        await ref.child('users/$value1/wishlist').once(DatabaseEventType.value);

    final data = event.snapshot.value;
    print(data);

// Ensure that data is a non-null Map<String, dynamic> or handle the case where it's not
    if (data != null) {
      print("Data is not null");
      print("Type of data: ${data.runtimeType}");

      // Ensure that data is a list
      if (data is List<Object?>) {
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
      } else if (data is Map<Object?, Object?>) {
        Map<Object, Object> mappedData = Map.fromEntries(
          data.entries.map((entry) => MapEntry<Object, Object>(
              entry.key as Object, entry.value as Object)),
        );
        print(mappedData);
        // Map<Object, Object> d = mappedData.isNotEmpty ? mappedData.first : {};
        mappedData.forEach((key, value) {
          Object d = value;
          Map<Object?, Object?> da = d as Map<Object?, Object?>;
          print(da['image']);
          //  Map<Object, Object> d2 = da as Map<Object, Object>;

          // Convert the data to Item and add it to the items list
          items.add(Item.fromMap(Map<String, dynamic>.from(da)));
          CatalogModel.items = items;
          print(CatalogModel.items);
          print('ok');
        });
        // print(a['image']);

        // ignore: unused_local_variable
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
    return Scaffold(
      backgroundColor: context.cardColor,
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              Container(
                alignment: Alignment.centerLeft,
                child: "Wishlist"
                    .text
                    .xl5
                    .bold
                    .color(context.theme.colorScheme.secondary)
                    .make(),
              ),
              if (CatalogModel.items != null && CatalogModel.items.isNotEmpty)
                CatalogList(
                  value1: value1,
                ).py16().expand()
              else
                Column(
                  children: [
                    SizedBox(
                      height: 140,
                    ),
                    Image.asset('assets/images/empty-wishlist.png'),
                    SizedBox(height: 40),
                    "Your Wishlist is an empty !!!"
                        .text
                        .lg
                        .bold
                        .color(context.theme.colorScheme.secondary)
                        .make(),
                  ],
                )
            ],
          ),
        ),
      ),
      drawer: MyDrawer(value1: value1),
    );
  }
}
