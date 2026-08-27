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
  final bool isVerifiedStore;
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
    this.isVerifiedStore = false,
    required this.imageUrls,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'priceSDG': priceSDG,
      'brand': brand,
      'storage': storage,
      'batteryHealth': batteryHealth,
      'state': state,
      'locality': locality,
      'sellerPhone': sellerPhone,
      'whatsappNumber': whatsappNumber,
      'isVerifiedStore': isVerifiedStore,
      'imageUrls': imageUrls,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  factory PhoneModel.fromMap(Map<String, dynamic> map, String docId) {
    return PhoneModel(
      id: docId,
      title: map['title'] ?? '',
      priceSDG: (map['priceSDG'] ?? 0).toDouble(),
      brand: map['brand'] ?? '',
      storage: map['storage'] ?? '',
      batteryHealth: map['batteryHealth'] ?? 0,
      state: map['state'] ?? '',
      locality: map['locality'] ?? '',
      sellerPhone: map['sellerPhone'] ?? '',
      whatsappNumber: map['whatsappNumber'] ?? '',
      isVerifiedStore: map['isVerifiedStore'] ?? false,
      imageUrls: List<String>.from(map['imageUrls'] ?? []),
      createdAt: DateTime.tryParse(map['createdAt'] ?? '') ?? DateTime.now(),
    );
  }
}
