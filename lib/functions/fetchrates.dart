import 'package:currency_x/model/exRate.dart';
import 'package:currency_x/utils/key.dart';
import '../model/allCurrencies.dart';
import 'package:http/http.dart' as http;

Future<ExRate> fetchrates() async {
  var response = await http.get(Uri.parse(
      'https://openexchangerates.org/api/latest.json?app_id=' + key
  ));
  final result = exRateFromJson(response.body);
  return result;
}

Future<Map> fetchcurrencies() async {
  var response = await http.get(Uri.parse(
      'https://openexchangerates.org/api/currencies.json?prettyprint=false&show_alternative=false&show_inactive=false&app_id=' + key
  ));
  final allCurrencies = allCurrenciesFromJson(response.body);
  return allCurrencies;
}

String convertany(Map exchangeRates, String amount, String currencybase,
    String currencyfinal) {
  String output = (double.parse(amount) /
      exchangeRates[currencybase] *
      exchangeRates[currencyfinal])
      .toStringAsFixed(2)
      .toString();

  return output;
}