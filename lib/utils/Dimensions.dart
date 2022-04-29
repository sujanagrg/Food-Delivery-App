import 'package:get/get.dart'; //with this we have access to the getx package

class Dimensions {
  //Lets make the container dynamic.
  static double screenHeight = Get.context!
      .height; //Accessing the height property.'!' this indicates that this is not going to be null.
  static double screenWidth =
      Get.context!.width; // Accessing the width property
  static double pageView = screenHeight / 2.1; //(672/320)=2.1
  //672(Height of our device)/220(Height of the first container)=3.05(Note: Placing this value below this line)
  static double pageViewContainer = screenHeight / 3.05;
  static double pageViewTextContainer = screenHeight /
      5.6; //672(Height of our device)/120(Height of the first container)=5.6(Note: Placing this value here)
  //dynamic height padding and margin
  static double height10 = screenHeight / 67.2;
  static double height20 = screenHeight / 33.6;
  static double height15 = screenHeight / 44.8;
  static double height30 = screenHeight / 22.4;
  static double height45 = screenHeight / 14.93;
  //dynamic width padding nad margin
  static double width10 = screenHeight / 67.2;
  static double width20 = screenHeight / 33.6;
  static double width15 = screenHeight / 44.8;
  static double width30 = screenHeight / 22.4;
  static double width45 = screenHeight / 14.93;

  static double font20 = screenHeight / 33.6;

  //radius
  static double radius15 = screenHeight / 44.8;
  static double radius20 = screenHeight / 33.6;
  static double radius30 = screenHeight / 22.4;

  //icons size
  static double iconSize24 = screenHeight / 28;
  static double iconSize15 = screenHeight / 44.8;
}
