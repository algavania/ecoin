import 'package:flutter/material.dart';
import 'package:ecoin/core/app_text_styles.dart';
import 'package:ecoin/core/color_values.dart';
import 'package:ecoin/core/styles.dart';

class AppTheme extends InheritedWidget {
  const AppTheme({
    required this.textTheme,
    required super.child,
    super.key,
  });

  final AppTextStyles textTheme;

  // Static method to access the theme from context
  static AppTheme? of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<AppTheme>();

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => true;
}

ThemeData ecoinThemeData(BuildContext context) {
  const primaryColor = ColorValues.primary50;
  final primaryColorMap = <int, Color>{
    50: primaryColor,
    100: primaryColor,
    200: primaryColor,
    300: primaryColor,
    400: primaryColor,
    500: primaryColor,
    600: primaryColor,
    700: primaryColor,
    800: primaryColor,
    900: primaryColor,
  };
  final primaryMaterialColor =
      MaterialColor(primaryColor.value, primaryColorMap);

  return ThemeData(
      useMaterial3: true,
      primaryColor: primaryColor,
      primarySwatch: primaryMaterialColor,
      colorScheme: ColorScheme.fromSwatch(primarySwatch: primaryMaterialColor),
      scaffoldBackgroundColor: ColorValues.lightGrey,
      canvasColor: ColorValues.lightGrey,
      brightness: Brightness.light,
      appBarTheme: const AppBarTheme(
        surfaceTintColor: Colors.transparent,
      ),
      navigationBarTheme: NavigationBarThemeData(
        elevation: 0,
        indicatorColor: Colors.transparent,
        labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
        surfaceTintColor: ColorValues.white,
        backgroundColor: ColorValues.white,
        labelTextStyle: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.selected)) {
            return const TextStyle(
              color: ColorValues.text50,
              fontSize: 13,
              height: 0,
              fontWeight: FontWeight.bold,
            );
          }
          return const TextStyle(
            color: ColorValues.grey20,
            fontSize: 13,
            height: 0,
          );
        }),
        iconTheme: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.selected)) {
            return const IconThemeData(color: ColorValues.primary50);
          }
          return const IconThemeData(color: ColorValues.grey20);
        }),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: ColorValues.primary50,
          foregroundColor: ColorValues.secondaryText50,
          minimumSize: const Size(double.infinity, 50),
          elevation: 0,
          padding: const EdgeInsets.all(Styles.contentPadding),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(Styles.defaultBorder),
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: ColorValues.secondaryText50,
          elevation: 0,
          padding: const EdgeInsets.all(Styles.contentPadding),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(Styles.defaultBorder),
          ),
        ),
      ),
      iconTheme: const IconThemeData(color: ColorValues.grey50),
      textTheme: AppTextStyles.style(context),
      indicatorColor: ColorValues.primary50,
      tabBarTheme: TabBarTheme(
          indicatorColor: ColorValues.primary50,
          labelColor: ColorValues.primary50,
          overlayColor:
              MaterialStateProperty.all(ColorValues.grey10.withOpacity(0.5))));
}
