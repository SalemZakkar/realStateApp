import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

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
  static const List<Locale> supportedLocales = <Locale>[Locale('en')];

  /// No description provided for @logIn.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get logIn;

  /// No description provided for @email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @name.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get name;

  /// No description provided for @code.
  ///
  /// In en, this message translates to:
  /// **'Code'**
  String get code;

  /// No description provided for @phoneNumber.
  ///
  /// In en, this message translates to:
  /// **'Phone Number'**
  String get phoneNumber;

  /// No description provided for @confirmPassword.
  ///
  /// In en, this message translates to:
  /// **'Confirm Password'**
  String get confirmPassword;

  /// No description provided for @signUp.
  ///
  /// In en, this message translates to:
  /// **'Sign Up'**
  String get signUp;

  /// No description provided for @forgetPassword.
  ///
  /// In en, this message translates to:
  /// **'Forget Password'**
  String get forgetPassword;

  /// No description provided for @continuE.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get continuE;

  /// No description provided for @retry.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get retry;

  /// No description provided for @success.
  ///
  /// In en, this message translates to:
  /// **'Success'**
  String get success;

  /// No description provided for @accessDetails.
  ///
  /// In en, this message translates to:
  /// **'Access Details'**
  String get accessDetails;

  /// No description provided for @errorMessage.
  ///
  /// In en, this message translates to:
  /// **'OOPS! Something went wrong'**
  String get errorMessage;

  /// No description provided for @accessDeniedMessage.
  ///
  /// In en, this message translates to:
  /// **'Access Denied, You have insufficient privileges'**
  String get accessDeniedMessage;

  /// No description provided for @noInternetConnection.
  ///
  /// In en, this message translates to:
  /// **'No internet connection'**
  String get noInternetConnection;

  /// No description provided for @connectionTimeOut.
  ///
  /// In en, this message translates to:
  /// **'Connection timeout'**
  String get connectionTimeOut;

  /// No description provided for @unauthenticatedMessage.
  ///
  /// In en, this message translates to:
  /// **'Session is Expired!'**
  String get unauthenticatedMessage;

  /// No description provided for @yes.
  ///
  /// In en, this message translates to:
  /// **'Yes'**
  String get yes;

  /// No description provided for @no.
  ///
  /// In en, this message translates to:
  /// **'No'**
  String get no;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @search.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get search;

  /// No description provided for @done.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get done;

  /// No description provided for @fieldRequiredMessage.
  ///
  /// In en, this message translates to:
  /// **'Required Field'**
  String get fieldRequiredMessage;

  /// No description provided for @codeIsRequired.
  ///
  /// In en, this message translates to:
  /// **'Code is required'**
  String get codeIsRequired;

  /// No description provided for @youHaveUnverifiedEmailPleaseVerifyIt.
  ///
  /// In en, this message translates to:
  /// **'You have unverified email, please verify it!'**
  String get youHaveUnverifiedEmailPleaseVerifyIt;

  /// No description provided for @resetPassword.
  ///
  /// In en, this message translates to:
  /// **'Reset Password'**
  String get resetPassword;

  /// No description provided for @yourPasswordMustBeAtLeast8charactersLongAndContainAtLeastLetterAndOneDigit.
  ///
  /// In en, this message translates to:
  /// **'Your password must be at least 8 characters long and contain at least letter and one digit'**
  String
  get yourPasswordMustBeAtLeast8charactersLongAndContainAtLeastLetterAndOneDigit;

  /// No description provided for @shouldContainAtLeastOneCapitalLetter.
  ///
  /// In en, this message translates to:
  /// **'Should contain at least one capital letter'**
  String get shouldContainAtLeastOneCapitalLetter;

  /// No description provided for @shouldContainAtLeastOneSmallLetter.
  ///
  /// In en, this message translates to:
  /// **'Should contain at least one small letter'**
  String get shouldContainAtLeastOneSmallLetter;

  /// No description provided for @shouldContainAtLeastOneSmallLetterAndOneCapitalLetter.
  ///
  /// In en, this message translates to:
  /// **'capital letter and small letter'**
  String get shouldContainAtLeastOneSmallLetterAndOneCapitalLetter;

  /// No description provided for @shouldContainAtLeast8Characters.
  ///
  /// In en, this message translates to:
  /// **'at least 8 character'**
  String get shouldContainAtLeast8Characters;

  /// No description provided for @shouldContainAtLeastOneSymbol.
  ///
  /// In en, this message translates to:
  /// **'at least one symbol'**
  String get shouldContainAtLeastOneSymbol;

  /// No description provided for @nonLessThan.
  ///
  /// In en, this message translates to:
  /// **'Non less than'**
  String get nonLessThan;

  /// No description provided for @nonMoreThan.
  ///
  /// In en, this message translates to:
  /// **'Non more than'**
  String get nonMoreThan;

  /// No description provided for @matchedPassword.
  ///
  /// In en, this message translates to:
  /// **'matched password'**
  String get matchedPassword;

  /// No description provided for @createANewPasswordForYourAccount.
  ///
  /// In en, this message translates to:
  /// **'Create a new password for your account'**
  String get createANewPasswordForYourAccount;

  /// No description provided for @doNotHaveAccount.
  ///
  /// In en, this message translates to:
  /// **'Don\'t have account?'**
  String get doNotHaveAccount;

  /// No description provided for @createNewAccount.
  ///
  /// In en, this message translates to:
  /// **'Create new account'**
  String get createNewAccount;

  /// No description provided for @enterYourEmailAndPassword.
  ///
  /// In en, this message translates to:
  /// **'Enter Your Email And Password'**
  String get enterYourEmailAndPassword;

  /// No description provided for @orCreateNewAccount.
  ///
  /// In en, this message translates to:
  /// **'Or Create New Account'**
  String get orCreateNewAccount;

  /// No description provided for @alreadyHaveAccount.
  ///
  /// In en, this message translates to:
  /// **'Already Have Account ?'**
  String get alreadyHaveAccount;

  /// No description provided for @createAccount.
  ///
  /// In en, this message translates to:
  /// **'Create Account'**
  String get createAccount;

  /// No description provided for @welcomeToOurApplication.
  ///
  /// In en, this message translates to:
  /// **'Welcome to our application'**
  String get welcomeToOurApplication;

  /// No description provided for @phone.
  ///
  /// In en, this message translates to:
  /// **'phone'**
  String get phone;

  /// No description provided for @enterYourEmailOtp.
  ///
  /// In en, this message translates to:
  /// **'Enter Your Email to send otp message'**
  String get enterYourEmailOtp;

  /// No description provided for @verifyEmail.
  ///
  /// In en, this message translates to:
  /// **'Verify Email'**
  String get verifyEmail;

  /// No description provided for @enterYourCode.
  ///
  /// In en, this message translates to:
  /// **'Enter the code you received on your email'**
  String get enterYourCode;

  /// No description provided for @changePassword.
  ///
  /// In en, this message translates to:
  /// **'Change Password'**
  String get changePassword;

  /// No description provided for @changeYourAccountPassword.
  ///
  /// In en, this message translates to:
  /// **'Change Your Account Password'**
  String get changeYourAccountPassword;

  /// No description provided for @currentPassword.
  ///
  /// In en, this message translates to:
  /// **'Current Password'**
  String get currentPassword;

  /// No description provided for @resend.
  ///
  /// In en, this message translates to:
  /// **'Resend'**
  String get resend;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @realStates.
  ///
  /// In en, this message translates to:
  /// **'RealStates'**
  String get realStates;

  /// No description provided for @logOut.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logOut;

  /// No description provided for @logoutMessage.
  ///
  /// In en, this message translates to:
  /// **'Are u sure you want to logout?'**
  String get logoutMessage;

  /// No description provided for @profile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profile;

  /// No description provided for @edit.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get edit;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @contactUs.
  ///
  /// In en, this message translates to:
  /// **'Contact Us'**
  String get contactUs;

  /// No description provided for @whatsapp.
  ///
  /// In en, this message translates to:
  /// **'Whatsapp'**
  String get whatsapp;

  /// No description provided for @telegram.
  ///
  /// In en, this message translates to:
  /// **'Telegram'**
  String get telegram;

  /// No description provided for @aboutUs.
  ///
  /// In en, this message translates to:
  /// **'About Us'**
  String get aboutUs;

  /// No description provided for @location.
  ///
  /// In en, this message translates to:
  /// **'Location'**
  String get location;

  /// No description provided for @sendWhatsapp.
  ///
  /// In en, this message translates to:
  /// **'Send whatsapp'**
  String get sendWhatsapp;

  /// No description provided for @sendTelegram.
  ///
  /// In en, this message translates to:
  /// **'Send telegram'**
  String get sendTelegram;

  /// No description provided for @callUs.
  ///
  /// In en, this message translates to:
  /// **'Call us'**
  String get callUs;

  /// No description provided for @facebook.
  ///
  /// In en, this message translates to:
  /// **'Facebook'**
  String get facebook;

  /// No description provided for @instagram.
  ///
  /// In en, this message translates to:
  /// **'Instagram'**
  String get instagram;

  /// No description provided for @toSaveYouMustLogin.
  ///
  /// In en, this message translates to:
  /// **'To save you must login'**
  String get toSaveYouMustLogin;

  /// No description provided for @categoryE.
  ///
  /// In en, this message translates to:
  /// **'{category, select, buy{Buy} rent{Rent} other{Unknown}}'**
  String categoryE(String category);

  /// No description provided for @category.
  ///
  /// In en, this message translates to:
  /// **'Category'**
  String get category;

  /// No description provided for @propertyDeedE.
  ///
  /// In en, this message translates to:
  /// **'{type, select, green{Green Deed} courtRolling{Court Rolling Deed} municipal{Municipal Deed} farm{Farm Deed} industrial{Industrial Deed} agricultural{Agricultural Deed} stock{Stock Owner Ship} other{Unknown}}'**
  String propertyDeedE(String type);

  /// No description provided for @propertyDeed.
  ///
  /// In en, this message translates to:
  /// **'Property Deed'**
  String get propertyDeed;

  /// No description provided for @propertyType.
  ///
  /// In en, this message translates to:
  /// **'Property Type'**
  String get propertyType;

  /// No description provided for @propertyTypeE.
  ///
  /// In en, this message translates to:
  /// **'{type, select, apartment{Apartment} land{Land} villa{Villa} agriculturalLand{Agricultural Land} industrialLand{Industrial Land} farm{Farm} shop{Shop} architecture{Architecture} other{Unknown}}'**
  String propertyTypeE(String type);

  /// No description provided for @price.
  ///
  /// In en, this message translates to:
  /// **'Price'**
  String get price;

  /// No description provided for @neighborhood.
  ///
  /// In en, this message translates to:
  /// **'Neighborhood'**
  String get neighborhood;

  /// No description provided for @address.
  ///
  /// In en, this message translates to:
  /// **'Address'**
  String get address;

  /// No description provided for @rooms.
  ///
  /// In en, this message translates to:
  /// **'Rooms'**
  String get rooms;

  /// No description provided for @floor.
  ///
  /// In en, this message translates to:
  /// **'Floor'**
  String get floor;

  /// No description provided for @area.
  ///
  /// In en, this message translates to:
  /// **'Area'**
  String get area;

  /// No description provided for @bedrooms.
  ///
  /// In en, this message translates to:
  /// **'Bedrooms'**
  String get bedrooms;

  /// No description provided for @bathrooms.
  ///
  /// In en, this message translates to:
  /// **'Bathrooms'**
  String get bathrooms;

  /// No description provided for @kitchen.
  ///
  /// In en, this message translates to:
  /// **'Kitchen'**
  String get kitchen;

  /// No description provided for @garage.
  ///
  /// In en, this message translates to:
  /// **'Garage'**
  String get garage;

  /// No description provided for @balcony.
  ///
  /// In en, this message translates to:
  /// **'Balcony'**
  String get balcony;

  /// No description provided for @description.
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get description;

  /// No description provided for @images.
  ///
  /// In en, this message translates to:
  /// **'Images'**
  String get images;

  /// No description provided for @addImage.
  ///
  /// In en, this message translates to:
  /// **'Add Image'**
  String get addImage;

  /// No description provided for @addNewImage.
  ///
  /// In en, this message translates to:
  /// **'Add New Image'**
  String get addNewImage;

  /// No description provided for @deleteImage.
  ///
  /// In en, this message translates to:
  /// **'Delete Image'**
  String get deleteImage;

  /// No description provided for @deleteImageMessage.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete this image?'**
  String get deleteImageMessage;

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// No description provided for @noData.
  ///
  /// In en, this message translates to:
  /// **'No Data'**
  String get noData;

  /// No description provided for @specifications.
  ///
  /// In en, this message translates to:
  /// **'Specifications'**
  String get specifications;

  /// No description provided for @m2.
  ///
  /// In en, this message translates to:
  /// **'M2'**
  String get m2;

  /// No description provided for @age.
  ///
  /// In en, this message translates to:
  /// **'Age'**
  String get age;

  /// No description provided for @year.
  ///
  /// In en, this message translates to:
  /// **'Year'**
  String get year;

  /// No description provided for @city.
  ///
  /// In en, this message translates to:
  /// **'City'**
  String get city;

  /// No description provided for @map.
  ///
  /// In en, this message translates to:
  /// **'Map'**
  String get map;

  /// No description provided for @min.
  ///
  /// In en, this message translates to:
  /// **'Min'**
  String get min;

  /// No description provided for @max.
  ///
  /// In en, this message translates to:
  /// **'Max'**
  String get max;

  /// No description provided for @syp.
  ///
  /// In en, this message translates to:
  /// **'Syp'**
  String get syp;

  /// No description provided for @favourites.
  ///
  /// In en, this message translates to:
  /// **'Favourites'**
  String get favourites;

  /// No description provided for @km2.
  ///
  /// In en, this message translates to:
  /// **'Km2'**
  String get km2;

  /// No description provided for @updateApp.
  ///
  /// In en, this message translates to:
  /// **'Update App'**
  String get updateApp;

  /// No description provided for @pleaseUpdateApp.
  ///
  /// In en, this message translates to:
  /// **'The app version is outdated'**
  String get pleaseUpdateApp;

  /// No description provided for @update.
  ///
  /// In en, this message translates to:
  /// **'Update'**
  String get update;

  /// No description provided for @savedProperties.
  ///
  /// In en, this message translates to:
  /// **'Saved Properties'**
  String get savedProperties;

  /// No description provided for @properties.
  ///
  /// In en, this message translates to:
  /// **'Properties'**
  String get properties;

  /// No description provided for @home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// No description provided for @myProperties.
  ///
  /// In en, this message translates to:
  /// **'My Properties'**
  String get myProperties;

  /// No description provided for @propertiesMap.
  ///
  /// In en, this message translates to:
  /// **'Properties Map'**
  String get propertiesMap;

  /// No description provided for @propertiesList.
  ///
  /// In en, this message translates to:
  /// **'Properties List'**
  String get propertiesList;

  /// No description provided for @featured.
  ///
  /// In en, this message translates to:
  /// **'Featured'**
  String get featured;

  /// No description provided for @fastAccess.
  ///
  /// In en, this message translates to:
  /// **'Fast Access'**
  String get fastAccess;

  /// No description provided for @addNewProperty.
  ///
  /// In en, this message translates to:
  /// **'Add New Property'**
  String get addNewProperty;

  /// No description provided for @title.
  ///
  /// In en, this message translates to:
  /// **'Title'**
  String get title;

  /// No description provided for @optional.
  ///
  /// In en, this message translates to:
  /// **'Optional'**
  String get optional;

  /// No description provided for @inDollar.
  ///
  /// In en, this message translates to:
  /// **'In dollar'**
  String get inDollar;

  /// No description provided for @size.
  ///
  /// In en, this message translates to:
  /// **'Size'**
  String get size;

  /// No description provided for @bathroom.
  ///
  /// In en, this message translates to:
  /// **'Bathroom'**
  String get bathroom;

  /// No description provided for @propertyAge.
  ///
  /// In en, this message translates to:
  /// **'Property Age'**
  String get propertyAge;

  /// No description provided for @sizeM2.
  ///
  /// In en, this message translates to:
  /// **'Size (m2)'**
  String get sizeM2;

  /// No description provided for @propertyAgeInYears.
  ///
  /// In en, this message translates to:
  /// **'Property age in years'**
  String get propertyAgeInYears;

  /// No description provided for @mainInfo.
  ///
  /// In en, this message translates to:
  /// **'Main info'**
  String get mainInfo;

  /// No description provided for @sizeInfo.
  ///
  /// In en, this message translates to:
  /// **'Size info'**
  String get sizeInfo;

  /// No description provided for @propertyInfo.
  ///
  /// In en, this message translates to:
  /// **'Property info'**
  String get propertyInfo;

  /// No description provided for @back.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get back;

  /// No description provided for @next.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get next;

  /// No description provided for @stock.
  ///
  /// In en, this message translates to:
  /// **'Stock'**
  String get stock;

  /// No description provided for @stocks2400.
  ///
  /// In en, this message translates to:
  /// **'Stocks /2400'**
  String get stocks2400;
}

class _TranslationsDelegate extends LocalizationsDelegate<Translations> {
  const _TranslationsDelegate();

  @override
  Future<Translations> load(Locale locale) {
    return SynchronousFuture<Translations>(lookupTranslations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en'].contains(locale.languageCode);

  @override
  bool shouldReload(_TranslationsDelegate old) => false;
}

Translations lookupTranslations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
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
