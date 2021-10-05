import 'package:fitness_99/global/widgets/custom_product_list.dart';
import 'package:flutter/material.dart';

class ListProductsView extends StatelessWidget {
  const ListProductsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      children: [
        CustomProductList(
          title: 'Protien Powder',
          subtitle: 'Lets science protien power',
          imgName: 'protien_powder.jpg',
        ),
        CustomProductList(
          title: 'Protien Powder',
          subtitle: 'Lets science protien power',
          imgName: 'protien_powder.jpg',
        ),
        CustomProductList(
          title: 'Protien Powder',
          subtitle: 'Lets science protien power',
          imgName: 'protien_powder.jpg',
        ),
        CustomProductList(
          title: 'Protien Powder',
          subtitle: 'Lets science protien power',
          imgName: 'protien_powder.jpg',
        ),
        CustomProductList(
          title: 'Protien Powder',
          subtitle: 'Lets science protien power',
          imgName: 'protien_powder.jpg',
        ),
        CustomProductList(
          title: 'Protien Powder',
          subtitle: 'Lets science protien power',
          imgName: 'protien_powder.jpg',
        ),
        CustomProductList(
          title: 'Protien Powder',
          subtitle: 'Lets science protien power',
          imgName: 'protien_powder.jpg',
        ),
        CustomProductList(
          title: 'Protien Powder',
          subtitle: 'Lets science protien power',
          imgName: 'protien_powder.jpg',
        ),
      ],
    );
  }
}
