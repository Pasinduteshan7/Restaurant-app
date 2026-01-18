import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppSpacing {
  static const double xs = 4.0;
  static const double sm = 8.0;
  static const double md = 16.0;
  static const double lg = 24.0;
  static const double xl = 32.0;
  static const double xxl = 48.0;

  static const EdgeInsets paddingXs = EdgeInsets.all(xs);
  static const EdgeInsets paddingSm = EdgeInsets.all(sm);
  static const EdgeInsets paddingMd = EdgeInsets.all(md);
  static const EdgeInsets paddingLg = EdgeInsets.all(lg);
  static const EdgeInsets paddingXl = EdgeInsets.all(xl);

  static const EdgeInsets horizontalXs = EdgeInsets.symmetric(horizontal: xs);
  static const EdgeInsets horizontalSm = EdgeInsets.symmetric(horizontal: sm);
  static const EdgeInsets horizontalMd = EdgeInsets.symmetric(horizontal: md);
  static const EdgeInsets horizontalLg = EdgeInsets.symmetric(horizontal: lg);
  static const EdgeInsets horizontalXl = EdgeInsets.symmetric(horizontal: xl);

  static const EdgeInsets verticalXs = EdgeInsets.symmetric(vertical: xs);
  static const EdgeInsets verticalSm = EdgeInsets.symmetric(vertical: sm);
  static const EdgeInsets verticalMd = EdgeInsets.symmetric(vertical: md);
  static const EdgeInsets verticalLg = EdgeInsets.symmetric(vertical: lg);
  static const EdgeInsets verticalXl = EdgeInsets.symmetric(vertical: xl);
}

class AppRadius {
  static const double sm = 8.0;
  static const double md = 12.0;
  static const double lg = 16.0;
  static const double xl = 24.0;
  static const double full = 999.0;
}

extension TextStyleContext on BuildContext {
  TextTheme get textStyles => Theme.of(this).textTheme;
  ColorScheme get colors => Theme.of(this).colorScheme;
}

extension TextStyleExtensions on TextStyle {
  TextStyle get bold => copyWith(fontWeight: FontWeight.bold);
  TextStyle get semiBold => copyWith(fontWeight: FontWeight.w600);
  TextStyle get medium => copyWith(fontWeight: FontWeight.w500);
  TextStyle get normal => copyWith(fontWeight: FontWeight.w400);
  TextStyle get light => copyWith(fontWeight: FontWeight.w300);
  TextStyle withColor(Color color) => copyWith(color: color);
  TextStyle withSize(double size) => copyWith(fontSize: size);
}

class AppColors {
  static const primary = Color(0xFFFF5722);
  static const onPrimary = Color(0xFFFFFFFF);
  static const primaryContainer = Color(0xFFFFCCBC);
  static const onPrimaryContainer = Color(0xFF3E1000);

  static const secondary = Color(0xFF4CAF50);
  static const onSecondary = Color(0xFFFFFFFF);
  static const secondaryContainer = Color(0xFFC8E6C9);
  static const onSecondaryContainer = Color(0xFF002200);

  static const tertiary = Color(0xFFFFC107);
  static const onTertiary = Color(0xFF000000);

  static const background = Color(0xFFFFFBF7);
  static const surface = Color(0xFFFFFFFF);
  static const onSurface = Color(0xFF2D2520);
  static const outline = Color(0xFFD7CCC8);
  static const shadow = Color(0xFF2D2520);

  static const error = Color(0xFFBA1A1A);
  static const onError = Color(0xFFFFFFFF);
}

class DarkAppColors {
  static const primary = Color(0xFFFF8A65);
  static const onPrimary = Color(0xFF5F1600);
  static const primaryContainer = Color(0xFF8B2500);
  static const onPrimaryContainer = Color(0xFFFFDBD0);

  static const secondary = Color(0xFF81C784);
  static const onSecondary = Color(0xFF003305);

  static const background = Color(0xFF1A1614);
  static const surface = Color(0xFF25201D);
  static const onSurface = Color(0xFFEDE0DB);
  static const outline = Color(0xFFA18C83);
}

