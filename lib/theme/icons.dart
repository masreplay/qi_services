// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:qi_services/icons/icons.dart';

/// This file contains all the icons used in the app.
/// Prevent extension and instantiation
///
/// implementation:
/// https://m3.material.io/styles/icons/overview
abstract final class DefaultIcons {
  // main
  static const IconData account = Icons.credit_card;
  static const IconData service = GeneratedIcons.service;
  static const IconData more = Icons.more_horiz_outlined;
  static const IconData transfer = Icons.currency_exchange;

  static const IconData notifications = Icons.notifications_outlined;
  static const IconData add_card = Icons.add_card_outlined;

  static const IconData qr_code_scanner = Icons.qr_code_scanner;

  // theme
  static const IconData theme = Icons.color_lens_outlined;
  static const IconData placeholder = Icons.image_outlined;

  // common
  static const IconData search = Icons.search_outlined;
  static const IconData password = Icons.lock_outline;
  static const IconData phone = Icons.phone_outlined;
  static const IconData visible = Icons.visibility_outlined;
  static const IconData invisible = Icons.visibility_off_outlined;
}
