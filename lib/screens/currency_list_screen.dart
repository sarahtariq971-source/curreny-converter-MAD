// import 'package:flutter/material.dart';
// import 'package:currency_converter/models/currency.dart';

// class CurrencyListScreen extends StatelessWidget {
//   final Function(Currency) onCurrencySelected;

//   const CurrencyListScreen({
//     super.key,
//     required this.onCurrencySelected,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: MediaQuery.of(context).size.height * 0.8,
//       padding: const EdgeInsets.all(16),
//       child: Column(
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Text(
//               'Select Currency',
//               style: Theme.of(context).textTheme.headlineSmall,
//             ),
//           ),
//           Expanded(
//             child: ListView.builder(
//               itemCount: Currency.popularCurrencies.length,
//               itemBuilder: (context, index) {
//                 final currency = Currency.popularCurrencies[index];
//                 return ListTile(
//                   leading: Text(
//                     currency.flag,
//                     style: const TextStyle(fontSize: 24),
//                   ),
//                   title: Text(currency.name),
//                   subtitle: Text(currency.code),
//                   trailing: Text(currency.symbol),
//                   onTap: () {
//                     onCurrencySelected(currency);
//                     Navigator.pop(context);
//                   },
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:currency_converter/models/currency.dart';

class CurrencyListScreen extends StatefulWidget {
  final Function(Currency) onCurrencySelected;

  const CurrencyListScreen({
    super.key,
    required this.onCurrencySelected,
  });

  @override
  State<CurrencyListScreen> createState() => _CurrencyListScreenState();
}

class _CurrencyListScreenState extends State<CurrencyListScreen> {
  List<Currency> _currencies = [];
  List<Currency> _filteredCurrencies = [];
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _currencies = Currency.getAllCurrencies();
    _filteredCurrencies = _currencies;
    _searchController.addListener(_filterCurrencies);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _filterCurrencies() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filteredCurrencies = _currencies.where((currency) {
        return currency.name.toLowerCase().contains(query) ||
               currency.code.toLowerCase().contains(query) ||
               currency.symbol.toLowerCase().contains(query);
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.85,
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: Text(
              'Select Currency',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
          ),
          TextField(
            controller: _searchController,
            decoration: InputDecoration(
              hintText: 'Search currency...',
              prefixIcon: const Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              contentPadding: const EdgeInsets.symmetric(vertical: 12),
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: _filteredCurrencies.isEmpty
                ? const Center(
                    child: Text(
                      'No currencies found',
                      style: TextStyle(color: Colors.grey),
                    ),
                  )
                : ListView.builder(
                    itemCount: _filteredCurrencies.length,
                    itemBuilder: (context, index) {
                      final currency = _filteredCurrencies[index];
                      return ListTile(
                        leading: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.grey[800],
                          ),
                          child: Center(
                            child: Text(
                              currency.flag,
                              style: const TextStyle(fontSize: 20),
                            ),
                          ),
                        ),
                        title: Text(
                          currency.name,
                          style: const TextStyle(fontWeight: FontWeight.w500),
                        ),
                        subtitle: Text(currency.code),
                        trailing: Text(
                          currency.symbol,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        onTap: () {
                          widget.onCurrencySelected(currency);
                          Navigator.pop(context);
                        },
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}