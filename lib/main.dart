import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:stripe_payment_gateway/homePage.dart';

void main() {
  Stripe.publishableKey =
      'pk_test_51OWbyqD49ZkMlbPCa20LBj5MQANRa5cE3eXkr6mUlPvV9wxTxL8B6aaxfcAvdDO5lbCp6ojWEwrSHdKhmJXBSDvm00KtZRAMyA';
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}
