import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'translations_ar.dart';
import 'translations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of Translations
/// returned by `Translations.of(context)`.
///
/// Applications need to include `Translations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'translation/translations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: Translations.localizationsDelegates,
///   supportedLocales: Translations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the Translations.supportedLocales
/// property.
abstract class Translations {
  Translations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static Translations? of(BuildContext context) {
    return Localizations.of<Translations>(context, Translations);
  }

  static const LocalizationsDelegate<Translations> delegate =
      _TranslationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en'),
  ];

  /// No description provided for @logIn.
  ///
  /// In ar, this message translates to:
  /// **'تسجيل الدخول'**
  String get logIn;

  /// No description provided for @email.
  ///
  /// In ar, this message translates to:
  /// **'البريد الإلكتروني'**
  String get email;

  /// No description provided for @password.
  ///
  /// In ar, this message translates to:
  /// **'كلمة المرور'**
  String get password;

  /// No description provided for @name.
  ///
  /// In ar, this message translates to:
  /// **'الاسم'**
  String get name;

  /// No description provided for @code.
  ///
  /// In ar, this message translates to:
  /// **'الرمز'**
  String get code;

  /// No description provided for @phoneNumber.
  ///
  /// In ar, this message translates to:
  /// **'رقم الهاتف'**
  String get phoneNumber;

  /// No description provided for @confirmPassword.
  ///
  /// In ar, this message translates to:
  /// **'تأكيد كلمة المرور'**
  String get confirmPassword;

  /// No description provided for @signUp.
  ///
  /// In ar, this message translates to:
  /// **'إنشاء حساب'**
  String get signUp;

  /// No description provided for @forgetPassword.
  ///
  /// In ar, this message translates to:
  /// **'نسيت كلمة المرور'**
  String get forgetPassword;

  /// No description provided for @continuE.
  ///
  /// In ar, this message translates to:
  /// **'متابعة'**
  String get continuE;

  /// No description provided for @retry.
  ///
  /// In ar, this message translates to:
  /// **'إعادة المحاولة'**
  String get retry;

  /// No description provided for @success.
  ///
  /// In ar, this message translates to:
  /// **'نجاح'**
  String get success;

  /// No description provided for @accessDetails.
  ///
  /// In ar, this message translates to:
  /// **'تفاصيل الوصول'**
  String get accessDetails;

  /// No description provided for @errorMessage.
  ///
  /// In ar, this message translates to:
  /// **'عذراً! حدث خطأ ما'**
  String get errorMessage;

  /// No description provided for @accessDeniedMessage.
  ///
  /// In ar, this message translates to:
  /// **'تم رفض الوصول، ليس لديك الصلاحيات الكافية'**
  String get accessDeniedMessage;

  /// No description provided for @noInternetConnection.
  ///
  /// In ar, this message translates to:
  /// **'لا يوجد اتصال بالإنترنت'**
  String get noInternetConnection;

  /// No description provided for @connectionTimeOut.
  ///
  /// In ar, this message translates to:
  /// **'انتهت مهلة الاتصال'**
  String get connectionTimeOut;

  /// No description provided for @unauthenticatedMessage.
  ///
  /// In ar, this message translates to:
  /// **'انتهت الجلسة!'**
  String get unauthenticatedMessage;

  /// No description provided for @yes.
  ///
  /// In ar, this message translates to:
  /// **'نعم'**
  String get yes;

  /// No description provided for @no.
  ///
  /// In ar, this message translates to:
  /// **'لا'**
  String get no;

  /// No description provided for @cancel.
  ///
  /// In ar, this message translates to:
  /// **'إلغاء'**
  String get cancel;

  /// No description provided for @search.
  ///
  /// In ar, this message translates to:
  /// **'بحث'**
  String get search;

  /// No description provided for @done.
  ///
  /// In ar, this message translates to:
  /// **'تم'**
  String get done;

  /// No description provided for @fieldRequiredMessage.
  ///
  /// In ar, this message translates to:
  /// **'حقل مطلوب'**
  String get fieldRequiredMessage;

  /// No description provided for @codeIsRequired.
  ///
  /// In ar, this message translates to:
  /// **'الرمز مطلوب'**
  String get codeIsRequired;

  /// No description provided for @youHaveUnverifiedEmailPleaseVerifyIt.
  ///
  /// In ar, this message translates to:
  /// **'لديك بريد غير مُفعل، يرجى تفعيله!'**
  String get youHaveUnverifiedEmailPleaseVerifyIt;

  /// No description provided for @resetPassword.
  ///
  /// In ar, this message translates to:
  /// **'إعادة تعيين كلمة المرور'**
  String get resetPassword;

  /// No description provided for @yourPasswordMustBeAtLeast8charactersLongAndContainAtLeastLetterAndOneDigit.
  ///
  /// In ar, this message translates to:
  /// **'يجب أن تحتوي كلمة المرور على 8 أحرف على الأقل، وحرف ورقم واحد على الأقل'**
  String
  get yourPasswordMustBeAtLeast8charactersLongAndContainAtLeastLetterAndOneDigit;

  /// No description provided for @shouldContainAtLeastOneCapitalLetter.
  ///
  /// In ar, this message translates to:
  /// **'يجب أن تحتوي على حرف كبير واحد على الأقل'**
  String get shouldContainAtLeastOneCapitalLetter;

  /// No description provided for @shouldContainAtLeastOneSmallLetter.
  ///
  /// In ar, this message translates to:
  /// **'يجب أن تحتوي على حرف صغير واحد على الأقل'**
  String get shouldContainAtLeastOneSmallLetter;

  /// No description provided for @shouldContainAtLeastOneSmallLetterAndOneCapitalLetter.
  ///
  /// In ar, this message translates to:
  /// **'حرف كبير وحرف صغير'**
  String get shouldContainAtLeastOneSmallLetterAndOneCapitalLetter;

  /// No description provided for @shouldContainAtLeast8Characters.
  ///
  /// In ar, this message translates to:
  /// **'8 أحرف على الأقل'**
  String get shouldContainAtLeast8Characters;

  /// No description provided for @shouldContainAtLeastOneSymbol.
  ///
  /// In ar, this message translates to:
  /// **'رمز واحد على الأقل'**
  String get shouldContainAtLeastOneSymbol;

  /// No description provided for @nonLessThan.
  ///
  /// In ar, this message translates to:
  /// **'لا يقل عن'**
  String get nonLessThan;

  /// No description provided for @nonMoreThan.
  ///
  /// In ar, this message translates to:
  /// **'لا يزيد عن'**
  String get nonMoreThan;

  /// No description provided for @matchedPassword.
  ///
  /// In ar, this message translates to:
  /// **'كلمة المرور متطابقة'**
  String get matchedPassword;

  /// No description provided for @createANewPasswordForYourAccount.
  ///
  /// In ar, this message translates to:
  /// **'أنشئ كلمة مرور جديدة لحسابك'**
  String get createANewPasswordForYourAccount;

  /// No description provided for @doNotHaveAccount.
  ///
  /// In ar, this message translates to:
  /// **'ليس لديك حساب؟'**
  String get doNotHaveAccount;

  /// No description provided for @createNewAccount.
  ///
  /// In ar, this message translates to:
  /// **'إنشاء حساب جديد'**
  String get createNewAccount;

  /// No description provided for @enterYourEmailAndPassword.
  ///
  /// In ar, this message translates to:
  /// **'أدخل البريد الإلكتروني وكلمة المرور'**
  String get enterYourEmailAndPassword;

  /// No description provided for @orCreateNewAccount.
  ///
  /// In ar, this message translates to:
  /// **'أو أنشئ حساباً جديداً'**
  String get orCreateNewAccount;

  /// No description provided for @alreadyHaveAccount.
  ///
  /// In ar, this message translates to:
  /// **'لديك حساب بالفعل؟'**
  String get alreadyHaveAccount;

  /// No description provided for @createAccount.
  ///
  /// In ar, this message translates to:
  /// **'إنشاء حساب'**
  String get createAccount;

  /// No description provided for @welcomeToOurApplication.
  ///
  /// In ar, this message translates to:
  /// **'مرحباً بك في تطبيقنا'**
  String get welcomeToOurApplication;

  /// No description provided for @phone.
  ///
  /// In ar, this message translates to:
  /// **'الهاتف'**
  String get phone;

  /// No description provided for @enterYourEmailOtp.
  ///
  /// In ar, this message translates to:
  /// **'أدخل بريدك الإلكتروني لإرسال رمز التحقق'**
  String get enterYourEmailOtp;

  /// No description provided for @verifyEmail.
  ///
  /// In ar, this message translates to:
  /// **'تفعيل البريد الإلكتروني'**
  String get verifyEmail;

  /// No description provided for @enterYourCode.
  ///
  /// In ar, this message translates to:
  /// **'أدخل الرمز المرسل إلى بريدك الإلكتروني'**
  String get enterYourCode;

  /// No description provided for @changePassword.
  ///
  /// In ar, this message translates to:
  /// **'تغيير كلمة المرور'**
  String get changePassword;

  /// No description provided for @changeYourAccountPassword.
  ///
  /// In ar, this message translates to:
  /// **'غيّر كلمة مرور حسابك'**
  String get changeYourAccountPassword;

  /// No description provided for @currentPassword.
  ///
  /// In ar, this message translates to:
  /// **'كلمة المرور الحالية'**
  String get currentPassword;

  /// No description provided for @resend.
  ///
  /// In ar, this message translates to:
  /// **'إعادة الإرسال'**
  String get resend;

  /// No description provided for @settings.
  ///
  /// In ar, this message translates to:
  /// **'الإعدادات'**
  String get settings;

  /// No description provided for @realStates.
  ///
  /// In ar, this message translates to:
  /// **'العقارات'**
  String get realStates;

  /// No description provided for @logOut.
  ///
  /// In ar, this message translates to:
  /// **'تسجيل الخروج'**
  String get logOut;

  /// No description provided for @logoutMessage.
  ///
  /// In ar, this message translates to:
  /// **'هل أنت متأكد أنك تريد تسجيل الخروج؟'**
  String get logoutMessage;

  /// No description provided for @profile.
  ///
  /// In ar, this message translates to:
  /// **'الملف الشخصي'**
  String get profile;

  /// No description provided for @edit.
  ///
  /// In ar, this message translates to:
  /// **'تعديل'**
  String get edit;

  /// No description provided for @save.
  ///
  /// In ar, this message translates to:
  /// **'حفظ'**
  String get save;

  /// No description provided for @contactUs.
  ///
  /// In ar, this message translates to:
  /// **'اتصل بنا'**
  String get contactUs;

  /// No description provided for @whatsapp.
  ///
  /// In ar, this message translates to:
  /// **'واتساب'**
  String get whatsapp;

  /// No description provided for @telegram.
  ///
  /// In ar, this message translates to:
  /// **'تيليغرام'**
  String get telegram;

  /// No description provided for @aboutUs.
  ///
  /// In ar, this message translates to:
  /// **'معلومات عنا'**
  String get aboutUs;

  /// No description provided for @location.
  ///
  /// In ar, this message translates to:
  /// **'الموقع'**
  String get location;

  /// No description provided for @sendWhatsapp.
  ///
  /// In ar, this message translates to:
  /// **'إرسال عبر واتساب'**
  String get sendWhatsapp;

  /// No description provided for @sendTelegram.
  ///
  /// In ar, this message translates to:
  /// **'إرسال عبر تيليغرام'**
  String get sendTelegram;

  /// No description provided for @callUs.
  ///
  /// In ar, this message translates to:
  /// **'اتصل بنا'**
  String get callUs;

  /// No description provided for @facebook.
  ///
  /// In ar, this message translates to:
  /// **'فيسبوك'**
  String get facebook;

  /// No description provided for @instagram.
  ///
  /// In ar, this message translates to:
  /// **'إنستغرام'**
  String get instagram;

  /// No description provided for @toSaveYouMustLogin.
  ///
  /// In ar, this message translates to:
  /// **'لحفظ العقار يجب تسجيل الدخول'**
  String get toSaveYouMustLogin;

  /// No description provided for @categoryE.
  ///
  /// In ar, this message translates to:
  /// **'{category, select, buy{شراء} rent{إيجار} swap{مبادلة} other{غير معروف}}'**
  String categoryE(String category);

  /// No description provided for @realEstateStatusE.
  ///
  /// In ar, this message translates to:
  /// **'{status, select, rented{مؤجر} sold{مباع} available{متاح} other{غير معروف}}'**
  String realEstateStatusE(String status);

  /// No description provided for @category.
  ///
  /// In ar, this message translates to:
  /// **'الفئة'**
  String get category;

  /// No description provided for @propertyDeedE.
  ///
  /// In ar, this message translates to:
  /// **'{type, select, green{سند أخضر} courtRolling{سند محكمة} municipal{سند بلدي} farm{سند مزرعة} industrial{سند صناعي} agricultural{سند زراعي} stock{سند ملكية أسهم} other{غير معروف}}'**
  String propertyDeedE(String type);

  /// No description provided for @propertyDeed.
  ///
  /// In ar, this message translates to:
  /// **'سند الملكية'**
  String get propertyDeed;

  /// No description provided for @propertyType.
  ///
  /// In ar, this message translates to:
  /// **'نوع العقار'**
  String get propertyType;

  /// No description provided for @propertyTypeE.
  ///
  /// In ar, this message translates to:
  /// **'{type, select, apartment{شقة} land{أرض} villa{فيلا} agriculturalLand{أرض زراعية} industrialLand{أرض صناعية} farm{مزرعة} shop{محل} architecture{عمارة} other{غير معروف}}'**
  String propertyTypeE(String type);

  /// No description provided for @price.
  ///
  /// In ar, this message translates to:
  /// **'السعر'**
  String get price;

  /// No description provided for @neighborhood.
  ///
  /// In ar, this message translates to:
  /// **'الحي'**
  String get neighborhood;

  /// No description provided for @address.
  ///
  /// In ar, this message translates to:
  /// **'العنوان'**
  String get address;

  /// No description provided for @rooms.
  ///
  /// In ar, this message translates to:
  /// **'الغرف'**
  String get rooms;

  /// No description provided for @floor.
  ///
  /// In ar, this message translates to:
  /// **'الطابق'**
  String get floor;

  /// No description provided for @area.
  ///
  /// In ar, this message translates to:
  /// **'المساحة'**
  String get area;

  /// No description provided for @bedrooms.
  ///
  /// In ar, this message translates to:
  /// **'غرف النوم'**
  String get bedrooms;

  /// No description provided for @bathrooms.
  ///
  /// In ar, this message translates to:
  /// **'الحمامات'**
  String get bathrooms;

  /// No description provided for @kitchen.
  ///
  /// In ar, this message translates to:
  /// **'المطبخ'**
  String get kitchen;

  /// No description provided for @garage.
  ///
  /// In ar, this message translates to:
  /// **'كراج'**
  String get garage;

  /// No description provided for @balcony.
  ///
  /// In ar, this message translates to:
  /// **'شرفة'**
  String get balcony;

  /// No description provided for @description.
  ///
  /// In ar, this message translates to:
  /// **'الوصف'**
  String get description;

  /// No description provided for @images.
  ///
  /// In ar, this message translates to:
  /// **'الصور'**
  String get images;

  /// No description provided for @addImage.
  ///
  /// In ar, this message translates to:
  /// **'إضافة صورة'**
  String get addImage;

  /// No description provided for @addNewImage.
  ///
  /// In ar, this message translates to:
  /// **'إضافة صورة جديدة'**
  String get addNewImage;

  /// No description provided for @deleteImage.
  ///
  /// In ar, this message translates to:
  /// **'حذف الصورة'**
  String get deleteImage;

  /// No description provided for @deleteImageMessage.
  ///
  /// In ar, this message translates to:
  /// **'هل أنت متأكد أنك تريد حذف هذه الصورة؟'**
  String get deleteImageMessage;

  /// No description provided for @delete.
  ///
  /// In ar, this message translates to:
  /// **'حذف'**
  String get delete;

  /// No description provided for @noData.
  ///
  /// In ar, this message translates to:
  /// **'لا توجد بيانات'**
  String get noData;

  /// No description provided for @specifications.
  ///
  /// In ar, this message translates to:
  /// **'المواصفات'**
  String get specifications;

  /// No description provided for @m2.
  ///
  /// In ar, this message translates to:
  /// **'م²'**
  String get m2;

  /// No description provided for @age.
  ///
  /// In ar, this message translates to:
  /// **'العمر'**
  String get age;

  /// No description provided for @year.
  ///
  /// In ar, this message translates to:
  /// **'سنة'**
  String get year;

  /// No description provided for @city.
  ///
  /// In ar, this message translates to:
  /// **'المدينة'**
  String get city;

  /// No description provided for @map.
  ///
  /// In ar, this message translates to:
  /// **'الخريطة'**
  String get map;

  /// No description provided for @min.
  ///
  /// In ar, this message translates to:
  /// **'الحد الأدنى'**
  String get min;

  /// No description provided for @max.
  ///
  /// In ar, this message translates to:
  /// **'الحد الأقصى'**
  String get max;

  /// No description provided for @syp.
  ///
  /// In ar, this message translates to:
  /// **'ل.س'**
  String get syp;

  /// No description provided for @favourites.
  ///
  /// In ar, this message translates to:
  /// **'المفضلة'**
  String get favourites;

  /// No description provided for @km2.
  ///
  /// In ar, this message translates to:
  /// **'كم²'**
  String get km2;

  /// No description provided for @updateApp.
  ///
  /// In ar, this message translates to:
  /// **'تحديث التطبيق'**
  String get updateApp;

  /// No description provided for @pleaseUpdateApp.
  ///
  /// In ar, this message translates to:
  /// **'إصدار التطبيق قديم'**
  String get pleaseUpdateApp;

  /// No description provided for @update.
  ///
  /// In ar, this message translates to:
  /// **'تحديث'**
  String get update;

  /// No description provided for @savedProperties.
  ///
  /// In ar, this message translates to:
  /// **'العقارات المحفوظة'**
  String get savedProperties;

  /// No description provided for @properties.
  ///
  /// In ar, this message translates to:
  /// **'العقارات'**
  String get properties;

  /// No description provided for @home.
  ///
  /// In ar, this message translates to:
  /// **'الرئيسية'**
  String get home;

  /// No description provided for @myProperties.
  ///
  /// In ar, this message translates to:
  /// **'عقاراتي'**
  String get myProperties;

  /// No description provided for @propertiesMap.
  ///
  /// In ar, this message translates to:
  /// **'خريطة العقارات'**
  String get propertiesMap;

  /// No description provided for @propertiesList.
  ///
  /// In ar, this message translates to:
  /// **'قائمة العقارات'**
  String get propertiesList;

  /// No description provided for @featured.
  ///
  /// In ar, this message translates to:
  /// **'مميز'**
  String get featured;

  /// No description provided for @fastAccess.
  ///
  /// In ar, this message translates to:
  /// **'وصول سريع'**
  String get fastAccess;

  /// No description provided for @addNewProperty.
  ///
  /// In ar, this message translates to:
  /// **'إضافة عقار جديد'**
  String get addNewProperty;

  /// No description provided for @title.
  ///
  /// In ar, this message translates to:
  /// **'العنوان'**
  String get title;

  /// No description provided for @optional.
  ///
  /// In ar, this message translates to:
  /// **'اختياري'**
  String get optional;

  /// No description provided for @inDollar.
  ///
  /// In ar, this message translates to:
  /// **'بالدولار'**
  String get inDollar;

  /// No description provided for @size.
  ///
  /// In ar, this message translates to:
  /// **'الحجم'**
  String get size;

  /// No description provided for @bathroom.
  ///
  /// In ar, this message translates to:
  /// **'حمام'**
  String get bathroom;

  /// No description provided for @propertyAge.
  ///
  /// In ar, this message translates to:
  /// **'عمر العقار'**
  String get propertyAge;

  /// No description provided for @sizeM2.
  ///
  /// In ar, this message translates to:
  /// **'المساحة (م²)'**
  String get sizeM2;

  /// No description provided for @propertyAgeInYears.
  ///
  /// In ar, this message translates to:
  /// **'عمر العقار بالسنوات'**
  String get propertyAgeInYears;

  /// No description provided for @mainInfo.
  ///
  /// In ar, this message translates to:
  /// **'المعلومات الرئيسية'**
  String get mainInfo;

  /// No description provided for @sizeInfo.
  ///
  /// In ar, this message translates to:
  /// **'معلومات المساحة'**
  String get sizeInfo;

  /// No description provided for @propertyInfo.
  ///
  /// In ar, this message translates to:
  /// **'معلومات العقار'**
  String get propertyInfo;

  /// No description provided for @back.
  ///
  /// In ar, this message translates to:
  /// **'رجوع'**
  String get back;

  /// No description provided for @next.
  ///
  /// In ar, this message translates to:
  /// **'التالي'**
  String get next;

  /// No description provided for @stock.
  ///
  /// In ar, this message translates to:
  /// **'سهم'**
  String get stock;

  /// No description provided for @stocks2400.
  ///
  /// In ar, this message translates to:
  /// **'أسهم /2400'**
  String get stocks2400;

  /// No description provided for @pressOnTheMapAndUseExpandIconForBiggerMap.
  ///
  /// In ar, this message translates to:
  /// **'اضغط على الخريطة واستخدم رمز التوسيع لعرض أكبر'**
  String get pressOnTheMapAndUseExpandIconForBiggerMap;

  /// No description provided for @thePropertyWillBeDeleted.
  ///
  /// In ar, this message translates to:
  /// **'سيتم حذف العقار!'**
  String get thePropertyWillBeDeleted;

  /// No description provided for @propertyAddMessageWarning.
  ///
  /// In ar, this message translates to:
  /// **'سيتم مراجعة العقار خلال 48 ساعة، بعدها لا يمكنك تعديل البيانات'**
  String get propertyAddMessageWarning;

  /// No description provided for @pleaseMakeSureYouAddedImages.
  ///
  /// In ar, this message translates to:
  /// **'أضف 3 صور على الأقل للعقار، وإلا لن يتم قبوله'**
  String get pleaseMakeSureYouAddedImages;

  /// No description provided for @propertyRejected.
  ///
  /// In ar, this message translates to:
  /// **'تم رفض العقار'**
  String get propertyRejected;

  /// No description provided for @pressOnTheMapToSetTheMarker.
  ///
  /// In ar, this message translates to:
  /// **'اضغط على الخريطة لتحديد الموقع'**
  String get pressOnTheMapToSetTheMarker;

  /// No description provided for @longPressOnTheImageAndDragIt.
  ///
  /// In ar, this message translates to:
  /// **'اضغط زر الأضافة واختر صورة - اضغط مطولاً على الصورة واسحبها لتغيير الترتيب - الصورة الأولى ستكون صورة الغلاف.'**
  String get longPressOnTheImageAndDragIt;

  /// No description provided for @status.
  ///
  /// In ar, this message translates to:
  /// **'الحالة'**
  String get status;

  /// No description provided for @pressToChangePropertyStatus.
  ///
  /// In ar, this message translates to:
  /// **'اضغط لتغيير حالة العقار'**
  String get pressToChangePropertyStatus;

  /// No description provided for @rejected.
  ///
  /// In ar, this message translates to:
  /// **'مرفوض'**
  String get rejected;

  /// No description provided for @main.
  ///
  /// In ar, this message translates to:
  /// **'الرئيسية'**
  String get main;

  /// No description provided for @property.
  ///
  /// In ar, this message translates to:
  /// **'العقار'**
  String get property;

  /// No description provided for @postStatus.
  ///
  /// In ar, this message translates to:
  /// **'حالة المنشور'**
  String get postStatus;

  /// No description provided for @propertyPostStatusE.
  ///
  /// In ar, this message translates to:
  /// **'{status, select, pending{تتم المراجعة} rejected {مرفوض} approved {مقبول} other{غير معروف}}'**
  String propertyPostStatusE(String status);

  /// No description provided for @authPageRequiresLogin.
  ///
  /// In ar, this message translates to:
  /// **'هذه الصفحة تتطلب تسجيل الدخول للوصول إلى محتواها.'**
  String get authPageRequiresLogin;

  /// No description provided for @dollar.
  ///
  /// In ar, this message translates to:
  /// **'دولار'**
  String get dollar;

  /// No description provided for @tutorial.
  ///
  /// In ar, this message translates to:
  /// **'دليل الإستخدام'**
  String get tutorial;

  /// No description provided for @changeStatusWarning.
  ///
  /// In ar, this message translates to:
  /// **'⚠️ تنبيه مهم: هل أنت متأكد من تغيير الحالة إلى مباع أو مؤجّر؟ بعد الحفظ لن تتمكّن من التراجع عن هذا الإجراء. في حال غيرت الحالة بالخطأ، يرجى التواصل مع فريق الدعم عبر زر (اتصل بنا) في أسفل الصفحة.'**
  String get changeStatusWarning;

  /// No description provided for @cantChangeStatus.
  ///
  /// In ar, this message translates to:
  /// **'لا يمكن تغيير حالة عقار مؤجر او مباع اذا غيرته مسبقا بالخطأ يرجى التواصل مع فريق الدعم عبر زر (اتصل بنا) في أسفل الصفحة.'**
  String get cantChangeStatus;

  /// No description provided for @ok.
  ///
  /// In ar, this message translates to:
  /// **'حسناً'**
  String get ok;

  /// No description provided for @phoneNumberRealEstate.
  ///
  /// In ar, this message translates to:
  /// **'سيتواصل معك الزبون على هذا الرقم'**
  String get phoneNumberRealEstate;

  /// No description provided for @callTheOwner.
  ///
  /// In ar, this message translates to:
  /// **'إتصل بصاحب الإعلان'**
  String get callTheOwner;

  /// No description provided for @callMaisonHub.
  ///
  /// In ar, this message translates to:
  /// **'إتصل ب Maison Hub'**
  String get callMaisonHub;
}

class _TranslationsDelegate extends LocalizationsDelegate<Translations> {
  const _TranslationsDelegate();

  @override
  Future<Translations> load(Locale locale) {
    return SynchronousFuture<Translations>(lookupTranslations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_TranslationsDelegate old) => false;
}

Translations lookupTranslations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return TranslationsAr();
    case 'en':
      return TranslationsEn();
  }

  throw FlutterError(
    'Translations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
