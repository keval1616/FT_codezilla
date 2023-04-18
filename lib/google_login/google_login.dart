// import 'dart:io';
//
// import 'package:file_picker/file_picker.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
//
// import 'package:path/path.dart' as path;
// import 'package:url_launcher/url_launcher.dart';
// import 'package:http/http.dart' as http;
// import 'package:path/path.dart' as p;
//
// class LoginScreen extends StatefulWidget {
//   const LoginScreen({super.key});
//
//   @override
//   State<LoginScreen> createState() => _LoginScreenState();
// }
// const _clientId = "676041512066-fvrm1mavqj2ob61i34j3og82cjcjienf.apps.googleusercontent.com";
// const _scopes = ['https://www.googleapis.com/auth/drive.file'];
//
// class _LoginScreenState extends State<LoginScreen> {
//   final FirebaseAuth googleuser = FirebaseAuth.instance;
//
//   final storage = new FlutterSecureStorage();
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   final GoogleSignIn googleSignIn =
//       GoogleSignIn(scopes: ['https://www.googleapis.com/auth/drive.appdata']);
//   GoogleSignInAccount? googleSignInAccount;
//   // ga.FileList list;
//   // var signedIn = false;
//   final GoogleDrive googleDrive = GoogleDrive();
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: Column(
//           children: [
//             SizedBox(
//               height: 20,
//             ),
//             GestureDetector(
//               onTap: _loginWithGoogle,
//               child: Center(
//                 child: Container(
//                     height: 100,
//                     width: 100,
//                     color: Colors.red,
//                     child: Center(child: Text("signin"))),
//               ),
//             ),
//               SizedBox(
//               height: 20,
//             ),
//             GestureDetector(
//               onTap: (){
//                 googleDrive.getHttpClient();
//               },
//               child: Center(
//                 child: Container(
//                     height: 100,
//                     width: 100,
//                     color: Colors.red,
//                     child: Center(child: Text("upload"))),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//   // Future<String?> signInWithGoogle() async {
//   //   try {
//   //     UserCredential? userCredential;
//   //     final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
//   //     final GoogleSignInAuthentication googleAuth =
//   //     await googleUser!.authentication;
//   //     final AuthCredential googleAuthCredential = GoogleAuthProvider.credential(
//   //       accessToken: googleAuth.accessToken,
//   //       idToken: googleAuth.idToken,
//   //     );
//   //     userCredential = await googleuser
//   //         .signInWithCredential(googleAuthCredential)
//   //         .then((value) {
//   //       print("google user email => ${value.user?.email}");
//   //       print("google user accrssToken => ${googleAuth.accessToken}");
//   //       print("google user idToken => ${googleAuth.idToken}");
//   //       print("google displayName => ${value.user?.displayName}");
//   //       print("google uid => ${value.user?.uid}");
//   //     });
//   //   } catch (e) {
//   //     print("Firebase google sign in error=====> " + e.toString());
//   //   }
//   // }
//
//   Future<void> _loginWithGoogle() async {
//     // signedIn = await storage.read(key: "signedIn") == "true" ? true : false;
//     googleSignIn.onCurrentUserChanged
//         .listen((GoogleSignInAccount? googleSignInAccount) async {
//       if (googleSignInAccount != null) {
//         _afterGoogleLogin(googleSignInAccount);
//       }
//     });
//     // if (signedIn) {
//     //   try {
//     //     googleSignIn.signInSilently().whenComplete(() => () {});
//     //   } catch (e) {
//     //     storage.write(key: "signedIn", value: "false").then((value) {
//     //       setState(() {
//     //         signedIn = false;
//     //       });
//     //     });
//     //   }
//     // } else {
//     final GoogleSignInAccount? googleSignInAccount =
//         await googleSignIn.signIn();
//     _afterGoogleLogin(googleSignInAccount);
//     // }
//   }
//
//   Future<void> _afterGoogleLogin(GoogleSignInAccount? gSA) async {
//     googleSignInAccount = gSA;
//     final GoogleSignInAuthentication? googleSignInAuthentication =
//         await googleSignInAccount?.authentication;
//
//     final AuthCredential credential = GoogleAuthProvider.credential(
//       accessToken: googleSignInAuthentication?.accessToken,
//       idToken: googleSignInAuthentication?.idToken,
//     );
//
//     final UserCredential authResult =
//         await _auth.signInWithCredential(credential);
//     final User? user = authResult.user;
//
//     assert(!user!.isAnonymous);
//     assert(await user?.getIdToken() != null);
//
//     final User? currentUser = _auth.currentUser;
//     assert(user?.uid == currentUser?.uid);
//
//     print('signInWithGoogle succeeded: $user');
//
//     // storage.write(key: "signedIn", value: "true").then((value) {
//     //   setState(() {
//     //     signedIn = true;
//     //   });
//     // });
//   }
//
// //   _uploadFileToGoogleDrive() async {
// //   var client = GoogleHttpClient(await googleSignInAccount!.authHeaders);
// //   var drive = ga.DriveApi(client);
// //   ga.File fileToUpload = ga.File();
// //   var file = await FilePicker.platform.pickFiles();
// //   fileToUpload.parents = ["appDataFolder"];
// //   fileToUpload.name = path.basename(file?.files.first.path??"");
// //   var response = await drive.files.create(
// //     fileToUpload,
// //     uploadMedia: ga.Media(file!.files.first.readStream!, file.files.first.size),
// //   );
// //   print(response);
// // }
// }
//
// // class GoogleHttpClient extends IOClient {
// //   Map<String, String> _headers;
// //
// //   GoogleHttpClient(this._headers) : super();
// //
// //   @override
// //   Future<IOStreamedResponse> send(BaseRequest request) =>
// //       super.send(request..headers.addAll(_headers));
// //
// //   @override
// //   Future<Response> head(Object url, {Map<String, String>? headers}) => super
// //       .head(Uri.parse(url.toString()), headers: headers?..addAll(_headers));
// // }
//
// class GoogleDrive {
//   final storage = SecureStorage();
//   //Get Authenticated Http Client
//   Future<http.Client> getHttpClient() async {
//     //Get Credentials
//     var credentials = await storage.getCredentials();
//     if (credentials == null) {
//       //Needs user authentication
//       var authClient = await clientViaUserConsent(
//           ClientId(_clientId),_scopes, (url) {
//         //Open Url in Browser
//         launch(url);
//       });
//       //Save Credentials
//       // await storage.saveCredentials(authClient.credentials.accessToken,
//       //     authClient.credentials.refreshToken!);
//       return authClient;
//     } else {
//       print(credentials["expiry"]);
//       //Already authenticated
//       return authenticatedClient(
//           http.Client(),
//           AccessCredentials(
//               AccessToken(credentials["type"], credentials["data"],
//                   DateTime.tryParse(credentials["expiry"])!),
//               credentials["refreshToken"],
//               _scopes));
//     }
//   }
//
// // check if the directory forlder is already available in drive , if available return its id
// // if not available create a folder in drive and return id
// //   if not able to create id then it means user authetication has failed
//   Future<String?> _getFolderId(ga.DriveApi driveApi) async {
//     final mimeType = "application/vnd.google-apps.folder";
//     String folderName = "personalDiaryBackup";
//
//     try {
//       final found = await driveApi.files.list(
//         q: "mimeType = '$mimeType' and name = '$folderName'",
//         $fields: "files(id, name)",
//       );
//       final files = found.files;
//       if (files == null) {
//         print("Sign-in first Error");
//         return null;
//       }
//
//       // The folder already exists
//       if (files.isNotEmpty) {
//         return files.first.id;
//       }
//
//       // Create a folder
//       ga.File folder = ga.File();
//       folder.name = folderName;
//       folder.mimeType = mimeType;
//       final folderCreation = await driveApi.files.create(folder);
//       print("Folder ID: ${folderCreation.id}");
//
//       return folderCreation.id;
//     } catch (e) {
//       print(e);
//       return null;
//     }
//   }
//
//
//   uploadFileToGoogleDrive(File file) async {
//     var client = await getHttpClient();
//     var drive = ga.DriveApi(client);
//     String? folderId =  await _getFolderId(drive);
//     if(folderId == null){
//       print("Sign-in first Error");
//     }else {
//       ga.File fileToUpload = ga.File();
//       fileToUpload.parents = [folderId];
//       fileToUpload.name = p.basename(file.absolute.path);
//       var response = await drive.files.create(
//         fileToUpload,
//         uploadMedia: ga.Media(file.openRead(), file.lengthSync()),
//       );
//       print(response);
//     }
//
//   }
//
//
//
//
// }
// class SecureStorage {
//   final storage = FlutterSecureStorage();
//
//   //Save Credentials
//   // Future saveCredentials(AccessToken token, String refreshToken) async {
//   //   print(token.expiry.toIso8601String());
//   //   await storage.write(key: "type", value: token.type);
//   //   await storage.write(key: "data", value: token.data);
//   //   await storage.write(key: "expiry", value: token.expiry.toString());
//   //   await storage.write(key: "refreshToken", value: refreshToken);
//   // }
//
//   //Get Saved Credentials
//   Future<Map<String, dynamic>?> getCredentials() async {
//     var result = await storage.readAll();
//     if (result.isEmpty) return null;
//     return result;
//   }
//
//   //Clear Saved Credentials
//   Future clear() {
//     return storage.deleteAll();
//   }
// }
