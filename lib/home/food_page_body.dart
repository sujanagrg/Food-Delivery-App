import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:food_delivery/widgets/big_text.dart';
import 'package:food_delivery/widgets/icon_and_text_widget.dart';
import 'package:food_delivery/widgets/small_text.dart';

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
  double _height = 220;
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
    //we dont need that value and remove from the memory. In this way we keep the memory as small as possible.
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 320,
          child: PageView.builder(
              //This makes the objects scrollable
              controller: pageController,
              itemCount: 5,
              itemBuilder: (context, position) {
                return _buildPageItem(position);
              }),
        ),
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
        )
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
            height: 220,
            margin: EdgeInsets.only(
                left: 10,
                right:
                    10), //helps to create empty space between the two container of different pages while scrolling
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
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
              height: 120,
              margin: EdgeInsets.only(left: 30, right: 30, bottom: 30),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
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
                padding: EdgeInsets.only(top: 15, left: 15, right: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BigText(text: 'Chinese Side'),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Wrap(
                          //We use wrap widget to draw the same thing again and again horizontally.
                          children: List.generate(
                              5, //Here we are generating 5 stars
                              (index) => Icon(
                                    // => This arrow is called Arrow Function, means that it reaturns a function.
                                    Icons.star,
                                    color: AppColors.mainColor,
                                    size: 15,
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
                      height: 10,
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