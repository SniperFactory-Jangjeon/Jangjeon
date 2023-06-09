import 'package:flutter/material.dart';

class AppTextStyle {
  //헤더 볼드폰트 32사이즈
  static const h1B32 = TextStyle(fontFamily: 'PretendardBold', fontSize: 32);

  //헤더 볼드폰트 28사이즈
  static TextStyle h2B28({Color color = Colors.black}) =>
      TextStyle(fontFamily: 'PretendardBold', fontSize: 28, color: color);

  //헤더 볼드폰트 24사이즈
  static TextStyle h3B24({Color color = Colors.black}) =>
      TextStyle(fontFamily: 'PretendardBold', fontSize: 24, color: color);

  //헤더 볼드폰트 20사이즈
  static TextStyle h4B20({Color color = Colors.black}) =>
      TextStyle(fontFamily: 'PretendardBold', fontSize: 20, color: color);

  //본문 볼드폰트 24사이즈
  static TextStyle b1B24({Color color = Colors.black}) =>
      TextStyle(fontFamily: 'PretendardBold', fontSize: 24, color: color);

  //본문 미디엄폰트 24사이즈
  static TextStyle b1M24({Color color = Colors.black}) =>
      TextStyle(fontFamily: 'PretendardMedium', fontSize: 24, color: color);

  //본문 볼드폰트 18사이즈
  static TextStyle b2B18({Color color = Colors.black}) =>
      TextStyle(fontFamily: 'PretendardBold', fontSize: 18, color: color);

  //본문 미디엄폰트 18사이즈
  static TextStyle b2M18({Color color = Colors.black}) =>
      TextStyle(fontFamily: 'PretendardMedium', fontSize: 18, color: color);

  //본문 볼드폰트 16사이즈
  static TextStyle b3B16({Color color = Colors.black}) =>
      TextStyle(fontFamily: 'PretendardBold', fontSize: 16, color: color);

  //본문 미디엄폰트 16사이즈
  static TextStyle b3M16({Color color = Colors.black}) =>
      TextStyle(fontFamily: 'PretendardMedium', fontSize: 16, color: color);

  //본문 레귤러폰트 16사이즈
  static TextStyle b3R16(
          {Color color = Colors.black,
          double? letterSpacing,
          double? wordSpacing,
          double? height}) =>
      TextStyle(
          fontFamily: 'PretendardRegular',
          fontSize: 16,
          color: color,
          letterSpacing: letterSpacing,
          wordSpacing: wordSpacing,
          height: height);

  //본문 볼드폰트 14사이즈
  static TextStyle b4B14({Color color = Colors.black}) =>
      TextStyle(fontFamily: 'PretendardBold', fontSize: 14, color: color);

  //본문 미디엄폰트 14사이즈
  static TextStyle b4M14({Color color = Colors.black}) =>
      TextStyle(fontFamily: 'PretendardMedium', fontSize: 14, color: color);

  //본문 레귤러폰트 14사이즈
  static TextStyle b4R14({Color color = Colors.black}) =>
      TextStyle(fontFamily: 'PretendardRegular', fontSize: 14, color: color);

  //본문 볼드폰트 12사이즈
  static TextStyle b5B12({Color color = Colors.black}) =>
      TextStyle(fontFamily: 'PretendardBold', fontSize: 12, color: color);

  //본문 미디엄폰트 12사이즈
  static TextStyle b5M12({Color color = Colors.black}) =>
      TextStyle(fontFamily: 'PretendardMedium', fontSize: 12, color: color);

  //본문 레귤러폰트 12사이즈
  static TextStyle b5R12({Color color = Colors.black}) =>
      TextStyle(fontFamily: 'PretendardRegular', fontSize: 12, color: color);

  //본문 미디엄폰트 10사이즈
  static TextStyle b5M10({Color color = Colors.black}) =>
      TextStyle(fontFamily: 'PretendardMedium', fontSize: 10, color: color);

  //본문 레귤러폰트 10사이즈
  static TextStyle b5R10({Color color = Colors.black}) =>
      TextStyle(fontFamily: 'PretendardRegular', fontSize: 10, color: color);
}