ThemeData get lightTheme => ThemeData(
  useMaterial3: true,
  brightness: Brightness.light,
  colorScheme: const ColorScheme.light(
    primary: AppColors.primary,
    onPrimary: AppColors.onPrimary,
    primaryContainer: AppColors.primaryContainer,
    onPrimaryContainer: AppColors.onPrimaryContainer,
    secondary: AppColors.secondary,
    onSecondary: AppColors.onSecondary,
    secondaryContainer: AppColors.secondaryContainer,
    onSecondaryContainer: AppColors.onSecondaryContainer,
    tertiary: AppColors.tertiary,
    onTertiary: AppColors.onTertiary,
    surface: AppColors.surface,
    onSurface: AppColors.onSurface,
    surfaceContainerHighest: Color(0xFFF5F0EB),
    onSurfaceVariant: Color(0xFF5D4F48),
    outline: AppColors.outline,
    error: AppColors.error,
    onError: AppColors.onError,
  ),
  scaffoldBackgroundColor: AppColors.background,
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.transparent,
    elevation: 0,
    centerTitle: true,
    foregroundColor: AppColors.onSurface,
  ),
  cardTheme: CardThemeData(
    elevation: 0,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(AppRadius.md),
      side: const BorderSide(color: Color(0xFFEEE0D8), width: 1),
    ),
    color: AppColors.surface,
    clipBehavior: Clip.antiAlias,
  ),
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: Colors.white,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppRadius.md),
      borderSide: const BorderSide(color: AppColors.outline),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppRadius.md),
      borderSide: const BorderSide(color: AppColors.outline),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppRadius.md),
      borderSide: const BorderSide(color: AppColors.primary, width: 2),
    ),
    contentPadding: AppSpacing.paddingMd,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: AppColors.primary,
      foregroundColor: AppColors.onPrimary,
      elevation: 0,
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadius.lg),
      ),
      textStyle: GoogleFonts.poppins(
        fontSize: 16,
        fontWeight: FontWeight.w600,
      ),
    ),
  ),
  textTheme: _buildTextTheme(),
);

ThemeData get darkTheme => ThemeData(
  useMaterial3: true,
  brightness: Brightness.dark,
  colorScheme: const ColorScheme.dark(
    primary: DarkAppColors.primary,
    onPrimary: DarkAppColors.onPrimary,
    primaryContainer: DarkAppColors.primaryContainer,
    onPrimaryContainer: DarkAppColors.onPrimaryContainer,
    secondary: DarkAppColors.secondary,
    onSecondary: DarkAppColors.onSecondary,
    surface: DarkAppColors.surface,
    onSurface: DarkAppColors.onSurface,
    outline: DarkAppColors.outline,
  ),
  scaffoldBackgroundColor: DarkAppColors.background,
  textTheme: _buildTextTheme(),
);

TextTheme _buildTextTheme() {
  return TextTheme(
    displayLarge: GoogleFonts.poppins(fontWeight: FontWeight.w700),
    displayMedium: GoogleFonts.poppins(fontWeight: FontWeight.w700),
    displaySmall: GoogleFonts.poppins(fontWeight: FontWeight.w600),
    headlineLarge: GoogleFonts.poppins(fontWeight: FontWeight.w600),
    headlineMedium: GoogleFonts.poppins(fontWeight: FontWeight.w600),
    headlineSmall: GoogleFonts.poppins(fontWeight: FontWeight.w600),
    titleLarge: GoogleFonts.poppins(fontWeight: FontWeight.w600),
    titleMedium: GoogleFonts.poppins(fontWeight: FontWeight.w500),
    titleSmall: GoogleFonts.poppins(fontWeight: FontWeight.w500),
    bodyLarge: GoogleFonts.inter(fontWeight: FontWeight.w400),
    bodyMedium: GoogleFonts.inter(fontWeight: FontWeight.w400),
    bodySmall: GoogleFonts.inter(fontWeight: FontWeight.w400),
    labelLarge: GoogleFonts.inter(fontWeight: FontWeight.w600),
  );
}
