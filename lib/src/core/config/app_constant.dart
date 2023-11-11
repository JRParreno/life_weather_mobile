import 'package:flutter/material.dart';

class AppConstant {
  static const kMockupHeight = 812;
  static const kMockupWidth = 375;
  static const shimmerGradient = LinearGradient(
    colors: [
      Color(0xFFEBEBF4),
      Color(0xFFF4F4F4),
      Color(0xFFEBEBF4),
    ],
    stops: [
      0.1,
      0.3,
      0.4,
    ],
    begin: Alignment(-1.0, -0.3),
    end: Alignment(1.0, 0.3),
  );
  static const clientId = 'NWk2s2dK1MsXfmFYUDBH4gbw5d1CZ0CsDoeoszNu';
  static const clientSecret =
      'yA0lNm4kvAxMJYNXU589eUM4lVtUZQYFlGW01suk2P5BNDO4Lw7g8JzyfjazspAwn0A9lqPLqGuOI7ZC5xIVImLLZCfuIh9D4MFz5OC2w28yV49nd0KGXHxrn7bonjer';
  static const serverUrl = 'http://192.168.1.4:8000';

  // static const clientId = 'O03Jbck3kLuqPeLCHaCHyB7HI9gOUKYhFvKhvQDa';
  // static const clientSecret =
  //     'kDPK7NLIWVMmyw29SyFhogcZrGUKIOz7fvCLAatdxo2efsuVMXl7uTCrTGs3Vfctx5Y6MeTBNBI3RbwHpLea9vJYNAcbeGEy9MroBPItJ5JUhIZNlYzLL74qEty794kf';
  // static const serverUrl = 'https://life-weather-core.onrender.com';

  static const apiUrl = '$serverUrl/api';
  static const apiUser = '$serverUrl/user';
  static const appName = 'Life Weather';

  static const weatherApiKey = 'bb80294d73796b098327d24d487250ee';
}
