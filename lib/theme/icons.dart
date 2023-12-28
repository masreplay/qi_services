// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:qi_services/icons/icons.dart';

/// This file contains all the icons used in the app.
/// Prevent extension and instantiation
///
/// implementation:
/// https://m3.material.io/styles/icons/overview
abstract final class DefaultIcons {
  // account
  static const IconData account = Icons.credit_card;

  // service
  static const IconData service = AppIcons.service;

  // more
  static const IconData more = Icons.more_horiz_outlined;

  // transfer
  static const IconData transfer = Icons.currency_exchange;

  // theme
  static const IconData theme = Icons.color_lens_outlined;
  
  // common
  static const IconData search = Icons.search_outlined;
  static const IconData password = Icons.lock_outline;
  static const IconData phone = Icons.phone_outlined;
  static const IconData visible = Icons.visibility_outlined;
  static const IconData invisible = Icons.visibility_off_outlined;
}
