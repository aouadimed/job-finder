  import 'package:cv_frontend/global/utils/country_code_data.dart';

String countryCodeFromCountryName(String countryName) {
    String? countryCode = countryNameToCode[countryName];
    return countryCode ?? '';
  }