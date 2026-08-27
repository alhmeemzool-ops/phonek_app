import 'package:flutter/material.dart';
import '../models/phone_model.dart';
import '../services/firebase_service.dart';

class PhoneDetailsScreen extends StatelessWidget {
  final PhoneModel phone;

  const PhoneDetailsScreen({Key? key, required this.phone}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(phone.title, style: const TextStyle(color: Color(0xFFFFD700))),
        backgroundColor: const Color(0xFF1E1E1E),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 240,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey[850],
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Center(
                child: Icon(Icons.phone_android, size: 100, color: Color(0xFFFFD700)),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              phone.title,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              '${phone.priceSDG} جنيه سوداني',
              style: const TextStyle(fontSize: 20, color: Color(0xFFFFD700), fontWeight: FontWeight.bold),
            ),
            const Divider(height: 30, color: Colors.grey),
            const Text('المواصفات الرئيسية:', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                Chip(label: Text('الماركة: ${phone.brand}')),
                Chip(label: Text('السعة: ${phone.storage}')),
                Chip(label: Text('البطارية: ${phone.batteryHealth}%')),
                Chip(label: Text('الموقع: ${phone.state} - ${phone.locality}')),
              ],
            ),
            const SizedBox(height: 30),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    onPressed: () => PhoneKService.openWhatsApp(phone.whatsappNumber, phone.title),
                    icon: const Icon(Icons.chat, color: Colors.white),
                    label: const Text('مراسلة عبر واتساب', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFFFD700),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    onPressed: () => PhoneKService.makePhoneCall(phone.sellerPhone),
                    icon: const Icon(Icons.phone, color: Colors.black),
                    label: const Text('اتصال مباشر', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
