import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:slicelife/models/user_model.dart';

enum StateRegistration {
  // ignore: constant_identifier_names
  COMPLETE,
  // ignore: constant_identifier_names
  IN_PROGRESS,
}

class UserService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

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
      await mailingList(userModel.email!,
          stateRegistration: StateRegistration.COMPLETE);
    }

    userModel.uid = userCredential.user!.uid;
    return userModel;
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }

  Future<StateRegistration> mailingList(
    String email, {
    StateRegistration? stateRegistration,
  }) async {
    DocumentReference documentReference =
        _firebaseFirestore.collection('mailinglist').doc(email);

    DocumentSnapshot documentSnapshot = await documentReference.get();

    // ignore: unnecessary_null_comparison
    if (stateRegistration != null) {
      await _firebaseFirestore.collection('mailinglist').doc(email).set({
        'state': stateRegistration.toString(),
      });
      return stateRegistration;
    }
    if (documentSnapshot.exists) {
      String state = documentSnapshot.get('state');
      return StateRegistration.values
          .firstWhere((element) => element.toString() == state);
    }
    await documentReference.set({
      'state': StateRegistration.IN_PROGRESS.toString(),
    });

    return StateRegistration.IN_PROGRESS;
  }
}
