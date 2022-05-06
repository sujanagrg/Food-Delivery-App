import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:food_delivery/widgets/big_text.dart';
import 'package:food_delivery/widgets/icon_and_text_widget.dart';
import 'package:food_delivery/widgets/small_text.dart';

import '../../utils/Dimensions.dart';


class FoodPageBody extends StatefulWidget {
  const FoodPageBody({Key? key}) : super(key: key);

  @override
  State<FoodPageBody> createState() => _FoodPageBodyState();
}

class _FoodPageBodyState extends State<FoodPageBody> {
  PageController pageController = PageController(viewportFraction: 0.85);
  //viewportfraction tells you whether the next slide and previous slide should be visible .i.e to which extend must the slides be shown(I hope that makes sense)

  var _currPageValue = 0.0;
  double _scaleFactor = 0.8; //80% of its original size
  double _height = Dimensions.pageViewContainer;
  //now, initialize the page value
  @override
  void initState() {
    //It is a method inside any stateful class that you can use it. But if you want to use it. You have to override it.
    super
        .initState(); //Here we can get the current pageValue. As we go left and right, we can get it.
    //In initState we initialize the necessary things theat the page might need.
    //to do that we need to attach the page Listener to this pageController.
    pageController.addListener(() {
      //Inside of it we can get the current page value.
      setState(() {
        //As soon as we get the new value, we will let the UI know about it to update the screen. So here we use setState
        _currPageValue = pageController
            .page!; //The value we get here is saved to the currPageValue
        // print("Current value is" + _currPageValue.toString()); //This will show the currentPageValue of the pages.
      });
    });
  }

