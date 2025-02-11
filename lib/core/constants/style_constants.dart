import 'package:flutter/material.dart';
import 'package:product_listing/core/constants/app_colors.dart';

class StyleConstants {
  static ButtonStyle primaryButtonStyle = OutlinedButton.styleFrom(
    foregroundColor: Colors.white,
    backgroundColor: AppColors.color_1DA1F2,
    minimumSize: const Size(80, 40),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(6)),
    ),
    side: const BorderSide(
      width: 1.0,
      color: AppColors.color_EDF8FF,
    ),
  );

  static ButtonStyle secondaryButtonStyle = OutlinedButton.styleFrom(
    foregroundColor: AppColors.color_1DA1F2,
    backgroundColor: AppColors.color_EDF8FF,
    minimumSize: const Size(80, 40),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(6)),
    ),
    side: const BorderSide(
      width: 1.0,
      color: AppColors.color_EDF8FF,
    ),
  );
}
