import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user_model.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// تسجيل دخول المستخدم
  Future<UserModel?> signIn(String email, String password) async {
    try {
      UserCredential userCredential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      
      DocumentSnapshot doc = await _firestore.collection('users').doc(userCredential.user!.uid).get();
      
      if (doc.exists) {
        return UserModel.fromMap(doc.data() as Map<String, dynamic>);
      }
      return null;
    } on FirebaseAuthException catch (e) {
      throw _handleAuthException(e);
    }
  }

  /// إنشاء حساب جديد
  Future<UserModel?> signUp(String email, String password, String name) async {
    try {
      UserCredential userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      UserModel user = UserModel(
        id: userCredential.user!.uid,
        email: email,
        name: name,
        isVerified: false,
        createdAt: DateTime.now(),
      );

      await _firestore.collection('users').doc(user.id).set(user.toMap());
      
      return user;
    } on FirebaseAuthException catch (e) {
      throw _handleAuthException(e);
    }
  }

  /// تسجيل الخروج
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  /// الحصول على المستخدم الحالي
  Future<UserModel?> getCurrentUser() async {
    User? firebaseUser = _firebaseAuth.currentUser;
    if (firebaseUser == null) return null;

    DocumentSnapshot doc = await _firestore.collection('users').doc(firebaseUser.uid).get();
    if (doc.exists) {
      return UserModel.fromMap(doc.data() as Map<String, dynamic>);
    }
    return null;
  }

  /// التحقق من حالة المستخدم
  Stream<User?> authStateChanges() {
    return _firebaseAuth.authStateChanges();
  }

  /// معالجة أخطاء Firebase
  String _handleAuthException(FirebaseAuthException e) {
    switch (e.code) {
      case 'user-not-found':
        return 'المستخدم غير موجود';
      case 'wrong-password':
        return 'كلمة المرور غير صحيحة';
      case 'email-already-in-use':
        return 'البريد الإلكتروني مستخدم بالفعل';
      case 'weak-password':
        return 'كلمة المرور ضعيفة جداً';
      default:
        return 'حدث خطأ: ${e.message}';
    }
  }
}