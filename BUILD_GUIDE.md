# دليل رفع المشروع للبناء على Codemagic

## الخطوة 1: إعداد GitHub

### إنشاء حساب GitHub (إذا لم يكن لديك)
1. اذهب إلى: https://github.com
2. اضغط "Sign up"
3. أدخل البيانات المطلوبة

### إنشاء مستودع جديد
1. اضغط الزر الأخضر "New" أو "+"
2. اختر "New repository"
3. اسم المستودع: `order-management-app`
4. اجعله Public
5. اضغط "Create repository"

## الخطوة 2: رفع المشروع لـ GitHub

### باستخدام GitHub Desktop (الأسهل)
1. حمل GitHub Desktop من: https://desktop.github.com
2. سجل دخول بحسابك
3. اضغط "Clone a repository from the Internet"
4. اختر المستودع الذي أنشأته
5. انسخ محتويات مجلد `order_management_app` إلى المجلد المحلي
6. في GitHub Desktop اضغط "Commit to main"
7. اضغط "Push origin"

### باستخدام سطر الأوامر
```bash
cd order_management_app
git init
git add .
git commit -m "Initial commit"
git branch -M main
git remote add origin https://github.com/YOUR_USERNAME/order-management-app.git
git push -u origin main
```

## الخطوة 3: إعداد Codemagic

### التسجيل في Codemagic
1. اذهب إلى: https://codemagic.io
2. اضغط "Login with GitHub"
3. امنح الصلاحيات المطلوبة

### إضافة التطبيق
1. اضغط "Add application"
2. اختر "Flutter App"
3. اختر مستودع GitHub الخاص بك
4. اضغط "Select"

### إعداد البناء
1. في صفحة التطبيق، اضغط "Start new build"
2. اختر Branch: `main`
3. اختر Build configuration: `Release`
4. اضغط "Start new build"

## الخطوة 4: انتظار البناء

- سيستغرق البناء 10-15 دقيقة
- يمكنك متابعة التقدم في الصفحة
- عند الانتهاء ستحصل على رابط تحميل APK

## الخطوة 5: تحميل APK

1. بعد انتهاء البناء بنجاح
2. اضغط على "Artifacts"
3. حمل ملف APK
4. انقل الملف لهاتفك وثبته

## ملاحظات مهمة

### Firebase محلي للاختبار
- المشروع يستخدم إعدادات Firebase وهمية للاختبار
- البيانات لن تُحفظ بشكل دائم
- مناسب للاختبار فقط

### استكشاف الأخطاء
إذا فشل البناء:
1. تحقق من ملف `pubspec.yaml`
2. تأكد من وجود جميع الملفات المطلوبة
3. راجع سجل الأخطاء في Codemagic

### الروابط المهمة
- Codemagic: https://codemagic.io
- GitHub: https://github.com
- GitHub Desktop: https://desktop.github.com
- Flutter Documentation: https://flutter.dev/docs

## البديل السريع: النسخة الويب
إذا واجهت مشاكل في البناء، يمكنك استخدام النسخة الويب:
```bash
node server.js
```
ثم افتح: http://localhost:3000