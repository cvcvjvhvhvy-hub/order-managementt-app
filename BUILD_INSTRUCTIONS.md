# تعليمات بناء APK مجاناً

## 🔗 الروابط المطلوبة:
- **GitHub**: https://github.com
- **Codemagic**: https://codemagic.io

## 📋 الخطوات التفصيلية:

### الطريقة الأولى: GitHub Actions (مجاني تماماً)

#### 1. إنشاء حساب GitHub:
- اذهب إلى: https://github.com
- اضغط "Sign up"
- أدخل بياناتك

#### 2. إنشاء مستودع جديد:
- اضغط "New repository"
- اسم المستودع: `order-management-app`
- اختر "Public" (مجاني)
- اضغط "Create repository"

#### 3. رفع الملفات:
```bash
git init
git add .
git commit -m "Initial commit"
git branch -M main
git remote add origin https://github.com/USERNAME/order-management-app.git
git push -u origin main
```

#### 4. تفعيل Actions:
- اذهب لتبويب "Actions" في المستودع
- سيبدأ البناء تلقائياً
- انتظر 5-10 دقائق
- حمل APK من "Artifacts"

---

### الطريقة الثانية: Codemagic (الأسهل)

#### 1. اذهب إلى:
https://codemagic.io

#### 2. سجل دخول:
- اضغط "Login with GitHub"
- وافق على الصلاحيات

#### 3. إضافة المشروع:
- اضغط "Add application"
- اختر مستودع GitHub
- اختر "Flutter App"

#### 4. إعداد البناء:
- اختر "Android" فقط
- اضغط "Start new build"
- انتظر 10-15 دقيقة
- حمل APK

---

## ⚠️ ملاحظات مهمة:

### قبل البناء يجب:
1. **إضافة ملفات Android المفقودة**
2. **إعداد Firebase بشكل صحيح**
3. **تحديث firebase_options.dart**

### إنشاء مشروع Flutter كامل:
```bash
flutter create --org com.orderapp order_management_complete
# ثم نسخ ملفات lib والإعدادات
```

---

## 🎯 الخيار الأسرع:
**استخدم Codemagic** - أسهل وأسرع للمبتدئين!