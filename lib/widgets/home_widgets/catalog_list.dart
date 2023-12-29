import 'package:first_app/models/cart.dart';
import 'package:first_app/pages/home_detail_page.dart';
import 'package:first_app/widgets/home_widgets/catalog_image.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import '../../models/catelog.dart';
import '../themes.dart';
import 'add_to_cart.dart';

class CatalogList extends StatelessWidget {
  const CatalogList({super.key, required this.value1});
  final String value1;

  @override
  Widget build(BuildContext context) {
    return !context.isMobile
        ? GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, crossAxisSpacing: 20),
            shrinkWrap: true,
            itemCount: CatalogModel.items.length,
            itemBuilder: (context, index) {
              final catalog = CatalogModel.items[index];
              return InkWell(
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => HomeDetailPage(
                                catalog: catalog,
                                value1: value1,
                              ))),
                  child: CatalogItem(
                    catalog: catalog,
                    value1: value1,
                  ));
            })
        : ListView.builder(
            shrinkWrap: true,
            itemCount: CatalogModel.items.length,
            itemBuilder: (context, index) {
              final catalog = CatalogModel.items[index];
              return InkWell(
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => HomeDetailPage(
                              catalog: catalog, value1: value1))),
                  child: CatalogItem(
                    catalog: catalog,
                    value1: value1,
                  ));
            });
  }
}

class CatalogItem extends StatelessWidget {
  final Item catalog;
  final String value1;
  const CatalogItem({super.key, required this.catalog, required this.value1})
      : assert(catalog != null);

  @override
  Widget build(BuildContext context) {
    var children2 = [
      Hero(
          tag: Key(catalog.id.toString()),
          child: CatalogImage(image: catalog.image)),
      Expanded(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          catalog.name.text.lg.bold.color(MyTheme.darkBluishColor).make(),
          catalog.desc.text.textStyle(context.captionStyle).make(),
          10.heightBox,
          ButtonBar(
            alignment: MainAxisAlignment.spaceBetween,
            buttonPadding: EdgeInsets.zero,
            children: [
              "\$${catalog.price}".text.bold.xl.make(),
              AddToCart(catalog)
            ],
          ).pOnly(right: 8.0)
        ],
      ).p(context.isMobile ? 0 : 16))
    ];
    return VxBox(
            child: context.isMobile
                ? Row(
                    children: children2,
                  )
                : Column(children: children2))
        .color(context.cardColor)
        .rounded
        .square(150)
        .make()
        .py16();
  }
}
