// import 'dart:convert';
// import 'package:http/http.dart';
//
// import 'package:flutter/material.dart';
// import 'package:stripe_payment/stripe_payment.dart';
//
// class PaymentPage extends StatefulWidget {
//   @override
//   _PaymentPageState createState() => _PaymentPageState();
// }
//
// class _PaymentPageState extends State<PaymentPage> {
//   Token? _paymentToken;
//   PaymentMethod? _paymentMethod;
//   String _error = '';
//   bool _loading = false;
//
//   @override
//   void initState() {
//     super.initState();
//     StripePayment.setStripeAccount(null);
//   }
//
//   void setError(dynamic error) {
//     setState(() {
//       _error = error.toString();
//       _loading = false;
//     });
//   }
//
//   Future<void> createPaymentIntent(String amount, String currency) async {
//     try {
//       final response = await http.post(
//         Uri.parse('https://api.stripe.com/v1/payment_intents'),
//         headers: {
//           'Authorization': 'Bearer your_secret_key', // Replace with your secret key
//           'Content-Type': 'application/x-www-form-urlencoded',
//         },
//         body: {
//           'amount': amount, // Amount in smallest currency unit (e.g., cents for USD)
//           'currency': currency,
//           'payment_method_types[]': 'card',
//         },
//       );
//
//       final paymentIntent = jsonDecode(response.body);
//       return paymentIntent['client_secret'];
//     } catch (error) {
//       setError(error);
//     }
//   }
//
//   Future<void> makePayment() async {
//     try {
//       setState(() => _loading = true);
//
//       final clientSecret = await createPaymentIntent('1000', 'usd'); // $10.00
//
//       final paymentIntent = await StripePayment.confirmPaymentIntent(
//         PaymentIntent(
//           clientSecret: clientSecret,
//           paymentMethodId: _paymentMethod?.id,
//         ),
//       );
//
//       setState(() {
//         _paymentToken = paymentIntent.paymentIntentId;
//         _loading = false;
//       });
//
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Payment Successful!')),
//       );
//     } catch (error) {
//       setError(error);
//     }
//   }
//
//   Future<void> addCard() async {
//     try {
//       final paymentMethod = await StripePayment.paymentRequestWithCardForm(
//         CardFormPaymentRequest(),
//       );
//
//       setState(() {
//         _paymentMethod = paymentMethod;
//       });
//     } catch (error) {
//       setError(error);
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("Stripe Payment")),
//       body: _loading
//           ? Center(child: CircularProgressIndicator())
//           : Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           if (_paymentMethod != null)
//             Text('Payment Method: ${_paymentMethod!.card?.last4}'),
//           SizedBox(height: 20),
//           ElevatedButton(
//             onPressed: addCard,
//             child: Text("Add Card"),
//           ),
//           SizedBox(height: 20),
//           ElevatedButton(
//             onPressed: makePayment,
//             child: Text("Make Payment"),
//           ),
//           if (_error.isNotEmpty)
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Text(
//                 'Error: $_error',
//                 style: TextStyle(color: Colors.red),
//               ),
//             ),
//         ],
//       ),
//     );
//   }
// }
