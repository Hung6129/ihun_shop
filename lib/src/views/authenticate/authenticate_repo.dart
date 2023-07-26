// import 'package:flutter/material.dart';

// import 'presentation/sign_in_bloc/sign_in_bloc.dart';
// import 'presentation/sign_up_bloc/sign_up_bloc.dart';

// class AuthenticateRepo {
//   final BuildContext context;
//   const AuthenticateRepo({required this.context});

//   // take email and password then hanlde sign in
//   Future<void> handleSignIn(String type) async {
//     try {
//       if (type == "emailAndPassword") {
//         final state = context.read<SignInBloc>().state;
//         String email = state.email;
//         String password = state.password;
//         if (email.isEmpty) {
//           // email is emty
//           toastInfor(
//             text: "You need to fill in email address",
//             bgColor: Palettes.p7,
//             textColor: Colors.white,
//           );
//           return;
//         }
//         if (password.isEmpty) {
//           // password is emty
//           toastInfor(
//             text: "You need to fill in password",
//             bgColor: Palettes.p7,
//             textColor: Colors.white,
//           );
//           return;
//         }
//         if (!email.contains('@') && !email.contains('.')) {
//           // email is emty
//           toastInfor(
//             text: "Invaild email",
//             bgColor: Palettes.p7,
//             textColor: Colors.white,
//           );
//           return;
//         }
//         try {
//           final userCredential = await FirebaseAuth.instance
//               .signInWithEmailAndPassword(email: email, password: password);
//           if (userCredential.user == null) {
//             // user not exist
//             toastInfor(
//               text: "Sorry\nThe email address don't exist",
//               bgColor: Palettes.p7,
//               textColor: Colors.white,
//             );
//             return;
//           }
//           if (!userCredential.user!.emailVerified) {
//             // user not verified
//             toastInfor(
//               text:
//                   "You haven't verify your email address.\nPlease verify your account",
//               bgColor: Palettes.p7,
//               textColor: Colors.white,
//             );
//             return;
//           }
//           var user = userCredential.user;
//           if (user != null) {
//             toastInfor(
//               text: "Successfully sign in",
//               bgColor: Colors.greenAccent,
//               textColor: Colors.white,
//             );
//             Global.storageServices
//                 .setString(AppConstant.STORAGE_USER_TOKEN_KEY, '123456');
//             Global.storageServices.setBool(
//               AppConstant.STORAGE_DEVICE_OPEN_FIRST_TIME,
//               true,
//             );
//             // ignore: use_build_context_synchronously
//             Navigator.pushNamedAndRemoveUntil(
//                 context, '/main_page', (route) => false);
//             return;
//           } else {
//             toastInfor(
//               text: "You not a user of this app\nTry to sign up a new account",
//               bgColor: Palettes.p7,
//               textColor: Colors.white,
//             );
//             return;
//           }
//         } on FirebaseAuthException catch (e) {
//           if (e.code == 'user-not-found') {
//             toastInfor(
//               text: "No user found for that email",
//               bgColor: Palettes.p7,
//               textColor: Colors.white,
//             );
//             return;
//           } else if (e.code == 'wrong-password') {
//             toastInfor(
//               text: "Wrong password\nPlease try again",
//               bgColor: Palettes.p7,
//               textColor: Colors.white,
//             );
//             return;
//           } else if (e.code == 'invalid-email') {
//             toastInfor(
//               text: "Wrong email\nPlease try again",
//               bgColor: Palettes.p7,
//               textColor: Colors.white,
//             );
//             return;
//           }
//         }
//       }
//     } catch (e) {
//       toastInfor(
//         text: "Something went wrong\nPlease try again next time",
//         bgColor: Palettes.p7,
//         textColor: Colors.white,
//       );
//     }
//   }

