import 'package:firebase_database/firebase_database.dart';
import 'package:first_app/widgets/home_widgets/add_to_cart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:velocity_x/velocity_x.dart';

import '../models/catelog.dart';
// import '../widgets/themes.dart';

class HomeDetailPage extends StatefulWidget {
  final Item catalog;
  final String value1;
  const HomeDetailPage({super.key, required this.catalog, required this.value1})
      : assert(catalog != null);

  @override
  State<HomeDetailPage> createState() =>
      _HomeDetailPageState(catalog: catalog, value1: value1);
}

class _HomeDetailPageState extends State<HomeDetailPage> {
  bool click = false; // Remove dots from the key
  final Item catalog;
  final String value1;
  _HomeDetailPageState({required this.catalog, required this.value1});
  // late SharedPreferences prefs = prefs;
  @override
  void initState() {
    super.initState();
    loadLocalStore();
  }

  Future<void> loadLocalStore() async {
    // Obtain shared preferences.
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final bool a = prefs.getBool(catalog.id.toString()) ?? false;
    setState(() {
      click = a;
    });

    // Now prefs is initialized and can be used.
  }

  // Obtain shared preferences.
  void handleclick() async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    // if (prefs != null) {
    if (click) {
      FirebaseDatabase.instance
          .ref()
          .child('users')
          .child(value1)
          .child('wishlist')
          .child('${catalog.id}')
          .update({
        'name': catalog.name,
        'desc': catalog.desc,
        'price': catalog.price,
        'id': catalog.id,
        'image': catalog.image,
        'color': catalog.color
      });

      prefs.setBool(catalog.id.toString(), true);
    } else {
      FirebaseDatabase.instance
          .ref()
          .child('users')
          .child(value1)
          .child('wishlist')
          .child('${catalog.id}')
          .remove();

      prefs.setBool(catalog.id.toString(), false);
    }
    // }
  }

  @override
  Widget build(BuildContext context) {
    final dummytext =
        "Lorem ipsum dolor sit amet. Enim facilisis nisl rhoncus mattis. Ac tincidunt vitae semper quis lectus nulla at. Velit dignissim quam adipiscing vitae proin sagittis nisl rhoncus mattis. Suspendisse ultrices gravida dictum";

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      backgroundColor: context.canvasColor,
      bottomNavigationBar: Container(
        color: context.cardColor,
        child: ButtonBar(
          alignment: MainAxisAlignment.spaceBetween,
          buttonPadding: EdgeInsets.zero,
          children: [
            "\$ ${widget.catalog.price}".text.bold.xl4.red800.make(),
            AddToCart(widget.catalog).wh(120, 50)
          ],
        ).p32(),
      ),
      body: SafeArea(
          bottom: false,
          child: Stack(children: [
            Positioned(
                top: 0,
                right: 20,
                child: InkWell(
                  onTap: () {
                    setState(() {
                      click = !click;
                      handleclick();
                    });
                  },
                  child: Icon(
                    CupertinoIcons.heart_circle,
                    size: 40,
                    color: click ? Colors.red : Colors.black54,
                  ),
                )),
            Column(
              children: [
                Hero(
                        tag: Key(widget.catalog.id.toString()),
                        child: Image.network(widget.catalog.image))
                    .h32(context),
                Expanded(
                    child: VxArc(
                        height: 30.0,
                        edge: VxEdge.top,
                        arcType: VxArcType.convey,
                        child: Container(
                            color: context.cardColor,
                            width: context.screenWidth,
                            child: Column(
                              children: [
                                widget.catalog.name.text.xl4.bold
                                    .color(context.theme.colorScheme.secondary)
                                    .make(),
                                widget.catalog.desc.text.xl
                                    .textStyle(context.captionStyle)
                                    .make(),
                                10.heightBox,
                                dummytext.text
                                    .textStyle(context.captionStyle)
                                    .make()
                                    .p16(),
                              ],
                            ).py64())))
              ],
            ),
          ])),
    );
  }
}
