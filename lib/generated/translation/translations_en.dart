// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'translations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class TranslationsEn extends Translations {
  TranslationsEn([String locale = 'en']) : super(locale);

  @override
  String get logIn => 'Login';

  @override
  String get email => 'Email';

  @override
  String get password => 'Password';

  @override
  String get name => 'Name';

  @override
  String get code => 'Code';

  @override
  String get phoneNumber => 'Phone Number';

  @override
  String get confirmPassword => 'Confirm Password';

  @override
  String get signUp => 'Sign Up';

  @override
  String get forgetPassword => 'Forget Password';

  @override
  String get continuE => 'Continue';

  @override
  String get retry => 'Retry';

  @override
  String get success => 'Success';

  @override
  String get accessDetails => 'Access Details';

  @override
  String get errorMessage => 'OOPS! Something went wrong';

  @override
  String get accessDeniedMessage =>
      'Access Denied, You have insufficient privileges';

  @override
  String get noInternetConnection => 'No internet connection';

  @override
  String get connectionTimeOut => 'Connection timeout';

  @override
  String get unauthenticatedMessage => 'Session is Expired!';

  @override
  String get yes => 'Yes';

  @override
  String get no => 'No';

  @override
  String get cancel => 'Cancel';

  @override
  String get search => 'Search';

  @override
  String get done => 'Done';

  @override
  String get fieldRequiredMessage => 'Required Field';

  @override
  String get codeIsRequired => 'Code is required';

  @override
  String get youHaveUnverifiedEmailPleaseVerifyIt =>
      'You have unverified email, please verify it!';

  @override
  String get resetPassword => 'Reset Password';

  @override
  String
  get yourPasswordMustBeAtLeast8charactersLongAndContainAtLeastLetterAndOneDigit =>
      'Your password must be at least 8 characters long and contain at least letter and one digit';

  @override
  String get shouldContainAtLeastOneCapitalLetter =>
      'Should contain at least one capital letter';

  @override
  String get shouldContainAtLeastOneSmallLetter =>
      'Should contain at least one small letter';

  @override
  String get shouldContainAtLeastOneSmallLetterAndOneCapitalLetter =>
      'capital letter and small letter';

  @override
  String get shouldContainAtLeast8Characters => 'at least 8 character';

  @override
  String get shouldContainAtLeastOneSymbol => 'at least one symbol';

  @override
  String get matchedPassword => 'matched password';

  @override
  String get createANewPasswordForYourAccount =>
      'Create a new password for your account';

  @override
  String get doNotHaveAccount => 'Don\'t have account?';

  @override
  String get createNewAccount => 'Create new account';

  @override
  String get enterYourEmailAndPassword => 'Enter Your Email And Password';

  @override
  String get orCreateNewAccount => 'Or Create New Account';

  @override
  String get alreadyHaveAccount => 'Already Have Account ?';

  @override
  String get createAccount => 'Create Account';

  @override
  String get welcomeToOurApplication => 'Welcome to our application';

  @override
  String get phone => 'phone';

  @override
  String get enterYourEmailOtp => 'Enter Your Email to send otp message';

  @override
  String get verifyEmail => 'Verify Email';

  @override
  String get enterYourCode => 'Enter the code you received on your email';

  @override
  String get changePassword => 'Change Password';

  @override
  String get changeYourAccountPassword => 'Change Your Account Password';

  @override
  String get currentPassword => 'Current Password';

  @override
  String get resend => 'Resend';

  @override
  String get settings => 'Settings';
}
