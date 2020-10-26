// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars

class S {
  S();
  
  static S current;
  
  static const AppLocalizationDelegate delegate =
    AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false) ? locale.languageCode : locale.toString();
    final localeName = Intl.canonicalizedLocale(name); 
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      S.current = S();
      
      return S.current;
    });
  } 

  static S of(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Welcome`
  String get welcome {
    return Intl.message(
      'Welcome',
      name: 'welcome',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get email {
    return Intl.message(
      'Email',
      name: 'email',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get password {
    return Intl.message(
      'Password',
      name: 'password',
      desc: '',
      args: [],
    );
  }

  /// `Continue`
  String get continueTo {
    return Intl.message(
      'Continue',
      name: 'continueTo',
      desc: '',
      args: [],
    );
  }

  /// `Do Not Have Account`
  String get doNotHaveAccount {
    return Intl.message(
      'Do Not Have Account',
      name: 'doNotHaveAccount',
      desc: '',
      args: [],
    );
  }

  /// `Create Account`
  String get singUp {
    return Intl.message(
      'Create Account',
      name: 'singUp',
      desc: '',
      args: [],
    );
  }

  /// `Password reset`
  String get restPassword {
    return Intl.message(
      'Password reset',
      name: 'restPassword',
      desc: '',
      args: [],
    );
  }

  /// `Forget password`
  String get forgetPassword {
    return Intl.message(
      'Forget password',
      name: 'forgetPassword',
      desc: '',
      args: [],
    );
  }

  /// `This field is empty Please fill in the field`
  String get errorTextRequired {
    return Intl.message(
      'This field is empty Please fill in the field',
      name: 'errorTextRequired',
      desc: '',
      args: [],
    );
  }

  /// `Email is invalid. Try again`
  String get errorTextEmail {
    return Intl.message(
      'Email is invalid. Try again',
      name: 'errorTextEmail',
      desc: '',
      args: [],
    );
  }

  /// `Name is short. {Length} must be at least a letter or a number`
  String errorTextMinLength(Object Length) {
    return Intl.message(
      'Name is short. $Length must be at least a letter or a number',
      name: 'errorTextMinLength',
      desc: '',
      args: [Length],
    );
  }

  /// `Sing up`
  String get singUpTitle {
    return Intl.message(
      'Sing up',
      name: 'singUpTitle',
      desc: '',
      args: [],
    );
  }

  /// `Add Image profile`
  String get profileImage {
    return Intl.message(
      'Add Image profile',
      name: 'profileImage',
      desc: '',
      args: [],
    );
  }

  /// `Name`
  String get name {
    return Intl.message(
      'Name',
      name: 'name',
      desc: '',
      args: [],
    );
  }

  /// `Main page`
  String get mainPage {
    return Intl.message(
      'Main page',
      name: 'mainPage',
      desc: '',
      args: [],
    );
  }

  /// `Profile`
  String get myProfile {
    return Intl.message(
      'Profile',
      name: 'myProfile',
      desc: '',
      args: [],
    );
  }

  /// `Active MUBRM`
  String get activeMubrm {
    return Intl.message(
      'Active MUBRM',
      name: 'activeMubrm',
      desc: '',
      args: [],
    );
  }

  /// `Active MUBRM MINI`
  String get activeMubrmPhone {
    return Intl.message(
      'Active MUBRM MINI',
      name: 'activeMubrmPhone',
      desc: '',
      args: [],
    );
  }

  /// `Share App`
  String get shareApp {
    return Intl.message(
      'Share App',
      name: 'shareApp',
      desc: '',
      args: [],
    );
  }

  /// `Exit`
  String get exit {
    return Intl.message(
      'Exit',
      name: 'exit',
      desc: '',
      args: [],
    );
  }

  /// `Add Link`
  String get addLink {
    return Intl.message(
      'Add Link',
      name: 'addLink',
      desc: '',
      args: [],
    );
  }

  /// `QR code`
  String get barcode {
    return Intl.message(
      'QR code',
      name: 'barcode',
      desc: '',
      args: [],
    );
  }

  /// `Edit Profile`
  String get editAccount {
    return Intl.message(
      'Edit Profile',
      name: 'editAccount',
      desc: '',
      args: [],
    );
  }

  /// `Edit Photo profile`
  String get editImage {
    return Intl.message(
      'Edit Photo profile',
      name: 'editImage',
      desc: '',
      args: [],
    );
  }

  /// `Your Social Media List`
  String get socialMediaMyList {
    return Intl.message(
      'Your Social Media List',
      name: 'socialMediaMyList',
      desc: '',
      args: [],
    );
  }

  /// `Save`
  String get save {
    return Intl.message(
      'Save',
      name: 'save',
      desc: '',
      args: [],
    );
  }

  /// `Enter your Link`
  String get enterYourLink {
    return Intl.message(
      'Enter your Link',
      name: 'enterYourLink',
      desc: '',
      args: [],
    );
  }

  /// `Delete`
  String get delete {
    return Intl.message(
      'Delete',
      name: 'delete',
      desc: '',
      args: [],
    );
  }

  /// `Open Account`
  String get openAccount {
    return Intl.message(
      'Open Account',
      name: 'openAccount',
      desc: '',
      args: [],
    );
  }

  /// `Default Account`
  String get setDef {
    return Intl.message(
      'Default Account',
      name: 'setDef',
      desc: '',
      args: [],
    );
  }

  /// `Share Account`
  String get shareMyAccount {
    return Intl.message(
      'Share Account',
      name: 'shareMyAccount',
      desc: '',
      args: [],
    );
  }

  /// `Generate QR`
  String get generateQR {
    return Intl.message(
      'Generate QR',
      name: 'generateQR',
      desc: '',
      args: [],
    );
  }

  /// `Edit Phone Number`
  String get editPhoneNumber {
    return Intl.message(
      'Edit Phone Number',
      name: 'editPhoneNumber',
      desc: '',
      args: [],
    );
  }

  /// `Phone Number`
  String get phoneNumber {
    return Intl.message(
      'Phone Number',
      name: 'phoneNumber',
      desc: '',
      args: [],
    );
  }

  /// `Phone Number Active success`
  String get phoneNumberSuccess {
    return Intl.message(
      'Phone Number Active success',
      name: 'phoneNumberSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Device Support App`
  String get deviceSupportApp {
    return Intl.message(
      'Device Support App',
      name: 'deviceSupportApp',
      desc: '',
      args: [],
    );
  }

  /// `Device Not Support App`
  String get deviceNotSupportApp {
    return Intl.message(
      'Device Not Support App',
      name: 'deviceNotSupportApp',
      desc: '',
      args: [],
    );
  }

  /// `Account Not Active on Mubrm Active Now`
  String get accountNotActive {
    return Intl.message(
      'Account Not Active on Mubrm Active Now',
      name: 'accountNotActive',
      desc: '',
      args: [],
    );
  }

  /// `Account Active on Mubrm`
  String get accountActive {
    return Intl.message(
      'Account Active on Mubrm',
      name: 'accountActive',
      desc: '',
      args: [],
    );
  }

  /// `Hold your Mubrm to the middle back of your phone to active it,Hold the Mubrm there until success popup appears!`
  String get messageToHold {
    return Intl.message(
      'Hold your Mubrm to the middle back of your phone to active it,Hold the Mubrm there until success popup appears!',
      name: 'messageToHold',
      desc: '',
      args: [],
    );
  }

  /// `Activated number on Mubrm is {phone}`
  String phoneNumberIs(Object phone) {
    return Intl.message(
      'Activated number on Mubrm is $phone',
      name: 'phoneNumberIs',
      desc: '',
      args: [phone],
    );
  }

  /// `A password reset link has been sent to your email. Check it now`
  String get restPasswordSuccess {
    return Intl.message(
      'A password reset link has been sent to your email. Check it now',
      name: 'restPasswordSuccess',
      desc: '',
      args: [],
    );
  }

  /// `There is no user record corresponding to this identifier. The user may have been deleted.`
  String get restPasswordError {
    return Intl.message(
      'There is no user record corresponding to this identifier. The user may have been deleted.',
      name: 'restPasswordError',
      desc: '',
      args: [],
    );
  }

  /// `The data has been successfully updated`
  String get dataUpdateSuccess {
    return Intl.message(
      'The data has been successfully updated',
      name: 'dataUpdateSuccess',
      desc: '',
      args: [],
    );
  }

  /// `The password is invalid `
  String get wrongPassword {
    return Intl.message(
      'The password is invalid ',
      name: 'wrongPassword',
      desc: '',
      args: [],
    );
  }

  /// `Share {account}`
  String shareMyAccountSocial(Object account) {
    return Intl.message(
      'Share $account',
      name: 'shareMyAccountSocial',
      desc: '',
      args: [account],
    );
  }

  /// `visit my account {account}`
  String shareMyAccountSocialMessage(Object account) {
    return Intl.message(
      'visit my account $account',
      name: 'shareMyAccountSocialMessage',
      desc: '',
      args: [account],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    if (locale != null) {
      for (var supportedLocale in supportedLocales) {
        if (supportedLocale.languageCode == locale.languageCode) {
          return true;
        }
      }
    }
    return false;
  }
}