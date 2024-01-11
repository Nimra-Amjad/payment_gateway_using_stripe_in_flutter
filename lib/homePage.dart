import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Map<String, dynamic>? paymentIntent;

  void makePayment() async {
    try {
      paymentIntent = await createPaymentIntent();
      var gpay = PaymentSheetGooglePay(
          merchantCountryCode: "US", currencyCode: "US", testEnv: true);
      await Stripe.instance.initPaymentSheet(
          paymentSheetParameters: SetupPaymentSheetParameters(
        paymentIntentClientSecret: paymentIntent!["client_secret"],
        style: ThemeMode.dark,
        merchantDisplayName: "Nimra",
        googlePay: gpay,
      ));
      displayPaymentSheet();
      print("helloooo");
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  void displayPaymentSheet() {
    try {
      Stripe.instance.presentPaymentSheet();
      print("done");
    } catch (e) {
      print("failed");
    }
  }

  createPaymentIntent() async {
    try {
      Map<String, dynamic> body = {"amount": "1000", "currency": "USD"};

      http.Response resonse = await http.post(
          Uri.parse("https://api.stripe.com/v1/payment_intents"),
          body: body,
          headers: {
            "Authorization":
                "Bearer sk_test_51OWbyqD49ZkMlbPCBNVFbUh0IXh3ikRItGyYY1j2ZT3NYNSWKWzrlSYGlbAtMiA179mqtOnkESUx22VvbxHGx3yh00jBiUb5j5",
            "Content-Type": "application/x-www-form-urlencoded"
          });
      return json.decode(resonse.body);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Stripe Payment Integration"),
      ),
      body: Center(
        child: ElevatedButton(
            onPressed: () {
              makePayment();
            },
            child: Text("Pay Me")),
      ),
    );
  }
}
