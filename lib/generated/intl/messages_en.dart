// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
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
  String get localeName => 'en';

  static m0(Length) => "Name is short. ${Length} must be at least a letter or a number";

  static m1(phone) => "Activated number on Mubrm is ${phone}";

  static m2(account) => "Share ${account}";

  static m3(account) => "visit my account ${account}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static _notInlinedMessages(_) => <String, Function> {
    "accountActive" : MessageLookupByLibrary.simpleMessage("Account Active on Mubrm"),
    "accountNotActive" : MessageLookupByLibrary.simpleMessage("Account Not Active on Mubrm Active Now"),
    "activeMubrm" : MessageLookupByLibrary.simpleMessage("Active MUBRM"),
    "activeMubrmPhone" : MessageLookupByLibrary.simpleMessage("Active MUBRM MINI"),
    "addLink" : MessageLookupByLibrary.simpleMessage("Add Link"),
    "barcode" : MessageLookupByLibrary.simpleMessage("QR code"),
    "continueTo" : MessageLookupByLibrary.simpleMessage("Continue"),
    "continueWithGoogle" : MessageLookupByLibrary.simpleMessage("Continue with Google"),
    "dataUpdateSuccess" : MessageLookupByLibrary.simpleMessage("The data has been successfully updated"),
    "delete" : MessageLookupByLibrary.simpleMessage("Delete"),
    "deviceNotSupportApp" : MessageLookupByLibrary.simpleMessage("Device Not Support App"),
    "deviceSupportApp" : MessageLookupByLibrary.simpleMessage("Device Support App"),
    "doNotHaveAccount" : MessageLookupByLibrary.simpleMessage("Do Not Have Account"),
    "editAccount" : MessageLookupByLibrary.simpleMessage("Edit Profile"),
    "editImage" : MessageLookupByLibrary.simpleMessage("Edit Photo profile"),
    "editPhoneNumber" : MessageLookupByLibrary.simpleMessage("Edit Phone Number"),
    "email" : MessageLookupByLibrary.simpleMessage("Email"),
    "enterYourLink" : MessageLookupByLibrary.simpleMessage("Enter your Link"),
    "errorTextEmail" : MessageLookupByLibrary.simpleMessage("Email is invalid. Try again"),
    "errorTextFormat" : MessageLookupByLibrary.simpleMessage("The format of the name is incorrect"),
    "errorTextMinLength" : m0,
    "errorTextRequired" : MessageLookupByLibrary.simpleMessage("This field is empty Please fill in the field"),
    "exit" : MessageLookupByLibrary.simpleMessage("Exit"),
    "forgetPassword" : MessageLookupByLibrary.simpleMessage("Forget password"),
    "generateQR" : MessageLookupByLibrary.simpleMessage("Generate QR"),
    "mainPage" : MessageLookupByLibrary.simpleMessage("Main page"),
    "makeProfileMessage" : MessageLookupByLibrary.simpleMessage("when your profile is public . others can access your profile using the link : "),
    "makeProfilePublic" : MessageLookupByLibrary.simpleMessage("Make profile public"),
    "messageToHold" : MessageLookupByLibrary.simpleMessage("Hold your Mubrm to the middle back of your phone to active it,Hold the Mubrm there until success popup appears!"),
    "myProfile" : MessageLookupByLibrary.simpleMessage("Profile"),
    "name" : MessageLookupByLibrary.simpleMessage("Name"),
    "openAccount" : MessageLookupByLibrary.simpleMessage("Open Account"),
    "password" : MessageLookupByLibrary.simpleMessage("Password"),
    "phoneNumber" : MessageLookupByLibrary.simpleMessage("Phone Number"),
    "phoneNumberIs" : m1,
    "phoneNumberSuccess" : MessageLookupByLibrary.simpleMessage("Phone Number Active success"),
    "profileImage" : MessageLookupByLibrary.simpleMessage("Add Image profile"),
    "restPassword" : MessageLookupByLibrary.simpleMessage("Password reset"),
    "restPasswordError" : MessageLookupByLibrary.simpleMessage("There is no user record corresponding to this identifier. The user may have been deleted."),
    "restPasswordSuccess" : MessageLookupByLibrary.simpleMessage("A password reset link has been sent to your email. Check it now"),
    "save" : MessageLookupByLibrary.simpleMessage("Save"),
    "setDef" : MessageLookupByLibrary.simpleMessage("Default Account"),
    "shareApp" : MessageLookupByLibrary.simpleMessage("Share App"),
    "shareMyAccount" : MessageLookupByLibrary.simpleMessage("Share Account"),
    "shareMyAccountSocial" : m2,
    "shareMyAccountSocialMessage" : m3,
    "singUp" : MessageLookupByLibrary.simpleMessage("Create Account"),
    "singUpTitle" : MessageLookupByLibrary.simpleMessage("Sing up"),
    "socialMediaMyList" : MessageLookupByLibrary.simpleMessage("Your Social Media List"),
    "welcome" : MessageLookupByLibrary.simpleMessage("Welcome"),
    "wrongPassword" : MessageLookupByLibrary.simpleMessage("The password is invalid ")
  };
}
