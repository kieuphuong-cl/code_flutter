// import 'package:flutter/material.dart';
// import 'package:buoi_cuoi/data/api.dart'; // Import API provider
// import 'package:buoi_cuoi/model/bill.dart'; // Import Bill model

// class PaymentPage extends StatelessWidget {
//   const PaymentPage({Key? key}) : super(key: key);

//   // Function to process payment using API
//   Future<void> processPayment(List<Bill> bills) async {
//     try {
//       // Call the API to process the payment
//       await APIRepository().toBill(bills);
//       print('Payment successful');
//     } catch (ex) {
//       print('Error processing payment: $ex');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Payment'),
//       ),
//       body: Center(
//         child: ElevatedButton(
//           onPressed: () {
//             // Example bills for testing
//             List<Bill> lstBill = [];
//             Future<String> Payment() async {
//               await APIRepository().toBill(lstBill);
//               return "";
//             }

//             // Process the payment
//             processPayment(lstBill);
//           },
//           child: Text('Process Payment'),
//         ),
//       ),
//     );
//   }
// }
