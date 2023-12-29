import 'package:flutter/cupertino.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../widgets/themes.dart';

class CatalogImage extends StatelessWidget {
  final String image;


  CatalogImage({super.key, required this.image});

  @override
  Widget build(BuildContext context) {

      // External URL, use Image.network
      return Padding(
        padding: EdgeInsets.all(2),
        child: Image.network(
          image,

        )
            .box
            .rounded
            .color(context.canvasColor)
            .make()
            .p12()
            .wPCT(context: context, widthPCT: context.isMobile? 40:20)
            .h40(context),
      );


  }
}
