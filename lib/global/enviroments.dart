import 'dart:io';
import 'package:flutter/foundation.dart';

class Enviroments {
  static String apiURLDev = Platform.isAndroid
      ? "http://10.0.2.2:4000/api"
      : "http://localhost:4000/api";
  static String socketURLDev =
      Platform.isAndroid ? "http://10.0.2.2:4000/" : "http://localhost:4000/";
  static String apiURL = kReleaseMode ? "http://myURL/api" : apiURLDev;
  static String socketURL = kReleaseMode ? "http://myURL/" : socketURLDev;
}
