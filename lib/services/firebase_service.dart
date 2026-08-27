import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/phone_model.dart';

class PhoneKService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // جلب الإعلانات من قاعدة البيانات
  Stream<List<PhoneModel>> getPhones() {
    return _firestore
        .collection('phones')
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) => PhoneModel.fromMap(doc.data(), doc.id))
          .toList();
    });
  }

  // إضافة إعلان جديد
  Future<void> addPhone(PhoneModel phone) async {
    await _firestore.collection('phones').add(phone.toMap());
  }

  // إجراء اتصال هاتفي مباشر
  static Future<void> makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(scheme: 'tel', path: phoneNumber);
    if (await canLaunchUrl(launchUri)) {
      await launchUrl(launchUri);
    }
  }

  // فتح المحادثة المباشرة عبر الواتساب
  static Future<void> openWhatsApp(String phone, String phoneTitle) async {
    final String cleanPhone = phone.replaceAll('+', '').replaceAll(' ', '');
    final String message = Uri.encodeComponent("مرحباً، أستفسر عن إعلانك لهاتف: $phoneTitle على تطبيق PhoneK");
    final Uri whatsappUri = Uri.parse("https://wa.me/$cleanPhone?text=$message");
    
    if (await canLaunchUrl(whatsappUri)) {
      await launchUrl(whatsappUri, mode: LaunchMode.externalApplication);
    }
  }
}
