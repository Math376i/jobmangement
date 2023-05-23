import 'dart:ui';

abstract class ColorDef {
  static const Color company100 =
      Color.fromARGB(255, 203, 230, 245); // Lightest
  static const Color company400 = Color.fromARGB(255, 55, 163, 221);
  static const Color company = Color.fromARGB(255, 23, 141, 204); // standard
  static const Color company600 = Color.fromARGB(255, 11, 117, 175);
  static const Color company700 = Color.fromARGB(255, 0, 44, 68); // darkest

  static const Color allert = Color.fromARGB(255, 197, 43, 29);
  static const Color okay = Color.fromARGB(255, 14, 201, 20);
  static const Color warning = Color.fromARGB(255, 243, 200, 61);
}
