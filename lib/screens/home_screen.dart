// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:currency_converter/services/exchange_service.dart';
// import 'package:currency_converter/models/currency.dart';
// import 'package:currency_converter/screens/currency_list_screen.dart';
// import 'package:currency_converter/widgets/currency_card.dart';

// class HomeScreen extends StatefulWidget {
//   const HomeScreen({super.key});

//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   final TextEditingController _amountController = TextEditingController();

//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       Provider.of<ExchangeService>(context, listen: false).fetchExchangeRates();
//     });
//     _amountController.text = '1.00';
//   }

//   @override
//   void dispose() {
//     _amountController.dispose();
//     super.dispose();
//   }

//   void _showCurrencyPicker(bool isFromCurrency) {
//     showModalBottomSheet(
//       context: context,
//       isScrollControlled: true,
//       builder: (context) {
//         return CurrencyListScreen(
//           onCurrencySelected: (currency) {
//             if (isFromCurrency) {
//               Provider.of<ExchangeService>(context, listen: false)
//                   .setFromCurrency(currency);
//             } else {
//               Provider.of<ExchangeService>(context, listen: false)
//                   .setToCurrency(currency);
//             }
//           },
//         );
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Currency Converter'),
//         centerTitle: true,
//         elevation: 0,
//       ),
//       body: Consumer<ExchangeService>(
//         builder: (context, service, child) {
//           return Column(
//             children: [
//               // Amount Input Section
//               Padding(
//                 padding: const EdgeInsets.all(20.0),
//                 child: Card(
//                   elevation: 4,
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(16),
//                   ),
//                   child: Padding(
//                     padding: const EdgeInsets.all(20.0),
//                     child: Column(
//                       children: [
//                         TextField(
//                           controller: _amountController,
//                           keyboardType: TextInputType.number,
//                           decoration: InputDecoration(
//                             labelText: 'Amount',
//                             prefixIcon: const Icon(Icons.money),
//                             border: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(12),
//                             ),
//                             suffixIcon: IconButton(
//                               icon: const Icon(Icons.clear),
//                               onPressed: () {
//                                 _amountController.clear();
//                                 service.setAmount(0);
//                               },
//                             ),
//                           ),
//                           onChanged: (value) {
//                             final amount = double.tryParse(value) ?? 0;
//                             service.setAmount(amount);
//                           },
//                         ),
//                         const SizedBox(height: 20),
//                         Row(
//                           children: [
//                             Expanded(
//                               child: CurrencyCard(
//                                 currency: service.fromCurrency,
//                                 onTap: () => _showCurrencyPicker(true),
//                               ),
//                             ),
//                             IconButton(
//                               onPressed: service.swapCurrencies,
//                               icon: Container(
//                                 padding: const EdgeInsets.all(8),
//                                 decoration: BoxDecoration(
//                                   color: Theme.of(context).colorScheme.primary,
//                                   shape: BoxShape.circle,
//                                 ),
//                                 child: const Icon(
//                                   Icons.swap_horiz,
//                                   color: Colors.white,
//                                 ),
//                               ),
//                             ),
//                             Expanded(
//                               child: CurrencyCard(
//                                 currency: service.toCurrency,
//                                 onTap: () => _showCurrencyPicker(false),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),

//               // Conversion Result
//               if (service.isLoading)
//                 const Padding(
//                   padding: EdgeInsets.all(20.0),
//                   child: CircularProgressIndicator(),
//                 )
//               else if (service.errorMessage.isNotEmpty)
//                 Padding(
//                   padding: const EdgeInsets.all(20.0),
//                   child: Text(
//                     service.errorMessage,
//                     style: TextStyle(
//                       color: Theme.of(context).colorScheme.error,
//                     ),
//                   ),
//                 )
//               else
//                 Card(
//                   margin: const EdgeInsets.symmetric(horizontal: 20),
//                   elevation: 4,
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(16),
//                   ),
//                   child: Padding(
//                     padding: const EdgeInsets.all(24.0),
//                     child: Column(
//                       children: [
//                         Text(
//                           '${service.amount.toStringAsFixed(2)} ${service.fromCurrency.code} =',
//                           style: Theme.of(context).textTheme.titleLarge,
//                         ),
//                         const SizedBox(height: 8),
//                         Text(
//                           '${service.convertedAmount.toStringAsFixed(2)} ${service.toCurrency.code}',
//                           style: Theme.of(context).textTheme.headlineMedium!.copyWith(
//                             fontWeight: FontWeight.bold,
//                             color: Theme.of(context).colorScheme.primary,
//                           ),
//                         ),
//                         const SizedBox(height: 16),
//                         Text(
//                           '1 ${service.fromCurrency.code} = ${(service.convertedAmount / service.amount).toStringAsFixed(4)} ${service.toCurrency.code}',
//                           style: Theme.of(context).textTheme.bodyMedium!.copyWith(
//                             color: Colors.grey[600],
//                           ),
//                         ),
//                         Text(
//                           '1 ${service.toCurrency.code} = ${(service.amount / service.convertedAmount).toStringAsFixed(4)} ${service.fromCurrency.code}',
//                           style: Theme.of(context).textTheme.bodyMedium!.copyWith(
//                             color: Colors.grey[600],
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),

