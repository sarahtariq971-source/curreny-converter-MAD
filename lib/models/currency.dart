// class Currency {
//   final String code;
//   final String name;
//   final String flag; // Emoji flag
//   final String symbol;

//   Currency({
//     required this.code,
//     required this.name,
//     required this.flag,
//     required this.symbol,
//   });

//   static List<Currency> popularCurrencies = [
//     Currency(code: 'USD', name: 'US Dollar', flag: '🇺🇸', symbol: '\$'),
//     Currency(code: 'EUR', name: 'Euro', flag: '🇪🇺', symbol: '€'),
//     Currency(code: 'GBP', name: 'British Pound', flag: '🇬🇧', symbol: '£'),
//     Currency(code: 'JPY', name: 'Japanese Yen', flag: '🇯🇵', symbol: '¥'),
//     Currency(code: 'AUD', name: 'Australian Dollar', flag: '🇦🇺', symbol: '\$'),
//     Currency(code: 'CAD', name: 'Canadian Dollar', flag: '🇨🇦', symbol: '\$'),
//     Currency(code: 'CHF', name: 'Swiss Franc', flag: '🇨🇭', symbol: 'Fr'),
//     Currency(code: 'CNY', name: 'Chinese Yuan', flag: '🇨🇳', symbol: '¥'),
//     Currency(code: 'INR', name: 'Indian Rupee', flag: '🇮🇳', symbol: '₹'),
//     Currency(code: 'SGD', name: 'Singapore Dollar', flag: '🇸🇬', symbol: '\$'),
//     Currency(code: 'NZD', name: 'New Zealand Dollar', flag: '🇳🇿', symbol: '\$'),
//     Currency(code: 'KRW', name: 'South Korean Won', flag: '🇰🇷', symbol: '₩'),
//     Currency(code: 'BRL', name: 'Brazilian Real', flag: '🇧🇷', symbol: 'R\$'),
//     Currency(code: 'RUB', name: 'Russian Ruble', flag: '🇷🇺', symbol: '₽'),
//     Currency(code: 'ZAR', name: 'South African Rand', flag: '🇿🇦', symbol: 'R'),
//     Currency(code: 'AED', name: 'UAE Dirham', flag: '🇦🇪', symbol: 'د.إ'),
//     Currency(code: 'SAR', name: 'Saudi Riyal', flag: '🇸🇦', symbol: 'ر.س'),
//     Currency(code: 'TRY', name: 'Turkish Lira', flag: '🇹🇷', symbol: '₺'),
//     Currency(code: 'MXN', name: 'Mexican Peso', flag: '🇲🇽', symbol: '\$'),
//     Currency(code: 'IDR', name: 'Indonesian Rupiah', flag: '🇮🇩', symbol: 'Rp'),
//   ];

//   static Currency getCurrencyByCode(String code) {
//     return popularCurrencies.firstWhere(
//       (currency) => currency.code == code,
//       orElse: () => Currency(
//         code: code,
//         name: code,
//         flag: '🏳️',
//         symbol: '',
//       ),
//     );
//   }
// }
class Currency {
  final String code;
  final String name;
  final String flag;
  final String symbol;

  Currency({
    required this.code,
    required this.name,
    required this.flag,
    required this.symbol,
  });