  @override
  void dispose() {
    pageController
        .dispose(); //when we leave the page in general, we dispose them and let the memory management system know that
    //we don't need that value and remove from the memory. In this way we keep the memory as small as possible.
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //slider section one
        Container(
          //  height: 320,
          height: Dimensions.pageView,
          child: PageView.builder(
              //This makes the objects scrollable
              controller: pageController,
              itemCount: 5,
              itemBuilder: (context, position) {
                return _buildPageItem(position);
              }),
        ),
        //Dots
        new DotsIndicator(
          // The dots under the container
          dotsCount: 5,
          position: _currPageValue,
          decorator: DotsDecorator(
            size: const Size.square(9.0),
            activeSize: const Size(18.0, 9.0),
            activeShape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0)),
          ),
        ),
        //Popular text i.e. second section of the page container.
        SizedBox(
          height: Dimensions.height30,
        ),
        Container(
          margin: EdgeInsets.only(left: Dimensions.width30),
          child: Row(
            //Using crossaxisalignment to bring the "." and "Food pairing" in the same bottom line.
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              BigText(text: "Popular"),
              SizedBox(
                width: Dimensions.width10,
              ),
              Container(
                margin: EdgeInsets.only(bottom: 3),
                child: BigText(
                  text: ".",
                  color: Colors.black26,
                ),
              ),
              SizedBox(
                width: Dimensions.width10,
              ),
              Container(
                  margin: EdgeInsets.only(bottom: 2),
                  child: SmallText(text: "Food pairing")),
            ],
          ),
        ),
        //list of food and images below popular text using listviewbuilder
          ListView.builder(
            physics: NeverScrollableScrollPhysics(),//Helps to scroll the Second container with the Popular text and the list of food.
           shrinkWrap: true,//We need to make the shrinkwrap true if we remove the container. If the listviewbuilder is inside the container than the shrinkwrap should be disabled.
              itemCount: 10,
              itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsets.only(
                      left: Dimensions.width20, right: Dimensions.width20, bottom: Dimensions.height10),
                  child: Row(
                    children: [
                      //Image section for the second half of the page below Popular.
                      Container(//This container is for the image below the popular text.
                        width: Dimensions.listViewImageSize,
                        height: Dimensions.listViewImageSize,
                        decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(Dimensions.radius20),
                          color: Colors.white38,
                          image: DecorationImage(
                            fit: BoxFit.cover,
                              image: AssetImage("assets/image/food0.png")),
                        ),
                      ),
                      //Text container
                      Expanded(//Expanded widget will for the container to take all the available space in the container.
                        child: Container(//mention height and width so that it may be visible
                          height: Dimensions.listViewTextContSize,//This container is for the text written beside the Popular image.
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(//This helps us to show which side we want to make visible
                           topRight: Radius.circular(Dimensions.radius20),
                              bottomRight: Radius.circular(Dimensions.radius20),
                            ),
                            color: Colors.white,
                          ),
                          child: Padding(
                            padding: EdgeInsets.only(left: Dimensions.width10, right: Dimensions.width10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                               BigText(text: "Nutritious fruit meal in China"),
                                SizedBox(height: Dimensions.height10,),
                                SmallText(text: "With chinese characteristics"),
                                SizedBox(height: Dimensions.height10,),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }),
      ],
    );
  }

  Widget _buildPageItem(int index) {
    //The actual scaling up and down happens inside this method
    Matrix4 matrix = new Matrix4
        .identity(); //Here we created object from identity Marix4. It has three coordinates x,y and z.
    if (index == _currPageValue.floor()) {
      // This refers to the currrent slide.
      var currScale = 1 -
          (_currPageValue - index) *
              (1 -
                  _scaleFactor); // This equation is only true for the current index.
      var currTrans = _height * (1 - currScale) / 2;

      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else if (index == _currPageValue.floor() + 1) {
      // This condition is for the next slide.
      var currScale = 1 -
          (_currPageValue - index) *
              (1 -
                  _scaleFactor); // This equation is only true for the current index.
      var currTrans = _height * (1 - currScale) / 2;

      matrix = Matrix4.diagonal3Values(1, currScale, 1);
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else if (index == _currPageValue.floor() - 1) {
      // This condition is for the previous slide.
      var currScale =
          _scaleFactor + (_currPageValue - index + 1) * (1 - _scaleFactor);

      var currTrans = _height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1);
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else {
      var currScale = 0.8;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, _height * (1 - _scaleFactor) / 2, 1);
    }
    return Transform(
      transform: matrix, //It takes matrix and pass the matrix
      child: Stack(
        children: [
          Container(
            //   height: 220, //height of the first container. Replacing this value with the dynamic value for the Dimension class.
            height: Dimensions
                .pageViewContainer, //Using the height defined in the class Dimensions
            margin: EdgeInsets.only(
                left: Dimensions.width10,
                right: Dimensions
                    .width10), //helps to create empty space between the two container of different pages while scrolling
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimensions.radius30),
                color: Color(0xFFffd28d),
                // color: index.isEven
                //     ? Color(0xFF89dad0)
                //     : Color(
                //         0xFFffd28d), // The color changes according to the odd and even sequence 0f the index.
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage("assets/image/food0.png"))),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              //    height: 120, // height of Text container
              height: Dimensions.pageViewTextContainer,
              margin: EdgeInsets.only(
                  left: Dimensions.width30,
                  right: Dimensions.width30,
                  bottom: Dimensions.height30),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(Dimensions.radius30),
                  boxShadow: [
                    BoxShadow(
                        color: Color(0xFFe8e8e8),
                        blurRadius: 5.0,
                        offset: Offset(0, 5)),
                    BoxShadow(
                      color: Colors.white,
                      offset: Offset(-5, 0),
                    ),
                    BoxShadow(
                      color: Colors.white,
                      offset: Offset(5, 0),
                    ),
                  ]),
              child: Container(
                padding: EdgeInsets.only(
                    top: Dimensions.height15, left: 15, right: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BigText(text: 'Chinese Side'),
                    SizedBox(
                      height: Dimensions.height10,
                    ),
                    Row(
                      children: [
                        Wrap(
                          //We use wrap widget to draw the same thing again and again horizontally.
                          children: List.generate(
                              5, //Here we are generating 5 stars
                              (index) => Icon(
                                    // => This arrow is called Arrow Function, means that it returns a function.
                                    Icons.star,
                                    color: AppColors.mainColor,
                                    size: Dimensions.iconSize15,
                                  )),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        SmallText(text: '4.5'),
                        SizedBox(
                          width: 10,
                        ),
                        SmallText(text: '1287'),
                        SizedBox(
                          width: 10,
                        ),
                        SmallText(text: 'comments'),
                      ],
                    ),
                    SizedBox(
                      height: Dimensions.height20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconAndTextWidget(
                            icon: Icons.circle_sharp,
                            text: 'Normal',
                            iconColor: AppColors.iconColor1),
                        IconAndTextWidget(
                            icon: Icons.location_on,
                            text: '1.7km',
                            iconColor: AppColors.mainColor),
                        IconAndTextWidget(
                            icon: Icons.access_time_rounded,
                            text: '32min',
                            iconColor: AppColors.iconColor2),
                      ],
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
