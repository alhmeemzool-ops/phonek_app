#!/bin/bash

# تحديث النظام
sudo apt-get update
sudo apt-get install -y curl git

# تثبيت Flutter SDK
git clone https://github.com/flutter/flutter.git -b stable /home/gitpod/.flutter
export PATH="/home/gitpod/.flutter/bin:$PATH"
flutter config --no-analytics
flutter doctor

# تثبيت المتطلبات
cd /workspace/phonek_app
flutter pub get

# تفعيل Flutter Web
flutter config --enable-web

echo "✅ تم تثبيت Flutter بنجاح!"
echo "🚀 لتشغيل التطبيق: flutter run -d web"
