import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'views/add_phone_screen.dart';
import 'views/phone_details_screen.dart';
import 'models/phone_model.dart';
import 'services/firebase_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp();
  } catch (e) {
    // تتأكد من عمل التطبيق حتى لو انتظرت تهيئة السيرفر
  }
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
    final PhoneKService phoneService = PhoneKService();

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
      body: StreamBuilder<List<PhoneModel>>(
        stream: phoneService.getPhones(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator(color: Color(0xFFFFD700)));
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text(
                'لا توجد إعلانات مضافة حالياً.\nاضغط على زر الإضافة بالأعلى لإدراج أول هاتف!',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey, fontSize: 16),
              ),
            );
          }

          final phones = snapshot.data!;

          return ListView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: phones.length,
            itemBuilder: (context, index) {
              final phone = phones[index];

              return Card(
                color: const Color(0xFF1E1E1E),
                margin: const EdgeInsets.only(bottom: 10),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                child: ListTile(
                  leading: const Icon(Icons.phone_android, size: 40, color: Color(0xFFFFD700)),
                  title: Text(phone.title, style: const TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Text('${phone.priceSDG} ج.س • ${phone.state}', style: const TextStyle(color: Colors.grey)),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Color(0xFFFFD700)),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PhoneDetailsScreen(phone: phone),
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
