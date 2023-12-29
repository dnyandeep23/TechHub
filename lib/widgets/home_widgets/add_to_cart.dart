import 'package:first_app/core/store.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../models/cart.dart';
import '../../models/catelog.dart';

class AddToCart extends StatelessWidget {
  final Item catalog;
  AddToCart(this.catalog, {super.key});

  // bool isInCart = false;
  // final _cart = CartModel();
  @override
  Widget build(BuildContext context) {

    VxState.watch(context, on: [AddMutation,RemoveMutation]);
    final CartModel _cart = (VxState.store as MyStore).cart;
    // final CatalogModel _catalog = (VxState.store as MyStore).catalog;
    bool isInCart = _cart.items.contains(catalog) ?? false;

    return ElevatedButton(onPressed: (){
      if(!isInCart){
        // isInCart = isInCart.toggle();
        // final _catalog = CatalogModel();
        // final _cart = CartModel();
        // _cart.catalog = _catalog;
        // _cart.add(catalog);
        AddMutation(catalog);
      }else{
        RemoveMutation(catalog);
      }

    },

      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(context.theme.highlightColor),
          shape: MaterialStateProperty.all(StadiumBorder())
      ),
      child: isInCart ? Icon(Icons.done) : Icon(Icons.add_shopping_cart_outlined)
    );
  }
}
