import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vms_app/helper/colors.dart';

class CustomButton extends StatelessWidget {
  String buttonText;
  Function()? onPressed;
  ButtonType buttonType;
  double? width, height, textSize;
  EdgeInsets? margin, padding;

  CustomButton({
    required this.buttonText,
    this.onPressed,
    this.buttonType = ButtonType.primary,
    this.width,
    this.height,
    this.margin,
    this.padding,
    this.textSize,
  });

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      margin: margin,
      padding: padding,
      height: height ?? 40,
      width: width ?? 150,
      child: ElevatedButton(
        style: ButtonStyle(
            elevation: MaterialStateProperty.all(8),
            backgroundColor: MaterialStateProperty.all(buttonColor(buttonType)),
            shape: MaterialStateProperty.all(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12)))),
        child: Text(
          buttonText,
          style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: textSize ?? 14),
        ),
        onPressed: onPressed,
      ),
    );
  }

  buttonColor(ButtonType buttonType) {
    return buttonType == ButtonType.primary ? primary : btnBlack;
  }
}

enum ButtonType { primary, secondary }
