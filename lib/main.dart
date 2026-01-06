// // import 'package:flutter/material.dart';
// // import 'package:flutter_dotenv/flutter_dotenv.dart';
// // import 'package:provider/provider.dart';
// // import 'package:currency_converter/screens/home_screen.dart';
// // import 'package:currency_converter/services/exchange_service.dart';

// // void main() async {
// //   WidgetsFlutterBinding.ensureInitialized();
// //   await dotenv.load(fileName: ".env");
// //   runApp(const MyApp());
// // }

// // class MyApp extends StatelessWidget {
// //   const MyApp({super.key});

// //   @override
// //   Widget build(BuildContext context) {
// //     return MultiProvider(
// //       providers: [
// //         ChangeNotifierProvider(
// //           create: (_) => ExchangeService(),
// //         ),
// //       ],
// //       child: MaterialApp(
// //         title: 'Currency Converter',
// //         theme: ThemeData(
// //           colorScheme: ColorScheme.fromSeed(
// //             seedColor: Colors.deepPurple,
// //             brightness: Brightness.dark,
// //           ),
// //           useMaterial3: true,
// //         ),
// //         home: const HomeScreen(),
// //         debugShowCheckedModeBanner: false,
// //       ),
// //     );
// //   }
// // }
// import 'package:flutter/material.dart';
// import 'package:flutter_dotenv/flutter_dotenv.dart';
// import 'package:provider/provider.dart';
// import 'package:currency_converter/screens/home_screen.dart';
// import 'package:currency_converter/services/exchange_service.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await dotenv.load(fileName: ".env");
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MultiProvider(
//       providers: [
//         ChangeNotifierProvider(
//           create: (_) => ExchangeService(),
//         ),
//       ],
//       child: MaterialApp(
//         title: 'Currency Converter Pro',
//         theme: ThemeData(
//           colorScheme: ColorScheme.fromSeed(
//             seedColor: Colors.deepPurple,
//             brightness: Brightness.dark,
//           ),
//           useMaterial3: true,
//         ),
//         home: const HomeScreen(),
//         debugShowCheckedModeBanner: false,
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:currency_converter/screens/home_screen.dart';
// import 'package:currency_converter/services/exchange_service.dart'; // Remove this
import 'package:currency_converter/services/free_exchange_service.dart'; // Add this

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await dotenv.load(fileName: ".env"); // Remove this line if not using .env
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          // create: (_) => ExchangeService(), // Remove this
          create: (_) => FreeExchangeService(), // Add this
        ),
      ],
      child: MaterialApp(
        title: 'Currency Converter Pro',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.deepPurple,
            brightness: Brightness.dark,
          ),
          useMaterial3: true,
        ),
        home: const HomeScreen(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}