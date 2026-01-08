// import 'package:flutter/material.dart';
// import 'package:currency_converter/models/currency.dart';

// class CurrencyCard extends StatelessWidget {
//   final Currency currency;
//   final VoidCallback onTap;

//   const CurrencyCard({
//     super.key,
//     required this.currency,
//     required this.onTap,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: onTap,
//       borderRadius: BorderRadius.circular(12),
//       child: Container(
//         padding: const EdgeInsets.all(16),
//         decoration: BoxDecoration(
//           color: Theme.of(context).colorScheme.surfaceVariant,
//           borderRadius: BorderRadius.circular(12),
//           border: Border.all(
//             color: Theme.of(context).colorScheme.outline.withOpacity(0.3),
//           ),
//         ),
//         child: Row(
//           children: [
//             Text(
//               currency.flag,
//               style: const TextStyle(fontSize: 24),
//             ),
//             const SizedBox(width: 12),
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     currency.code,
//                     style: const TextStyle(
//                       fontWeight: FontWeight.bold,
//                       fontSize: 16,
//                     ),
//                   ),
//                   Text(
//                     currency.name,
//                     style: TextStyle(
//                       color: Colors.grey[600],
//                       fontSize: 12,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             Icon(
//               Icons.arrow_drop_down,
//               color: Theme.of(context).colorScheme.onSurfaceVariant,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:currency_converter/models/currency.dart';

class CurrencyCard extends StatelessWidget {
  final Currency currency;
  final VoidCallback onTap;

  const CurrencyCard({
    super.key,
    required this.currency,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surfaceVariant,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: Theme.of(context).colorScheme.outline.withOpacity(0.3),
          ),
        ),
        child: Row(
          children: [
            Container(
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
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    currency.code,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 2),
                  Text(
                    currency.name,
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 12,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.arrow_drop_down,
              color: Colors.grey,
            ),
          ],
        ),
      ),
    );
  }
}