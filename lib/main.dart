import 'package:flutt/src/screens/login/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Stripe.publishableKey =
      'pk_test_51Oxs9QCMuDUzDr4EQ3XtpeFJ3FEpOJR1Hzld7tD7Rlw8OEZ2TLRtsjMmjsJGZOYSLnxgCNYjJx4V96TEpoH0QTb600ItsREEoL';
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      locale: const Locale('es'),
      title: 'Tienda Electrónica',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      initialRoute: 'login',
      routes: {
        'login': (BuildContext context) => const LoginPage(),
      },
    );
  }
}
