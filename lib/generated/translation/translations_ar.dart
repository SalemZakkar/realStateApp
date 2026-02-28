// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'translations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class TranslationsAr extends Translations {
  TranslationsAr([String locale = 'ar']) : super(locale);

  @override
  String get logIn => 'تسجيل الدخول';

  @override
  String get email => 'البريد الإلكتروني';

  @override
  String get password => 'كلمة المرور';

  @override
  String get name => 'الاسم';

  @override
  String get code => 'الرمز';

  @override
  String get phoneNumber => 'رقم الهاتف';

  @override
  String get confirmPassword => 'تأكيد كلمة المرور';

  @override
  String get signUp => 'إنشاء حساب';

  @override
  String get forgetPassword => 'نسيت كلمة المرور';

  @override
  String get continuE => 'متابعة';

  @override
  String get retry => 'إعادة المحاولة';

  @override
  String get success => 'نجاح';

  @override
  String get accessDetails => 'تفاصيل الوصول';

  @override
  String get errorMessage => 'عذراً! حدث خطأ ما';

  @override
  String get accessDeniedMessage => 'تم رفض الوصول، ليس لديك الصلاحيات الكافية';

  @override
  String get noInternetConnection => 'لا يوجد اتصال بالإنترنت';

  @override
  String get connectionTimeOut => 'انتهت مهلة الاتصال';

  @override
  String get unauthenticatedMessage => 'انتهت الجلسة!';

  @override
  String get yes => 'نعم';

  @override
  String get no => 'لا';

  @override
  String get cancel => 'إلغاء';

  @override
  String get search => 'بحث';

  @override
  String get done => 'تم';

  @override
  String get fieldRequiredMessage => 'حقل مطلوب';

  @override
  String get codeIsRequired => 'الرمز مطلوب';

  @override
  String get youHaveUnverifiedEmailPleaseVerifyIt =>
      'لديك بريد غير مُفعل، يرجى تفعيله!';

  @override
  String get resetPassword => 'إعادة تعيين كلمة المرور';

  @override
  String
  get yourPasswordMustBeAtLeast8charactersLongAndContainAtLeastLetterAndOneDigit =>
      'يجب أن تحتوي كلمة المرور على 8 أحرف على الأقل، وحرف ورقم واحد على الأقل';

  @override
  String get shouldContainAtLeastOneCapitalLetter =>
      'يجب أن تحتوي على حرف كبير واحد على الأقل';

  @override
  String get shouldContainAtLeastOneSmallLetter =>
      'يجب أن تحتوي على حرف صغير واحد على الأقل';

  @override
  String get shouldContainAtLeastOneSmallLetterAndOneCapitalLetter =>
      'حرف كبير وحرف صغير';

  @override
  String get shouldContainAtLeast8Characters => '8 أحرف على الأقل';

  @override
  String get shouldContainAtLeastOneSymbol => 'رمز واحد على الأقل';

  @override
  String get nonLessThan => 'لا يقل عن';

  @override
  String get nonMoreThan => 'لا يزيد عن';

  @override
  String get matchedPassword => 'كلمة المرور متطابقة';

  @override
  String get createANewPasswordForYourAccount => 'أنشئ كلمة مرور جديدة لحسابك';

  @override
  String get doNotHaveAccount => 'ليس لديك حساب؟';

  @override
  String get createNewAccount => 'إنشاء حساب جديد';

  @override
  String get enterYourEmailAndPassword => 'أدخل البريد الإلكتروني وكلمة المرور';

  @override
  String get orCreateNewAccount => 'أو أنشئ حساباً جديداً';

  @override
  String get alreadyHaveAccount => 'لديك حساب بالفعل؟';

  @override
  String get createAccount => 'إنشاء حساب';

  @override
  String get welcomeToOurApplication => 'مرحباً بك في تطبيقنا';

  @override
  String get phone => 'الهاتف';

  @override
  String get enterYourEmailOtp => 'أدخل بريدك الإلكتروني لإرسال رمز التحقق';

  @override
  String get verifyEmail => 'تفعيل البريد الإلكتروني';

  @override
  String get enterYourCode => 'أدخل الرمز المرسل إلى بريدك الإلكتروني';

  @override
  String get changePassword => 'تغيير كلمة المرور';

  @override
  String get changeYourAccountPassword => 'غيّر كلمة مرور حسابك';

  @override
  String get currentPassword => 'كلمة المرور الحالية';

  @override
  String get resend => 'إعادة الإرسال';

  @override
  String get settings => 'الإعدادات';

  @override
  String get realStates => 'العقارات';

  @override
  String get logOut => 'تسجيل الخروج';

  @override
  String get logoutMessage => 'هل أنت متأكد أنك تريد تسجيل الخروج؟';

  @override
  String get profile => 'الملف الشخصي';

  @override
  String get edit => 'تعديل';

  @override
  String get save => 'حفظ';

  @override
  String get contactUs => 'اتصل بنا';

  @override
  String get whatsapp => 'واتساب';

  @override
  String get telegram => 'تيليغرام';

  @override
  String get aboutUs => 'معلومات عنا';

  @override
  String get location => 'الموقع';

  @override
  String get sendWhatsapp => 'إرسال عبر واتساب';

  @override
  String get sendTelegram => 'إرسال عبر تيليغرام';

  @override
  String get callUs => 'اتصل بنا';

  @override
  String get facebook => 'فيسبوك';

  @override
  String get instagram => 'إنستغرام';

  @override
  String get toSaveYouMustLogin => 'لحفظ العقار يجب تسجيل الدخول';

  @override
  String categoryE(String category) {
    String _temp0 = intl.Intl.selectLogic(category, {
      'buy': 'شراء',
      'rent': 'إيجار',
      'swap': 'مبادلة',
      'other': 'غير معروف',
    });
    return '$_temp0';
  }

  @override
  String realEstateStatusE(String status) {
    String _temp0 = intl.Intl.selectLogic(status, {
      'rented': 'مؤجر',
      'sold': 'مباع',
      'available': 'متاح',
      'other': 'غير معروف',
    });
    return '$_temp0';
  }

  @override
  String get category => 'الفئة';

  @override
  String propertyDeedE(String type) {
    String _temp0 = intl.Intl.selectLogic(type, {
      'green': 'طابو أخضر',
      'courtRolling': 'طابو محكمة',
      'municipal': 'طابو بلدي',
      'farm': 'طابو مزرعة',
      'industrial': 'طابو صناعي',
      'agricultural': 'طابو زراعي',
      'stock': 'طابو أسهم',
      'other': 'غير معروف',
    });
    return '$_temp0';
  }

  @override
  String get propertyDeed => 'الطّابو';

  @override
  String get propertyType => 'نوع العقار';

  @override
  String propertyTypeE(String type) {
    String _temp0 = intl.Intl.selectLogic(type, {
      'apartment': 'شقة',
      'land': 'أرض',
      'villa': 'فيلا',
      'agriculturalLand': 'أرض زراعية',
      'industrialLand': 'أرض صناعية',
      'farm': 'مزرعة',
      'shop': 'محل',
      'architecture': 'عمارة',
      'other': 'غير معروف',
    });
    return '$_temp0';
  }

  @override
  String get price => 'السعر';

  @override
  String get neighborhood => 'الحي';

  @override
  String get address => 'العنوان';

  @override
  String get rooms => 'الغرف';

  @override
  String get floor => 'الطابق';

  @override
  String get area => 'المساحة';

  @override
  String get bedrooms => 'غرف النوم';

  @override
  String get bathrooms => 'الحمامات';

  @override
  String get kitchen => 'المطبخ';

  @override
  String get garage => 'كراج';

  @override
  String get balcony => 'شرفة';

  @override
  String get description => 'الوصف';

  @override
  String get images => 'الصور';

  @override
  String get addImage => 'إضافة صورة';

  @override
  String get addNewImage => 'إضافة صورة جديدة';

  @override
  String get deleteImage => 'حذف الصورة';

  @override
  String get deleteImageMessage => 'هل أنت متأكد أنك تريد حذف هذه الصورة؟';

  @override
  String get delete => 'حذف';

  @override
  String get noData => 'لا توجد بيانات';

  @override
  String get specifications => 'المواصفات';

  @override
  String get m2 => 'م²';

  @override
  String get age => 'العمر';

  @override
  String get year => 'سنة';

  @override
  String get city => 'المدينة';

  @override
  String get map => 'الخريطة';

  @override
  String get min => 'الحد الأدنى';

  @override
  String get max => 'الحد الأقصى';

  @override
  String get syp => 'ل.س';

  @override
  String get favourites => 'المفضلة';

  @override
  String get km2 => 'كم²';

  @override
  String get updateApp => 'تحديث التطبيق';

  @override
  String get pleaseUpdateApp => 'إصدار التطبيق قديم';

  @override
  String get update => 'تحديث';

  @override
  String get savedProperties => 'العقارات المحفوظة';

  @override
  String get properties => 'العقارات';

  @override
  String get home => 'الرئيسية';

  @override
  String get myProperties => 'عقاراتي';

  @override
  String get propertiesMap => 'خريطة العقارات';

  @override
  String get propertiesList => 'قائمة العقارات';

  @override
  String get featured => 'مميز';

  @override
  String get fastAccess => 'وصول سريع';

  @override
  String get addNewProperty => 'إضافة عقار جديد';

  @override
  String get title => 'العنوان';

  @override
  String get optional => 'اختياري';

  @override
  String get inDollar => 'بالدولار';

  @override
  String get size => 'الحجم';

  @override
  String get bathroom => 'حمام';

  @override
  String get propertyAge => 'عمر العقار';

  @override
  String get sizeM2 => 'المساحة (م²)';

  @override
  String get propertyAgeInYears => 'عمر العقار بالسنوات';

  @override
  String get mainInfo => 'المعلومات الرئيسية';

  @override
  String get sizeInfo => 'معلومات المساحة';

  @override
  String get propertyInfo => 'معلومات العقار';

  @override
  String get back => 'رجوع';

  @override
  String get next => 'التالي';

  @override
  String get stock => 'سهم';

  @override
  String get stocks2400 => 'أسهم /2400';

  @override
  String get pressOnTheMapAndUseExpandIconForBiggerMap =>
      'اضغط على الخريطة واستخدم رمز التوسيع لعرض أكبر';

  @override
  String get thePropertyWillBeDeleted => 'سيتم حذف العقار!';

  @override
  String get propertyAddMessageWarning =>
      'سيتم مراجعة العقار خلال 48 ساعة، بعدها لا يمكنك تعديل البيانات';

  @override
  String get pleaseMakeSureYouAddedImages =>
      'أضف 3 صور على الأقل للعقار، وإلا لن يتم قبوله';

  @override
  String get propertyRejected => 'تم رفض العقار';

  @override
  String get pressOnTheMapToSetTheMarker => 'اضغط على الخريطة لتحديد الموقع';

  @override
  String get longPressOnTheImageAndDragIt =>
      'اضغط زر الأضافة واختر صورة - اضغط مطولاً على الصورة واسحبها لتغيير الترتيب - الصورة الأولى ستكون صورة الغلاف.';

  @override
  String get status => 'الحالة';

  @override
  String get pressToChangePropertyStatus => 'اضغط لتغيير حالة العقار';

  @override
  String get rejected => 'مرفوض';

  @override
  String get main => 'الرئيسية';

  @override
  String get property => 'العقار';

  @override
  String get postStatus => 'حالة المنشور';

  @override
  String propertyPostStatusE(String status) {
    String _temp0 = intl.Intl.selectLogic(status, {
      'pending': 'تتم المراجعة',
      'rejected': 'مرفوض',
      'approved': 'مقبول',
      'other': 'غير معروف',
    });
    return '$_temp0';
  }

  @override
  String get authPageRequiresLogin =>
      'هذه الصفحة تتطلب تسجيل الدخول للوصول إلى محتواها.';

  @override
  String get dollar => 'دولار';

  @override
  String get tutorial => 'دليل الإستخدام';

  @override
  String get changeStatusWarning =>
      '⚠️ تنبيه مهم: هل أنت متأكد من تغيير الحالة إلى مباع أو مؤجّر؟ بعد الحفظ لن تتمكّن من التراجع عن هذا الإجراء. في حال غيرت الحالة بالخطأ، يرجى التواصل مع فريق الدعم عبر زر (اتصل بنا) في أسفل الصفحة.';

  @override
  String get cantChangeStatus =>
      'لا يمكن تغيير حالة عقار مؤجر او مباع اذا غيرته مسبقا بالخطأ يرجى التواصل مع فريق الدعم عبر زر (اتصل بنا) في أسفل الصفحة.';

  @override
  String get ok => 'حسناً';

  @override
  String get phoneNumberRealEstate => 'سيتواصل معك الزبون على هذا الرقم';

  @override
  String get callTheOwner => 'إتصل بصاحب الإعلان';

  @override
  String get callMaisonHub => 'إتصل ب Maison Hub';

  @override
  String get privacyPolicy => 'سياسة الخصوصية';

  @override
  String get termsAndConditions => 'الشروط والأحكام';

  @override
  String get and => 'و';

  @override
  String get iAcceptTermsAndConditionsAndPrivacyPolicy =>
      'أنا أقبل بشروط الإستخدام وسياسة الخصوصية';

  @override
  String get iAccept => 'أنا أوافق على ';

  @override
  String get enterYourPhoneNumber => 'أدخل رقم هاتفك لنرسل اليك كود تحقق';

  @override
  String get verification => 'التحقق';

  @override
  String get sendTheCodeWeHaveSent =>
      'ادخل الكود المرسل الى رقمك ليتم تسجيل الدخول';

  @override
  String get continueAsGuest => 'متابعة كضيف';

  @override
  String get confirmation => 'تأكيد';

  @override
  String get areUSureYouWillLogout => 'هل أنت متأكد انك تريد تسجيل الخروج ؟';

  @override
  String get info => 'معلومات';

  @override
  String get mostExpensive => 'الأكثر سعراً';

  @override
  String get lessExpensive => 'الأقل سعراً';

  @override
  String get biggest => 'الأكبر مساحةً';

  @override
  String get smallest => 'الأصغر مساحةً';

  @override
  String get theFiltering => 'الفلترة';

  @override
  String get more => 'أكثر';

  @override
  String get all => 'الكل';

  @override
  String get sellBuySwap => 'بيع/شراء/مبادلة';

  @override
  String get whoAreWe => 'من نحن ؟';
}
