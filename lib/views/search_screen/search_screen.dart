import 'package:fitness_99/global/utils/fontsAndSizes.dart';
import 'package:fitness_99/global/widgets/custom_search_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SearchScreenView extends StatelessWidget {
  const SearchScreenView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Search Groups',
                style: TextStyles.sgproBold.f34,
              ),
              const SizedBox(height: 15),
              CustomSearchFeild(),
              SizedBox(height: 15),
              ListTile(
                leading:
                    SvgPicture.asset('assets/images/search_screen/fitness.svg'),
                title: Text(
                  'Hemanth',
                  style: TextStyles.sgproRegular.f18,
                ),
                subtitle: Text(
                  'Stronger today',
                  style: TextStyles.sgproRegular.f18.greyMid,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
