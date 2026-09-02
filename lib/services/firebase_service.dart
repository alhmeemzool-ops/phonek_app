import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/phone_model.dart';

class PhoneKService {
  final CollectionReference _phonesRef =
      FirebaseFirestore.instance.collection('phones');

  /// جلب قائمة الهواتف كـ Stream مرتبة من الأحدث للأقدم
  Stream<List<PhoneModel>> getPhones() {
    return _phonesRef
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => PhoneModel.fromMap(
                doc.data() as Map<String, dynamic>, doc.id))
            .toList());
  }

  /// إضافة هاتف جديد إلى Firestore
  Future<void> addPhone(PhoneModel phone) async {
    await _phonesRef.add(phone.toMap());
  }

  /// حذف هاتف (اختياري لكن مفيد لاحقًا)
  Future<void> deletePhone(String id) async {
    await _phonesRef.doc(id).delete();
  }

  /// فتح تطبيق الاتصال المباشر
  static Future<void> makePhoneCall(String phoneNumber) async {
    final Uri uri = Uri(scheme: 'tel', path: phoneNumber);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

  /// فتح واتساب مع رسالة جاهزة تحتوي اسم الهاتف
  static Future<void> openWhatsApp(String phoneNumber, String phoneTitle) async {
    final String message = Uri.encodeComponent(
        'مرحباً، أنا مهتم بالهاتف: $phoneTitle');
    final Uri uri = Uri.parse('https://wa.me/$phoneNumber?text=$message');
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }
}
