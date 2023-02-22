// import 'dart:io';
//
// import 'package:codezilla/screen/editscan_screen/editscanscreen.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:marquee/marquee.dart';
// import 'package:qr_code_scanner/qr_code_scanner.dart';
//
//
// class QrScannerPage extends StatefulWidget {
//   const QrScannerPage({super.key});
//
//   @override
//   State<QrScannerPage> createState() => _QrScannerPageState();
// }
//
// class _QrScannerPageState extends State<QrScannerPage> {
//   final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
//   Barcode? result;
//   QRViewController? controller;
//   bool navigate = true;
//
//   @override
//   Widget build(BuildContext context) {
//     var scanArea = (MediaQuery.of(context).size.width < 400 ||
//         MediaQuery.of(context).size.height < 400)
//         ? 180.0
//         : 300.0;
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text(
//           'QR Code',
//           style: TextStyle(color: Colors.black),
//         ),
//         centerTitle: true,
//         elevation: 0.0,
//         backgroundColor: Colors.transparent,
//         leading: GestureDetector(
//           onTap: () {
//             Navigator.pop(context);
//           },
//           child: const Icon(
//             Icons.arrow_back_ios,
//             color: Colors.black,
//             size: 20.0,
//           ),
//         ),
//       ),
//       body: Stack(
//         children: <Widget>[
//           QRView(
//             key: qrKey,
//             overlay: QrScannerOverlayShape(
//                 borderColor: Colors.red,
//                 borderRadius: 10,
//                 borderLength: 30,
//                 borderWidth: 10,
//                 cutOutSize: scanArea),
//             onQRViewCreated: _onQRViewCreated,
//           ),
//           Positioned(top: 100.0, child: textScroll()),
//           Positioned(
//               bottom: 100.0,
//               left: 0.0,
//               right: 0.0,
//               child: GestureDetector(
//                 onTap: () {},
//                 child: Container(
//                   height: 50.0,
//                   margin: const EdgeInsets.symmetric(horizontal: 20.0),
//                   padding: const EdgeInsets.symmetric(vertical: 15.0),
//                   decoration: BoxDecoration(
//                       color: Colors.red,
//                       borderRadius:
//                       const BorderRadius.all(Radius.circular(30.0))),
//                   child: const Center(
//                     child: Text(
//                       'VIEW CUSTOMER HISTORY',
//                       style: TextStyle(
//                           fontSize: 16.0,
//                           fontWeight: FontWeight.w500,
//                           color: Colors.white),
//                     ),
//                   ),
//                 ),
//               ))
//         ],
//       ),
//     );
//   }
//
//   void _onQRViewCreated(QRViewController controller) {
//     setState(() {
//       this.controller = controller;
//       resuecamara();
//     });
//     controller.scannedDataStream.listen((scanData) {
//       if (navigate) {
//         navigate = false;
//         Navigator.of(context)
//             .push(MaterialPageRoute(
//             builder: (context) => EditscanScreen(result: scanData)))
//             .then((value) {
//           // navigate = true;
//         });
//       }
//     });
//   }
//
//   void resuecamara() {
//     if (Platform.isAndroid) {
//       controller!.pauseCamera();
//     }
//     controller!.resumeCamera();
//   }
//
//   Widget textScroll() {
//     return Container(
//       width: MediaQuery.of(context).size.width,
//       height: 40.0,
//       decoration: const BoxDecoration(color: Colors.amberAccent),
//       child: Center(
//         child: Marquee(
//           text: '    Access is allowed    ',
//           style: const TextStyle(
//               color: Colors.black, fontSize: 18.0, fontWeight: FontWeight.bold),
//         ),
//       ),
//     );
//   }
//
//   @override
//   void dispose() {
//     controller?.dispose();
//     super.dispose();
//   }
// }