//               // Popular Currencies Grid
//               Expanded(
//                 child: Padding(
//                   padding: const EdgeInsets.all(20.0),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         'Popular Currencies',
//                         style: Theme.of(context).textTheme.titleLarge,
//                       ),
//                       const SizedBox(height: 16),
//                       Expanded(
//                         child: GridView.builder(
//                           gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                             crossAxisCount: 3,
//                             crossAxisSpacing: 12,
//                             mainAxisSpacing: 12,
//                             childAspectRatio: 1.5,
//                           ),
//                           itemCount: Currency.popularCurrencies.length,
//                           itemBuilder: (context, index) {
//                             final currency = Currency.popularCurrencies[index];
//                             return InkWell(
//                               onTap: () {
//                                 service.setToCurrency(currency);
//                               },
//                               borderRadius: BorderRadius.circular(12),
//                               child: Container(
//                                 decoration: BoxDecoration(
//                                   color: Theme.of(context).colorScheme.surfaceVariant,
//                                   borderRadius: BorderRadius.circular(12),
//                                   border: service.toCurrency.code == currency.code
//                                       ? Border.all(
//                                           color: Theme.of(context).colorScheme.primary,
//                                           width: 2,
//                                         )
//                                       : null,
//                                 ),
//                                 padding: const EdgeInsets.all(12),
//                                 child: Column(
//                                   mainAxisAlignment: MainAxisAlignment.center,
//                                   children: [
//                                     Text(
//                                       currency.flag,
//                                       style: const TextStyle(fontSize: 24),
//                                     ),
//                                     const SizedBox(height: 8),
//                                     Text(
//                                       currency.code,
//                                       style: const TextStyle(
//                                         fontWeight: FontWeight.bold,
//                                       ),
//                                     ),
//                                     Text(
//                                       currency.name.split(' ').first,
//                                       style: const TextStyle(
//                                         fontSize: 12,
//                                         color: Colors.grey,
//                                       ),
//                                       overflow: TextOverflow.ellipsis,
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             );
//                           },
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           );
//         },
//       ),
//       floatingActionButton: Consumer<ExchangeService>(
//         builder: (context, service, child) {
//           return FloatingActionButton.extended(
//             onPressed: () {
//               service.swapCurrencies();
//             },
//             icon: const Icon(Icons.swap_horiz),
//             label: const Text('Swap Currencies'),
//           );
//         },
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:currency_converter/services/exchange_service.dart';
import 'package:currency_converter/models/currency.dart';
import 'package:currency_converter/screens/currency_list_screen.dart';
import 'package:currency_converter/widgets/currency_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _amountController = TextEditingController();
  late ExchangeService _service;

  @override
  void initState() {
    super.initState();
    _amountController.text = '1.00';
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _service = Provider.of<ExchangeService>(context, listen: false);
    _service.fetchExchangeRates();
  }

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  void _showCurrencyPicker(bool isFromCurrency) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return CurrencyListScreen(
          onCurrencySelected: (currency) {
            if (isFromCurrency) {
              _service.setFromCurrency(currency);
            } else {
              _service.setToCurrency(currency);
            }
          },
        );
      },
    );
  }

  String _formatNumber(double number) {
    if (number >= 1000) {
      return number.toStringAsFixed(2);
    } else if (number >= 100) {
      return number.toStringAsFixed(3);
    } else if (number >= 10) {
      return number.toStringAsFixed(4);
    } else {
      return number.toStringAsFixed(6);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Currency Converter'),
        centerTitle: true,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _service.fetchExchangeRates,
            tooltip: 'Refresh rates',
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Consumer<ExchangeService>(
              builder: (context, service, child) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 16),

                    // Amount Input Card
                    Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          children: [
                            TextField(
                              controller: _amountController,
                              keyboardType: TextInputType.numberWithOptions(decimal: true),
                              decoration: InputDecoration(
                                labelText: 'Amount',
                                prefixIcon: const Icon(Icons.attach_money_rounded),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                suffixIcon: IconButton(
                                  icon: const Icon(Icons.clear),
                                  onPressed: () {
                                    _amountController.clear();
                                    service.setAmount(0);
                                  },
                                ),
                              ),
                              onChanged: (value) {
                                final amount = double.tryParse(value) ?? 0;
                                service.setAmount(amount);
                              },
                            ),
                            const SizedBox(height: 20),
                            
                            // Currency Selection Row
                            Row(
                              children: [
                                Expanded(
                                  child: CurrencyCard(
                                    currency: service.fromCurrency,
                                    onTap: () => _showCurrencyPicker(true),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 8),
                                  child: IconButton(
                                    onPressed: service.swapCurrencies,
                                    icon: Container(
                                      padding: const EdgeInsets.all(12),
                                      decoration: BoxDecoration(
                                        color: Theme.of(context).colorScheme.primary,
                                        shape: BoxShape.circle,
                                      ),
                                      child: const Icon(
                                        Icons.swap_horiz_rounded,
                                        color: Colors.white,
                                        size: 24,
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: CurrencyCard(
                                    currency: service.toCurrency,
                                    onTap: () => _showCurrencyPicker(false),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 24),

                    // Conversion Result
                    if (service.isLoading)
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 40),
                        child: Column(
                          children: [
                            const CircularProgressIndicator(),
                            const SizedBox(height: 16),
                            Text(
                              'Fetching latest rates...',
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ],
                        ),
                      )
                    else if (service.errorMessage.isNotEmpty && service.errorMessage.contains('Using sample'))
                      Card(
                        margin: EdgeInsets.zero,
                        elevation: 2,
                        color: Colors.orange[900]!.withOpacity(0.2),
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Row(
                            children: [
                              Icon(Icons.info_outline, color: Colors.orange[700]),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  'Using sample rates for demo',
                                  style: TextStyle(color: Colors.orange[700]),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    else if (service.errorMessage.isNotEmpty)
                      Card(
                        margin: EdgeInsets.zero,
                        elevation: 2,
                        color: Colors.red[900]!.withOpacity(0.2),
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Row(
                            children: [
                              const Icon(Icons.error_outline, color: Colors.red),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  service.errorMessage,
                                  style: const TextStyle(color: Colors.red),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    else
                      Card(
                        margin: EdgeInsets.zero,
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(24.0),
                          child: Column(
                            children: [
                              Text(
                                '${_formatNumber(service.amount)} ${service.fromCurrency.code}',
                                style: Theme.of(context).textTheme.titleLarge,
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 12),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    '=',
                                    style: Theme.of(context).textTheme.titleLarge,
                                  ),
                                  const SizedBox(width: 8),
                                  Flexible(
                                    child: Text(
                                      '${_formatNumber(service.convertedAmount)} ${service.toCurrency.code}',
                                      style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: Theme.of(context).colorScheme.primary,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 20),
                              Divider(color: Colors.grey[700]),
                              const SizedBox(height: 16),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Column(
                                      children: [
                                        Text(
                                          '1 ${service.fromCurrency.code}',
                                          style: const TextStyle(fontSize: 12),
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          '${_formatNumber(service.convertedAmount / service.amount)} ${service.toCurrency.code}',
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Column(
                                      children: [
                                        Text(
                                          '1 ${service.toCurrency.code}',
                                          style: const TextStyle(fontSize: 12),
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          '${_formatNumber(service.amount / service.convertedAmount)} ${service.fromCurrency.code}',
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              if (service.lastUpdated != null)
                                Padding(
                                  padding: const EdgeInsets.only(top: 16),
                                  child: Text(
                                    'Last updated: ${service.lastUpdated!.hour.toString().padLeft(2, '0')}:${service.lastUpdated!.minute.toString().padLeft(2, '0')}',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey[500],
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),

                    const SizedBox(height: 24),

                    // Popular Currencies Section
                    Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: Text(
                              'Popular Currencies',
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                          ),
                          const SizedBox(height: 12),
                          SizedBox(
                            height: 120, // Fixed height to prevent overflow
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: Currency.getPopularCurrencies().length,
                              itemBuilder: (context, index) {
                                final currency = Currency.getPopularCurrencies()[index];
                                return Container(
                                  width: 100,
                                  margin: const EdgeInsets.only(right: 12),
                                  child: InkWell(
                                    onTap: () {
                                      service.setToCurrency(currency);
                                    },
                                    borderRadius: BorderRadius.circular(12),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: service.toCurrency.code == currency.code
                                            ? Theme.of(context).colorScheme.primary.withOpacity(0.2)
                                            : Theme.of(context).colorScheme.surfaceVariant,
                                        borderRadius: BorderRadius.circular(12),
                                        border: Border.all(
                                          color: service.toCurrency.code == currency.code
                                              ? Theme.of(context).colorScheme.primary
                                              : Colors.transparent,
                                          width: 2,
                                        ),
                                      ),
                                      padding: const EdgeInsets.all(12),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            currency.flag,
                                            style: const TextStyle(fontSize: 24),
                                          ),
                                          const SizedBox(height: 8),
                                          Text(
                                            currency.code,
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 14,
                                            ),
                                          ),
                                          const SizedBox(height: 4),
                                          Flexible(
                                            child: Text(
                                              currency.symbol,
                                              style: const TextStyle(
                                                fontSize: 12,
                                                color: Colors.grey,
                                              ),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Quick Amount Buttons
                    Padding(
                      padding: const EdgeInsets.only(bottom: 24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: Text(
                              'Quick Amount',
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            children: [10, 50, 100, 500, 1000, 5000].map((amount) {
                              return ActionChip(
                                label: Text(
                                  amount.toString(),
                                  style: const TextStyle(fontWeight: FontWeight.bold),
                                ),
                                onPressed: () {
                                  _amountController.text = amount.toString();
                                  service.setAmount(amount.toDouble());
                                },
                                backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
                              );
                            }).toList(),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 80), // Bottom padding for FAB
                  ],
                );
              },
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _service.swapCurrencies,
        icon: const Icon(Icons.swap_horiz_rounded),
        label: const Text('Swap'),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}