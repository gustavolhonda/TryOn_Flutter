// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `This field is required`
  String get requiredField {
    return Intl.message(
      'This field is required',
      name: 'requiredField',
      desc: '',
      args: [],
    );
  }

  /// `Incorrect email`
  String get wrongEmail {
    return Intl.message(
      'Incorrect email',
      name: 'wrongEmail',
      desc: '',
      args: [],
    );
  }

  /// `Incorrect password`
  String get wrongPassword {
    return Intl.message(
      'Incorrect password',
      name: 'wrongPassword',
      desc: '',
      args: [],
    );
  }

  /// `Unknown error`
  String get unknownError {
    return Intl.message(
      'Unknown error',
      name: 'unknownError',
      desc: '',
      args: [],
    );
  }

  /// `Welcome to TryOn!`
  String get welcomeTitle {
    return Intl.message(
      'Welcome to TryOn!',
      name: 'welcomeTitle',
      desc: '',
      args: [],
    );
  }

  /// `Try and Enjoy`
  String get welcomeSubtitle {
    return Intl.message(
      'Try and Enjoy',
      name: 'welcomeSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get emailLabel {
    return Intl.message(
      'Email',
      name: 'emailLabel',
      desc: '',
      args: [],
    );
  }

  /// `Enter your email`
  String get emailHint {
    return Intl.message(
      'Enter your email',
      name: 'emailHint',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get passwordLabel {
    return Intl.message(
      'Password',
      name: 'passwordLabel',
      desc: '',
      args: [],
    );
  }

  /// `Enter your password`
  String get passwordHint {
    return Intl.message(
      'Enter your password',
      name: 'passwordHint',
      desc: '',
      args: [],
    );
  }

  /// `Login`
  String get loginButton {
    return Intl.message(
      'Login',
      name: 'loginButton',
      desc: '',
      args: [],
    );
  }

  /// `Forgot your password? Click here`
  String get forgotPassword {
    return Intl.message(
      'Forgot your password? Click here',
      name: 'forgotPassword',
      desc: '',
      args: [],
    );
  }

  /// `Don't have an account yet?`
  String get noAccount {
    return Intl.message(
      'Don\'t have an account yet?',
      name: 'noAccount',
      desc: '',
      args: [],
    );
  }

  /// `Register here!`
  String get registerHere {
    return Intl.message(
      'Register here!',
      name: 'registerHere',
      desc: '',
      args: [],
    );
  }

  /// `Register`
  String get registerTitle {
    return Intl.message(
      'Register',
      name: 'registerTitle',
      desc: '',
      args: [],
    );
  }

  /// `Register Screen`
  String get registerScreen {
    return Intl.message(
      'Register Screen',
      name: 'registerScreen',
      desc: '',
      args: [],
    );
  }

  /// `Forgot Password`
  String get forgotPasswordTitle {
    return Intl.message(
      'Forgot Password',
      name: 'forgotPasswordTitle',
      desc: '',
      args: [],
    );
  }

  /// `Password Recovery Screen`
  String get forgotPasswordScreen {
    return Intl.message(
      'Password Recovery Screen',
      name: 'forgotPasswordScreen',
      desc: '',
      args: [],
    );
  }

  /// `Your notifications`
  String get notificationsTitle {
    return Intl.message(
      'Your notifications',
      name: 'notificationsTitle',
      desc: '',
      args: [],
    );
  }

  /// `No notifications`
  String get noNotifications {
    return Intl.message(
      'No notifications',
      name: 'noNotifications',
      desc: '',
      args: [],
    );
  }

  /// `Home`
  String get mainHome {
    return Intl.message(
      'Home',
      name: 'mainHome',
      desc: '',
      args: [],
    );
  }

  /// `Orders`
  String get mainOrders {
    return Intl.message(
      'Orders',
      name: 'mainOrders',
      desc: '',
      args: [],
    );
  }

  /// `Notifications`
  String get mainNotifications {
    return Intl.message(
      'Notifications',
      name: 'mainNotifications',
      desc: '',
      args: [],
    );
  }

  /// `My Orders`
  String get ordersTitle {
    return Intl.message(
      'My Orders',
      name: 'ordersTitle',
      desc: '',
      args: [],
    );
  }

  /// `Your cart is empty`
  String get cartEmpty {
    return Intl.message(
      'Your cart is empty',
      name: 'cartEmpty',
      desc: '',
      args: [],
    );
  }

  /// `Total ({count} items):`
  String totalItems(Object count) {
    return Intl.message(
      'Total ($count items):',
      name: 'totalItems',
      desc: '',
      args: [count],
    );
  }

  /// `Clear Cart`
  String get clearCart {
    return Intl.message(
      'Clear Cart',
      name: 'clearCart',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to remove all items from the cart?`
  String get clearCartConfirm {
    return Intl.message(
      'Are you sure you want to remove all items from the cart?',
      name: 'clearCartConfirm',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get cancel {
    return Intl.message(
      'Cancel',
      name: 'cancel',
      desc: '',
      args: [],
    );
  }

  /// `Clear`
  String get clear {
    return Intl.message(
      'Clear',
      name: 'clear',
      desc: '',
      args: [],
    );
  }

  /// `Finish Order`
  String get finishOrder {
    return Intl.message(
      'Finish Order',
      name: 'finishOrder',
      desc: '',
      args: [],
    );
  }

  /// `Order placed successfully!`
  String get orderSuccess {
    return Intl.message(
      'Order placed successfully!',
      name: 'orderSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Description:`
  String get description {
    return Intl.message(
      'Description:',
      name: 'description',
      desc: '',
      args: [],
    );
  }

  /// `Add to Cart`
  String get addToCart {
    return Intl.message(
      'Add to Cart',
      name: 'addToCart',
      desc: '',
      args: [],
    );
  }

  /// `TryOn`
  String get appTitle {
    return Intl.message(
      'TryOn',
      name: 'appTitle',
      desc: '',
      args: [],
    );
  }

  /// `All`
  String get tabAll {
    return Intl.message(
      'All',
      name: 'tabAll',
      desc: '',
      args: [],
    );
  }

  /// `Promotions`
  String get tabPromotions {
    return Intl.message(
      'Promotions',
      name: 'tabPromotions',
      desc: '',
      args: [],
    );
  }

  /// `Stores`
  String get tabStores {
    return Intl.message(
      'Stores',
      name: 'tabStores',
      desc: '',
      args: [],
    );
  }

  /// `Highlights`
  String get highlights {
    return Intl.message(
      'Highlights',
      name: 'highlights',
      desc: '',
      args: [],
    );
  }

  /// `Products`
  String get products {
    return Intl.message(
      'Products',
      name: 'products',
      desc: '',
      args: [],
    );
  }

  /// `Try Again`
  String get tryAgain {
    return Intl.message(
      'Try Again',
      name: 'tryAgain',
      desc: '',
      args: [],
    );
  }

  /// `Stores`
  String get stores {
    return Intl.message(
      'Stores',
      name: 'stores',
      desc: '',
      args: [],
    );
  }

  /// `Street Wear`
  String get storeStreetWear {
    return Intl.message(
      'Street Wear',
      name: 'storeStreetWear',
      desc: '',
      args: [],
    );
  }

  /// `Error loading products`
  String get errorLoadingProducts {
    return Intl.message(
      'Error loading products',
      name: 'errorLoadingProducts',
      desc: '',
      args: [],
    );
  }

  /// `Product added to cart!`
  String get productAddedToCart {
    return Intl.message(
      'Product added to cart!',
      name: 'productAddedToCart',
      desc: '',
      args: [],
    );
  }

  /// `Error adding to cart`
  String get errorAddingToCart {
    return Intl.message(
      'Error adding to cart',
      name: 'errorAddingToCart',
      desc: '',
      args: [],
    );
  }

  /// `Select a size`
  String get selectSize {
    return Intl.message(
      'Select a size',
      name: 'selectSize',
      desc: '',
      args: [],
    );
  }

  /// `Loading...`
  String get loading {
    return Intl.message(
      'Loading...',
      name: 'loading',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'pt'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
