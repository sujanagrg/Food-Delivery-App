//This widget is reusable for passing the icons color and text color.
import 'package:flutter/cupertino.dart';
import 'package:food_delivery/utils/Dimensions.dart';
import 'package:food_delivery/widgets/small_text.dart';

class IconAndTextWidget extends StatelessWidget {
  //This class should send icon name, icon color, text and text color
  //Declare variable
  final IconData icon; //we cannot pass icon but icon data.
  final String text;

  final Color iconColor;
  const IconAndTextWidget(
      {Key? key,
      required this.icon,
      required this.text,
      required this.iconColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      //Here we are returning row because the icon and text are paired up horizontally
      children: [
        Icon(
          icon,
          color: iconColor,
          size: Dimensions.iconSize24,
        ),
        SizedBox(
          width: 5,
        ),
        SmallText(
          text: text,
        )
      ],
    );
  }
}
