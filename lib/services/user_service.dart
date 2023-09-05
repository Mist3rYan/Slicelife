import 'package:firebase_auth/firebase_auth.dart';
import 'package:slicelife/models/user_model.dart';

class UserService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Stream<UserModel> get user {
    return _auth
        .authStateChanges()
        .asyncMap((user) => UserModel(uid: user!.uid, email: user.email));
  }

  Future<UserModel> auth(UserModel userModel) async {
    // ignore: unused_local_variable
    UserCredential userCredential;

    try {
      userCredential = await _auth.signInWithEmailAndPassword(
          email: userModel.email!, password: userModel.password!);
    } catch (e) {
      userCredential = await _auth.createUserWithEmailAndPassword(
          email: userModel.email!, password: userModel.password!);
    }

    userModel.uid = userCredential.user!.uid;
    return userModel;
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }
}
