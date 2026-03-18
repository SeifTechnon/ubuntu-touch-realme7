# Ubuntu Touch — Realme 7 (salaa / RMX2163)

![Build Status](https://github.com/YOUR_USERNAME/ubuntu-touch-realme7/workflows/Build%20Ubuntu%20Touch%20-%20Realme%207/badge.svg)

---

## معلومات الجهاز

| المعلومة | القيمة |
|----------|--------|
| الجهاز | Realme 7 |
| الطراز | RMX2163 |
| الكود | salaa |
| الـ Chipset | MediaTek Helio G95 (MT6853) |
| الـ RAM | 8GB |
| Android | 12 (S) |
| Halium | 12.0 |
| الحالة | 🔨 قيد التطوير |

---

## حالة المكوّنات

| المكوّن | الحالة |
|---------|--------|
| الشاشة | ⬜ قيد الاختبار |
| اللمس | ⬜ قيد الاختبار |
| Wi-Fi | ⬜ قيد الاختبار |
| Bluetooth | ⬜ قيد الاختبار |
| الصوت | ⬜ قيد الاختبار |
| الكاميرا | ⬜ قيد الاختبار |
| GPS | ⬜ قيد الاختبار |
| البصمة | ⬜ قيد الاختبار |
| الاهتزاز | ⬜ قيد الاختبار |

---

## تنزيل الملفات

اضغط **Actions** ← اختر آخر build ناجح ← نزّل من **Artifacts**

| الملف | الاستخدام |
|-------|-----------|
| `halium-boot-realme7-android12` | فلاشه على boot partition |
| `system-realme7-android12` | system image |
| `vendor-realme7-android12` | vendor image |

---

## طريقة التثبيت

### المتطلبات
- ✅ Bootloader مفتوح
- ✅ TWRP مثبت
- ✅ ADB + Fastboot على الكمبيوتر

### الخطوات

**1. نسخة احتياطية (مهم جداً!)**
```bash
adb shell su -c "dd if=/dev/block/by-name/boot of=/sdcard/boot_backup.img"
adb pull /sdcard/boot_backup.img ./
```

**2. أدخل Fastboot Mode**
```bash
adb reboot bootloader
fastboot devices   # تأكد يظهر الهاتف
```

**3. اختبر أولاً بدون فلاش دائم**
```bash
fastboot boot halium-boot.img
# إذا بوّت بنجاح → تابع للخطوة 4
```

**4. الفلاش الدائم**
```bash
fastboot flash boot   halium-boot.img
fastboot flash system system.img
fastboot flash vendor vendor.img
fastboot erase userdata
fastboot reboot
```

**5. تثبيت Ubuntu rootfs**
```bash
adb push ubuntu-rootfs.tar.gz /sdcard/
adb shell su -c "mkdir -p /data/ubuntu && tar xzf /sdcard/ubuntu-rootfs.tar.gz -C /data/ubuntu"
adb reboot
```

**6. استعادة الهاتف إذا فشل كل شيء**
```bash
fastboot flash boot boot_backup.img
fastboot reboot
```

---

## المصادر

| المصدر | الرابط |
|--------|--------|
| Kernel Android 12 | [realme7_AndroidS-kernel-source](https://github.com/realme-kernel-opensource/realme7_realme8_Narzo30_Narzo20pro-AndroidS-kernel-source) |
| Device Tree | [android_device_realme_salaa](https://github.com/Matrixx-Devices/android_device_realme_salaa) |
| Halium | [Halium/android](https://github.com/Halium/android) |
| UBports Docs | [docs.ubports.com](https://docs.ubports.com/en/latest/porting/index.html) |
| مجتمع الـ Porting | [t.me/ubports_porting](https://t.me/ubports_porting) |

---

## شكر وتقدير
- [ubuntu-touch-clover/ubports-ci](https://github.com/ubuntu-touch-clover/ubports-ci)
- [ubuntu-touch-lavender/ubports-ci](https://github.com/ubuntu-touch-lavender/ubports-ci)
- [UBports Community](https://ubports.com)
