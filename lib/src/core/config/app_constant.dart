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
  static const serverUrl = 'http://127.0.0.1:8000';

  // static const clientId = 'ogBtWLnnW28j7dWxRC2RO58TKU0zxavnSRGZv68q';
  // static const clientSecret =
  //     'moSB3YO8dlD5il18ILfQdrBTZMwowLHEi4AcxHlHY2bgDGZk1FgAVhDuzj2Xu4XrsaLgoltII8PVJSXmtEw7liPT5HVPmpo4gYWcDJm81MMFNUOnhjckoYbJXRAA8nxf';
  // static const serverUrl = 'https://tire-tech-core.onrender.com';

  static const apiUrl = '$serverUrl/api';
  static const apiUser = '$serverUrl/user';
  static const appName = 'Life Weather';
  static const googleApiKey = 'AIzaSyBK2zX8K3Jr2fObVaDBLmjN5vpZ-RPNMy8';
}
