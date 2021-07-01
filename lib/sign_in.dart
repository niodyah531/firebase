import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_sign_in/google_sign_in.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn googleSignIn = GoogleSignIn();

String name;
String email;
String imageUrl;

Future<String> signInWithGoogle() async {
  await Firebase.initializeApp();

  final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
  final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;

  final AuthCredential credential = GoogleAuthProvider.credential(
    accessToken: googleSignInAuthentication.accessToken,
    idToken: googleSignInAuthentication.idToken,
  );

  final UserCredential authResult = await _auth.signInWithCredential(credential);
  final User user = authResult.user;

  if (user != null) {
    //pengecekan jika email=null
    assert(user.email != null);
    assert(user.displayName != null);
    assert(user.photoURL != null);

    name = user.displayName;
    email = user.email;
    imageUrl = user.photoURL;

    //hanya mengambil bagian pertama dari nama yaitu nama depan
    if (name.contains(" ")) {
      name = name.substring(0, name.indexOf(" "));
    }

    assert(!user.isAnonymous);
    assert(await user.getIdToken() != null);

    final User currentUser = _auth.currentUser;
    assert(user.uid == currentUser.uid);
    print('signInWithGoogle succeeded: $user');
    return '$user';
  }
  return null;
}

Future<String> SignInWithEmailAndPassword(String username, String pass) async {
  await Firebase.initializeApp();

  UserCredential userAuth = (await _auth.signInWithEmailAndPassword(email: username, password: pass));
  User user = userAuth.user;

  if (user != null) {
    //pengecekan jika email=null
    assert(user.email != null);

    name = user.email;
    email = user.email;
    imageUrl = user.email;
    //hanya mengambil bagian pertama dari nama yaitu nama depan
    if (name.contains("@")){
      name = name.substring(0, name.indexOf("@"));
    }
    assert(!user.isAnonymous);
    assert(await user.getIdToken() != null);
    final User currentUser = _auth.currentUser;
    assert(user.uid == currentUser.uid);
    print('signInWithGoogle successed: $user');
    return '$user';
  }
  return null;
}

Future<String> createUserWithEmailAndPassword(
  String username, String pass) async {
    await Firebase.initializeApp();

    UserCredential userAuth = (await _auth.createUserWithEmailAndPassword(email: username, password: pass));
    User user = userAuth.user;

    if (user != null) {
      //pengecekan jika email=null
      assert(user.email != null);

      name = user.email;
      email = user.email;
      imageUrl = user.email;
      //hanya mengambil bagian pertama dari nama yaitu nama depan
      if (name.contains("@")) {
        name = name.substring(0, name.indexOf("@"));
      }
      assert(!user.isAnonymous);
      assert(await user.getIdToken() != null);
      final User currentUser = _auth.currentUser;
      assert(user.uid == currentUser.uid);
      print('signInWithGoogle succesed: $user');
      return '$user';
    }
    return null;
  }
Future<void> signOutGoogle() async {
  await googleSignIn.signOut();
  print("User Signed Out");
}