import 'package:flutter/material.dart';
import 'package:food_delivery/home/food_page_body.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:food_delivery/widgets/big_text.dart';
import 'package:food_delivery/widgets/small_text.dart';

class MainFoodPage extends StatefulWidget {
  const MainFoodPage({Key? key}) : super(key: key);

  @override
  State<MainFoodPage> createState() => _MainFoodPageState();
}

class _MainFoodPageState extends State<MainFoodPage> {
  @override
  Widget build(BuildContext context) {
    print("current height is " + MediaQuery.of(context).size.height.toString());
    return Scaffold(
        body: Column(
      children: [
        //showing the header
        Container(
          child: Container(
            margin: EdgeInsets.only(top: 45, bottom: 15),
            padding: EdgeInsets.only(left: 20, right: 20),
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
                    width: 45,
                    height: 45,
                    child: Icon(
                      Icons.search,
                      color: Colors.white,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: AppColors.mainColor,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        //showing the body
        FoodPageBody(),
      ],
    ));
  }
}
