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
  // static const clientId = 'zpjTOiQJyWrevPe2U6yZ9wwmhpB9ee7QHMxhuyvD';
  // static const clientSecret =
  //     'Fn50XVhsS1FnAmxGv7MB8lCP2hPf4s1SVbgW5B2Z7452AeXcN9gWL1tq5DwqWGa3lbX7azGnjZA4BYOcqivE04WkraGRup4HAKettXURzU8iD7XGRoMaD04wFjebNGyR';
  // static const serverUrl = 'http://192.168.1.2:8000';

  static const clientId = 'ogBtWLnnW28j7dWxRC2RO58TKU0zxavnSRGZv68q';
  static const clientSecret =
      'moSB3YO8dlD5il18ILfQdrBTZMwowLHEi4AcxHlHY2bgDGZk1FgAVhDuzj2Xu4XrsaLgoltII8PVJSXmtEw7liPT5HVPmpo4gYWcDJm81MMFNUOnhjckoYbJXRAA8nxf';
  static const serverUrl = 'https://tire-tech-core.onrender.com';

  static const apiUrl = '$serverUrl/api';
  static const apiUser = '$serverUrl/user';
  static const appName = 'Life Weather';
  static const googleApiKey = 'AIzaSyBK2zX8K3Jr2fObVaDBLmjN5vpZ-RPNMy8';
}
