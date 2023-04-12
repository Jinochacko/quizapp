import 'package:flutter/cupertino.dart';
import 'package:quiz/models/countryItem.dart';
import 'package:quiz/services/countries.dart';

class QuizProvider extends ChangeNotifier {
  final _service = CountryService();
  List<CountryItem> _countries = [];
  CountryItem _country =
      CountryItem(name: '', code: '', region: '', isSelected: false);
  int _percentageStep = 0;
  String _documentName = "";
  String _documentNumber = "";
  final int _totalNumberOfQuestions = 3;
  List<CountryItem> get countries => _countries;
  String get documentNumber => _documentNumber;
  String get documentName => _documentName;
  CountryItem get country => _country;
  int get percentageStep => _percentageStep;
  int get totalNumberOfQuestions => _totalNumberOfQuestions;

  Future<void> getCountries() async {
    _countries = await _service.fetchCountries();
    notifyListeners();
  }

  void setDocumentNumber(String documentNumber) {
    _documentNumber = documentNumber;
    notifyListeners();
  }

  void setDocumentName(String documentName) {
    _documentName = documentName;
    notifyListeners();
  }

  void setCountry(CountryItem country) {
    _country = country;
    notifyListeners();
  }

  void setPercentageStep(int step) {
    _percentageStep = step;
    notifyListeners();
  }
}
