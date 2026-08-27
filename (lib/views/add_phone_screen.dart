import 'package:flutter/material.dart';
import '../models/phone_model.dart';
import '../services/firebase_service.dart';

class AddPhoneScreen extends StatefulWidget {
  const AddPhoneScreen({Key? key}) : super(key: key);

  @override
  _AddPhoneScreenState createState() => _AddPhoneScreenState();
}

class _AddPhoneScreenState extends State<AddPhoneScreen> {
  final _formKey = GlobalKey<FormState>();
  final PhoneKService _phoneService = PhoneKService();

  String _title = '';
  double _priceSDG = 0.0;
  String _brand = 'Apple';
  String _storage = '128GB';
  int _batteryHealth = 100;
  String _state = 'الخرطوم';
  String _locality = 'الخرطوم';
  String _sellerPhone = '';
  String _whatsappNumber = '';
  bool _isLoading = false;

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      setState(() => _isLoading = true);

      try {
        final newPhone = PhoneModel(
          id: '',
          title: _title,
          priceSDG: _priceSDG,
          brand: _brand,
          storage: _storage,
          batteryHealth: _batteryHealth,
          state: _state,
          locality: _locality,
          sellerPhone: _sellerPhone,
          whatsappNumber: _whatsappNumber,
          imageUrls: [],
          createdAt: DateTime.now(),
        );

        await _phoneService.addPhone(newPhone);
        Navigator.pop(context);
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('حدث خطأ: $e')),
        );
      } finally {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('إضافة هاتف جديد', style: TextStyle(color: Color(0xFFFFD700))),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator(color: Color(0xFFFFD700)))
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      decoration: const InputDecoration(labelText: 'اسم الهاتف (مثال: iPhone 13 Pro)'),
                      validator: (val) => val == null || val.isEmpty ? 'حقل مطلوب' : null,
                      onSaved: (val) => _title = val!,
                    ),
                    TextFormField(
                      decoration: const InputDecoration(labelText: 'السعر بالجنيه السوداني'),
                      keyboardType: TextInputType.number,
                      validator: (val) => val == null || double.tryParse(val) == null ? 'أدخل رقماً صحيحاً' : null,
                      onSaved: (val) => _priceSDG = double.parse(val!),
                    ),
                    DropdownButtonFormField<String>(
                      value: _brand,
                      dropdownColor: const Color(0xFF1E1E1E),
                      items: ['Apple', 'Samsung', 'Xiaomi', 'Huawei', 'Other']
                          .map((b) => DropdownMenuItem(value: b, child: Text(b)))
                          .toList(),
                      onChanged: (val) => setState(() => _brand = val!),
                      decoration: const InputDecoration(labelText: 'الماركة'),
                    ),
                    TextFormField(
                      decoration: const InputDecoration(labelText: 'الذاكرة (مثال: 256GB)'),
                      onSaved: (val) => _storage = val ?? '128GB',
                    ),
                    TextFormField(
                      decoration: const InputDecoration(labelText: 'صحة البطارية (مثال: 85)'),
                      keyboardType: TextInputType.number,
                      onSaved: (val) => _batteryHealth = int.tryParse(val ?? '') ?? 100,
                    ),
                    TextFormField(
                      decoration: const InputDecoration(labelText: 'الولاية (مثال: الخرطوم، نهر النيل)'),
                      onSaved: (val) => _state = val ?? 'الخرطوم',
                    ),
                    TextFormField(
                      decoration: const InputDecoration(labelText: 'المحليّة / المدينة'),
                      onSaved: (val) => _locality = val ?? '',
                    ),
                    TextFormField(
                      decoration: const InputDecoration(labelText: 'رقم هاتف البائع'),
                      keyboardType: TextInputType.phone,
                      onSaved: (val) => _sellerPhone = val ?? '',
                    ),
                    TextFormField(
                      decoration: const InputDecoration(labelText: 'رقم الواتساب (مثال: 2499xxxxxxx)'),
                      keyboardType: TextInputType.phone,
                      onSaved: (val) => _whatsappNumber = val ?? '',
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFFFD700)),
                      onPressed: _submitForm,
                      child: const Text('نشر الإعلان', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