//   // take email and password then hanlde sign up
//   Future<void> handleSignUp() async {
//     try {
//       final state = context.read<SignUpBloc>().state;
//       String email = state.email;
//       String password = state.password;
//       String userName = state.userName;
//       String reTypePassword = state.reTypePassword;
//       if (userName.isEmpty) {
//         // userName is emty
//         toastInfor(
//           text: "You need to fill in User Name",
//           bgColor: Palettes.p7,
//           textColor: Colors.white,
//         );
//         return;
//       }
//       if (email.isEmpty) {
//         // email is emty
//         toastInfor(
//           text: "You need to fill in Email address",
//           bgColor: Palettes.p7,
//           textColor: Colors.white,
//         );
//         return;
//       }
//       if (password.isEmpty) {
//         // password is emty
//         toastInfor(
//           text: "You need to fill in Password",
//           bgColor: Palettes.p7,
//           textColor: Colors.white,
//         );
//         return;
//       }
//       if (!email.contains('@') && !email.contains('.')) {
//         // email is emty
//         toastInfor(
//           text: "Invaild email",
//           bgColor: Palettes.p7,
//           textColor: Colors.white,
//         );
//         return;
//       }
//       if (reTypePassword.isEmpty) {
//         // reTypePassword is emty
//         toastInfor(
//           text: "You need to retype the Password",
//           bgColor: Palettes.p7,
//           textColor: Colors.white,
//         );
//         return;
//       }
//       if (reTypePassword != password) {
//         // check retype password
//         toastInfor(
//           text: "Retype password not match the password",
//           bgColor: Palettes.p7,
//           textColor: Colors.white,
//         );
//         return;
//       }
//       try {
//         final userCredential = await FirebaseAuth.instance
//             .createUserWithEmailAndPassword(email: email, password: password);
//         if (userCredential.user != null) {
//           await userCredential.user?.sendEmailVerification();
//           await userCredential.user?.updateDisplayName(userName);
//           toastInfor(
//             text:
//                 'An email has been sent to your email box\nPlease check and click the link to activate your account',
//             bgColor: Colors.greenAccent,
//             textColor: Colors.white,
//           );

//           // ignore: use_build_context_synchronously
//           Navigator.of(context).pop();
//         }
//       } on FirebaseAuthException catch (e) {
//         if (e.code == 'weak-password') {
//           toastInfor(
//             text: 'The password provided is too weak.',
//             bgColor: Palettes.p7,
//             textColor: Colors.white,
//           );
//         } else if (e.code == 'email-already-in-use') {
//           toastInfor(
//             text: 'The account already exists for that email.',
//             bgColor: Palettes.p7,
//             textColor: Colors.white,
//           );
//         }
//       }
//     } catch (e) {
//       toastInfor(
//         text: "Something went wrong\nPlease try again next time",
//         bgColor: Palettes.p7,
//         textColor: Colors.white,
//       );
//     }
//   }

//   // sign out
//   Future<void> signOut() async {
//     await FirebaseAuth.instance.signOut();
//   }

//   // using google mail to sign in
//   Future<void> handleSignInWithGoogle() async {
//     // Trigger the authentication flow
//     final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

//     // Obtain the auth details from the request
//     final GoogleSignInAuthentication? googleAuth =
//         await googleUser?.authentication;

//     // Create a new credential
//     final credential = GoogleAuthProvider.credential(
//       accessToken: googleAuth?.accessToken,
//       idToken: googleAuth?.idToken,
//     );

//     // Once signed in, return the UserCredential
//     try {
//       final user = await FirebaseAuth.instance.signInWithCredential(credential);
//       if (user.user == null) {
//         toastInfor(
//           text: "Something went wrong\nPlease try again next time",
//           bgColor: Palettes.p7,
//           textColor: Colors.white,
//         );
//       } else {
//         toastInfor(
//           text: "Successfully sign in",
//           bgColor: Colors.greenAccent,
//           textColor: Colors.white,
//         );
//         Global.storageServices
//             .setString(AppConstant.STORAGE_USER_TOKEN_KEY, '123456789');
//         Global.storageServices.setBool(
//           AppConstant.STORAGE_DEVICE_OPEN_FIRST_TIME,
//           true,
//         );
//         // ignore: use_build_context_synchronously
//         Navigator.pushNamedAndRemoveUntil(
//             context, '/main_page', (route) => false);
//       }
//     } on FirebaseAuthException catch (e) {
//       if (e.code == 'account-exists-with-different-credential') {
//         toastInfor(
//           text: "The account already exists with a different credential.",
//           bgColor: Palettes.p7,
//           textColor: Colors.white,
//         );
//       } else if (e.code == 'invalid-credential') {
//         toastInfor(
//           text: "Error occurred while accessing credentials. Try again.",
//           bgColor: Palettes.p7,
//           textColor: Colors.white,
//         );
//       }
//     } catch (e) {
//       toastInfor(
//         text: "Error occurred using Google Sign-In. Try again.",
//         bgColor: Palettes.p7,
//         textColor: Colors.white,
//       );
//     }
//   }
// }
