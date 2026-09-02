#!/bin/bash

echo "🚀 Building Flutter Web App..."
flutter config --enable-web
flutter pub get
flutter build web --release

echo "✅ Build Complete!"
echo "📁 Output: build/web/"
