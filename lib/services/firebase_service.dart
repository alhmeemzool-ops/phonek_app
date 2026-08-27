import 'package:cloud_firestore/cloud_firestore.dart';

class PhoneModel {
  final String id;
  final String title;
  final double priceSDG;
  final String brand;
  final String storage;
  final int batteryHealth;
  final String state;
  final String locality;
  final String sellerPhone;
  final String whatsappNumber;
  final List<String> imageUrls;
  final DateTime createdAt;

  PhoneModel({
    required this.id,
    required this.title,
    required this.priceSDG,
    required this.brand,
    required this.storage,
    required this.batteryHealth,
    required this.state,
    required this.locality,
    required this.sellerPhone,
    required this.whatsappNumber,
    required this.imageUrls,
    required this.createdAt,
  });

  // تحويل البيانات لإرسالها إلى Firestore بأمان
  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'priceSDG': priceSDG,
      'brand': brand,
      'storage': storage,
      'batteryHealth': batteryHealth,
      'state': state,
      'locality': locality,
      'sellerPhone': sellerPhone,
      'whatsappNumber': whatsappNumber,
      'imageUrls': imageUrls,
      'createdAt': Timestamp.fromDate(createdAt),
    };
  }

  // قراءة البيانات من Firestore مع معالجة صارمة للأنواع لمنع الانهيار
  factory PhoneModel.fromMap(Map<String, dynamic> map, String documentId) {
    return PhoneModel(
      id: documentId,
      title: map['title'] ?? '',
      priceSDG: map['priceSDG'] != null
          ? (map['priceSDG'] is int
              ? (map['priceSDG'] as int).toDouble()
              : map['priceSDG'] as double)
          : 0.0,
      brand: map['brand'] ?? '',
      storage: map['storage'] ?? '',
      batteryHealth: map['batteryHealth'] != null
          ? (map['batteryHealth'] is double
              ? (map['batteryHealth'] as double).toInt()
              : map['batteryHealth'] as int)
          : 100,
      state: map['state'] ?? '',
      locality: map['locality'] ?? '',
      sellerPhone: map['sellerPhone'] ?? '',
      whatsappNumber: map['whatsappNumber'] ?? '',
      imageUrls: map['imageUrls'] != null
          ? List<String>.from(map['imageUrls'])
          : [],
      createdAt: map['createdAt'] != null
          ? (map['createdAt'] as Timestamp).toDate()
          : DateTime.now(),
    );
  }
}
