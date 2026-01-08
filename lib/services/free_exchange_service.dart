import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import '../models/currency.dart';

class FreeExchangeService with ChangeNotifier {
  double _amount = 1.0;
  Currency _fromCurrency = Currency.getPopularCurrencies()[0];
  Currency _toCurrency = Currency.getPopularCurrencies()[1];
  double _convertedAmount = 0.0;
  bool _isLoading = false;
  String _errorMessage = '';
  Map<String, double> _exchangeRates = {};
  DateTime? _lastUpdated;

  double get amount => _amount;
  Currency get fromCurrency => _fromCurrency;
  Currency get toCurrency => _toCurrency;
  double get convertedAmount => _convertedAmount;
  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;
  DateTime? get lastUpdated => _lastUpdated;

  void setAmount(double value) {
    _amount = value;
    _convert();
    notifyListeners();
  }

  void setFromCurrency(Currency currency) {
    _fromCurrency = currency;
    _convert();
    notifyListeners();
  }

  void setToCurrency(Currency currency) {
    _toCurrency = currency;
    _convert();
    notifyListeners();
  }

  void swapCurrencies() {
    final temp = _fromCurrency;
    _fromCurrency = _toCurrency;
    _toCurrency = temp;
    _convert();
    notifyListeners();
  }

  Future<void> fetchExchangeRates() async {
    _isLoading = true;
    _errorMessage = '';
    notifyListeners();

    try {
      // Using exchangerate.host - FREE, no API key needed, supports more currencies
      final response = await http.get(
        Uri.parse('https://api.exchangerate.host/latest?base=USD'),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final rates = _parseRates(data['rates']);
        _exchangeRates = rates;
        _lastUpdated = DateTime.now();
        _convert();
        _errorMessage = '';
      } else {
        _errorMessage = 'Using sample exchange rates';
        _useSampleRates();
      }
    } catch (e) {
      _errorMessage = 'Using sample rates. Error: ${e.toString().split('\n').first}';
      _useSampleRates();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Map<String, double> _parseRates(dynamic ratesData) {
    final Map<String, double> parsedRates = {};
    
    if (ratesData is Map) {
      ratesData.forEach((key, value) {
        try {
          if (value is int) {
            parsedRates[key.toString()] = value.toDouble();
          } else if (value is double) {
            parsedRates[key.toString()] = value;
          } else if (value is String) {
            parsedRates[key.toString()] = double.tryParse(value) ?? 0.0;
          } else if (value is num) {
            parsedRates[key.toString()] = value.toDouble();
          }
        } catch (e) {
          // Skip invalid entries
          if (kDebugMode) {
            print('Error parsing rate for $key: $value');
          }
        }
      });
    }
    
    return parsedRates;
  }

  void _useSampleRates() {
    // Extended sample rates
    _exchangeRates = {
      'USD': 1.0,    'EUR': 0.85,   'GBP': 0.73,   'JPY': 110.0,
      'AUD': 1.35,   'CAD': 1.25,   'CHF': 0.92,   'CNY': 6.45,
      'INR': 74.0,   'SGD': 1.34,   'NZD': 1.42,   'KRW': 1180.0,
      'BRL': 5.25,   'RUB': 74.5,   'ZAR': 14.5,   'AED': 3.67,
      'SAR': 3.75,   'TRY': 8.5,    'MXN': 20.0,   'IDR': 14250.0,
      'ARS': 100.5,  'CLP': 800.0,  'COP': 3800.0, 'PEN': 4.0,
      'SEK': 8.7,    'NOK': 8.5,    'DKK': 6.3,    'PLN': 3.9,
      'CZK': 21.5,   'HUF': 310.0,  'RON': 4.2,    'UAH': 27.0,
      'THB': 33.0,   'VND': 23000.0,'MYR': 4.2,    'PHP': 50.0,
      'PKR': 175.0,  'BDT': 85.0,   'ILS': 3.3,    'QAR': 3.64,
      'KWD': 0.3,    'OMR': 0.38,   'EGP': 15.7,   'NGN': 415.0,
      'KES': 110.0,  'GHS': 6.0,    'ETB': 45.0,   'MAD': 9.0,
      'DZD': 135.0,
    };
    _lastUpdated = DateTime.now();
    _convert();
  }

  void _convert() {
    if (_exchangeRates.isEmpty) return;

    final fromRate = _exchangeRates[_fromCurrency.code] ?? 1.0;
    final toRate = _exchangeRates[_toCurrency.code] ?? 1.0;

    if (fromRate == 0.0) {
      _convertedAmount = 0.0;
      return;
    }

    final amountInUSD = _amount / fromRate;
    _convertedAmount = amountInUSD * toRate;

    notifyListeners();
  }
}