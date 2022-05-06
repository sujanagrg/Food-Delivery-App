import 'package:flutter/material.dart';
import 'package:food_delivery/utils/Dimensions.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:food_delivery/widgets/big_text.dart';
import 'package:food_delivery/widgets/small_text.dart';

import 'food_page_body.dart';

class MainFoodPage extends StatefulWidget {
  const MainFoodPage({Key? key}) : super(key: key);

  @override
  State<MainFoodPage> createState() => _MainFoodPageState();
}

class _MainFoodPageState extends State<MainFoodPage> {
  @override
  Widget build(BuildContext context) {
    // print("current height is " + MediaQuery.of(context).size.height.toString());// Show the height of the current device.
    // print("current width is " + MediaQuery.of(context).size.width.toString());//This shows the width of the current device.
    return Scaffold(
        body: Column(
      children: [
        //showing the header
        Container(
          child: Container(
            margin: EdgeInsets.only(
                top: Dimensions.height45, bottom: Dimensions.height15),
            padding: EdgeInsets.only(
                left: Dimensions.width20, right: Dimensions.width20),
            child: Row(
              //There are two parts in this row i.e. 'the country and the city' and another being the 'search icon'
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  //Using column to line up the 'country' and 'city' one after another
                  children: [
                    BigText(
                      text: 'Nepal', //country name
                      color: AppColors.mainColor,
                      size: 30,
                    ),
                    Row(
                      //wrapping the 'city' and 'dropdown button' in a row
                      children: [
                        SmallText(
                          text: 'Pokhara', //city name
                          color: Colors.black54,
                        ),
                        Icon(Icons.arrow_drop_down_rounded)
                      ],
                    )
                  ],
                ),
                Center(
                  child: Container(
                    //This container is for the 'Search icon' located at top right corner
                    width: Dimensions.width45,
                    height: Dimensions.height45,
                    child: Icon(
                      Icons.search,
                      color: Colors.white,
                      size: Dimensions
                          .iconSize24, //In flutter the default size of the icon is 24
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Dimensions.radius15),
                      color: AppColors.mainColor,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        //showing the body
        Expanded(child: SingleChildScrollView(
          child: FoodPageBody(),
        ))
      ],
    ));
  }
}
