# PhoneK App - Web Deployment Guide

## 🚀 نشر التطبيق على Vercel

### الخطوة 1: تجهيز البناء

```bash
flutter config --enable-web
flutter pub get
flutter build web --release
```

### الخطوة 2: الربط مع Vercel

**الطريقة الأولى - من خلال GitHub (الأسهل):**

1. اذهب إلى: https://vercel.com/
2. اضغط **Sign In** واختر **GitHub**
3. اختر المشروع `phonek_app`
4. Vercel سيبني التطبيق تلقائياً
5. سيعطيك رابط مثل: `https://phonek-app.vercel.app`

**الطريقة الثانية - من Terminal:**

```bash
npm install -g vercel
vercel login
vercel
```

### الخطوة 3: التحديثات التلقائية

- كل push إلى GitHub
- Vercel سينشر تلقائياً
- الرابط يبقى نفسه

---

## ✅ النتيجة النهائية:

رابط تطبيقك: **https://phonek-app.vercel.app**

---

يمكنك فتح الرابط مباشرة والتطبيق يعمل! 🎉
