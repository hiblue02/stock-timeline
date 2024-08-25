import 'package:flutter/material.dart';

import 'app_colors.dart';

// 스타일을 설정할 수 있는 함수
Text buttonStyle(String text,
    {double fontSize = 10.0,
    FontWeight fontWeight = FontWeight.normal,
    Color color = Colors.white}) {
  return Text(
    text,
    style: TextStyle(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
    ),
  );
}

ElevatedButton appButton(String text, VoidCallback onPressed,
    {double fontSize = 10.0, FontWeight fontWeight = FontWeight.normal}) {

  return ElevatedButton(
    style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(
            vertical: 15.0, horizontal: 20.0),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        backgroundColor: AppColors.mainBlue),
    onPressed: onPressed,
    child: Text(
      text,
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: Colors.white,
      ),
    )
  );
}
