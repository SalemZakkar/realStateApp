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
  String get nonLessThan => 'Non less than';

  @override
  String get nonMoreThan => 'Non more than';

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

  @override
  String get realStates => 'RealStates';

  @override
  String get logOut => 'Logout';

  @override
  String get logoutMessage => 'Are u sure you want to logout?';

  @override
  String get profile => 'Profile';

  @override
  String get edit => 'Edit';

  @override
  String get save => 'Save';

  @override
  String get contactUs => 'Contact Us';

  @override
  String get whatsapp => 'Whatsapp';

  @override
  String get telegram => 'Telegram';

  @override
  String get aboutUs => 'About Us';

  @override
  String get location => 'Location';

  @override
  String get sendWhatsapp => 'Send whatsapp';

  @override
  String get sendTelegram => 'Send telegram';

  @override
  String get callUs => 'Call us';

  @override
  String get facebook => 'Facebook';

  @override
  String get instagram => 'Instagram';

  @override
  String get toSaveYouMustLogin => 'To save you must login';

  @override
  String categoryE(String category) {
    String _temp0 = intl.Intl.selectLogic(category, {
      'buy': 'Buy',
      'rent': 'Rent',
      'swap': 'Swap',
      'other': 'Unknown',
    });
    return '$_temp0';
  }

  @override
  String realEstateStatusE(String status) {
    String _temp0 = intl.Intl.selectLogic(status, {
      'rented': 'Rented',
      'sold': 'Sold',
      'available': 'Available',
      'other': 'Unknown',
    });
    return '$_temp0';
  }

  @override
  String get category => 'Category';

  @override
  String propertyDeedE(String type) {
    String _temp0 = intl.Intl.selectLogic(type, {
      'green': 'Green Deed',
      'courtRolling': 'Court Rolling Deed',
      'municipal': 'Municipal Deed',
      'farm': 'Farm Deed',
      'industrial': 'Industrial Deed',
      'agricultural': 'Agricultural Deed',
      'stock': 'Stock Owner Ship',
      'other': 'Unknown',
    });
    return '$_temp0';
  }

  @override
  String get propertyDeed => 'Property Deed';

  @override
  String get propertyType => 'Property Type';

  @override
  String propertyTypeE(String type) {
    String _temp0 = intl.Intl.selectLogic(type, {
      'apartment': 'Apartment',
      'land': 'Land',
      'villa': 'Villa',
      'agriculturalLand': 'Agricultural Land',
      'industrialLand': 'Industrial Land',
      'farm': 'Farm',
      'shop': 'Shop',
      'architecture': 'Architecture',
      'other': 'Unknown',
    });
    return '$_temp0';
  }

  @override
  String get price => 'Price';

  @override
  String get neighborhood => 'Neighborhood';

  @override
  String get address => 'Address';

  @override
  String get rooms => 'Rooms';

  @override
  String get floor => 'Floor';

  @override
  String get area => 'Area';

  @override
  String get bedrooms => 'Bedrooms';

  @override
  String get bathrooms => 'Bathrooms';

  @override
  String get kitchen => 'Kitchen';

  @override
  String get garage => 'Garage';

  @override
  String get balcony => 'Balcony';

  @override
  String get description => 'Description';

  @override
  String get images => 'Images';

  @override
  String get addImage => 'Add Image';

  @override
  String get addNewImage => 'Add New Image';

  @override
  String get deleteImage => 'Delete Image';

  @override
  String get deleteImageMessage =>
      'Are you sure you want to delete this image?';

  @override
  String get delete => 'Delete';

  @override
  String get noData => 'No Data';

  @override
  String get specifications => 'Specifications';

  @override
  String get m2 => 'M2';

  @override
  String get age => 'Age';

  @override
  String get year => 'Year';

  @override
  String get city => 'City';

  @override
  String get map => 'Map';

  @override
  String get min => 'Min';

  @override
  String get max => 'Max';

  @override
  String get syp => 'Syp';

  @override
  String get favourites => 'Favourites';

  @override
  String get km2 => 'Km2';

  @override
  String get updateApp => 'Update App';

  @override
  String get pleaseUpdateApp => 'The app version is outdated';

  @override
  String get update => 'Update';

  @override
  String get savedProperties => 'Saved Properties';

  @override
  String get properties => 'Properties';

  @override
  String get home => 'Home';

  @override
  String get myProperties => 'My Properties';

  @override
  String get propertiesMap => 'Properties Map';

  @override
  String get propertiesList => 'Properties List';

  @override
  String get featured => 'Featured';

  @override
  String get fastAccess => 'Fast Access';

  @override
  String get addNewProperty => 'Add New Property';

  @override
  String get title => 'Title';

  @override
  String get optional => 'Optional';

  @override
  String get inDollar => 'In dollar';

  @override
  String get size => 'Size';

  @override
  String get bathroom => 'Bathroom';

  @override
  String get propertyAge => 'Property Age';

  @override
  String get sizeM2 => 'Size (m2)';

  @override
  String get propertyAgeInYears => 'Property age in years';

  @override
  String get mainInfo => 'Main info';

  @override
  String get sizeInfo => 'Size info';

  @override
  String get propertyInfo => 'Property info';

  @override
  String get back => 'Back';

  @override
  String get next => 'Next';

  @override
  String get stock => 'Stock';

  @override
  String get stocks2400 => 'Stocks /2400';

  @override
  String get pressOnTheMapAndUseExpandIconForBiggerMap =>
      'Press on the map and use expand icon for bigger map';

  @override
  String get thePropertyWillBeDeleted => 'The property will be deleted !';

  @override
  String get propertyAddMessageWarning =>
      'property will be reviewed in the soon 48 hours after that you can\'t edit the data';

  @override
  String get pleaseMakeSureYouAddedImages =>
      'Add at least 3 images to the property otherwise the property will never be accepted';

  @override
  String get propertyRejected => 'Property rejected';

  @override
  String get pressOnTheMapToSetTheMarker =>
      'Press on the map to set the marker';

  @override
  String get longPressOnTheImageAndDragIt =>
      'Long press on the image and drag it to change the order , the first image will be the cover image.';

  @override
  String get status => 'Status';

  @override
  String get pressToChangePropertyStatus => 'Press to change property status';

  @override
  String get rejected => 'Rejected';

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
}
