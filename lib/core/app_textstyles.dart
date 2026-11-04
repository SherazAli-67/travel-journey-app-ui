import 'package:flutter/material.dart';
import 'package:travel_journey_app/constants/string_const.dart';
import 'package:travel_journey_app/core/app_colors.dart';

class AppTextStyles {
  static const _font = StringConst.appFontFamily;

  static const welcomeHeadline = TextStyle(
    fontFamily: _font,
    fontSize: 34,
    fontWeight: .w600,
    height: 1.2,
    color: AppColors.white,
  );

  static const welcomeSubtitle = TextStyle(
    fontFamily: _font,
    fontSize: 14,
    fontWeight: .w500,
    height: 1.2,
    color: AppColors.white72,
  );

  static const greetingLight = TextStyle(
    fontFamily: _font,
    fontSize: 18,
    fontWeight: .w300,
    height: 1.5,
    color: AppColors.white,
  );

  static const greetingBold = TextStyle(
    fontFamily: _font,
    fontSize: 18,
    fontWeight: .w700,
    height: 1.5,
    color: AppColors.white,
  );

  static const homeTitle = TextStyle(
    fontFamily: _font,
    fontSize: 38,
    fontWeight: .w800,
    height: 1.15,
    color: AppColors.white,
  );

  static const searchPlaceholder = TextStyle(
    fontFamily: _font,
    fontSize: 16,
    fontWeight: .w500,
    height: 1.5,
    color: AppColors.white64,
  );

  static const chipLabel = TextStyle(
    fontFamily: _font,
    fontSize: 14,
    fontWeight: .w500,
    height: 1,
    color: AppColors.white,
  );

  static const chipLabelActive = TextStyle(
    fontFamily: _font,
    fontSize: 14,
    fontWeight: .w500,
    height: 1,
    color: AppColors.onPrimary,
  );

  static const placeName = TextStyle(
    fontFamily: _font,
    fontSize: 18,
    fontWeight: .w700,
    height: 1.4,
    color: AppColors.white,
  );

  static const placePrice = TextStyle(
    fontFamily: _font,
    fontSize: 20,
    fontWeight: .w800,
    height: 1.3,
    color: AppColors.primary,
  );

  static const placeLocation = TextStyle(
    fontFamily: _font,
    fontSize: 14,
    fontWeight: .w500,
    height: 1.3,
    color: AppColors.white,
  );

  static const placeRating = TextStyle(
    fontFamily: _font,
    fontSize: 12,
    fontWeight: .w600,
    height: 1.3,
    color: AppColors.white,
  );

  static const screenTitle = TextStyle(
    fontFamily: _font,
    fontSize: 24,
    fontWeight: .w600,
    height: 1.5,
    color: AppColors.white,
  );

  static const resultsCount = TextStyle(
    fontFamily: _font,
    fontSize: 20,
    fontWeight: .w600,
    height: 1.5,
    color: AppColors.white,
  );

  static const detailTitle = TextStyle(
    fontFamily: _font,
    fontSize: 24,
    fontWeight: .w600,
    height: 1.35,
    color: AppColors.white,
  );

  static const infoLabel = TextStyle(
    fontFamily: _font,
    fontSize: 16,
    fontWeight: .w600,
    height: 1.5,
    color: AppColors.white,
  );

  static const infoValue = TextStyle(
    fontFamily: _font,
    fontSize: 14,
    fontWeight: .w700,
    height: 1.15,
    color: AppColors.primary,
  );

  static const sectionTitle = TextStyle(
    fontFamily: _font,
    fontSize: 20,
    fontWeight: .w600,
    height: 1.35,
    color: AppColors.white,
  );

  static const bodyMedium = TextStyle(
    fontFamily: _font,
    fontSize: 14,
    fontWeight: .w500,
    height: 1.4,
    color: AppColors.white64,
  );

  static const detailTabActive = TextStyle(
    fontFamily: _font,
    fontSize: 14,
    fontWeight: .w700,
    height: 1,
    color: AppColors.onPrimary,
  );

  static const detailTabInactive = TextStyle(
    fontFamily: _font,
    fontSize: 14,
    fontWeight: .w500,
    height: 1,
    color: AppColors.white,
  );
}
