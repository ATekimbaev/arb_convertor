import 'dart:convert';
import 'dart:io';

import 'apps_data.dart';
import 'marketing_data.dart';

void saveToArb(
    Map<String, dynamic> difference, String filePath, String locale) {
  var arbContent = '{\n  "@@locale": "$locale",\n';
  difference.forEach((key, value) {
    arbContent += '  "$key": "${value.toString()}",\n';
  });
  arbContent += '}\n';

  File(filePath).writeAsStringSync(arbContent);
}

Map<String, dynamic> compareMaps(
    Map<String, dynamic> map1, Map<String, dynamic> map2) {
  Map<String, dynamic> difference = {};

  map1.forEach((key, value) {
    if (!map2.containsKey(key)) {
      difference[key] = map1[key];
    }
  });

  map2.forEach((key, value) {
    if (!map1.containsKey(key)) {
      difference[key] = map2[key];
    }
  });

  return difference;
}

void main() {
  // Сравниваем их и сохраняем различия в файл
  Map<String, dynamic> difference = compareMaps(
    MarketingData.marketingData,
    AppsData.appsData,
  );
  saveToArb(difference, "difference.arb", 'ru');
}
