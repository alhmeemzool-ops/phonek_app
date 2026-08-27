import 'package:flutter/material.dart';
import '../models/phone_model.dart';
import '../services/firebase_service.dart';

class AddPhoneScreen extends StatefulWidget {
  const AddPhoneScreen({Key? key}) : super(key: key);

  @override
  State<AddPhoneScreen> createState() => _AddPhoneScreenState();
}

class _AddPhoneScreenState extends State<AddPhoneScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _priceController = TextEditingController();
  final _batteryController = TextEditingController();
  final _phoneController = TextEditingController();
  final _whatsappController = TextEditingController();

  String _selectedBrand = 'Apple';
  String _selectedStorage = '128GB';
  String _selectedState = 'الخرطوم';
  String _selectedLocality = 'الخرطوم';

  final List<String> _brands = ['Apple', 'Samsung', 'Xiaomi', 'Tecno', 'Infinix', 'Huawei', 'أخرى'];
  final List<String> _storages = ['64GB', '128GB', '256GB', '512GB', '1TB'];
  final List<String> _states = ['الخرطوم', 'الجزيرة', 'البحر الأحمر', 'نهر النيل', 'الشمالية', 'قدارف', 'أخرى'];

  void _savePhone() async {
    if (_formKey.currentState!.validate()) {
      final phone = PhoneModel(
        id: '',
        title: _titleController.text,
        priceSDG: double.tryParse(_priceController.text) ?? 0,
        brand: _selectedBrand,
        storage: _selectedStorage,
        batteryHealth: int.tryParse(_batteryController.text) ?? 100,
        state: _selectedState,
        locality: _selectedLocality,
        sellerPhone: _phoneController.text,
        whatsappNumber: _whatsappController.text,
        imageUrls: [],
        createdAt: DateTime.now(),
      );

      await PhoneKService().addPhone(phone);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('تم إضافة الإعلان بنجاح!')),
        );
        Navigator.pop(context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('إضافة هاتف جديد', style: TextStyle(color: Color(0xFFFFD700))),
        backgroundColor: const Color(0xFF1E1E1E),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(labelText: 'اسم الهاتف (مثال: iPhone 13 Pro)', border: OutlineInputBorder()),
                validator: (val) => val == null || val.isEmpty ? 'يرجى إدخال اسم الهاتف' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _priceController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'السعر (بالجنيه السوداني)', border: OutlineInputBorder()),
                validator: (val) => val == null || val.isEmpty ? 'يرجى إدخال السعر' : null,
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: DropdownButtonFormField<String>(
                      value: _selectedBrand,
                      items: _brands.map((b) => DropdownMenuItem(value: b, child: Text(b))).toList(),
                      onChanged: (val) => setState(() => _selectedBrand = val!),
                      decoration: const InputDecoration(labelText: 'الماركة', border: OutlineInputBorder()),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: DropdownButtonFormField<String>(
                      value: _selectedStorage,
                      items: _storages.map((s) => DropdownMenuItem(value: s, child: Text(s))).toList(),
                      onChanged: (val) => setState(() => _selectedStorage = val!),
                      decoration: const InputDecoration(labelText: 'المساحة', border: OutlineInputBorder()),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _batteryController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'صحة البطارية % (لأجهزة آيفون)', border: OutlineInputBorder()),
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField<String>(
                value: _selectedState,
                items: _states.map((st) => DropdownMenuItem(value: st, child: Text(st))).toList(),
                onChanged: (val) => setState(() => _selectedState = val!),
                decoration: const InputDecoration(labelText: 'الولاية', border: OutlineInputBorder()),
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(labelText: 'رقم الاتصال المباشر', border: OutlineInputBorder()),
                validator: (val) => val == null || val.isEmpty ? 'يرجى إدخال رقم الهاتف' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _whatsappController,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(labelText: 'رقم الواتساب', border: OutlineInputBorder()),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFFFD700)),
                  onPressed: _savePhone,
                  child: const Text('نشر الإعلان الآن', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
