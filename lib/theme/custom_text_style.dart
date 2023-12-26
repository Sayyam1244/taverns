import 'package:flutter/material.dart';
import '../core/app_export.dart';

/// A collection of pre-defined text styles for customizing text appearance,
/// categorized by different font families and weights.
/// Additionally, this class includes extensions on [TextStyle] to easily apply specific font families to text.

class CustomTextStyles {
  // Body text style
  static get bodySmallMulishBluegray900 =>
      theme.textTheme.bodySmall!.mulish.copyWith(
        color: appTheme.blueGray900,
      );
  static get bodySmall => theme.textTheme.bodySmall!.copyWith(
        color: theme.colorScheme.onErrorContainer.withOpacity(1),
      );
    static get bodySmallwithLetterSpacing => theme.textTheme.bodySmall!.copyWith(
        color: theme.colorScheme.onErrorContainer.withOpacity(1),
        letterSpacing: 10
      );
  static get bodySmallPrimary => theme.textTheme.bodySmall!.copyWith(
        color: theme.colorScheme.primary,
      );
  static get bodySmallSFProBluegray40001 =>
      theme.textTheme.bodySmall!.sFPro.copyWith(
        color: appTheme.blueGray40001,
      );
  // Headline text style
  static get headlineLargeCairoOnErrorContainer =>
      theme.textTheme.headlineLarge!.cairo.copyWith(
        color: theme.colorScheme.onErrorContainer.withOpacity(1),
        fontSize: 32.fSize,
      );
  static get headlineLargeCairoOnPrimary =>
      theme.textTheme.headlineLarge!.cairo.copyWith(
        color: theme.colorScheme.onPrimary,
        fontSize: 32.fSize,
      );
  static get headlineLargeCairoPrimary =>
      theme.textTheme.headlineLarge!.cairo.copyWith(
        color: theme.colorScheme.primary,
        fontSize: 32.fSize,
      );
  static get headlineSmallOnPrimary => theme.textTheme.headlineSmall!.copyWith(
        color: theme.colorScheme.onPrimary,
      );
  static get headlineSmallPrimaryContainer =>
      theme.textTheme.headlineSmall!.copyWith(
        color: theme.colorScheme.primaryContainer,
      );
  // Label text style
  static get labelLargeBluegray500 => theme.textTheme.labelLarge!.copyWith(
        color: appTheme.blueGray500,
      );
  static get labelLargeCairoGray80001 =>
      theme.textTheme.labelLarge!.cairo.copyWith(
        color: appTheme.gray80001.withOpacity(0.6),
        fontWeight: FontWeight.w600,
      );
  static get labelLargeGray60001 => theme.textTheme.labelLarge!.copyWith(
        color: appTheme.gray60001,
      );
  static get labelLargeOnErrorContainer => theme.textTheme.labelLarge!.copyWith(
        color: theme.colorScheme.onErrorContainer.withOpacity(1),
      );
  static get labelLargeOnErrorContainer_1 =>
      theme.textTheme.labelLarge!.copyWith(
        color: theme.colorScheme.onErrorContainer.withOpacity(1),
      );
  static get labelLargePrimary => theme.textTheme.labelLarge!.copyWith(
        color: theme.colorScheme.primary,
      );
  static get labelLargePrimary_1 => theme.textTheme.labelLarge!.copyWith(
        color: theme.colorScheme.primary,
      );
  static get labelLarge_1 => theme.textTheme.labelLarge!;
  // Title text style
  static get titleMediumCircularStdBluegray800 =>
      theme.textTheme.titleMedium!.circularStd.copyWith(
        color: appTheme.blueGray800,
        fontSize: 18.fSize,
      );
  static get titleMediumCircularStdBluegray90001 =>
      theme.textTheme.titleMedium!.circularStd.copyWith(
        color: appTheme.blueGray90001,
        fontWeight: FontWeight.w500,
      );
  static get titleMediumGray60001 => theme.textTheme.titleMedium!.copyWith(
        color: appTheme.gray60001,
        fontWeight: FontWeight.w600,
      );
  static get titleMediumMulishPrimary =>
      theme.textTheme.titleMedium!.mulish.copyWith(
        color: theme.colorScheme.primary,
        fontSize: 18.fSize,
      );
  static get titleMediumPrimary => theme.textTheme.titleMedium!.copyWith(
        color: theme.colorScheme.primary,
        fontWeight: FontWeight.w600,
      );
  static get titleMediumSecondaryContainer =>
      theme.textTheme.titleMedium!.copyWith(
        color: theme.colorScheme.secondaryContainer.withOpacity(1),
        fontSize: 18.fSize,
      );
  static get titleMediumSecondaryContainerSemiBold =>
      theme.textTheme.titleMedium!.copyWith(
        color: theme.colorScheme.secondaryContainer.withOpacity(1),
        fontWeight: FontWeight.w600,
      );
  static get titleMediumSecondaryContainerSemiBold_1 =>
      theme.textTheme.titleMedium!.copyWith(
        color: theme.colorScheme.secondaryContainer.withOpacity(1),
        fontWeight: FontWeight.w600,
      );
  static get titleSmallCircularStdBluegray70001 =>
      theme.textTheme.titleSmall!.circularStd.copyWith(
        color: appTheme.blueGray70001,
        fontWeight: FontWeight.w500,
      );
  static get titleSmallCircularStdBluegray800 =>
      theme.textTheme.titleSmall!.circularStd.copyWith(
        color: appTheme.blueGray800,
        fontWeight: FontWeight.w500,
      );
  static get titleSmallCircularStdOnErrorContainer =>
      theme.textTheme.titleSmall!.circularStd.copyWith(
        color: theme.colorScheme.onErrorContainer.withOpacity(1),
        fontWeight: FontWeight.w700,
      );
  static get titleSmallMulishBluegray700 =>
      theme.textTheme.titleSmall!.mulish.copyWith(
        color: appTheme.blueGray700,
        fontWeight: FontWeight.w500,
      );
  static get titleSmallMulishGray800 =>
      theme.textTheme.titleSmall!.mulish.copyWith(
        color: appTheme.gray800,
        fontWeight: FontWeight.w500,
      );
  static get titleSmallMulishRed400 =>
      theme.textTheme.titleSmall!.mulish.copyWith(
        color: appTheme.red400,
        fontWeight: FontWeight.w700,
      );
  static get titleSmallOnErrorContainer => theme.textTheme.titleSmall!.copyWith(
        color: theme.colorScheme.onErrorContainer.withOpacity(1),
        fontWeight: FontWeight.w700,
      );
  static get titleSmallPrimary => theme.textTheme.titleSmall!.copyWith(
        color: theme.colorScheme.primary,
      );
  static get titleSmallProductSansBluegray800 =>
      theme.textTheme.titleSmall!.productSans.copyWith(
        color: appTheme.blueGray800,
        fontWeight: FontWeight.w700,
      );
  static get titleSmallSecondaryContainer =>
      theme.textTheme.titleSmall!.copyWith(
        color: theme.colorScheme.secondaryContainer.withOpacity(1),
        fontWeight: FontWeight.w700,
      );
  static get titleSmallSecondaryContainer_1 =>
      theme.textTheme.titleSmall!.copyWith(
        color: theme.colorScheme.secondaryContainer.withOpacity(1),
      );
}

extension on TextStyle {
  TextStyle get sFPro {
    return copyWith(
      fontFamily: 'SF Pro',
    );
  }

  TextStyle get mulish {
    return copyWith(
      fontFamily: 'Mulish',
    );
  }

  TextStyle get circularStd {
    return copyWith(
      fontFamily: 'Circular Std',
    );
  }

  TextStyle get productSans {
    return copyWith(
      fontFamily: 'Product Sans',
    );
  }

  TextStyle get cairo {
    return copyWith(
      fontFamily: 'Cairo',
    );
  }
}
