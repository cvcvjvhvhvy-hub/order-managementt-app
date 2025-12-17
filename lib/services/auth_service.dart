import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  
  FirebaseAuth get auth => _auth;

  Future<void> verifyPhoneNumber(
    String phoneNumber,
    Function(String) codeSent,
    Function(String) verificationCompleted,
    Function(FirebaseAuthException) verificationFailed,
  ) async {
    await _auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (PhoneAuthCredential credential) async {
        await _auth.signInWithCredential(credential);
        verificationCompleted('Auto verified');
      },
      verificationFailed: verificationFailed,
      codeSent: (String verificationId, int? resendToken) {
        codeSent(verificationId);
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }

  Future<UserCredential> signInWithSmsCode(String verificationId, String smsCode) async {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
      verificationId: verificationId,
      smsCode: smsCode,
    );
    return await _auth.signInWithCredential(credential);
  }

  Future<void> registerUser(User user) async {
    await _firestore.collection('users').doc(user.id).set(user.toMap());
  }

  Future<User?> getCurrentUser() async {
    User? firebaseUser = _auth.currentUser;
    if (firebaseUser != null) {
      DocumentSnapshot doc = await _firestore.collection('users').doc(firebaseUser.uid).get();
      if (doc.exists) {
        return User.fromMap(doc.data() as Map<String, dynamic>);
      }
    }
    return null;
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }
}