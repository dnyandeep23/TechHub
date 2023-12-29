import 'package:firebase_database/firebase_database.dart';
import 'package:first_app/models/cart.dart';
import 'package:first_app/widgets/themes.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:velocity_x/velocity_x.dart';

import '../core/store.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key, required this.value1});
  final String value1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: context.canvasColor,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: "Cart".text.make(),
        ),
        body: Column(
          children: [
            _CartList().p32().expand(),
            Divider(),
            _CartTotal(
              value1: value1,
            ),
          ],
        ));
  }
}

class _CartTotal extends StatelessWidget {
  const _CartTotal({super.key, required this.value1});
  final String value1;
  @override
  Widget build(BuildContext context) {
    // final _cart = CartModel();
    final CartModel _cart = (VxState.store as MyStore).cart;

    return SizedBox(
      height: 200,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          VxConsumer(
            notifications: {},
            builder: (context, status, _) {
              // Assuming "totalPrice" is a property in the "Cart" class
              return "\$${_cart.totalPrice}"
                  .text
                  .xl5
                  .color(context.theme.colorScheme.secondary)
                  .make();
            },
            mutations: {RemoveMutation},
          ),
          30.widthBox,
          ElevatedButton(
            onPressed: () {
              print(_cart.items[0].id);
              var uuid = Uuid();
              var a = uuid.v1();

              if (_cart.items.length != 0) {
                FirebaseDatabase.instance.ref('users/$value1/order/$a').update({
                  'order_id': a,
                  'customer_name': value1,
                  'status': 'Un-Paid',
                });

                _cart.items.forEach((element) {
                  FirebaseDatabase.instance
                      .ref('users/$value1/order/$a/items/${element.id}')
                      .update({
                    'name': element.name,
                    'desc': element.desc,
                    'price': element.price,
                    'id': element.id,
                    'image': element.image,
                    'color': element.color
                  });
                });

                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: "Buying not supported yet... ".text.white.make()));
              } else {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: "Please select item first... ".text.white.make()));
              }
            },
            style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all(context.theme.highlightColor)),
            child: "Buy".text.white.make(),
          ).w32(context),
        ],
      ),
    );
  }
}

class _CartList extends StatelessWidget {
  // final _cart = CartModel();
  @override
  Widget build(BuildContext context) {
    VxState.watch(context, on: [RemoveMutation]);
    final CartModel _cart = (VxState.store as MyStore).cart;

    return _cart.items.isEmpty
        ? "Your Cart is an Empty".text.xl3.makeCentered()
        : ListView.builder(
            itemCount: _cart.items?.length,
            itemBuilder: (context, index) => ListTile(
                  leading: Icon(Icons.done),
                  trailing: IconButton(
                    icon: Icon(Icons.remove_circle_outline),
                    onPressed: () {
                      // _cart.remove(_cart.items[index]);

                      RemoveMutation(_cart.items[index]);
                    },
                  ),
                  title: _cart.items[index].name.text.make(),
                ));
  }
}
