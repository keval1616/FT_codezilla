// import 'package:flutter/material.dart';
// import 'package:google_sign_in/google_sign_in.dart';
// import 'package:googleapis/drive/v3.dart' as drive;
// import 'package:googleapis_auth/auth_io.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Google Drive Demo',
//       home: HomePage(),
//     );
//   }
// }

// class HomePage extends StatefulWidget {
//   @override
//   _HomePageState createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   final _googleSignIn = GoogleSignIn(scopes: [drive.DriveApi.driveMetadataReadScope]);
//   drive.DriveApi? _driveApi;

//   @override
//   void initState() {
//     super.initState();
//     _initializeDriveApi();
//   }

//   Future<void> _initializeDriveApi() async {
//     final authClient = await _googleSignIn.signInSilently().then((account) {
//       if (account == null) throw Exception('No signed in account');
//       return authenticatedClient(
//         account,
//         ClientId('<your client ID>', '<your client secret>'),
//       );
//     });

//     setState(() {
//       _driveApi = drive.DriveApi(authClient);
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Google Drive Demo')),
//       body: _driveApi == null ? Center(child: CircularProgressIndicator()) : FutureBuilder(
//         future: _driveApi!.files.list(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(child: CircularProgressIndicator());
//           } else if (snapshot.hasError) {
//             return Text('Error: ${snapshot.error}');
//           } else {
//             final files = (snapshot.data as drive.FileList).files;
//             return ListView.builder(
//               itemCount: files.length,
//               itemBuilder: (context, index) => ListTile(
//                 title: Text(files[index].name!),
//                 subtitle: Text(files[index].id!),
//               ),
//             );
//           }
//         },
//       ),
//     );
//   }
// }
