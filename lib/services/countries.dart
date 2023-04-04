import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:quiz/models/countryItem.dart';

class CountryService {
  Future<List<CountryItem>> fetchCountries() async {
    final response = await http
        .get(Uri.parse('https://restcountries.com/v3.1/all'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as List;
      final countries = data.map((item) => CountryItem.fromJson(item));

      return countries.toList();
    } else {
      throw Exception('Something went wrong');
    }
  }
}