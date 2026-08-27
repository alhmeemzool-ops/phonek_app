import 'package:flutter/material.dart';
import 'views/add_phone_screen.dart';
import 'views/phone_details_screen.dart';
import 'models/phone_model.dart';

void main() {
  runApp(const PhoneKApp());
}

class PhoneKApp extends StatelessWidget {
  const PhoneKApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PhoneK - فونك',
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.dark,
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF121212),
        primaryColor: const Color(0xFFFFD700),
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFFFFD700),
          secondary: Color(0xFFFFD700),
          surface: Color(0xFF1E1E1E),
        ),
      ),
      home: const MainHomeScreen(),
    );
  }
}

class MainHomeScreen extends StatelessWidget {
  const MainHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('فونك | PhoneK', style: TextStyle(color: Color(0xFFFFD700), fontWeight: FontWeight.bold)),
        actions: [
          IconButton(
            icon: const Icon(Icons.add_box, color: Color(0xFFFFD700)),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AddPhoneScreen()),
              );
            },
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: 5,
        itemBuilder: (context, index) {
          final samplePhone = PhoneModel(
            id: '$index',
            title: 'iPhone ${11 + index} Pro Max',
            priceSDG: 350000.0 + (index * 50000),
            brand: 'Apple',
            storage: '256GB',
            batteryHealth: 88,
            state: 'الخرطوم',
            locality: 'الخرطوم',
            sellerPhone: '0912345678',
            whatsappNumber: '249912345678',
            imageUrls: [],
            createdAt: DateTime.now(),
          );

          return Card(
            color: const Color(0xFF1E1E1E),
            margin: const EdgeInsets.only(bottom: 10),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: ListTile(
              leading: const Icon(Icons.phone_android, size: 40, color: Color(0xFFFFD700)),
              title: Text(samplePhone.title, style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text('${samplePhone.priceSDG} ج.س • ${samplePhone.state}', style: const TextStyle(color: Colors.grey)),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Color(0xFFFFD700)),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PhoneDetailsScreen(phone: samplePhone),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
