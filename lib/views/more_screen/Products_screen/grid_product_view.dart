import 'package:fitness_99/global/widgets/custom_product_grid.dart';
import 'package:flutter/material.dart';

class GridProductsView extends StatelessWidget {
  const GridProductsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      crossAxisCount: 2,
      children: [
        CustomProductGrid(
          title: 'Protien Powder',
          subtitle: 'Lets science protien powder',
          imgName: 'protien_powder.jpg',
          onTap: () {},
        ),
        CustomProductGrid(
          title: 'Protien Powder',
          subtitle: 'Lets science protien powder',
          imgName: 'protien_powder.jpg',
          onTap: () {},
        ),
        CustomProductGrid(
          title: 'Protien Powder',
          subtitle: 'Lets science protien powder',
          imgName: 'protien_powder.jpg',
          onTap: () {},
        ),
        CustomProductGrid(
          title: 'Protien Powder',
          subtitle: 'Lets science protien powder',
          imgName: 'protien_powder.jpg',
          onTap: () {},
        ),
        CustomProductGrid(
          title: 'Protien Powder',
          subtitle: 'Lets science protien powder',
          imgName: 'protien_powder.jpg',
          onTap: () {},
        ),
        CustomProductGrid(
          title: 'Protien Powder',
          subtitle: 'Lets science protien powder',
          imgName: 'protien_powder.jpg',
          onTap: () {},
        ),
        CustomProductGrid(
          title: 'Protien Powder',
          subtitle: 'Lets science protien powder',
          imgName: 'protien_powder.jpg',
          onTap: () {},
        ),
        CustomProductGrid(
          title: 'Protien Powder',
          subtitle: 'Lets science protien powder',
          imgName: 'protien_powder.jpg',
          onTap: () {},
        ),
      ],
    );
  }
}