  static List<Currency> getAllCurrencies() {
    return [
      // Americas
      Currency(code: 'USD', name: 'US Dollar', flag: '🇺🇸', symbol: '\$'),
      Currency(code: 'CAD', name: 'Canadian Dollar', flag: '🇨🇦', symbol: '\$'),
      Currency(code: 'MXN', name: 'Mexican Peso', flag: '🇲🇽', symbol: '\$'),
      Currency(code: 'BRL', name: 'Brazilian Real', flag: '🇧🇷', symbol: 'R\$'),
      Currency(code: 'ARS', name: 'Argentine Peso', flag: '🇦🇷', symbol: '\$'),
      Currency(code: 'CLP', name: 'Chilean Peso', flag: '🇨🇱', symbol: '\$'),
      Currency(code: 'COP', name: 'Colombian Peso', flag: '🇨🇴', symbol: '\$'),
      Currency(code: 'PEN', name: 'Peruvian Sol', flag: '🇵🇪', symbol: 'S/'),
      
      // Europe
      Currency(code: 'EUR', name: 'Euro', flag: '🇪🇺', symbol: '€'),
      Currency(code: 'GBP', name: 'British Pound', flag: '🇬🇧', symbol: '£'),
      Currency(code: 'CHF', name: 'Swiss Franc', flag: '🇨🇭', symbol: 'Fr'),
      Currency(code: 'SEK', name: 'Swedish Krona', flag: '🇸🇪', symbol: 'kr'),
      Currency(code: 'NOK', name: 'Norwegian Krone', flag: '🇳🇴', symbol: 'kr'),
      Currency(code: 'DKK', name: 'Danish Krone', flag: '🇩🇰', symbol: 'kr'),
      Currency(code: 'RUB', name: 'Russian Ruble', flag: '🇷🇺', symbol: '₽'),
      Currency(code: 'PLN', name: 'Polish Złoty', flag: '🇵🇱', symbol: 'zł'),
      Currency(code: 'CZK', name: 'Czech Koruna', flag: '🇨🇿', symbol: 'Kč'),
      Currency(code: 'HUF', name: 'Hungarian Forint', flag: '🇭🇺', symbol: 'Ft'),
      Currency(code: 'RON', name: 'Romanian Leu', flag: '🇷🇴', symbol: 'lei'),
      Currency(code: 'TRY', name: 'Turkish Lira', flag: '🇹🇷', symbol: '₺'),
      Currency(code: 'UAH', name: 'Ukrainian Hryvnia', flag: '🇺🇦', symbol: '₴'),
      
      // Asia
      Currency(code: 'JPY', name: 'Japanese Yen', flag: '🇯🇵', symbol: '¥'),
      Currency(code: 'CNY', name: 'Chinese Yuan', flag: '🇨🇳', symbol: '¥'),
      Currency(code: 'INR', name: 'Indian Rupee', flag: '🇮🇳', symbol: '₹'),
      Currency(code: 'KRW', name: 'South Korean Won', flag: '🇰🇷', symbol: '₩'),
      Currency(code: 'IDR', name: 'Indonesian Rupiah', flag: '🇮🇩', symbol: 'Rp'),
      Currency(code: 'THB', name: 'Thai Baht', flag: '🇹🇭', symbol: '฿'),
      Currency(code: 'VND', name: 'Vietnamese Dong', flag: '🇻🇳', symbol: '₫'),
      Currency(code: 'MYR', name: 'Malaysian Ringgit', flag: '🇲🇾', symbol: 'RM'),
      Currency(code: 'SGD', name: 'Singapore Dollar', flag: '🇸🇬', symbol: '\$'),
      Currency(code: 'PHP', name: 'Philippine Peso', flag: '🇵🇭', symbol: '₱'),
      Currency(code: 'PKR', name: 'Pakistani Rupee', flag: '🇵🇰', symbol: '₨'),
      Currency(code: 'BDT', name: 'Bangladeshi Taka', flag: '🇧🇩', symbol: '৳'),
      Currency(code: 'SAR', name: 'Saudi Riyal', flag: '🇸🇦', symbol: 'ر.س'),
      Currency(code: 'AED', name: 'UAE Dirham', flag: '🇦🇪', symbol: 'د.إ'),
      Currency(code: 'ILS', name: 'Israeli Shekel', flag: '🇮🇱', symbol: '₪'),
      Currency(code: 'QAR', name: 'Qatari Riyal', flag: '🇶🇦', symbol: 'ر.ق'),
      Currency(code: 'KWD', name: 'Kuwaiti Dinar', flag: '🇰🇼', symbol: 'د.ك'),
      Currency(code: 'OMR', name: 'Omani Rial', flag: '🇴🇲', symbol: 'ر.ع.'),
      
      // Oceania
      Currency(code: 'AUD', name: 'Australian Dollar', flag: '🇦🇺', symbol: '\$'),
      Currency(code: 'NZD', name: 'New Zealand Dollar', flag: '🇳🇿', symbol: '\$'),
      
      // Africa
      Currency(code: 'ZAR', name: 'South African Rand', flag: '🇿🇦', symbol: 'R'),
      Currency(code: 'EGP', name: 'Egyptian Pound', flag: '🇪🇬', symbol: '£'),
      Currency(code: 'NGN', name: 'Nigerian Naira', flag: '🇳🇬', symbol: '₦'),
      Currency(code: 'KES', name: 'Kenyan Shilling', flag: '🇰🇪', symbol: 'Sh'),
      Currency(code: 'GHS', name: 'Ghanaian Cedi', flag: '🇬🇭', symbol: '₵'),
      Currency(code: 'ETB', name: 'Ethiopian Birr', flag: '🇪🇹', symbol: 'Br'),
      Currency(code: 'MAD', name: 'Moroccan Dirham', flag: '🇲🇦', symbol: 'د.م.'),
      Currency(code: 'DZD', name: 'Algerian Dinar', flag: '🇩🇿', symbol: 'د.ج'),
    ];
  }

  static List<Currency> getPopularCurrencies() {
    return [
      Currency(code: 'USD', name: 'US Dollar', flag: '🇺🇸', symbol: '\$'),
      Currency(code: 'EUR', name: 'Euro', flag: '🇪🇺', symbol: '€'),
      Currency(code: 'GBP', name: 'British Pound', flag: '🇬🇧', symbol: '£'),
      Currency(code: 'JPY', name: 'Japanese Yen', flag: '🇯🇵', symbol: '¥'),
      Currency(code: 'AUD', name: 'Australian Dollar', flag: '🇦🇺', symbol: '\$'),
      Currency(code: 'CAD', name: 'Canadian Dollar', flag: '🇨🇦', symbol: '\$'),
      Currency(code: 'CHF', name: 'Swiss Franc', flag: '🇨🇭', symbol: 'Fr'),
      Currency(code: 'CNY', name: 'Chinese Yuan', flag: '🇨🇳', symbol: '¥'),
      Currency(code: 'INR', name: 'Indian Rupee', flag: '🇮🇳', symbol: '₹'),
      Currency(code: 'SGD', name: 'Singapore Dollar', flag: '🇸🇬', symbol: '\$'),
      Currency(code: 'NZD', name: 'New Zealand Dollar', flag: '🇳🇿', symbol: '\$'),
      Currency(code: 'KRW', name: 'South Korean Won', flag: '🇰🇷', symbol: '₩'),
    ];
  }

  static Currency getCurrencyByCode(String code) {
    return getAllCurrencies().firstWhere(
      (currency) => currency.code == code,
      orElse: () => Currency(
        code: code,
        name: code,
        flag: '🏳️',
        symbol: '',
      ),
    );
  }
}