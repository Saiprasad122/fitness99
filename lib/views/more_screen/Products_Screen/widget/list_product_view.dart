import 'package:flutter/material.dart';
import 'custom_product_list.dart';

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
          onTap: () {},
        ),
        CustomProductList(
          title: 'Protien Powder',
          subtitle: 'Lets science protien power',
          imgName: 'protien_powder.jpg',
          onTap: () {},
        ),
        CustomProductList(
          title: 'Protien Powder',
          subtitle: 'Lets science protien power',
          imgName: 'protien_powder.jpg',
          onTap: () {},
        ),
        CustomProductList(
          title: 'Protien Powder',
          subtitle: 'Lets science protien power',
          imgName: 'protien_powder.jpg',
          onTap: () {},
        ),
        CustomProductList(
          title: 'Protien Powder',
          subtitle: 'Lets science protien power',
          imgName: 'protien_powder.jpg',
          onTap: () {},
        ),
        CustomProductList(
          title: 'Protien Powder',
          subtitle: 'Lets science protien power',
          imgName: 'protien_powder.jpg',
          onTap: () {},
        ),
        CustomProductList(
          title: 'Protien Powder',
          subtitle: 'Lets science protien power',
          imgName: 'protien_powder.jpg',
          onTap: () {},
        ),
        CustomProductList(
          title: 'Protien Powder',
          subtitle: 'Lets science protien power',
          imgName: 'protien_powder.jpg',
          onTap: () {},
        ),
      ],
    );
  }
}
