// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a ar locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'ar';

  static m0(Length) => "الاسم  قصير يجب أن تكون ${Length} حرف أو رقم على الاقل";

  static m1(phone) => "الرقم المفعل على Mubrm هو${phone}";

  static m2(account) => "شارك ${account}";

  static m3(account) => "قم بزيارة حسابي  ${account}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static _notInlinedMessages(_) => <String, Function> {
    "accountActive" : MessageLookupByLibrary.simpleMessage("الحساب  معفل على الشريحة"),
    "accountNotActive" : MessageLookupByLibrary.simpleMessage("الحساب غير معفل على الشريحة فعله الآن"),
    "activeMubrm" : MessageLookupByLibrary.simpleMessage("تفعيل MUBRM"),
    "activeMubrmPhone" : MessageLookupByLibrary.simpleMessage("تفعيل MUBRM MINI"),
    "addLink" : MessageLookupByLibrary.simpleMessage("اضافة رابط"),
    "barcode" : MessageLookupByLibrary.simpleMessage("باركود"),
    "continueTo" : MessageLookupByLibrary.simpleMessage("متابعة"),
    "continueWithGoogle" : MessageLookupByLibrary.simpleMessage("متابعة عبر غوغل "),
    "dataUpdateSuccess" : MessageLookupByLibrary.simpleMessage("تم تحديث البيانات بنجاح"),
    "delete" : MessageLookupByLibrary.simpleMessage("حذف"),
    "deviceNotSupportApp" : MessageLookupByLibrary.simpleMessage("الجهاز لا يدعم التطبيق"),
    "deviceSupportApp" : MessageLookupByLibrary.simpleMessage("الجهاز يدعم التطبيق"),
    "doNotHaveAccount" : MessageLookupByLibrary.simpleMessage("ليس لديك حساب"),
    "editAccount" : MessageLookupByLibrary.simpleMessage("تعديل الحساب"),
    "editImage" : MessageLookupByLibrary.simpleMessage("تعديل الصورة"),
    "editPhoneNumber" : MessageLookupByLibrary.simpleMessage("تعديل الرقم"),
    "email" : MessageLookupByLibrary.simpleMessage("البريد الالكتروني"),
    "enterYourLink" : MessageLookupByLibrary.simpleMessage("أدخل الرابط الخاص بك"),
    "errorTextEmail" : MessageLookupByLibrary.simpleMessage("البريد الالكتروني غير صحيح حاول من جديد"),
    "errorTextFormat" : MessageLookupByLibrary.simpleMessage("صيغة الاسم غير صحيح"),
    "errorTextMinLength" : m0,
    "errorTextRequired" : MessageLookupByLibrary.simpleMessage("هذا الحقل فارغ يرجى ملئ الحقل"),
    "exit" : MessageLookupByLibrary.simpleMessage("تسجيل خروج"),
    "forgetPassword" : MessageLookupByLibrary.simpleMessage("نسيت كلمة المرور"),
    "generateQR" : MessageLookupByLibrary.simpleMessage("شارك حساباتك عن طريق الباركود"),
    "mainPage" : MessageLookupByLibrary.simpleMessage("الصفحة الرئيسية"),
    "makeProfileMessage" : MessageLookupByLibrary.simpleMessage("عندما يكون ملفك الشخصي عامًا. يمكن للآخرين الوصول إلى ملف التعريف الخاص بك باستخدام الرابط:"),
    "makeProfilePublic" : MessageLookupByLibrary.simpleMessage("اجعل الملف الشخصي عامًا"),
    "messageToHold" : MessageLookupByLibrary.simpleMessage("امسك MUBRM في منتصف الجزء الخلفي من هاتفك لتنشيطه ، امسك MUBRM هناك حتى تظهر النافذة المنبثقة للنجاح!"),
    "myProfile" : MessageLookupByLibrary.simpleMessage("الملف الشخصي"),
    "name" : MessageLookupByLibrary.simpleMessage("الاسم"),
    "openAccount" : MessageLookupByLibrary.simpleMessage("فتح الحساب"),
    "password" : MessageLookupByLibrary.simpleMessage("كلمة المرور"),
    "phoneNumber" : MessageLookupByLibrary.simpleMessage("رقم الهاتف"),
    "phoneNumberIs" : m1,
    "phoneNumberSuccess" : MessageLookupByLibrary.simpleMessage("تم تفعيل الرقم بنجاح"),
    "profileImage" : MessageLookupByLibrary.simpleMessage("اضافة صورة"),
    "restPassword" : MessageLookupByLibrary.simpleMessage("اعادة تهيئة كلمة المرور"),
    "restPasswordError" : MessageLookupByLibrary.simpleMessage("لا يوجد  بريد الكتروني مستخدم مطابق لهذا البريد. ربما تم حذف البريد."),
    "restPasswordSuccess" : MessageLookupByLibrary.simpleMessage("تم ارسال رابط اعادة تهيئة كلمة المرور الى بريدك الالكتروني تححقق منه الآن"),
    "save" : MessageLookupByLibrary.simpleMessage("حفظ"),
    "setDef" : MessageLookupByLibrary.simpleMessage("الحساب الافتراضي"),
    "shareApp" : MessageLookupByLibrary.simpleMessage("مشاركة التطبيق"),
    "shareMyAccount" : MessageLookupByLibrary.simpleMessage("شارك الحساب"),
    "shareMyAccountSocial" : m2,
    "shareMyAccountSocialMessage" : m3,
    "singUp" : MessageLookupByLibrary.simpleMessage("تسجيل حساب"),
    "singUpTitle" : MessageLookupByLibrary.simpleMessage("تسجيل دخول"),
    "socialMediaMyList" : MessageLookupByLibrary.simpleMessage("وسائل التواصل الاجتماعية الخاصة بك"),
    "welcome" : MessageLookupByLibrary.simpleMessage("مرحبا بك"),
    "wrongPassword" : MessageLookupByLibrary.simpleMessage("كلمة المرور غير صحيحة يرجى المحاولة مرة اخرى او استعادة كلمة المرور")
  };
}
