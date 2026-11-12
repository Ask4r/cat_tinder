// Complete Untitled UI React / Tailwind color catalog, adapted to Dart names.
// Project Figma colors take precedence.
import 'dart:ui';

import 'package:flutter/foundation.dart';

/// Typed color variables. Aliases are direct getter references, not string keys.
/// Unset overrides follow their primitive/semantic source when that source changes.
@immutable
class UiColors {
  const UiColors({
    this.dark = false,
    this._backgroundColorBorderTertiary,
    this._red50,
    this._red100,
    this._red200,
    this._red300,
    this._red400,
    this._red500,
    this._red600,
    this._red700,
    this._red800,
    this._red900,
    this._red950,
    this._orange50,
    this._orange100,
    this._orange200,
    this._orange300,
    this._orange400,
    this._orange500,
    this._orange600,
    this._orange700,
    this._orange800,
    this._orange900,
    this._orange950,
    this._amber50,
    this._amber100,
    this._amber200,
    this._amber300,
    this._amber400,
    this._amber500,
    this._amber600,
    this._amber700,
    this._amber800,
    this._amber900,
    this._amber950,
    this._yellow50,
    this._yellow100,
    this._yellow200,
    this._yellow300,
    this._yellow400,
    this._yellow500,
    this._yellow600,
    this._yellow700,
    this._yellow800,
    this._yellow900,
    this._yellow950,
    this._lime50,
    this._lime100,
    this._lime200,
    this._lime300,
    this._lime400,
    this._lime500,
    this._lime600,
    this._lime700,
    this._lime800,
    this._lime900,
    this._lime950,
    this._green50,
    this._green100,
    this._green200,
    this._green300,
    this._green400,
    this._green500,
    this._green600,
    this._green700,
    this._green800,
    this._green900,
    this._green950,
    this._emerald50,
    this._emerald100,
    this._emerald200,
    this._emerald300,
    this._emerald400,
    this._emerald500,
    this._emerald600,
    this._emerald700,
    this._emerald800,
    this._emerald900,
    this._emerald950,
    this._teal50,
    this._teal100,
    this._teal200,
    this._teal300,
    this._teal400,
    this._teal500,
    this._teal600,
    this._teal700,
    this._teal800,
    this._teal900,
    this._teal950,
    this._cyan50,
    this._cyan100,
    this._cyan200,
    this._cyan300,
    this._cyan400,
    this._cyan500,
    this._cyan600,
    this._cyan700,
    this._cyan800,
    this._cyan900,
    this._cyan950,
    this._sky50,
    this._sky100,
    this._sky200,
    this._sky300,
    this._sky400,
    this._sky500,
    this._sky600,
    this._sky700,
    this._sky800,
    this._sky900,
    this._sky950,
    this._blue50,
    this._blue100,
    this._blue200,
    this._blue300,
    this._blue400,
    this._blue500,
    this._blue600,
    this._blue700,
    this._blue800,
    this._blue900,
    this._blue950,
    this._indigo50,
    this._indigo100,
    this._indigo200,
    this._indigo300,
    this._indigo400,
    this._indigo500,
    this._indigo600,
    this._indigo700,
    this._indigo800,
    this._indigo900,
    this._indigo950,
    this._violet50,
    this._violet100,
    this._violet200,
    this._violet300,
    this._violet400,
    this._violet500,
    this._violet600,
    this._violet700,
    this._violet800,
    this._violet900,
    this._violet950,
    this._purple50,
    this._purple100,
    this._purple200,
    this._purple300,
    this._purple400,
    this._purple500,
    this._purple600,
    this._purple700,
    this._purple800,
    this._purple900,
    this._purple950,
    this._fuchsia50,
    this._fuchsia100,
    this._fuchsia200,
    this._fuchsia300,
    this._fuchsia400,
    this._fuchsia500,
    this._fuchsia600,
    this._fuchsia700,
    this._fuchsia800,
    this._fuchsia900,
    this._fuchsia950,
    this._pink50,
    this._pink100,
    this._pink200,
    this._pink300,
    this._pink400,
    this._pink500,
    this._pink600,
    this._pink700,
    this._pink800,
    this._pink900,
    this._pink950,
    this._rose50,
    this._rose100,
    this._rose200,
    this._rose300,
    this._rose400,
    this._rose500,
    this._rose600,
    this._rose700,
    this._rose800,
    this._rose900,
    this._rose950,
    this._slate50,
    this._slate100,
    this._slate200,
    this._slate300,
    this._slate400,
    this._slate500,
    this._slate600,
    this._slate700,
    this._slate800,
    this._slate900,
    this._slate950,
    this._gray50,
    this._gray100,
    this._gray200,
    this._gray300,
    this._gray400,
    this._gray500,
    this._gray600,
    this._gray700,
    this._gray800,
    this._gray900,
    this._gray950,
    this._zinc50,
    this._zinc100,
    this._zinc200,
    this._zinc300,
    this._zinc400,
    this._zinc500,
    this._zinc600,
    this._zinc700,
    this._zinc800,
    this._zinc900,
    this._zinc950,
    this._neutral50,
    this._neutral100,
    this._neutral200,
    this._neutral300,
    this._neutral400,
    this._neutral500,
    this._neutral600,
    this._neutral700,
    this._neutral800,
    this._neutral900,
    this._neutral950,
    this._stone50,
    this._stone100,
    this._stone200,
    this._stone300,
    this._stone400,
    this._stone500,
    this._stone600,
    this._stone700,
    this._stone800,
    this._stone900,
    this._stone950,
    this._mauve50,
    this._mauve100,
    this._mauve200,
    this._mauve300,
    this._mauve400,
    this._mauve500,
    this._mauve600,
    this._mauve700,
    this._mauve800,
    this._mauve900,
    this._mauve950,
    this._olive50,
    this._olive100,
    this._olive200,
    this._olive300,
    this._olive400,
    this._olive500,
    this._olive600,
    this._olive700,
    this._olive800,
    this._olive900,
    this._olive950,
    this._mist50,
    this._mist100,
    this._mist200,
    this._mist300,
    this._mist400,
    this._mist500,
    this._mist600,
    this._mist700,
    this._mist800,
    this._mist900,
    this._mist950,
    this._taupe50,
    this._taupe100,
    this._taupe200,
    this._taupe300,
    this._taupe400,
    this._taupe500,
    this._taupe600,
    this._taupe700,
    this._taupe800,
    this._taupe900,
    this._taupe950,
    this._black,
    this._white,
    this._transparent,
    this._alphaWhite,
    this._alphaBlack,
    this._brand50,
    this._brand100,
    this._brand200,
    this._brand300,
    this._brand400,
    this._brand500,
    this._brand600,
    this._brand700,
    this._brand800,
    this._brand900,
    this._brand950,
    this._utilityBlue50,
    this._utilityBlue100,
    this._utilityBlue200,
    this._utilityBlue300,
    this._utilityBlue400,
    this._utilityBlue500,
    this._utilityBlue600,
    this._utilityBlue700,
    this._utilityBrand50,
    this._utilityBrand50Alt,
    this._utilityBrand100,
    this._utilityBrand100Alt,
    this._utilityBrand200,
    this._utilityBrand200Alt,
    this._utilityBrand300,
    this._utilityBrand300Alt,
    this._utilityBrand400,
    this._utilityBrand400Alt,
    this._utilityBrand500,
    this._utilityBrand500Alt,
    this._utilityBrand600,
    this._utilityBrand600Alt,
    this._utilityBrand700,
    this._utilityBrand700Alt,
    this._utilityBrand800,
    this._utilityBrand800Alt,
    this._utilityBrand900,
    this._utilityBrand900Alt,
    this._utilityNeutral50,
    this._utilityNeutral100,
    this._utilityNeutral200,
    this._utilityNeutral300,
    this._utilityNeutral400,
    this._utilityNeutral500,
    this._utilityNeutral600,
    this._utilityNeutral700,
    this._utilityNeutral800,
    this._utilityNeutral900,
    this._utilityRed50,
    this._utilityRed100,
    this._utilityRed200,
    this._utilityRed300,
    this._utilityRed400,
    this._utilityRed500,
    this._utilityRed600,
    this._utilityRed700,
    this._utilityYellow50,
    this._utilityYellow100,
    this._utilityYellow200,
    this._utilityYellow300,
    this._utilityYellow400,
    this._utilityYellow500,
    this._utilityYellow600,
    this._utilityYellow700,
    this._utilityGreen50,
    this._utilityGreen100,
    this._utilityGreen200,
    this._utilityGreen300,
    this._utilityGreen400,
    this._utilityGreen500,
    this._utilityGreen600,
    this._utilityGreen700,
    this._utilityOrange50,
    this._utilityOrange100,
    this._utilityOrange200,
    this._utilityOrange300,
    this._utilityOrange400,
    this._utilityOrange500,
    this._utilityOrange600,
    this._utilityOrange700,
    this._utilityIndigo50,
    this._utilityIndigo100,
    this._utilityIndigo200,
    this._utilityIndigo300,
    this._utilityIndigo400,
    this._utilityIndigo500,
    this._utilityIndigo600,
    this._utilityIndigo700,
    this._utilityFuchsia50,
    this._utilityFuchsia100,
    this._utilityFuchsia200,
    this._utilityFuchsia300,
    this._utilityFuchsia400,
    this._utilityFuchsia500,
    this._utilityFuchsia600,
    this._utilityFuchsia700,
    this._utilityPink50,
    this._utilityPink100,
    this._utilityPink200,
    this._utilityPink300,
    this._utilityPink400,
    this._utilityPink500,
    this._utilityPink600,
    this._utilityPink700,
    this._utilityPurple50,
    this._utilityPurple100,
    this._utilityPurple200,
    this._utilityPurple300,
    this._utilityPurple400,
    this._utilityPurple500,
    this._utilityPurple600,
    this._utilityPurple700,
    this._utilitySky50,
    this._utilitySky100,
    this._utilitySky200,
    this._utilitySky300,
    this._utilitySky400,
    this._utilitySky500,
    this._utilitySky600,
    this._utilitySky700,
    this._utilitySlate50,
    this._utilitySlate100,
    this._utilitySlate200,
    this._utilitySlate300,
    this._utilitySlate400,
    this._utilitySlate500,
    this._utilitySlate600,
    this._utilitySlate700,
    this._utilityEmerald50,
    this._utilityEmerald100,
    this._utilityEmerald200,
    this._utilityEmerald300,
    this._utilityEmerald400,
    this._utilityEmerald500,
    this._utilityEmerald600,
    this._utilityEmerald700,
    this._utilityAmber50,
    this._utilityAmber100,
    this._utilityAmber200,
    this._utilityAmber300,
    this._utilityAmber400,
    this._utilityAmber500,
    this._utilityAmber600,
    this._utilityAmber700,
    this._textPrimary,
    this._textTertiary,
    this._textErrorPrimary,
    this._textWarningPrimary,
    this._textSuccessPrimary,
    this._textSecondary,
    this._textSecondaryHover,
    this._textTertiaryHover,
    this._textBrandSecondary,
    this._textPlaceholder,
    this._textBrandTertiary,
    this._textEditorIconFg,
    this._textEditorIconFgActive,
    this._textQuaternary,
    this._textBrandPrimary,
    this._textPrimaryOnBrand,
    this._textSecondaryOnBrand,
    this._textTertiaryOnBrand,
    this._textQuaternaryOnBrand,
    this._textBrandTertiaryAlt,
    this._textErrorPrimaryHover,
    this._textBrandSecondaryHover,
    this._borderPrimary,
    this._borderSecondary,
    this._borderSecondaryAlt,
    this._borderTertiary,
    this._borderError,
    this._borderErrorSubtle,
    this._borderBrand,
    this._borderBrandAlt,
    this._fgSecondary,
    this._fgWarningPrimary,
    this._fgSuccessPrimary,
    this._fgWhite,
    this._fgSuccessSecondary,
    this._fgSecondaryHover,
    this._fgPrimary,
    this._fgBrandSecondary,
    this._fgBrandPrimary,
    this._fgQuaternary,
    this._fgQuaternaryHover,
    this._fgErrorPrimary,
    this._fgWarningSecondary,
    this._fgErrorSecondary,
    this._fgTertiary,
    this._fgTertiaryHover,
    this._fgBrandPrimaryAlt,
    this._fgBrandSecondaryAlt,
    this._fgBrandSecondaryHover,
    this._bgPrimary,
    this._bgTertiary,
    this._bgBrandPrimary,
    this._bgErrorSecondary,
    this._bgWarningPrimary,
    this._bgWarningSecondary,
    this._bgSuccessPrimary,
    this._bgSuccessSecondary,
    this._bgBrandSolid,
    this._bgSecondarySolid,
    this._bgErrorSolid,
    this._bgWarningSolid,
    this._bgSuccessSolid,
    this._bgSecondaryHover,
    this._bgPrimaryHover,
    this._bgBrandSolidHover,
    this._bgErrorPrimary,
    this._bgBrandSecondary,
    this._bgSecondary,
    this._bgQuaternary,
    this._bgPrimaryAlt,
    this._bgBrandPrimaryAlt,
    this._bgSecondaryAlt,
    this._bgOverlay,
    this._bgBrandSection,
    this._bgBrandSectionSubtle,
    this._bgPrimarySolid,
    this._bgErrorSolidHover,
    this._appStoreBadgeBorder,
    this._avatarStylesBgNeutral,
    this._featuredIconLightFgBrand,
    this._featuredIconLightFgError,
    this._featuredIconLightFgGray,
    this._featuredIconLightFgSuccess,
    this._featuredIconLightFgWarning,
    this._focusRingError,
    this._focusRing,
    this._footerButtonFg,
    this._footerButtonFgHover,
    this._iconFgBrand,
    this._iconFgBrandOnBrand,
    this._screenMockupBorder,
    this._sliderHandleBg,
    this._sliderHandleBorder,
    this._toggleBorder,
    this._toggleSlimBorderPressedHover,
    this._toggleSlimBorderPressed,
    this._tooltipSupportingText,
    this._backgroundColorPrimary,
    this._backgroundColorTertiary,
    this._backgroundColorBrandPrimary,
    this._backgroundColorErrorSecondary,
    this._backgroundColorWarningPrimary,
    this._backgroundColorWarningSecondary,
    this._backgroundColorSuccessPrimary,
    this._backgroundColorSuccessSecondary,
    this._backgroundColorBrandSolid,
    this._backgroundColorSecondarySolid,
    this._backgroundColorErrorSolid,
    this._backgroundColorWarningSolid,
    this._backgroundColorSuccessSolid,
    this._backgroundColorSecondaryHover,
    this._backgroundColorPrimaryHover,
    this._backgroundColorBrandSolidHover,
    this._backgroundColorErrorPrimary,
    this._backgroundColorBrandSecondary,
    this._backgroundColorSecondary,
    this._backgroundColorQuaternary,
    this._backgroundColorPrimaryAlt,
    this._backgroundColorBrandPrimaryAlt,
    this._backgroundColorSecondaryAlt,
    this._backgroundColorOverlay,
    this._backgroundColorBrandSection,
    this._backgroundColorBrandSectionSubtle,
    this._backgroundColorPrimarySolid,
    this._backgroundColorErrorSolidHover,
    this._backgroundColorBorderBrand,
    this._backgroundColorBorderBrandAlt,
    this._textWhite,
    this._textColorPrimary,
    this._textColorSecondary,
    this._textColorSecondaryHover,
    this._textColorTertiary,
    this._textColorTertiaryHover,
    this._textColorErrorPrimary,
    this._textColorWarningPrimary,
    this._textColorSuccessPrimary,
    this._textColorBrandSecondary,
    this._textColorPlaceholder,
    this._textColorBrandTertiary,
    this._textColorEditorIconFg,
    this._textColorEditorIconFgActive,
    this._textColorQuaternary,
    this._textColorBrandPrimary,
    this._textColorPrimaryOnBrand,
    this._textColorSecondaryOnBrand,
    this._textColorTertiaryOnBrand,
    this._textColorQuaternaryOnBrand,
    this._textColorBrandTertiaryAlt,
    this._textColorErrorPrimaryHover,
    this._textColorBrandSecondaryHover,
    this._textColorTooltipSupportingText,
    this._borderColorPrimary,
    this._borderColorSecondary,
    this._borderColorSecondaryAlt,
    this._borderColorTertiary,
    this._borderColorError,
    this._borderColorErrorSubtle,
    this._borderColorBrand,
    this._borderColorBrandAlt,
    this._borderColorBrandSolid,
    this._borderColorBrandSolidHover,
    this._ringColorPrimary,
    this._ringColorSecondary,
    this._ringColorSecondaryAlt,
    this._ringColorTertiary,
    this._ringColorError,
    this._ringColorErrorSubtle,
    this._ringColorBrand,
    this._ringColorBrandAlt,
    this._ringColorBrandSolid,
    this._ringColorBrandSolidHover,
    this._outlineColorPrimary,
    this._outlineColorSecondary,
    this._outlineColorSecondaryAlt,
    this._outlineColorTertiary,
    this._outlineColorError,
    this._outlineColorErrorSubtle,
    this._outlineColorBrand,
    this._outlineColorBrandAlt,
    this._outlineColorBrandSolid,
    this._outlineColorBrandSolidHover,
    this._grayModern300,
    this._grayModern500,
    this._grayModern700,
    this._grayModern800,
  });
  final bool dark;
  final Color? _backgroundColorBorderTertiary;
  final Color? _red50;
  final Color? _red100;
  final Color? _red200;
  final Color? _red300;
  final Color? _red400;
  final Color? _red500;
  final Color? _red600;
  final Color? _red700;
  final Color? _red800;
  final Color? _red900;
  final Color? _red950;
  final Color? _orange50;
  final Color? _orange100;
  final Color? _orange200;
  final Color? _orange300;
  final Color? _orange400;
  final Color? _orange500;
  final Color? _orange600;
  final Color? _orange700;
  final Color? _orange800;
  final Color? _orange900;
  final Color? _orange950;
  final Color? _amber50;
  final Color? _amber100;
  final Color? _amber200;
  final Color? _amber300;
  final Color? _amber400;
  final Color? _amber500;
  final Color? _amber600;
  final Color? _amber700;
  final Color? _amber800;
  final Color? _amber900;
  final Color? _amber950;
  final Color? _yellow50;
  final Color? _yellow100;
  final Color? _yellow200;
  final Color? _yellow300;
  final Color? _yellow400;
  final Color? _yellow500;
  final Color? _yellow600;
  final Color? _yellow700;
  final Color? _yellow800;
  final Color? _yellow900;
  final Color? _yellow950;
  final Color? _lime50;
  final Color? _lime100;
  final Color? _lime200;
  final Color? _lime300;
  final Color? _lime400;
  final Color? _lime500;
  final Color? _lime600;
  final Color? _lime700;
  final Color? _lime800;
  final Color? _lime900;
  final Color? _lime950;
  final Color? _green50;
  final Color? _green100;
  final Color? _green200;
  final Color? _green300;
  final Color? _green400;
  final Color? _green500;
  final Color? _green600;
  final Color? _green700;
  final Color? _green800;
  final Color? _green900;
  final Color? _green950;
  final Color? _emerald50;
  final Color? _emerald100;
  final Color? _emerald200;
  final Color? _emerald300;
  final Color? _emerald400;
  final Color? _emerald500;
  final Color? _emerald600;
  final Color? _emerald700;
  final Color? _emerald800;
  final Color? _emerald900;
  final Color? _emerald950;
  final Color? _teal50;
  final Color? _teal100;
  final Color? _teal200;
  final Color? _teal300;
  final Color? _teal400;
  final Color? _teal500;
  final Color? _teal600;
  final Color? _teal700;
  final Color? _teal800;
  final Color? _teal900;
  final Color? _teal950;
  final Color? _cyan50;
  final Color? _cyan100;
  final Color? _cyan200;
  final Color? _cyan300;
  final Color? _cyan400;
  final Color? _cyan500;
  final Color? _cyan600;
  final Color? _cyan700;
  final Color? _cyan800;
  final Color? _cyan900;
  final Color? _cyan950;
  final Color? _sky50;
  final Color? _sky100;
  final Color? _sky200;
  final Color? _sky300;
  final Color? _sky400;
  final Color? _sky500;
  final Color? _sky600;
  final Color? _sky700;
  final Color? _sky800;
  final Color? _sky900;
  final Color? _sky950;
  final Color? _blue50;
  final Color? _blue100;
  final Color? _blue200;
  final Color? _blue300;
  final Color? _blue400;
  final Color? _blue500;
  final Color? _blue600;
  final Color? _blue700;
  final Color? _blue800;
  final Color? _blue900;
  final Color? _blue950;
  final Color? _indigo50;
  final Color? _indigo100;
  final Color? _indigo200;
  final Color? _indigo300;
  final Color? _indigo400;
  final Color? _indigo500;
  final Color? _indigo600;
  final Color? _indigo700;
  final Color? _indigo800;
  final Color? _indigo900;
  final Color? _indigo950;
  final Color? _violet50;
  final Color? _violet100;
  final Color? _violet200;
  final Color? _violet300;
  final Color? _violet400;
  final Color? _violet500;
  final Color? _violet600;
  final Color? _violet700;
  final Color? _violet800;
  final Color? _violet900;
  final Color? _violet950;
  final Color? _purple50;
  final Color? _purple100;
  final Color? _purple200;
  final Color? _purple300;
  final Color? _purple400;
  final Color? _purple500;
  final Color? _purple600;
  final Color? _purple700;
  final Color? _purple800;
  final Color? _purple900;
  final Color? _purple950;
  final Color? _fuchsia50;
  final Color? _fuchsia100;
  final Color? _fuchsia200;
  final Color? _fuchsia300;
  final Color? _fuchsia400;
  final Color? _fuchsia500;
  final Color? _fuchsia600;
  final Color? _fuchsia700;
  final Color? _fuchsia800;
  final Color? _fuchsia900;
  final Color? _fuchsia950;
  final Color? _pink50;
  final Color? _pink100;
  final Color? _pink200;
  final Color? _pink300;
  final Color? _pink400;
  final Color? _pink500;
  final Color? _pink600;
  final Color? _pink700;
  final Color? _pink800;
  final Color? _pink900;
  final Color? _pink950;
  final Color? _rose50;
  final Color? _rose100;
  final Color? _rose200;
  final Color? _rose300;
  final Color? _rose400;
  final Color? _rose500;
  final Color? _rose600;
  final Color? _rose700;
  final Color? _rose800;
  final Color? _rose900;
  final Color? _rose950;
  final Color? _slate50;
  final Color? _slate100;
  final Color? _slate200;
  final Color? _slate300;
  final Color? _slate400;
  final Color? _slate500;
  final Color? _slate600;
  final Color? _slate700;
  final Color? _slate800;
  final Color? _slate900;
  final Color? _slate950;
  final Color? _gray50;
  final Color? _gray100;
  final Color? _gray200;
  final Color? _gray300;
  final Color? _gray400;
  final Color? _gray500;
  final Color? _gray600;
  final Color? _gray700;
  final Color? _gray800;
  final Color? _gray900;
  final Color? _gray950;
  final Color? _zinc50;
  final Color? _zinc100;
  final Color? _zinc200;
  final Color? _zinc300;
  final Color? _zinc400;
  final Color? _zinc500;
  final Color? _zinc600;
  final Color? _zinc700;
  final Color? _zinc800;
  final Color? _zinc900;
  final Color? _zinc950;
  final Color? _neutral50;
  final Color? _neutral100;
  final Color? _neutral200;
  final Color? _neutral300;
  final Color? _neutral400;
  final Color? _neutral500;
  final Color? _neutral600;
  final Color? _neutral700;
  final Color? _neutral800;
  final Color? _neutral900;
  final Color? _neutral950;
  final Color? _stone50;
  final Color? _stone100;
  final Color? _stone200;
  final Color? _stone300;
  final Color? _stone400;
  final Color? _stone500;
  final Color? _stone600;
  final Color? _stone700;
  final Color? _stone800;
  final Color? _stone900;
  final Color? _stone950;
  final Color? _mauve50;
  final Color? _mauve100;
  final Color? _mauve200;
  final Color? _mauve300;
  final Color? _mauve400;
  final Color? _mauve500;
  final Color? _mauve600;
  final Color? _mauve700;
  final Color? _mauve800;
  final Color? _mauve900;
  final Color? _mauve950;
  final Color? _olive50;
  final Color? _olive100;
  final Color? _olive200;
  final Color? _olive300;
  final Color? _olive400;
  final Color? _olive500;
  final Color? _olive600;
  final Color? _olive700;
  final Color? _olive800;
  final Color? _olive900;
  final Color? _olive950;
  final Color? _mist50;
  final Color? _mist100;
  final Color? _mist200;
  final Color? _mist300;
  final Color? _mist400;
  final Color? _mist500;
  final Color? _mist600;
  final Color? _mist700;
  final Color? _mist800;
  final Color? _mist900;
  final Color? _mist950;
  final Color? _taupe50;
  final Color? _taupe100;
  final Color? _taupe200;
  final Color? _taupe300;
  final Color? _taupe400;
  final Color? _taupe500;
  final Color? _taupe600;
  final Color? _taupe700;
  final Color? _taupe800;
  final Color? _taupe900;
  final Color? _taupe950;
  final Color? _black;
  final Color? _white;
  final Color? _transparent;
  final Color? _alphaWhite;
  final Color? _alphaBlack;
  final Color? _brand50;
  final Color? _brand100;
  final Color? _brand200;
  final Color? _brand300;
  final Color? _brand400;
  final Color? _brand500;
  final Color? _brand600;
  final Color? _brand700;
  final Color? _brand800;
  final Color? _brand900;
  final Color? _brand950;
  final Color? _utilityBlue50;
  final Color? _utilityBlue100;
  final Color? _utilityBlue200;
  final Color? _utilityBlue300;
  final Color? _utilityBlue400;
  final Color? _utilityBlue500;
  final Color? _utilityBlue600;
  final Color? _utilityBlue700;
  final Color? _utilityBrand50;
  final Color? _utilityBrand50Alt;
  final Color? _utilityBrand100;
  final Color? _utilityBrand100Alt;
  final Color? _utilityBrand200;
  final Color? _utilityBrand200Alt;
  final Color? _utilityBrand300;
  final Color? _utilityBrand300Alt;
  final Color? _utilityBrand400;
  final Color? _utilityBrand400Alt;
  final Color? _utilityBrand500;
  final Color? _utilityBrand500Alt;
  final Color? _utilityBrand600;
  final Color? _utilityBrand600Alt;
  final Color? _utilityBrand700;
  final Color? _utilityBrand700Alt;
  final Color? _utilityBrand800;
  final Color? _utilityBrand800Alt;
  final Color? _utilityBrand900;
  final Color? _utilityBrand900Alt;
  final Color? _utilityNeutral50;
  final Color? _utilityNeutral100;
  final Color? _utilityNeutral200;
  final Color? _utilityNeutral300;
  final Color? _utilityNeutral400;
  final Color? _utilityNeutral500;
  final Color? _utilityNeutral600;
  final Color? _utilityNeutral700;
  final Color? _utilityNeutral800;
  final Color? _utilityNeutral900;
  final Color? _utilityRed50;
  final Color? _utilityRed100;
  final Color? _utilityRed200;
  final Color? _utilityRed300;
  final Color? _utilityRed400;
  final Color? _utilityRed500;
  final Color? _utilityRed600;
  final Color? _utilityRed700;
  final Color? _utilityYellow50;
  final Color? _utilityYellow100;
  final Color? _utilityYellow200;
  final Color? _utilityYellow300;
  final Color? _utilityYellow400;
  final Color? _utilityYellow500;
  final Color? _utilityYellow600;
  final Color? _utilityYellow700;
  final Color? _utilityGreen50;
  final Color? _utilityGreen100;
  final Color? _utilityGreen200;
  final Color? _utilityGreen300;
  final Color? _utilityGreen400;
  final Color? _utilityGreen500;
  final Color? _utilityGreen600;
  final Color? _utilityGreen700;
  final Color? _utilityOrange50;
  final Color? _utilityOrange100;
  final Color? _utilityOrange200;
  final Color? _utilityOrange300;
  final Color? _utilityOrange400;
  final Color? _utilityOrange500;
  final Color? _utilityOrange600;
  final Color? _utilityOrange700;
  final Color? _utilityIndigo50;
  final Color? _utilityIndigo100;
  final Color? _utilityIndigo200;
  final Color? _utilityIndigo300;
  final Color? _utilityIndigo400;
  final Color? _utilityIndigo500;
  final Color? _utilityIndigo600;
  final Color? _utilityIndigo700;
  final Color? _utilityFuchsia50;
  final Color? _utilityFuchsia100;
  final Color? _utilityFuchsia200;
  final Color? _utilityFuchsia300;
  final Color? _utilityFuchsia400;
  final Color? _utilityFuchsia500;
  final Color? _utilityFuchsia600;
  final Color? _utilityFuchsia700;
  final Color? _utilityPink50;
  final Color? _utilityPink100;
  final Color? _utilityPink200;
  final Color? _utilityPink300;
  final Color? _utilityPink400;
  final Color? _utilityPink500;
  final Color? _utilityPink600;
  final Color? _utilityPink700;
  final Color? _utilityPurple50;
  final Color? _utilityPurple100;
  final Color? _utilityPurple200;
  final Color? _utilityPurple300;
  final Color? _utilityPurple400;
  final Color? _utilityPurple500;
  final Color? _utilityPurple600;
  final Color? _utilityPurple700;
  final Color? _utilitySky50;
  final Color? _utilitySky100;
  final Color? _utilitySky200;
  final Color? _utilitySky300;
  final Color? _utilitySky400;
  final Color? _utilitySky500;
  final Color? _utilitySky600;
  final Color? _utilitySky700;
  final Color? _utilitySlate50;
  final Color? _utilitySlate100;
  final Color? _utilitySlate200;
  final Color? _utilitySlate300;
  final Color? _utilitySlate400;
  final Color? _utilitySlate500;
  final Color? _utilitySlate600;
  final Color? _utilitySlate700;
  final Color? _utilityEmerald50;
  final Color? _utilityEmerald100;
  final Color? _utilityEmerald200;
  final Color? _utilityEmerald300;
  final Color? _utilityEmerald400;
  final Color? _utilityEmerald500;
  final Color? _utilityEmerald600;
  final Color? _utilityEmerald700;
  final Color? _utilityAmber50;
  final Color? _utilityAmber100;
  final Color? _utilityAmber200;
  final Color? _utilityAmber300;
  final Color? _utilityAmber400;
  final Color? _utilityAmber500;
  final Color? _utilityAmber600;
  final Color? _utilityAmber700;
  final Color? _textPrimary;
  final Color? _textTertiary;
  final Color? _textErrorPrimary;
  final Color? _textWarningPrimary;
  final Color? _textSuccessPrimary;
  final Color? _textSecondary;
  final Color? _textSecondaryHover;
  final Color? _textTertiaryHover;
  final Color? _textBrandSecondary;
  final Color? _textPlaceholder;
  final Color? _textBrandTertiary;
  final Color? _textEditorIconFg;
  final Color? _textEditorIconFgActive;
  final Color? _textQuaternary;
  final Color? _textBrandPrimary;
  final Color? _textPrimaryOnBrand;
  final Color? _textSecondaryOnBrand;
  final Color? _textTertiaryOnBrand;
  final Color? _textQuaternaryOnBrand;
  final Color? _textBrandTertiaryAlt;
  final Color? _textErrorPrimaryHover;
  final Color? _textBrandSecondaryHover;
  final Color? _borderPrimary;
  final Color? _borderSecondary;
  final Color? _borderSecondaryAlt;
  final Color? _borderTertiary;
  final Color? _borderError;
  final Color? _borderErrorSubtle;
  final Color? _borderBrand;
  final Color? _borderBrandAlt;
  final Color? _fgSecondary;
  final Color? _fgWarningPrimary;
  final Color? _fgSuccessPrimary;
  final Color? _fgWhite;
  final Color? _fgSuccessSecondary;
  final Color? _fgSecondaryHover;
  final Color? _fgPrimary;
  final Color? _fgBrandSecondary;
  final Color? _fgBrandPrimary;
  final Color? _fgQuaternary;
  final Color? _fgQuaternaryHover;
  final Color? _fgErrorPrimary;
  final Color? _fgWarningSecondary;
  final Color? _fgErrorSecondary;
  final Color? _fgTertiary;
  final Color? _fgTertiaryHover;
  final Color? _fgBrandPrimaryAlt;
  final Color? _fgBrandSecondaryAlt;
  final Color? _fgBrandSecondaryHover;
  final Color? _bgPrimary;
  final Color? _bgTertiary;
  final Color? _bgBrandPrimary;
  final Color? _bgErrorSecondary;
  final Color? _bgWarningPrimary;
  final Color? _bgWarningSecondary;
  final Color? _bgSuccessPrimary;
  final Color? _bgSuccessSecondary;
  final Color? _bgBrandSolid;
  final Color? _bgSecondarySolid;
  final Color? _bgErrorSolid;
  final Color? _bgWarningSolid;
  final Color? _bgSuccessSolid;
  final Color? _bgSecondaryHover;
  final Color? _bgPrimaryHover;
  final Color? _bgBrandSolidHover;
  final Color? _bgErrorPrimary;
  final Color? _bgBrandSecondary;
  final Color? _bgSecondary;
  final Color? _bgQuaternary;
  final Color? _bgPrimaryAlt;
  final Color? _bgBrandPrimaryAlt;
  final Color? _bgSecondaryAlt;
  final Color? _bgOverlay;
  final Color? _bgBrandSection;
  final Color? _bgBrandSectionSubtle;
  final Color? _bgPrimarySolid;
  final Color? _bgErrorSolidHover;
  final Color? _appStoreBadgeBorder;
  final Color? _avatarStylesBgNeutral;
  final Color? _featuredIconLightFgBrand;
  final Color? _featuredIconLightFgError;
  final Color? _featuredIconLightFgGray;
  final Color? _featuredIconLightFgSuccess;
  final Color? _featuredIconLightFgWarning;
  final Color? _focusRingError;
  final Color? _focusRing;
  final Color? _footerButtonFg;
  final Color? _footerButtonFgHover;
  final Color? _iconFgBrand;
  final Color? _iconFgBrandOnBrand;
  final Color? _screenMockupBorder;
  final Color? _sliderHandleBg;
  final Color? _sliderHandleBorder;
  final Color? _toggleBorder;
  final Color? _toggleSlimBorderPressedHover;
  final Color? _toggleSlimBorderPressed;
  final Color? _tooltipSupportingText;
  final Color? _backgroundColorPrimary;
  final Color? _backgroundColorTertiary;
  final Color? _backgroundColorBrandPrimary;
  final Color? _backgroundColorErrorSecondary;
  final Color? _backgroundColorWarningPrimary;
  final Color? _backgroundColorWarningSecondary;
  final Color? _backgroundColorSuccessPrimary;
  final Color? _backgroundColorSuccessSecondary;
  final Color? _backgroundColorBrandSolid;
  final Color? _backgroundColorSecondarySolid;
  final Color? _backgroundColorErrorSolid;
  final Color? _backgroundColorWarningSolid;
  final Color? _backgroundColorSuccessSolid;
  final Color? _backgroundColorSecondaryHover;
  final Color? _backgroundColorPrimaryHover;
  final Color? _backgroundColorBrandSolidHover;
  final Color? _backgroundColorErrorPrimary;
  final Color? _backgroundColorBrandSecondary;
  final Color? _backgroundColorSecondary;
  final Color? _backgroundColorQuaternary;
  final Color? _backgroundColorPrimaryAlt;
  final Color? _backgroundColorBrandPrimaryAlt;
  final Color? _backgroundColorSecondaryAlt;
  final Color? _backgroundColorOverlay;
  final Color? _backgroundColorBrandSection;
  final Color? _backgroundColorBrandSectionSubtle;
  final Color? _backgroundColorPrimarySolid;
  final Color? _backgroundColorErrorSolidHover;
  final Color? _backgroundColorBorderBrand;
  final Color? _backgroundColorBorderBrandAlt;
  final Color? _textWhite;
  final Color? _textColorPrimary;
  final Color? _textColorSecondary;
  final Color? _textColorSecondaryHover;
  final Color? _textColorTertiary;
  final Color? _textColorTertiaryHover;
  final Color? _textColorErrorPrimary;
  final Color? _textColorWarningPrimary;
  final Color? _textColorSuccessPrimary;
  final Color? _textColorBrandSecondary;
  final Color? _textColorPlaceholder;
  final Color? _textColorBrandTertiary;
  final Color? _textColorEditorIconFg;
  final Color? _textColorEditorIconFgActive;
  final Color? _textColorQuaternary;
  final Color? _textColorBrandPrimary;
  final Color? _textColorPrimaryOnBrand;
  final Color? _textColorSecondaryOnBrand;
  final Color? _textColorTertiaryOnBrand;
  final Color? _textColorQuaternaryOnBrand;
  final Color? _textColorBrandTertiaryAlt;
  final Color? _textColorErrorPrimaryHover;
  final Color? _textColorBrandSecondaryHover;
  final Color? _textColorTooltipSupportingText;
  final Color? _borderColorPrimary;
  final Color? _borderColorSecondary;
  final Color? _borderColorSecondaryAlt;
  final Color? _borderColorTertiary;
  final Color? _borderColorError;
  final Color? _borderColorErrorSubtle;
  final Color? _borderColorBrand;
  final Color? _borderColorBrandAlt;
  final Color? _borderColorBrandSolid;
  final Color? _borderColorBrandSolidHover;
  final Color? _ringColorPrimary;
  final Color? _ringColorSecondary;
  final Color? _ringColorSecondaryAlt;
  final Color? _ringColorTertiary;
  final Color? _ringColorError;
  final Color? _ringColorErrorSubtle;
  final Color? _ringColorBrand;
  final Color? _ringColorBrandAlt;
  final Color? _ringColorBrandSolid;
  final Color? _ringColorBrandSolidHover;
  final Color? _outlineColorPrimary;
  final Color? _outlineColorSecondary;
  final Color? _outlineColorSecondaryAlt;
  final Color? _outlineColorTertiary;
  final Color? _outlineColorError;
  final Color? _outlineColorErrorSubtle;
  final Color? _outlineColorBrand;
  final Color? _outlineColorBrandAlt;
  final Color? _outlineColorBrandSolid;
  final Color? _outlineColorBrandSolidHover;
  final Color? _grayModern300;
  final Color? _grayModern500;
  final Color? _grayModern700;
  final Color? _grayModern800;

  Color get backgroundColorBorderTertiary =>
      _backgroundColorBorderTertiary ?? borderTertiary;
  Color get red50 =>
      _red50 ??
      (const Color.from(
        alpha: 1,
        red: 0.9968413300,
        green: 0.9495853876,
        blue: 0.9495856276,
        colorSpace: ColorSpace.extendedSRGB,
      )).withValues(colorSpace: ColorSpace.displayP3);
  Color get red100 =>
      _red100 ??
      (const Color.from(
        alpha: 1,
        red: 0.9993008558,
        green: 0.8856429635,
        blue: 0.8856769190,
        colorSpace: ColorSpace.extendedSRGB,
      )).withValues(colorSpace: ColorSpace.displayP3);
  Color get red200 =>
      _red200 ??
      (const Color.from(
        alpha: 1,
        red: 1.0029428110,
        green: 0.7898433951,
        blue: 0.7900282550,
        colorSpace: ColorSpace.extendedSRGB,
      )).withValues(colorSpace: ColorSpace.displayP3);
  Color get red300 =>
      _red300 ??
      (const Color.from(
        alpha: 1,
        red: 1.0097267582,
        green: 0.6346797890,
        blue: 0.6363713775,
        colorSpace: ColorSpace.extendedSRGB,
      )).withValues(colorSpace: ColorSpace.displayP3);
  Color get red400 =>
      _red400 ??
      (const Color.from(
        alpha: 1,
        red: 1.0055619970,
        green: 0.3911527173,
        blue: 0.4038567952,
        colorSpace: ColorSpace.extendedSRGB,
      )).withValues(colorSpace: ColorSpace.displayP3);
  Color get red500 =>
      _red500 ??
      (const Color.from(
        alpha: 1,
        red: 0.9826614278,
        green: 0.1717970770,
        blue: 0.2130701960,
        colorSpace: ColorSpace.extendedSRGB,
      )).withValues(colorSpace: ColorSpace.displayP3);
  Color get red600 =>
      _red600 ??
      (const Color.from(
        alpha: 1,
        red: 0.9064575627,
        green: -0.1215106092,
        blue: 0.0422145527,
        colorSpace: ColorSpace.extendedSRGB,
      )).withValues(colorSpace: ColorSpace.displayP3);
  Color get red700 =>
      _red700 ??
      (const Color.from(
        alpha: 1,
        red: 0.7568846987,
        green: -0.0664678956,
        blue: 0.0287543283,
        colorSpace: ColorSpace.extendedSRGB,
      )).withValues(colorSpace: ColorSpace.displayP3);
  Color get red800 =>
      _red800 ??
      (const Color.from(
        alpha: 1,
        red: 0.6222081595,
        green: 0.0287905648,
        blue: 0.0689380791,
        colorSpace: ColorSpace.extendedSRGB,
      )).withValues(colorSpace: ColorSpace.displayP3);
  Color get red900 =>
      _red900 ??
      (const Color.from(
        alpha: 1,
        red: 0.5091705003,
        green: 0.0923288072,
        blue: 0.1006869403,
        colorSpace: ColorSpace.extendedSRGB,
      )).withValues(colorSpace: ColorSpace.displayP3);
  Color get red950 =>
      _red950 ??
      (const Color.from(
        alpha: 1,
        red: 0.2753966633,
        green: 0.0315931539,
        blue: 0.0344976122,
        colorSpace: ColorSpace.extendedSRGB,
      )).withValues(colorSpace: ColorSpace.displayP3);
  Color get orange50 =>
      _orange50 ??
      (const Color.from(
        alpha: 1,
        red: 1.0008830368,
        green: 0.9690530612,
        blue: 0.9292629023,
        colorSpace: ColorSpace.extendedSRGB,
      )).withValues(colorSpace: ColorSpace.displayP3);
  Color get orange100 =>
      _orange100 ??
      (const Color.from(
        alpha: 1,
        red: 1.0010723904,
        green: 0.9288763364,
        blue: 0.8325848192,
        colorSpace: ColorSpace.extendedSRGB,
      )).withValues(colorSpace: ColorSpace.displayP3);
  Color get orange200 =>
      _orange200 ??
      (const Color.from(
        alpha: 1,
        red: 1.0004467802,
        green: 0.8411152215,
        blue: 0.6568333421,
        colorSpace: ColorSpace.extendedSRGB,
      )).withValues(colorSpace: ColorSpace.displayP3);
  Color get orange300 =>
      _orange300 ??
      (const Color.from(
        alpha: 1,
        red: 1.0111518063,
        green: 0.7222756436,
        blue: 0.4139270151,
        colorSpace: ColorSpace.extendedSRGB,
      )).withValues(colorSpace: ColorSpace.displayP3);
  Color get orange400 =>
      _orange400 ??
      (const Color.from(
        alpha: 1,
        red: 1.0124997952,
        green: 0.5370230866,
        blue: 0.0138408244,
        colorSpace: ColorSpace.extendedSRGB,
      )).withValues(colorSpace: ColorSpace.displayP3);
  Color get orange500 =>
      _orange500 ??
      (const Color.from(
        alpha: 1,
        red: 1.0186694226,
        green: 0.4107343076,
        blue: -0.3026561427,
        colorSpace: ColorSpace.extendedSRGB,
      )).withValues(colorSpace: ColorSpace.displayP3);
  Color get orange600 =>
      _orange600 ??
      (const Color.from(
        alpha: 1,
        red: 0.9607054872,
        green: 0.2881907387,
        blue: -0.2665047740,
        colorSpace: ColorSpace.extendedSRGB,
      )).withValues(colorSpace: ColorSpace.displayP3);
  Color get orange700 =>
      _orange700 ??
      (const Color.from(
        alpha: 1,
        red: 0.7918817556,
        green: 0.2072699066,
        blue: -0.1221621709,
        colorSpace: ColorSpace.extendedSRGB,
      )).withValues(colorSpace: ColorSpace.displayP3);
  Color get orange800 =>
      _orange800 ??
      (const Color.from(
        alpha: 1,
        red: 0.6244982063,
        green: 0.1766332258,
        blue: -0.0043414754,
        colorSpace: ColorSpace.extendedSRGB,
      )).withValues(colorSpace: ColorSpace.displayP3);
  Color get orange900 =>
      _orange900 ??
      (const Color.from(
        alpha: 1,
        red: 0.4951185021,
        green: 0.1654188865,
        blue: 0.0456522305,
        colorSpace: ColorSpace.extendedSRGB,
      )).withValues(colorSpace: ColorSpace.displayP3);
  Color get orange950 =>
      _orange950 ??
      (const Color.from(
        alpha: 1,
        red: 0.2664343585,
        green: 0.0744109912,
        blue: 0.0219053219,
        colorSpace: ColorSpace.extendedSRGB,
      )).withValues(colorSpace: ColorSpace.displayP3);
  Color get amber50 =>
      _amber50 ??
      (const Color.from(
        alpha: 1,
        red: 1.0006441361,
        green: 0.9845063801,
        blue: 0.9199939128,
        colorSpace: ColorSpace.extendedSRGB,
      )).withValues(colorSpace: ColorSpace.displayP3);
  Color get amber100 =>
      _amber100 ??
      (const Color.from(
        alpha: 1,
        red: 0.9969999633,
        green: 0.9530826157,
        blue: 0.7775238948,
        colorSpace: ColorSpace.extendedSRGB,
      )).withValues(colorSpace: ColorSpace.displayP3);
  Color get amber200 =>
      _amber200 ??
      (const Color.from(
        alpha: 1,
        red: 0.9957299198,
        green: 0.9012048281,
        blue: 0.5221890720,
        colorSpace: ColorSpace.extendedSRGB,
      )).withValues(colorSpace: ColorSpace.displayP3);
  Color get amber300 =>
      _amber300 ??
      (const Color.from(
        alpha: 1,
        red: 1.0029908702,
        green: 0.8238498656,
        blue: 0.1876053912,
        colorSpace: ColorSpace.extendedSRGB,
      )).withValues(colorSpace: ColorSpace.displayP3);
  Color get amber400 =>
      _amber400 ??
      (const Color.from(
        alpha: 1,
        red: 1.0003164305,
        green: 0.7272557135,
        blue: -0.5578538833,
        colorSpace: ColorSpace.extendedSRGB,
      )).withValues(colorSpace: ColorSpace.displayP3);
  Color get amber500 =>
      _amber500 ??
      (const Color.from(
        alpha: 1,
        red: 0.9942714498,
        green: 0.6020927241,
        blue: -0.5016326229,
        colorSpace: ColorSpace.extendedSRGB,
      )).withValues(colorSpace: ColorSpace.displayP3);
  Color get amber600 =>
      _amber600 ??
      (const Color.from(
        alpha: 1,
        red: 0.8837689326,
        green: 0.4433509010,
        blue: -0.3160854168,
        colorSpace: ColorSpace.extendedSRGB,
      )).withValues(colorSpace: ColorSpace.displayP3);
  Color get amber700 =>
      _amber700 ??
      (const Color.from(
        alpha: 1,
        red: 0.7317888091,
        green: 0.3010233079,
        blue: -0.1371451231,
        colorSpace: ColorSpace.extendedSRGB,
      )).withValues(colorSpace: ColorSpace.displayP3);
  Color get amber800 =>
      _amber800 ??
      (const Color.from(
        alpha: 1,
        red: 0.5903065497,
        green: 0.2337567356,
        blue: -0.0307740383,
        colorSpace: ColorSpace.extendedSRGB,
      )).withValues(colorSpace: ColorSpace.displayP3);
  Color get amber900 =>
      _amber900 ??
      (const Color.from(
        alpha: 1,
        red: 0.4804463123,
        green: 0.1997652927,
        blue: 0.0248330810,
        colorSpace: ColorSpace.extendedSRGB,
      )).withValues(colorSpace: ColorSpace.displayP3);
  Color get amber950 =>
      _amber950 ??
      (const Color.from(
        alpha: 1,
        red: 0.2740671450,
        green: 0.0984926938,
        blue: 0.0046668105,
        colorSpace: ColorSpace.extendedSRGB,
      )).withValues(colorSpace: ColorSpace.displayP3);
  Color get yellow50 =>
      _yellow50 ??
      (const Color.from(
        alpha: 1,
        red: 0.9955702998,
        green: 0.9878028185,
        blue: 0.9100785393,
        colorSpace: ColorSpace.extendedSRGB,
      )).withValues(colorSpace: ColorSpace.displayP3);
  Color get yellow100 =>
      _yellow100 ??
      (const Color.from(
        alpha: 1,
        red: 0.9969827639,
        green: 0.9767837354,
        blue: 0.7597211445,
        colorSpace: ColorSpace.extendedSRGB,
      )).withValues(colorSpace: ColorSpace.displayP3);
  Color get yellow200 =>
      _yellow200 ??
      (const Color.from(
        alpha: 1,
        red: 0.9986842023,
        green: 0.9411307353,
        blue: 0.5228279177,
        colorSpace: ColorSpace.extendedSRGB,
      )).withValues(colorSpace: ColorSpace.displayP3);
  Color get yellow300 =>
      _yellow300 ??
      (const Color.from(
        alpha: 1,
        red: 1.0037143353,
        green: 0.8762567031,
        blue: 0.1257120542,
        colorSpace: ColorSpace.extendedSRGB,
      )).withValues(colorSpace: ColorSpace.displayP3);
  Color get yellow400 =>
      _yellow400 ??
      (const Color.from(
        alpha: 1,
        red: 0.9930035720,
        green: 0.7819446021,
        blue: -0.7605438035,
        colorSpace: ColorSpace.extendedSRGB,
      )).withValues(colorSpace: ColorSpace.displayP3);
  Color get yellow500 =>
      _yellow500 ??
      (const Color.from(
        alpha: 1,
        red: 0.9413119540,
        green: 0.6929154086,
        blue: -0.5687534652,
        colorSpace: ColorSpace.extendedSRGB,
      )).withValues(colorSpace: ColorSpace.displayP3);
  Color get yellow600 =>
      _yellow600 ??
      (const Color.from(
        alpha: 1,
        red: 0.8175540962,
        green: 0.5296359903,
        blue: -0.3569615602,
        colorSpace: ColorSpace.extendedSRGB,
      )).withValues(colorSpace: ColorSpace.displayP3);
  Color get yellow700 =>
      _yellow700 ??
      (const Color.from(
        alpha: 1,
        red: 0.6510636045,
        green: 0.3732093826,
        blue: -0.1438854207,
        colorSpace: ColorSpace.extendedSRGB,
      )).withValues(colorSpace: ColorSpace.displayP3);
  Color get yellow800 =>
      _yellow800 ??
      (const Color.from(
        alpha: 1,
        red: 0.5359094288,
        green: 0.2927126803,
        blue: -0.0377188818,
        colorSpace: ColorSpace.extendedSRGB,
      )).withValues(colorSpace: ColorSpace.displayP3);
  Color get yellow900 =>
      _yellow900 ??
      (const Color.from(
        alpha: 1,
        red: 0.4504861617,
        green: 0.2424023417,
        blue: 0.0409036223,
        colorSpace: ColorSpace.extendedSRGB,
      )).withValues(colorSpace: ColorSpace.displayP3);
  Color get yellow950 =>
      _yellow950 ??
      (const Color.from(
        alpha: 1,
        red: 0.2618609918,
        green: 0.1240003021,
        blue: 0.0174205666,
        colorSpace: ColorSpace.extendedSRGB,
      )).withValues(colorSpace: ColorSpace.displayP3);
  Color get lime50 =>
      _lime50 ??
      (const Color.from(
        alpha: 1,
        red: 0.9690420850,
        green: 0.9965202437,
        blue: 0.9062309788,
        colorSpace: ColorSpace.extendedSRGB,
      )).withValues(colorSpace: ColorSpace.displayP3);
  Color get lime100 =>
      _lime100 ??
      (const Color.from(
        alpha: 1,
        red: 0.9250763462,
        green: 0.9888006880,
        blue: 0.7933730430,
        colorSpace: ColorSpace.extendedSRGB,
      )).withValues(colorSpace: ColorSpace.displayP3);
  Color get lime200 =>
      _lime200 ??
      (const Color.from(
        alpha: 1,
        red: 0.8477643797,
        green: 0.9783046536,
        blue: 0.5999008395,
        colorSpace: ColorSpace.extendedSRGB,
      )).withValues(colorSpace: ColorSpace.displayP3);
  Color get lime300 =>
      _lime300 ??
      (const Color.from(
        alpha: 1,
        red: 0.7329368245,
        green: 0.9551594833,
        blue: 0.3178040046,
        colorSpace: ColorSpace.extendedSRGB,
      )).withValues(colorSpace: ColorSpace.displayP3);
  Color get lime400 =>
      _lime400 ??
      (const Color.from(
        alpha: 1,
        red: 0.6024434268,
        green: 0.9016712315,
        blue: -0.3805850883,
        colorSpace: ColorSpace.extendedSRGB,
      )).withValues(colorSpace: ColorSpace.displayP3);
  Color get lime500 =>
      _lime500 ??
      (const Color.from(
        alpha: 1,
        red: 0.4872933027,
        green: 0.8099173875,
        blue: -0.4658493689,
        colorSpace: ColorSpace.extendedSRGB,
      )).withValues(colorSpace: ColorSpace.displayP3);
  Color get lime600 =>
      _lime600 ??
      (const Color.from(
        alpha: 1,
        red: 0.3687201160,
        green: 0.6474890882,
        blue: -0.2911832365,
        colorSpace: ColorSpace.extendedSRGB,
      )).withValues(colorSpace: ColorSpace.displayP3);
  Color get lime700 =>
      _lime700 ??
      (const Color.from(
        alpha: 1,
        red: 0.2848082281,
        green: 0.4915021266,
        blue: -0.0976166938,
        colorSpace: ColorSpace.extendedSRGB,
      )).withValues(colorSpace: ColorSpace.displayP3);
  Color get lime800 =>
      _lime800 ??
      (const Color.from(
        alpha: 1,
        red: 0.2372255570,
        green: 0.3880722240,
        blue: -0.0024024943,
        colorSpace: ColorSpace.extendedSRGB,
      )).withValues(colorSpace: ColorSpace.displayP3);
  Color get lime900 =>
      _lime900 ??
      (const Color.from(
        alpha: 1,
        red: 0.2070180456,
        green: 0.3272238448,
        blue: 0.0552369294,
        colorSpace: ColorSpace.extendedSRGB,
      )).withValues(colorSpace: ColorSpace.displayP3);
  Color get lime950 =>
      _lime950 ??
      (const Color.from(
        alpha: 1,
        red: 0.0990861088,
        green: 0.1812896126,
        blue: 0.0109398741,
        colorSpace: ColorSpace.extendedSRGB,
      )).withValues(colorSpace: ColorSpace.displayP3);
  Color get green50 =>
      _green50 ??
      (const Color.from(
        alpha: 1,
        red: 0.9413932491,
        green: 0.9922020488,
        blue: 0.9570246264,
        colorSpace: ColorSpace.extendedSRGB,
      )).withValues(colorSpace: ColorSpace.displayP3);
  Color get green100 =>
      _green100 ??
      (const Color.from(
        alpha: 1,
        red: 0.8608796459,
        green: 0.9882110531,
        blue: 0.9046970581,
        colorSpace: ColorSpace.extendedSRGB,
      )).withValues(colorSpace: ColorSpace.displayP3);
  Color get green200 =>
      _green200 ??
      (const Color.from(
        alpha: 1,
        red: 0.7250790687,
        green: 0.9712606816,
        blue: 0.8118364376,
        colorSpace: ColorSpace.extendedSRGB,
      )).withValues(colorSpace: ColorSpace.displayP3);
  Color get green300 =>
      _green300 ??
      (const Color.from(
        alpha: 1,
        red: 0.4814550617,
        green: 0.9463488966,
        blue: 0.6570021981,
        colorSpace: ColorSpace.extendedSRGB,
      )).withValues(colorSpace: ColorSpace.displayP3);
  Color get green400 =>
      _green400 ??
      (const Color.from(
        alpha: 1,
        red: 0.0198704765,
        green: 0.8753122798,
        blue: 0.4485096786,
        colorSpace: ColorSpace.extendedSRGB,
      )).withValues(colorSpace: ColorSpace.displayP3);
  Color get green500 =>
      _green500 ??
      (const Color.from(
        alpha: 1,
        red: -0.4043375922,
        green: 0.7871556158,
        blue: 0.3156217578,
        colorSpace: ColorSpace.extendedSRGB,
      )).withValues(colorSpace: ColorSpace.displayP3);
  Color get green600 =>
      _green600 ??
      (const Color.from(
        alpha: 1,
        red: -0.3033784233,
        green: 0.6513022629,
        blue: 0.2419925610,
        colorSpace: ColorSpace.extendedSRGB,
      )).withValues(colorSpace: ColorSpace.displayP3);
  Color get green700 =>
      _green700 ??
      (const Color.from(
        alpha: 1,
        red: -0.1110535951,
        green: 0.5099976638,
        blue: 0.2098096070,
        colorSpace: ColorSpace.extendedSRGB,
      )).withValues(colorSpace: ColorSpace.displayP3);
  Color get green800 =>
      _green800 ??
      (const Color.from(
        alpha: 1,
        red: 0.0057959849,
        green: 0.4014766284,
        blue: 0.1885884070,
        colorSpace: ColorSpace.extendedSRGB,
      )).withValues(colorSpace: ColorSpace.displayP3);
  Color get green900 =>
      _green900 ??
      (const Color.from(
        alpha: 1,
        red: 0.0511254089,
        green: 0.3286887955,
        blue: 0.1701724691,
        colorSpace: ColorSpace.extendedSRGB,
      )).withValues(colorSpace: ColorSpace.displayP3);
  Color get green950 =>
      _green950 ??
      (const Color.from(
        alpha: 1,
        red: 0.0119957256,
        green: 0.1810015303,
        blue: 0.0835035409,
        colorSpace: ColorSpace.extendedSRGB,
      )).withValues(colorSpace: ColorSpace.displayP3);
  Color get emerald50 =>
      _emerald50 ??
      (const Color.from(
        alpha: 1,
        red: 0.9243212968,
        green: 0.9920315609,
        blue: 0.9601800286,
        colorSpace: ColorSpace.extendedSRGB,
      )).withValues(colorSpace: ColorSpace.displayP3);
  Color get emerald100 =>
      _emerald100 ??
      (const Color.from(
        alpha: 1,
        red: 0.8159214747,
        green: 0.9808685480,
        blue: 0.8965166064,
        colorSpace: ColorSpace.extendedSRGB,
      )).withValues(colorSpace: ColorSpace.displayP3);
  Color get emerald200 =>
      _emerald200 ??
      (const Color.from(
        alpha: 1,
        red: 0.6444914801,
        green: 0.9558121960,
        blue: 0.8133241246,
        colorSpace: ColorSpace.extendedSRGB,
      )).withValues(colorSpace: ColorSpace.displayP3);
  Color get emerald300 =>
      _emerald300 ??
      (const Color.from(
        alpha: 1,
        red: 0.3698525185,
        green: 0.9150905540,
        blue: 0.7087672825,
        colorSpace: ColorSpace.extendedSRGB,
      )).withValues(colorSpace: ColorSpace.displayP3);
  Color get emerald400 =>
      _emerald400 ??
      (const Color.from(
        alpha: 1,
        red: -0.4031132542,
        green: 0.8325921500,
        blue: 0.5723413435,
        colorSpace: ColorSpace.extendedSRGB,
      )).withValues(colorSpace: ColorSpace.displayP3);
  Color get emerald500 =>
      _emerald500 ??
      (const Color.from(
        alpha: 1,
        red: -0.4979558315,
        green: 0.7387891447,
        blue: 0.4892808494,
        colorSpace: ColorSpace.extendedSRGB,
      )).withValues(colorSpace: ColorSpace.displayP3);
  Color get emerald600 =>
      _emerald600 ??
      (const Color.from(
        alpha: 1,
        red: -0.3322414676,
        green: 0.5989388722,
        blue: 0.3989836386,
        colorSpace: ColorSpace.extendedSRGB,
      )).withValues(colorSpace: ColorSpace.displayP3);
  Color get emerald700 =>
      _emerald700 ??
      (const Color.from(
        alpha: 1,
        red: -0.1811812157,
        green: 0.4782195512,
        blue: 0.3335466777,
        colorSpace: ColorSpace.extendedSRGB,
      )).withValues(colorSpace: ColorSpace.displayP3);
  Color get emerald800 =>
      _emerald800 ??
      (const Color.from(
        alpha: 1,
        red: -0.0705684040,
        green: 0.3777278668,
        blue: 0.2705765755,
        colorSpace: ColorSpace.extendedSRGB,
      )).withValues(colorSpace: ColorSpace.displayP3);
  Color get emerald900 =>
      _emerald900 ??
      (const Color.from(
        alpha: 1,
        red: -0.0111860600,
        green: 0.3081038671,
        blue: 0.2298271320,
        colorSpace: ColorSpace.extendedSRGB,
      )).withValues(colorSpace: ColorSpace.displayP3);
  Color get emerald950 =>
      _emerald950 ??
      (const Color.from(
        alpha: 1,
        red: -0.0020628231,
        green: 0.1736480990,
        blue: 0.1327839752,
        colorSpace: ColorSpace.extendedSRGB,
      )).withValues(colorSpace: ColorSpace.displayP3);
  Color get teal50 =>
      _teal50 ??
      (const Color.from(
        alpha: 1,
        red: 0.9422644156,
        green: 0.9925186064,
        blue: 0.9809167538,
        colorSpace: ColorSpace.extendedSRGB,
      )).withValues(colorSpace: ColorSpace.displayP3);
  Color get teal100 =>
      _teal100 ??
      (const Color.from(
        alpha: 1,
        red: 0.7967792238,
        green: 0.9858463329,
        blue: 0.9457265011,
        colorSpace: ColorSpace.extendedSRGB,
      )).withValues(colorSpace: ColorSpace.displayP3);
  Color get teal200 =>
      _teal200 ??
      (const Color.from(
        alpha: 1,
        red: 0.5870300798,
        green: 0.9674542340,
        blue: 0.8945855397,
        colorSpace: ColorSpace.extendedSRGB,
      )).withValues(colorSpace: ColorSpace.displayP3);
  Color get teal300 =>
      _teal300 ??
      (const Color.from(
        alpha: 1,
        red: 0.2756205177,
        green: 0.9274332068,
        blue: 0.8335047033,
        colorSpace: ColorSpace.extendedSRGB,
      )).withValues(colorSpace: ColorSpace.displayP3);
  Color get teal400 =>
      _teal400 ??
      (const Color.from(
        alpha: 1,
        red: -0.5197189947,
        green: 0.8352503957,
        blue: 0.7433175872,
        colorSpace: ColorSpace.extendedSRGB,
      )).withValues(colorSpace: ColorSpace.displayP3);
  Color get teal500 =>
      _teal500 ??
      (const Color.from(
        alpha: 1,
        red: -0.4786218709,
        green: 0.7333587477,
        blue: 0.6548707934,
        colorSpace: ColorSpace.extendedSRGB,
      )).withValues(colorSpace: ColorSpace.displayP3);
  Color get teal600 =>
      _teal600 ??
      (const Color.from(
        alpha: 1,
        red: -0.2983285081,
        green: 0.5892682392,
        blue: 0.5372884605,
        colorSpace: ColorSpace.extendedSRGB,
      )).withValues(colorSpace: ColorSpace.displayP3);
  Color get teal700 =>
      _teal700 ??
      (const Color.from(
        alpha: 1,
        red: -0.1178863331,
        green: 0.4689987767,
        blue: 0.4349716084,
        colorSpace: ColorSpace.extendedSRGB,
      )).withValues(colorSpace: ColorSpace.displayP3);
  Color get teal800 =>
      _teal800 ??
      (const Color.from(
        alpha: 1,
        red: -0.0274976690,
        green: 0.3731432805,
        blue: 0.3521346610,
        colorSpace: ColorSpace.extendedSRGB,
      )).withValues(colorSpace: ColorSpace.displayP3);
  Color get teal900 =>
      _teal900 ??
      (const Color.from(
        alpha: 1,
        red: 0.0420031332,
        green: 0.3081708303,
        blue: 0.2917559913,
        colorSpace: ColorSpace.extendedSRGB,
      )).withValues(colorSpace: ColorSpace.displayP3);
  Color get teal950 =>
      _teal950 ??
      (const Color.from(
        alpha: 1,
        red: 0.0081214521,
        green: 0.1847563842,
        blue: 0.1808228179,
        colorSpace: ColorSpace.extendedSRGB,
      )).withValues(colorSpace: ColorSpace.displayP3);
  Color get cyan50 =>
      _cyan50 ??
      (const Color.from(
        alpha: 1,
        red: 0.9250037783,
        green: 0.9960225100,
        blue: 0.9999691380,
        colorSpace: ColorSpace.extendedSRGB,
      )).withValues(colorSpace: ColorSpace.displayP3);
  Color get cyan100 =>
      _cyan100 ??
      (const Color.from(
        alpha: 1,
        red: 0.8092722554,
        green: 0.9805906066,
        blue: 0.9965360551,
        colorSpace: ColorSpace.extendedSRGB,
      )).withValues(colorSpace: ColorSpace.displayP3);
  Color get cyan200 =>
      _cyan200 ??
      (const Color.from(
        alpha: 1,
        red: 0.6366476289,
        green: 0.9554242818,
        blue: 0.9921552767,
        colorSpace: ColorSpace.extendedSRGB,
      )).withValues(colorSpace: ColorSpace.displayP3);
  Color get cyan300 =>
      _cyan300 ??
      (const Color.from(
        alpha: 1,
        red: 0.3266667958,
        green: 0.9169947283,
        blue: 0.9913581547,
        colorSpace: ColorSpace.extendedSRGB,
      )).withValues(colorSpace: ColorSpace.displayP3);
  Color get cyan400 =>
      _cyan400 ??
      (const Color.from(
        alpha: 1,
        red: -0.7070486941,
        green: 0.8273619094,
        blue: 0.9509645840,
        colorSpace: ColorSpace.extendedSRGB,
      )).withValues(colorSpace: ColorSpace.displayP3);
  Color get cyan500 =>
      _cyan500 ??
      (const Color.from(
        alpha: 1,
        red: -0.5594150130,
        green: 0.7218724374,
        blue: 0.8573380178,
        colorSpace: ColorSpace.extendedSRGB,
      )).withValues(colorSpace: ColorSpace.displayP3);
  Color get cyan600 =>
      _cyan600 ??
      (const Color.from(
        alpha: 1,
        red: -0.3191117646,
        green: 0.5741973101,
        blue: 0.7225723526,
        colorSpace: ColorSpace.extendedSRGB,
      )).withValues(colorSpace: ColorSpace.displayP3);
  Color get cyan700 =>
      _cyan700 ??
      (const Color.from(
        alpha: 1,
        red: -0.1352053756,
        green: 0.4590370452,
        blue: 0.5832521247,
        colorSpace: ColorSpace.extendedSRGB,
      )).withValues(colorSpace: ColorSpace.displayP3);
  Color get cyan800 =>
      _cyan800 ??
      (const Color.from(
        alpha: 1,
        red: -0.0034890638,
        green: 0.3711744095,
        blue: 0.4712478642,
        colorSpace: ColorSpace.extendedSRGB,
      )).withValues(colorSpace: ColorSpace.displayP3);
  Color get cyan900 =>
      _cyan900 ??
      (const Color.from(
        alpha: 1,
        red: 0.0637282751,
        green: 0.3067085826,
        blue: 0.3937416485,
        colorSpace: ColorSpace.extendedSRGB,
      )).withValues(colorSpace: ColorSpace.displayP3);
  Color get cyan950 =>
      _cyan950 ??
      (const Color.from(
        alpha: 1,
        red: 0.0211879211,
        green: 0.2006470969,
        blue: 0.2698320821,
        colorSpace: ColorSpace.extendedSRGB,
      )).withValues(colorSpace: ColorSpace.displayP3);
  Color get sky50 =>
      _sky50 ??
      (const Color.from(
        alpha: 1,
        red: 0.9398366945,
        green: 0.9765926487,
        blue: 1.0010899041,
        colorSpace: ColorSpace.extendedSRGB,
      )).withValues(colorSpace: ColorSpace.displayP3);
  Color get sky100 =>
      _sky100 ??
      (const Color.from(
        alpha: 1,
        red: 0.8755857146,
        green: 0.9489379803,
        blue: 0.9978108005,
        colorSpace: ColorSpace.extendedSRGB,
      )).withValues(colorSpace: ColorSpace.displayP3);
  Color get sky200 =>
      _sky200 ??
      (const Color.from(
        alpha: 1,
        red: 0.7218523388,
        green: 0.9026974813,
        blue: 0.9970122044,
        colorSpace: ColorSpace.extendedSRGB,
      )).withValues(colorSpace: ColorSpace.displayP3);
  Color get sky300 =>
      _sky300 ??
      (const Color.from(
        alpha: 1,
        red: 0.4532183272,
        green: 0.8316647912,
        blue: 1.0084088477,
        colorSpace: ColorSpace.extendedSRGB,
      )).withValues(colorSpace: ColorSpace.displayP3);
  Color get sky400 =>
      _sky400 ??
      (const Color.from(
        alpha: 1,
        red: -0.2014024876,
        green: 0.7364118749,
        blue: 1.0042938382,
        colorSpace: ColorSpace.extendedSRGB,
      )).withValues(colorSpace: ColorSpace.displayP3);
  Color get sky500 =>
      _sky500 ??
      (const Color.from(
        alpha: 1,
        red: -0.4405503414,
        green: 0.6497637764,
        blue: 0.9571310896,
        colorSpace: ColorSpace.extendedSRGB,
      )).withValues(colorSpace: ColorSpace.displayP3);
  Color get sky600 =>
      _sky600 ??
      (const Color.from(
        alpha: 1,
        red: -0.2898871832,
        green: 0.5181664409,
        blue: 0.8197996446,
        colorSpace: ColorSpace.extendedSRGB,
      )).withValues(colorSpace: ColorSpace.displayP3);
  Color get sky700 =>
      _sky700 ??
      (const Color.from(
        alpha: 1,
        red: -0.1519851751,
        green: 0.4116348708,
        blue: 0.6602958710,
        colorSpace: ColorSpace.extendedSRGB,
      )).withValues(colorSpace: ColorSpace.displayP3);
  Color get sky800 =>
      _sky800 ??
      (const Color.from(
        alpha: 1,
        red: -0.0658392173,
        green: 0.3490170055,
        blue: 0.5398579224,
        colorSpace: ColorSpace.extendedSRGB,
      )).withValues(colorSpace: ColorSpace.displayP3);
  Color get sky900 =>
      _sky900 ??
      (const Color.from(
        alpha: 1,
        red: 0.0067533557,
        green: 0.2902710890,
        blue: 0.4411054297,
        colorSpace: ColorSpace.extendedSRGB,
      )).withValues(colorSpace: ColorSpace.displayP3);
  Color get sky950 =>
      _sky950 ??
      (const Color.from(
        alpha: 1,
        red: 0.0198149861,
        green: 0.1839374974,
        blue: 0.2905612319,
        colorSpace: ColorSpace.extendedSRGB,
      )).withValues(colorSpace: ColorSpace.displayP3);
  Color get blue50 =>
      _blue50 ??
      (const Color.from(
        alpha: 1,
        red: 0.9369397785,
        green: 0.9640346234,
        blue: 0.9988718497,
        colorSpace: ColorSpace.extendedSRGB,
      )).withValues(colorSpace: ColorSpace.displayP3);
  Color get blue100 =>
      _blue100 ??
      (const Color.from(
        alpha: 1,
        red: 0.8582405402,
        green: 0.9178275216,
        blue: 0.9972704879,
        colorSpace: ColorSpace.extendedSRGB,
      )).withValues(colorSpace: ColorSpace.displayP3);
  Color get blue200 =>
      _blue200 ??
      (const Color.from(
        alpha: 1,
        red: 0.7450929961,
        green: 0.8586637657,
        blue: 1.0005706948,
        colorSpace: ColorSpace.extendedSRGB,
      )).withValues(colorSpace: ColorSpace.displayP3);
  Color get blue300 =>
      _blue300 ??
      (const Color.from(
        alpha: 1,
        red: 0.5565924059,
        green: 0.7731643417,
        blue: 1.0146476513,
        colorSpace: ColorSpace.extendedSRGB,
      )).withValues(colorSpace: ColorSpace.displayP3);
  Color get blue400 =>
      _blue400 ??
      (const Color.from(
        alpha: 1,
        red: 0.3157993614,
        green: 0.6355904431,
        blue: 1.0209814349,
        colorSpace: ColorSpace.extendedSRGB,
      )).withValues(colorSpace: ColorSpace.displayP3);
  Color get blue500 =>
      _blue500 ??
      (const Color.from(
        alpha: 1,
        red: 0.1693325426,
        green: 0.4980494619,
        blue: 1.0228333908,
        colorSpace: ColorSpace.extendedSRGB,
      )).withValues(colorSpace: ColorSpace.displayP3);
  Color get blue600 =>
      _blue600 ??
      (const Color.from(
        alpha: 1,
        red: 0.0836191463,
        green: 0.3644171223,
        blue: 0.9863430408,
        colorSpace: ColorSpace.extendedSRGB,
      )).withValues(colorSpace: ColorSpace.displayP3);
  Color get blue700 =>
      _blue700 ??
      (const Color.from(
        alpha: 1,
        red: 0.0779077835,
        green: 0.2791351731,
        blue: 0.9017744175,
        colorSpace: ColorSpace.extendedSRGB,
      )).withValues(colorSpace: ColorSpace.displayP3);
  Color get blue800 =>
      _blue800 ??
      (const Color.from(
        alpha: 1,
        red: 0.0997812413,
        green: 0.2337700753,
        blue: 0.7229223937,
        colorSpace: ColorSpace.extendedSRGB,
      )).withValues(colorSpace: ColorSpace.displayP3);
  Color get blue900 =>
      _blue900 ??
      (const Color.from(
        alpha: 1,
        red: 0.1090559260,
        green: 0.2221925684,
        blue: 0.5575136160,
        colorSpace: ColorSpace.extendedSRGB,
      )).withValues(colorSpace: ColorSpace.displayP3);
  Color get blue950 =>
      _blue950 ??
      (const Color.from(
        alpha: 1,
        red: 0.0872625830,
        green: 0.1431322980,
        blue: 0.3356920429,
        colorSpace: ColorSpace.extendedSRGB,
      )).withValues(colorSpace: ColorSpace.displayP3);
  Color get indigo50 =>
      _indigo50 ??
      (const Color.from(
        alpha: 1,
        red: 0.9333945408,
        green: 0.9491385898,
        blue: 1.0003081583,
        colorSpace: ColorSpace.extendedSRGB,
      )).withValues(colorSpace: ColorSpace.displayP3);
  Color get indigo100 =>
      _indigo100 ??
      (const Color.from(
        alpha: 1,
        red: 0.8779962747,
        green: 0.9058982457,
        blue: 1.0016237370,
        colorSpace: ColorSpace.extendedSRGB,
      )).withValues(colorSpace: ColorSpace.displayP3);
  Color get indigo200 =>
      _indigo200 ??
      (const Color.from(
        alpha: 1,
        red: 0.7783517080,
        green: 0.8231921386,
        blue: 1.0034169776,
        colorSpace: ColorSpace.extendedSRGB,
      )).withValues(colorSpace: ColorSpace.displayP3);
  Color get indigo300 =>
      _indigo300 ??
      (const Color.from(
        alpha: 1,
        red: 0.6391280338,
        green: 0.7021304891,
        blue: 1.0142638340,
        colorSpace: ColorSpace.extendedSRGB,
      )).withValues(colorSpace: ColorSpace.displayP3);
  Color get indigo400 =>
      _indigo400 ??
      (const Color.from(
        alpha: 1,
        red: 0.4878469627,
        green: 0.5265172875,
        blue: 1.0167751274,
        colorSpace: ColorSpace.extendedSRGB,
      )).withValues(colorSpace: ColorSpace.displayP3);
  Color get indigo500 =>
      _indigo500 ??
      (const Color.from(
        alpha: 1,
        red: 0.3821760676,
        green: 0.3718882929,
        blue: 1.0076878768,
        colorSpace: ColorSpace.extendedSRGB,
      )).withValues(colorSpace: ColorSpace.displayP3);
  Color get indigo600 =>
      _indigo600 ??
      (const Color.from(
        alpha: 1,
        red: 0.3108854947,
        green: 0.2244044885,
        blue: 0.9662612254,
        colorSpace: ColorSpace.extendedSRGB,
      )).withValues(colorSpace: ColorSpace.displayP3);
  Color get indigo700 =>
      _indigo700 ??
      (const Color.from(
        alpha: 1,
        red: 0.2643529907,
        green: 0.1765924509,
        blue: 0.8448341038,
        colorSpace: ColorSpace.extendedSRGB,
      )).withValues(colorSpace: ColorSpace.displayP3);
  Color get indigo800 =>
      _indigo800 ??
      (const Color.from(
        alpha: 1,
        red: 0.2154269236,
        green: 0.1632234398,
        blue: 0.6737073997,
        colorSpace: ColorSpace.extendedSRGB,
      )).withValues(colorSpace: ColorSpace.displayP3);
  Color get indigo900 =>
      _indigo900 ??
      (const Color.from(
        alpha: 1,
        red: 0.1916483677,
        green: 0.1726451524,
        blue: 0.5226693841,
        colorSpace: ColorSpace.extendedSRGB,
      )).withValues(colorSpace: ColorSpace.displayP3);
  Color get indigo950 =>
      _indigo950 ??
      (const Color.from(
        alpha: 1,
        red: 0.1171338450,
        green: 0.1026301661,
        blue: 0.3006191280,
        colorSpace: ColorSpace.extendedSRGB,
      )).withValues(colorSpace: ColorSpace.displayP3);
  Color get violet50 =>
      _violet50 ??
      (const Color.from(
        alpha: 1,
        red: 0.9605924930,
        green: 0.9527792883,
        blue: 0.9996634990,
        colorSpace: ColorSpace.extendedSRGB,
      )).withValues(colorSpace: ColorSpace.displayP3);
  Color get violet100 =>
      _violet100 ??
      (const Color.from(
        alpha: 1,
        red: 0.9290421512,
        green: 0.9130081540,
        blue: 0.9970683805,
        colorSpace: ColorSpace.extendedSRGB,
      )).withValues(colorSpace: ColorSpace.displayP3);
  Color get violet200 =>
      _violet200 ??
      (const Color.from(
        alpha: 1,
        red: 0.8665415287,
        green: 0.8378734731,
        blue: 1.0007511069,
        colorSpace: ColorSpace.extendedSRGB,
      )).withValues(colorSpace: ColorSpace.displayP3);
  Color get violet300 =>
      _violet300 ??
      (const Color.from(
        alpha: 1,
        red: 0.7700671241,
        green: 0.7039359660,
        blue: 1.0136156040,
        colorSpace: ColorSpace.extendedSRGB,
      )).withValues(colorSpace: ColorSpace.displayP3);
  Color get violet400 =>
      _violet400 ??
      (const Color.from(
        alpha: 1,
        red: 0.6526055562,
        green: 0.5169346988,
        blue: 1.0208072489,
        colorSpace: ColorSpace.extendedSRGB,
      )).withValues(colorSpace: ColorSpace.displayP3);
  Color get violet500 =>
      _violet500 ??
      (const Color.from(
        alpha: 1,
        red: 0.5559262918,
        green: 0.3181637581,
        blue: 1.0276310968,
        colorSpace: ColorSpace.extendedSRGB,
      )).withValues(colorSpace: ColorSpace.displayP3);
  Color get violet600 =>
      _violet600 ??
      (const Color.from(
        alpha: 1,
        red: 0.4999111544,
        green: 0.1337047133,
        blue: 0.9959982452,
        colorSpace: ColorSpace.extendedSRGB,
      )).withValues(colorSpace: ColorSpace.displayP3);
  Color get violet700 =>
      _violet700 ??
      (const Color.from(
        alpha: 1,
        red: 0.4396858792,
        green: 0.0314230940,
        blue: 0.9064205880,
        colorSpace: ColorSpace.extendedSRGB,
      )).withValues(colorSpace: ColorSpace.displayP3);
  Color get violet800 =>
      _violet800 ??
      (const Color.from(
        alpha: 1,
        red: 0.3653835375,
        green: 0.0555390532,
        blue: 0.7533062789,
        colorSpace: ColorSpace.extendedSRGB,
      )).withValues(colorSpace: ColorSpace.displayP3);
  Color get violet900 =>
      _violet900 ??
      (const Color.from(
        alpha: 1,
        red: 0.3024733513,
        green: 0.0891159598,
        blue: 0.6037157130,
        colorSpace: ColorSpace.extendedSRGB,
      )).withValues(colorSpace: ColorSpace.displayP3);
  Color get violet950 =>
      _violet950 ??
      (const Color.from(
        alpha: 1,
        red: 0.1825469362,
        green: 0.0509021676,
        blue: 0.4063526187,
        colorSpace: ColorSpace.extendedSRGB,
      )).withValues(colorSpace: ColorSpace.displayP3);
  Color get purple50 =>
      _purple50 ??
      (const Color.from(
        alpha: 1,
        red: 0.9804396826,
        green: 0.9611090496,
        blue: 0.9997745771,
        colorSpace: ColorSpace.extendedSRGB,
      )).withValues(colorSpace: ColorSpace.displayP3);
  Color get purple100 =>
      _purple100 ??
      (const Color.from(
        alpha: 1,
        red: 0.9525600822,
        green: 0.9090818984,
        blue: 0.9999773416,
        colorSpace: ColorSpace.extendedSRGB,
      )).withValues(colorSpace: ColorSpace.displayP3);
  Color get purple200 =>
      _purple200 ??
      (const Color.from(
        alpha: 1,
        red: 0.9150137115,
        green: 0.8330873936,
        blue: 1.0048411128,
        colorSpace: ColorSpace.extendedSRGB,
      )).withValues(colorSpace: ColorSpace.displayP3);
  Color get purple300 =>
      _purple300 ??
      (const Color.from(
        alpha: 1,
        red: 0.8544052015,
        green: 0.6977941742,
        blue: 1.0173858297,
        colorSpace: ColorSpace.extendedSRGB,
      )).withValues(colorSpace: ColorSpace.displayP3);
  Color get purple400 =>
      _purple400 ??
      (const Color.from(
        alpha: 1,
        red: 0.7595676687,
        green: 0.4798001025,
        blue: 1.0261813184,
        colorSpace: ColorSpace.extendedSRGB,
      )).withValues(colorSpace: ColorSpace.displayP3);
  Color get purple500 =>
      _purple500 ??
      (const Color.from(
        alpha: 1,
        red: 0.6779096338,
        green: 0.2759419594,
        blue: 1.0270836683,
        colorSpace: ColorSpace.extendedSRGB,
      )).withValues(colorSpace: ColorSpace.displayP3);
  Color get purple600 =>
      _purple600 ??
      (const Color.from(
        alpha: 1,
        red: 0.5968394296,
        green: 0.0617294199,
        blue: 0.9813577675,
        colorSpace: ColorSpace.extendedSRGB,
      )).withValues(colorSpace: ColorSpace.displayP3);
  Color get purple700 =>
      _purple700 ??
      (const Color.from(
        alpha: 1,
        red: 0.5099057001,
        green: -0.0262226246,
        blue: 0.8572576432,
        colorSpace: ColorSpace.extendedSRGB,
      )).withValues(colorSpace: ColorSpace.displayP3);
  Color get purple800 =>
      _purple800 ??
      (const Color.from(
        alpha: 1,
        red: 0.4299933559,
        green: 0.0666391571,
        blue: 0.6907452196,
        colorSpace: ColorSpace.extendedSRGB,
      )).withValues(colorSpace: ColorSpace.displayP3);
  Color get purple900 =>
      _purple900 ??
      (const Color.from(
        alpha: 1,
        red: 0.3507220207,
        green: 0.0873004923,
        blue: 0.5451927870,
        colorSpace: ColorSpace.extendedSRGB,
      )).withValues(colorSpace: ColorSpace.displayP3);
  Color get purple950 =>
      _purple950 ??
      (const Color.from(
        alpha: 1,
        red: 0.2346311940,
        green: 0.0117801178,
        blue: 0.4013692379,
        colorSpace: ColorSpace.extendedSRGB,
      )).withValues(colorSpace: ColorSpace.displayP3);
  Color get fuchsia50 =>
      _fuchsia50 ??
      (const Color.from(
        alpha: 1,
        red: 0.9914102308,
        green: 0.9567697449,
        blue: 0.9991073706,
        colorSpace: ColorSpace.extendedSRGB,
      )).withValues(colorSpace: ColorSpace.displayP3);
  Color get fuchsia100 =>
      _fuchsia100 ??
      (const Color.from(
        alpha: 1,
        red: 0.9815512108,
        green: 0.9089312587,
        blue: 1.0017214264,
        colorSpace: ColorSpace.extendedSRGB,
      )).withValues(colorSpace: ColorSpace.displayP3);
  Color get fuchsia200 =>
      _fuchsia200 ??
      (const Color.from(
        alpha: 1,
        red: 0.9639648460,
        green: 0.8133429756,
        blue: 1.0006065511,
        colorSpace: ColorSpace.extendedSRGB,
      )).withValues(colorSpace: ColorSpace.displayP3);
  Color get fuchsia300 =>
      _fuchsia300 ??
      (const Color.from(
        alpha: 1,
        red: 0.9550995722,
        green: 0.6572811042,
        blue: 1.0071189028,
        colorSpace: ColorSpace.extendedSRGB,
      )).withValues(colorSpace: ColorSpace.displayP3);
  Color get fuchsia400 =>
      _fuchsia400 ??
      (const Color.from(
        alpha: 1,
        red: 0.9299384568,
        green: 0.4175664008,
        blue: 1.0083665630,
        colorSpace: ColorSpace.extendedSRGB,
      )).withValues(colorSpace: ColorSpace.displayP3);
  Color get fuchsia500 =>
      _fuchsia500 ??
      (const Color.from(
        alpha: 1,
        red: 0.8836880323,
        green: 0.1657467086,
        blue: 0.9845013763,
        colorSpace: ColorSpace.extendedSRGB,
      )).withValues(colorSpace: ColorSpace.displayP3);
  Color get fuchsia600 =>
      _fuchsia600 ??
      (const Color.from(
        alpha: 1,
        red: 0.7836063108,
        green: -0.1531360316,
        blue: 0.8715410642,
        colorSpace: ColorSpace.extendedSRGB,
      )).withValues(colorSpace: ColorSpace.displayP3);
  Color get fuchsia700 =>
      _fuchsia700 ??
      (const Color.from(
        alpha: 1,
        red: 0.6584703226,
        green: -0.0814668292,
        blue: 0.7179514136,
        colorSpace: ColorSpace.extendedSRGB,
      )).withValues(colorSpace: ColorSpace.displayP3);
  Color get fuchsia800 =>
      _fuchsia800 ??
      (const Color.from(
        alpha: 1,
        red: 0.5413972804,
        green: 0.0051706388,
        blue: 0.5817819052,
        colorSpace: ColorSpace.extendedSRGB,
      )).withValues(colorSpace: ColorSpace.displayP3);
  Color get fuchsia900 =>
      _fuchsia900 ??
      (const Color.from(
        alpha: 1,
        red: 0.4479151958,
        green: 0.0753436114,
        blue: 0.4695966715,
        colorSpace: ColorSpace.extendedSRGB,
      )).withValues(colorSpace: ColorSpace.displayP3);
  Color get fuchsia950 =>
      _fuchsia950 ??
      (const Color.from(
        alpha: 1,
        red: 0.2938792688,
        green: 0.0014664057,
        blue: 0.3106185392,
        colorSpace: ColorSpace.extendedSRGB,
      )).withValues(colorSpace: ColorSpace.displayP3);
  Color get pink50 =>
      _pink50 ??
      (const Color.from(
        alpha: 1,
        red: 0.9913174731,
        green: 0.9486181425,
        blue: 0.9719057954,
        colorSpace: ColorSpace.extendedSRGB,
      )).withValues(colorSpace: ColorSpace.displayP3);
  Color get pink100 =>
      _pink100 ??
      (const Color.from(
        alpha: 1,
        red: 0.9886688337,
        green: 0.9052759845,
        blue: 0.9529445710,
        colorSpace: ColorSpace.extendedSRGB,
      )).withValues(colorSpace: ColorSpace.displayP3);
  Color get pink200 =>
      _pink200 ??
      (const Color.from(
        alpha: 1,
        red: 0.9876744348,
        green: 0.8090493193,
        blue: 0.9107282688,
        colorSpace: ColorSpace.extendedSRGB,
      )).withValues(colorSpace: ColorSpace.displayP3);
  Color get pink300 =>
      _pink300 ??
      (const Color.from(
        alpha: 1,
        red: 0.9940834170,
        green: 0.6464798662,
        blue: 0.8371420993,
        colorSpace: ColorSpace.extendedSRGB,
      )).withValues(colorSpace: ColorSpace.displayP3);
  Color get pink400 =>
      _pink400 ??
      (const Color.from(
        alpha: 1,
        red: 0.9856091038,
        green: 0.3920409275,
        blue: 0.7138619730,
        colorSpace: ColorSpace.extendedSRGB,
      )).withValues(colorSpace: ColorSpace.displayP3);
  Color get pink500 =>
      _pink500 ??
      (const Color.from(
        alpha: 1,
        red: 0.9658054492,
        green: 0.1981388052,
        blue: 0.6043243481,
        colorSpace: ColorSpace.extendedSRGB,
      )).withValues(colorSpace: ColorSpace.displayP3);
  Color get pink600 =>
      _pink600 ??
      (const Color.from(
        alpha: 1,
        red: 0.9013361401,
        green: -0.1146239857,
        blue: 0.4634100457,
        colorSpace: ColorSpace.extendedSRGB,
      )).withValues(colorSpace: ColorSpace.displayP3);
  Color get pink700 =>
      _pink700 ??
      (const Color.from(
        alpha: 1,
        red: 0.7777568234,
        green: -0.1153957016,
        blue: 0.3589229175,
        colorSpace: ColorSpace.extendedSRGB,
      )).withValues(colorSpace: ColorSpace.displayP3);
  Color get pink800 =>
      _pink800 ??
      (const Color.from(
        alpha: 1,
        red: 0.6386031554,
        green: -0.0168328710,
        blue: 0.2980438064,
        colorSpace: ColorSpace.extendedSRGB,
      )).withValues(colorSpace: ColorSpace.displayP3);
  Color get pink900 =>
      _pink900 ??
      (const Color.from(
        alpha: 1,
        red: 0.5251818465,
        green: 0.0632823566,
        blue: 0.2613339446,
        colorSpace: ColorSpace.extendedSRGB,
      )).withValues(colorSpace: ColorSpace.displayP3);
  Color get pink950 =>
      _pink950 ??
      (const Color.from(
        alpha: 1,
        red: 0.3180017375,
        green: 0.0150837033,
        blue: 0.1398192307,
        colorSpace: ColorSpace.extendedSRGB,
      )).withValues(colorSpace: ColorSpace.displayP3);
  Color get rose50 =>
      _rose50 ??
      (const Color.from(
        alpha: 1,
        red: 0.9990231292,
        green: 0.9447283625,
        blue: 0.9486036053,
        colorSpace: ColorSpace.extendedSRGB,
      )).withValues(colorSpace: ColorSpace.displayP3);
  Color get rose100 =>
      _rose100 ??
      (const Color.from(
        alpha: 1,
        red: 1.0000636638,
        green: 0.8934201642,
        blue: 0.9013286281,
        colorSpace: ColorSpace.extendedSRGB,
      )).withValues(colorSpace: ColorSpace.displayP3);
  Color get rose200 =>
      _rose200 ??
      (const Color.from(
        alpha: 1,
        red: 1.0002033589,
        green: 0.8011075744,
        blue: 0.8256557265,
        colorSpace: ColorSpace.extendedSRGB,
      )).withValues(colorSpace: ColorSpace.displayP3);
  Color get rose300 =>
      _rose300 ??
      (const Color.from(
        alpha: 1,
        red: 1.0139574139,
        green: 0.6299288075,
        blue: 0.6795160114,
        colorSpace: ColorSpace.extendedSRGB,
      )).withValues(colorSpace: ColorSpace.displayP3);
  Color get rose400 =>
      _rose400 ??
      (const Color.from(
        alpha: 1,
        red: 1.0160556754,
        green: 0.3888605448,
        blue: 0.4943315533,
        colorSpace: ColorSpace.extendedSRGB,
      )).withValues(colorSpace: ColorSpace.displayP3);
  Color get rose500 =>
      _rose500 ??
      (const Color.from(
        alpha: 1,
        red: 1.0033565834,
        green: 0.1246152078,
        blue: 0.3390032597,
        colorSpace: ColorSpace.extendedSRGB,
      )).withValues(colorSpace: ColorSpace.displayP3);
  Color get rose600 =>
      _rose600 ??
      (const Color.from(
        alpha: 1,
        red: 0.9273908944,
        green: -0.2356696268,
        blue: 0.2487091963,
        colorSpace: ColorSpace.extendedSRGB,
      )).withValues(colorSpace: ColorSpace.displayP3);
  Color get rose700 =>
      _rose700 ??
      (const Color.from(
        alpha: 1,
        red: 0.7785063817,
        green: -0.1607465912,
        blue: 0.2106962784,
        colorSpace: ColorSpace.extendedSRGB,
      )).withValues(colorSpace: ColorSpace.displayP3);
  Color get rose800 =>
      _rose800 ??
      (const Color.from(
        alpha: 1,
        red: 0.6466910169,
        green: -0.0469999588,
        blue: 0.2116679295,
        colorSpace: ColorSpace.extendedSRGB,
      )).withValues(colorSpace: ColorSpace.displayP3);
  Color get rose900 =>
      _rose900 ??
      (const Color.from(
        alpha: 1,
        red: 0.5445029075,
        green: 0.0300386732,
        blue: 0.2106989280,
        colorSpace: ColorSpace.extendedSRGB,
      )).withValues(colorSpace: ColorSpace.displayP3);
  Color get rose950 =>
      _rose950 ??
      (const Color.from(
        alpha: 1,
        red: 0.3031469649,
        green: 0.0088198226,
        blue: 0.0958587079,
        colorSpace: ColorSpace.extendedSRGB,
      )).withValues(colorSpace: ColorSpace.displayP3);
  Color get slate50 =>
      _slate50 ??
      (const Color.from(
        alpha: 1,
        red: 0.9731488523,
        green: 0.9800426054,
        blue: 0.9869375220,
        colorSpace: ColorSpace.extendedSRGB,
      )).withValues(colorSpace: ColorSpace.displayP3);
  Color get slate100 =>
      _slate100 ??
      (const Color.from(
        alpha: 1,
        red: 0.9444747091,
        green: 0.9604953703,
        blue: 0.9765152885,
        colorSpace: ColorSpace.extendedSRGB,
      )).withValues(colorSpace: ColorSpace.displayP3);
  Color get slate200 =>
      _slate200 ??
      (const Color.from(
        alpha: 1,
        red: 0.8859544006,
        green: 0.9101960349,
        blue: 0.9425160504,
        colorSpace: ColorSpace.extendedSRGB,
      )).withValues(colorSpace: ColorSpace.displayP3);
  Color get slate300 =>
      _slate300 ??
      (const Color.from(
        alpha: 1,
        red: 0.7923478775,
        green: 0.8358279493,
        blue: 0.8879724220,
        colorSpace: ColorSpace.extendedSRGB,
      )).withValues(colorSpace: ColorSpace.displayP3);
  Color get slate400 =>
      _slate400 ??
      (const Color.from(
        alpha: 1,
        red: 0.5648487376,
        green: 0.6316962756,
        blue: 0.7252391417,
        colorSpace: ColorSpace.extendedSRGB,
      )).withValues(colorSpace: ColorSpace.displayP3);
  Color get slate500 =>
      _slate500 ??
      (const Color.from(
        alpha: 1,
        red: 0.3839120696,
        green: 0.4547872205,
        blue: 0.5566604985,
        colorSpace: ColorSpace.extendedSRGB,
      )).withValues(colorSpace: ColorSpace.displayP3);
  Color get slate600 =>
      _slate600 ??
      (const Color.from(
        alpha: 1,
        red: 0.2709961620,
        green: 0.3340815478,
        blue: 0.4241887701,
        colorSpace: ColorSpace.extendedSRGB,
      )).withValues(colorSpace: ColorSpace.displayP3);
  Color get slate700 =>
      _slate700 ??
      (const Color.from(
        alpha: 1,
        red: 0.1935001365,
        green: 0.2552660384,
        blue: 0.3434872346,
        colorSpace: ColorSpace.extendedSRGB,
      )).withValues(colorSpace: ColorSpace.displayP3);
  Color get slate800 =>
      _slate800 ??
      (const Color.from(
        alpha: 1,
        red: 0.1121277119,
        green: 0.1600439839,
        blue: 0.2386724898,
        colorSpace: ColorSpace.extendedSRGB,
      )).withValues(colorSpace: ColorSpace.displayP3);
  Color get slate900 =>
      _slate900 ??
      (const Color.from(
        alpha: 1,
        red: 0.0571843254,
        green: 0.0900424642,
        blue: 0.1687959962,
        colorSpace: ColorSpace.extendedSRGB,
      )).withValues(colorSpace: ColorSpace.displayP3);
  Color get slate950 =>
      _slate950 ??
      (const Color.from(
        alpha: 1,
        red: 0.0074293218,
        green: 0.0232817487,
        blue: 0.0925050797,
        colorSpace: ColorSpace.extendedSRGB,
      )).withValues(colorSpace: ColorSpace.displayP3);
  Color get gray50 =>
      _gray50 ??
      (const Color.from(
        alpha: 1,
        red: 0.9763942293,
        green: 0.9809921702,
        blue: 0.9855895202,
        colorSpace: ColorSpace.extendedSRGB,
      )).withValues(colorSpace: ColorSpace.displayP3);
  Color get gray100 =>
      _gray100 ??
      (const Color.from(
        alpha: 1,
        red: 0.9528385021,
        green: 0.9569317557,
        blue: 0.9651184316,
        colorSpace: ColorSpace.extendedSRGB,
      )).withValues(colorSpace: ColorSpace.displayP3);
  Color get gray200 =>
      _gray200 ??
      (const Color.from(
        alpha: 1,
        red: 0.8983431379,
        green: 0.9064381730,
        blue: 0.9226285307,
        colorSpace: ColorSpace.extendedSRGB,
      )).withValues(colorSpace: ColorSpace.displayP3);
  Color get gray300 =>
      _gray300 ??
      (const Color.from(
        alpha: 1,
        red: 0.8190176743,
        green: 0.8358148740,
        blue: 0.8610087611,
        colorSpace: ColorSpace.extendedSRGB,
      )).withValues(colorSpace: ColorSpace.displayP3);
  Color get gray400 =>
      _gray400 ??
      (const Color.from(
        alpha: 1,
        red: 0.6000088100,
        green: 0.6313951762,
        blue: 0.6852225808,
        colorSpace: ColorSpace.extendedSRGB,
      )).withValues(colorSpace: ColorSpace.displayP3);
  Color get gray500 =>
      _gray500 ??
      (const Color.from(
        alpha: 1,
        red: 0.4154543466,
        green: 0.4470909705,
        blue: 0.5104967712,
        colorSpace: ColorSpace.extendedSRGB,
      )).withValues(colorSpace: ColorSpace.displayP3);
  Color get gray600 =>
      _gray600 ??
      (const Color.from(
        alpha: 1,
        red: 0.2888334540,
        green: 0.3335459243,
        blue: 0.3961163644,
        colorSpace: ColorSpace.extendedSRGB,
      )).withValues(colorSpace: ColorSpace.displayP3);
  Color get gray700 =>
      _gray700 ??
      (const Color.from(
        alpha: 1,
        red: 0.2115323322,
        green: 0.2550295884,
        blue: 0.3247052207,
        colorSpace: ColorSpace.extendedSRGB,
      )).withValues(colorSpace: ColorSpace.displayP3);
  Color get gray800 =>
      _gray800 ??
      (const Color.from(
        alpha: 1,
        red: 0.1169734968,
        green: 0.1607542754,
        blue: 0.2220155008,
        colorSpace: ColorSpace.extendedSRGB,
      )).withValues(colorSpace: ColorSpace.displayP3);
  Color get gray900 =>
      _gray900 ??
      (const Color.from(
        alpha: 1,
        red: 0.0645256287,
        green: 0.0937415897,
        blue: 0.1567844225,
        colorSpace: ColorSpace.extendedSRGB,
      )).withValues(colorSpace: ColorSpace.displayP3);
  Color get gray950 =>
      _gray950 ??
      (const Color.from(
        alpha: 1,
        red: 0.0115847274,
        green: 0.0276073314,
        blue: 0.0718757921,
        colorSpace: ColorSpace.extendedSRGB,
      )).withValues(colorSpace: ColorSpace.displayP3);
  Color get zinc50 =>
      _zinc50 ??
      (const Color.from(
        alpha: 1,
        red: 0.9802559799,
        green: 0.9802559799,
        blue: 0.9802559799,
        colorSpace: ColorSpace.extendedSRGB,
      )).withValues(colorSpace: ColorSpace.displayP3);
  Color get zinc100 =>
      _zinc100 ??
      (const Color.from(
        alpha: 1,
        red: 0.9563849497,
        green: 0.9563853274,
        blue: 0.9593429413,
        colorSpace: ColorSpace.extendedSRGB,
      )).withValues(colorSpace: ColorSpace.displayP3);
  Color get zinc200 =>
      _zinc200 ??
      (const Color.from(
        alpha: 1,
        red: 0.8944767221,
        green: 0.8944769094,
        blue: 0.9061506217,
        colorSpace: ColorSpace.extendedSRGB,
      )).withValues(colorSpace: ColorSpace.displayP3);
  Color get zinc300 =>
      _zinc300 ??
      (const Color.from(
        alpha: 1,
        red: 0.8310875324,
        green: 0.8310831942,
        blue: 0.8483446143,
        colorSpace: ColorSpace.extendedSRGB,
      )).withValues(colorSpace: ColorSpace.displayP3);
  Color get zinc400 =>
      _zinc400 ??
      (const Color.from(
        alpha: 1,
        red: 0.6226133261,
        green: 0.6225615600,
        blue: 0.6633595927,
        colorSpace: ColorSpace.extendedSRGB,
      )).withValues(colorSpace: ColorSpace.displayP3);
  Color get zinc500 =>
      _zinc500 ??
      (const Color.from(
        alpha: 1,
        red: 0.4429952046,
        green: 0.4429292160,
        blue: 0.4838042929,
        colorSpace: ColorSpace.extendedSRGB,
      )).withValues(colorSpace: ColorSpace.displayP3);
  Color get zinc600 =>
      _zinc600 ??
      (const Color.from(
        alpha: 1,
        red: 0.3211818620,
        green: 0.3210902015,
        blue: 0.3621075405,
        colorSpace: ColorSpace.extendedSRGB,
      )).withValues(colorSpace: ColorSpace.displayP3);
  Color get zinc700 =>
      _zinc700 ??
      (const Color.from(
        alpha: 1,
        red: 0.2464849040,
        green: 0.2464470670,
        blue: 0.2764649026,
        colorSpace: ColorSpace.extendedSRGB,
      )).withValues(colorSpace: ColorSpace.displayP3);
  Color get zinc800 =>
      _zinc800 ??
      (const Color.from(
        alpha: 1,
        red: 0.1528969165,
        green: 0.1528868480,
        blue: 0.1657702479,
        colorSpace: ColorSpace.extendedSRGB,
      )).withValues(colorSpace: ColorSpace.displayP3);
  Color get zinc900 =>
      _zinc900 ??
      (const Color.from(
        alpha: 1,
        red: 0.0937963913,
        green: 0.0937929169,
        blue: 0.1058316549,
        colorSpace: ColorSpace.extendedSRGB,
      )).withValues(colorSpace: ColorSpace.displayP3);
  Color get zinc950 =>
      _zinc950 ??
      (const Color.from(
        alpha: 1,
        red: 0.0353742610,
        green: 0.0353589996,
        blue: 0.0443181366,
        colorSpace: ColorSpace.extendedSRGB,
      )).withValues(colorSpace: ColorSpace.displayP3);
  Color get neutral50 => _neutral50 ?? const Color(0xFFFAFAFA);
  Color get neutral100 =>
      _neutral100 ??
      (const Color.from(
        alpha: 1,
        red: 0.9605869869,
        green: 0.9605869869,
        blue: 0.9605869869,
        colorSpace: ColorSpace.extendedSRGB,
      )).withValues(colorSpace: ColorSpace.displayP3);
  Color get neutral200 => _neutral200 ?? const Color(0xFFE5E5E5);
  Color get neutral300 =>
      _neutral300 ??
      (const Color.from(
        alpha: 1,
        red: 0.8314444503,
        green: 0.8314444503,
        blue: 0.8314444503,
        colorSpace: ColorSpace.extendedSRGB,
      )).withValues(colorSpace: ColorSpace.displayP3);
  Color get neutral400 =>
      _neutral400 ??
      (const Color.from(
        alpha: 1,
        red: 0.6301632043,
        green: 0.6301632043,
        blue: 0.6301632043,
        colorSpace: ColorSpace.extendedSRGB,
      )).withValues(colorSpace: ColorSpace.displayP3);
  Color get neutral500 => _neutral500 ?? const Color(0xFF737373);
  Color get neutral600 => _neutral600 ?? const Color(0xFF525252);
  Color get neutral700 =>
      _neutral700 ??
      (const Color.from(
        alpha: 1,
        red: 0.2504709015,
        green: 0.2504709015,
        blue: 0.2504709015,
        colorSpace: ColorSpace.extendedSRGB,
      )).withValues(colorSpace: ColorSpace.displayP3);
  Color get neutral800 =>
      _neutral800 ??
      (const Color.from(
        alpha: 1,
        red: 0.1493820776,
        green: 0.1493820776,
        blue: 0.1493820776,
        colorSpace: ColorSpace.extendedSRGB,
      )).withValues(colorSpace: ColorSpace.displayP3);
  Color get neutral900 => _neutral900 ?? const Color(0xFF171717);
  Color get neutral950 =>
      _neutral950 ??
      (const Color.from(
        alpha: 1,
        red: 0.0393882350,
        green: 0.0393882350,
        blue: 0.0393882350,
        colorSpace: ColorSpace.extendedSRGB,
      )).withValues(colorSpace: ColorSpace.displayP3);
  Color get stone50 =>
      _stone50 ??
      (const Color.from(
        alpha: 1,
        red: 0.9805331813,
        green: 0.9805335063,
        blue: 0.9775605365,
        colorSpace: ColorSpace.extendedSRGB,
      )).withValues(colorSpace: ColorSpace.displayP3);
  Color get stone100 =>
      _stone100 ??
      (const Color.from(
        alpha: 1,
        red: 0.9608630861,
        green: 0.9608634557,
        blue: 0.9579018561,
        colorSpace: ColorSpace.extendedSRGB,
      )).withValues(colorSpace: ColorSpace.displayP3);
  Color get stone200 =>
      _stone200 ??
      (const Color.from(
        alpha: 1,
        red: 0.9067104284,
        green: 0.8975317470,
        blue: 0.8929412664,
        colorSpace: ColorSpace.extendedSRGB,
      )).withValues(colorSpace: ColorSpace.displayP3);
  Color get stone300 =>
      _stone300 ??
      (const Color.from(
        alpha: 1,
        red: 0.8411658168,
        green: 0.8275092270,
        blue: 0.8184011122,
        colorSpace: ColorSpace.extendedSRGB,
      )).withValues(colorSpace: ColorSpace.displayP3);
  Color get stone400 =>
      _stone400 ??
      (const Color.from(
        alpha: 1,
        red: 0.6521305634,
        green: 0.6262227268,
        blue: 0.6089382264,
        colorSpace: ColorSpace.extendedSRGB,
      )).withValues(colorSpace: ColorSpace.displayP3);
  Color get stone500 =>
      _stone500 ??
      (const Color.from(
        alpha: 1,
        red: 0.4727141789,
        green: 0.4420021518,
        blue: 0.4200373004,
        colorSpace: ColorSpace.extendedSRGB,
      )).withValues(colorSpace: ColorSpace.displayP3);
  Color get stone600 =>
      _stone600 ??
      (const Color.from(
        alpha: 1,
        red: 0.3426504712,
        green: 0.3246754253,
        blue: 0.3021830555,
        colorSpace: ColorSpace.extendedSRGB,
      )).withValues(colorSpace: ColorSpace.displayP3);
  Color get stone700 =>
      _stone700 ??
      (const Color.from(
        alpha: 1,
        red: 0.2684879733,
        green: 0.2504235022,
        blue: 0.2323311942,
        colorSpace: ColorSpace.extendedSRGB,
      )).withValues(colorSpace: ColorSpace.displayP3);
  Color get stone800 =>
      _stone800 ??
      (const Color.from(
        alpha: 1,
        red: 0.1616239750,
        green: 0.1441947918,
        blue: 0.1398376556,
        colorSpace: ColorSpace.extendedSRGB,
      )).withValues(colorSpace: ColorSpace.displayP3);
  Color get stone900 =>
      _stone900 ??
      (const Color.from(
        alpha: 1,
        red: 0.1095120705,
        green: 0.0979876801,
        blue: 0.0903069949,
        colorSpace: ColorSpace.extendedSRGB,
      )).withValues(colorSpace: ColorSpace.displayP3);
  Color get stone950 =>
      _stone950 ??
      (const Color.from(
        alpha: 1,
        red: 0.0469592124,
        green: 0.0393561117,
        blue: 0.0355444840,
        colorSpace: ColorSpace.extendedSRGB,
      )).withValues(colorSpace: ColorSpace.displayP3);
  Color get mauve50 =>
      _mauve50 ??
      (const Color.from(
        alpha: 1,
        red: 0.9802559799,
        green: 0.9802559799,
        blue: 0.9802559799,
        colorSpace: ColorSpace.extendedSRGB,
      )).withValues(colorSpace: ColorSpace.displayP3);
  Color get mauve100 =>
      _mauve100 ??
      (const Color.from(
        alpha: 1,
        red: 0.9520339179,
        green: 0.9450931125,
        blue: 0.9520338483,
        colorSpace: ColorSpace.extendedSRGB,
      )).withValues(colorSpace: ColorSpace.displayP3);
  Color get mauve200 =>
      _mauve200 ??
      (const Color.from(
        alpha: 1,
        red: 0.9056048019,
        green: 0.8941535228,
        blue: 0.9056035858,
        colorSpace: ColorSpace.extendedSRGB,
      )).withValues(colorSpace: ColorSpace.displayP3);
  Color get mauve300 =>
      _mauve300 ??
      (const Color.from(
        alpha: 1,
        red: 0.8425781034,
        green: 0.8155398346,
        blue: 0.8425781645,
        colorSpace: ColorSpace.extendedSRGB,
      )).withValues(colorSpace: ColorSpace.displayP3);
  Color get mauve400 =>
      _mauve400 ??
      (const Color.from(
        alpha: 1,
        red: 0.6581094823,
        green: 0.6197160507,
        blue: 0.6619483195,
        colorSpace: ColorSpace.extendedSRGB,
      )).withValues(colorSpace: ColorSpace.displayP3);
  Color get mauve500 =>
      _mauve500 ??
      (const Color.from(
        alpha: 1,
        red: 0.4747966612,
        green: 0.4114503049,
        blue: 0.4827284447,
        colorSpace: ColorSpace.extendedSRGB,
      )).withValues(colorSpace: ColorSpace.displayP3);
  Color get mauve600 =>
      _mauve600 ??
      (const Color.from(
        alpha: 1,
        red: 0.3486132551,
        green: 0.2982944435,
        blue: 0.3563410307,
        colorSpace: ColorSpace.extendedSRGB,
      )).withValues(colorSpace: ColorSpace.displayP3);
  Color get mauve700 =>
      _mauve700 ??
      (const Color.from(
        alpha: 1,
        red: 0.2743740330,
        green: 0.2239768897,
        blue: 0.2782339379,
        colorSpace: ColorSpace.extendedSRGB,
      )).withValues(colorSpace: ColorSpace.displayP3);
  Color get mauve800 =>
      _mauve800 ??
      (const Color.from(
        alpha: 1,
        red: 0.1648955652,
        green: 0.1295056839,
        blue: 0.1727632888,
        colorSpace: ColorSpace.extendedSRGB,
      )).withValues(colorSpace: ColorSpace.displayP3);
  Color get mauve900 =>
      _mauve900 ??
      (const Color.from(
        alpha: 1,
        red: 0.1136310947,
        green: 0.0858502946,
        blue: 0.1175988153,
        colorSpace: ColorSpace.extendedSRGB,
      )).withValues(colorSpace: ColorSpace.displayP3);
  Color get mauve950 =>
      _mauve950 ??
      (const Color.from(
        alpha: 1,
        red: 0.0467017379,
        green: 0.0352761328,
        blue: 0.0466943714,
        colorSpace: ColorSpace.extendedSRGB,
      )).withValues(colorSpace: ColorSpace.displayP3);
  Color get olive50 =>
      _olive50 ??
      (const Color.from(
        alpha: 1,
        red: 0.9850226353,
        green: 0.9850314473,
        blue: 0.9761005760,
        colorSpace: ColorSpace.extendedSRGB,
      )).withValues(colorSpace: ColorSpace.displayP3);
  Color get olive100 =>
      _olive100 ??
      (const Color.from(
        alpha: 1,
        red: 0.9567246954,
        green: 0.9567269909,
        blue: 0.9419166744,
        colorSpace: ColorSpace.extendedSRGB,
      )).withValues(colorSpace: ColorSpace.displayP3);
  Color get olive200 =>
      _olive200 ??
      (const Color.from(
        alpha: 1,
        red: 0.9104167537,
        green: 0.9104012447,
        blue: 0.8898484497,
        colorSpace: ColorSpace.extendedSRGB,
      )).withValues(colorSpace: ColorSpace.displayP3);
  Color get olive300 =>
      _olive300 ??
      (const Color.from(
        alpha: 1,
        red: 0.8471263326,
        green: 0.8471101557,
        blue: 0.8152063561,
        colorSpace: ColorSpace.extendedSRGB,
      )).withValues(colorSpace: ColorSpace.displayP3);
  Color get olive400 =>
      _olive400 ??
      (const Color.from(
        alpha: 1,
        red: 0.6706212497,
        green: 0.6706162776,
        blue: 0.6120181093,
        colorSpace: ColorSpace.extendedSRGB,
      )).withValues(colorSpace: ColorSpace.displayP3);
  Color get olive500 =>
      _olive500 ??
      (const Color.from(
        alpha: 1,
        red: 0.4859872467,
        green: 0.4859375951,
        blue: 0.4035425730,
        colorSpace: ColorSpace.extendedSRGB,
      )).withValues(colorSpace: ColorSpace.displayP3);
  Color get olive600 =>
      _olive600 ??
      (const Color.from(
        alpha: 1,
        red: 0.3565354003,
        green: 0.3564930381,
        blue: 0.2935766041,
        colorSpace: ColorSpace.extendedSRGB,
      )).withValues(colorSpace: ColorSpace.displayP3);
  Color get olive700 =>
      _olive700 ??
      (const Color.from(
        alpha: 1,
        red: 0.2789824355,
        green: 0.2789702280,
        blue: 0.2233263775,
        colorSpace: ColorSpace.extendedSRGB,
      )).withValues(colorSpace: ColorSpace.displayP3);
  Color get olive800 =>
      _olive800 ??
      (const Color.from(
        alpha: 1,
        red: 0.1686330028,
        green: 0.1686556998,
        blue: 0.1329734414,
        colorSpace: ColorSpace.extendedSRGB,
      )).withValues(colorSpace: ColorSpace.displayP3);
  Color get olive900 =>
      _olive900 ??
      (const Color.from(
        alpha: 1,
        red: 0.1135070625,
        green: 0.1135141279,
        blue: 0.0861034662,
        colorSpace: ColorSpace.extendedSRGB,
      )).withValues(colorSpace: ColorSpace.displayP3);
  Color get olive950 =>
      _olive950 ??
      (const Color.from(
        alpha: 1,
        red: 0.0469361299,
        green: 0.0469389788,
        blue: 0.0356796701,
        colorSpace: ColorSpace.extendedSRGB,
      )).withValues(colorSpace: ColorSpace.displayP3);
  Color get mist50 =>
      _mist50 ??
      (const Color.from(
        alpha: 1,
        red: 0.9773699180,
        green: 0.9847586454,
        blue: 0.9847560181,
        colorSpace: ColorSpace.extendedSRGB,
      )).withValues(colorSpace: ColorSpace.displayP3);
  Color get mist100 =>
      _mist100 ??
      (const Color.from(
        alpha: 1,
        red: 0.9459531881,
        green: 0.9532968926,
        blue: 0.9532943663,
        colorSpace: ColorSpace.extendedSRGB,
      )).withValues(colorSpace: ColorSpace.displayP3);
  Color get mist200 =>
      _mist200 ??
      (const Color.from(
        alpha: 1,
        red: 0.8886658024,
        green: 0.9060047185,
        blue: 0.9103311602,
        colorSpace: ColorSpace.extendedSRGB,
      )).withValues(colorSpace: ColorSpace.displayP3);
  Color get mist300 =>
      _mist300 ??
      (const Color.from(
        alpha: 1,
        red: 0.8159321561,
        green: 0.8390741748,
        blue: 0.8468008513,
        colorSpace: ColorSpace.extendedSRGB,
      )).withValues(colorSpace: ColorSpace.displayP3);
  Color get mist400 =>
      _mist400 ??
      (const Color.from(
        alpha: 1,
        red: 0.6124490120,
        green: 0.6586060591,
        blue: 0.6701579981,
        colorSpace: ColorSpace.extendedSRGB,
      )).withValues(colorSpace: ColorSpace.displayP3);
  Color get mist500 =>
      _mist500 ??
      (const Color.from(
        alpha: 1,
        red: 0.4038991948,
        green: 0.4703440147,
        blue: 0.4859760104,
        colorSpace: ColorSpace.extendedSRGB,
      )).withValues(colorSpace: ColorSpace.displayP3);
  Color get mist600 =>
      _mist600 ??
      (const Color.from(
        alpha: 1,
        red: 0.2937794487,
        green: 0.3448076429,
        blue: 0.3565854013,
        colorSpace: ColorSpace.extendedSRGB,
      )).withValues(colorSpace: ColorSpace.displayP3);
  Color get mist700 =>
      _mist700 ??
      (const Color.from(
        alpha: 1,
        red: 0.2241550164,
        green: 0.2666136480,
        blue: 0.2781831284,
        colorSpace: ColorSpace.extendedSRGB,
      )).withValues(colorSpace: ColorSpace.displayP3);
  Color get mist800 =>
      _mist800 ??
      (const Color.from(
        alpha: 1,
        red: 0.1324720715,
        green: 0.1610622582,
        blue: 0.1692452047,
        colorSpace: ColorSpace.extendedSRGB,
      )).withValues(colorSpace: ColorSpace.displayP3);
  Color get mist900 =>
      _mist900 ??
      (const Color.from(
        alpha: 1,
        red: 0.0873791734,
        green: 0.1058366581,
        blue: 0.1132393621,
        colorSpace: ColorSpace.extendedSRGB,
      )).withValues(colorSpace: ColorSpace.displayP3);
  Color get mist950 =>
      _mist950 ??
      (const Color.from(
        alpha: 1,
        red: 0.0355946865,
        green: 0.0433893321,
        blue: 0.0472846673,
        colorSpace: ColorSpace.extendedSRGB,
      )).withValues(colorSpace: ColorSpace.displayP3);
  Color get taupe50 =>
      _taupe50 ??
      (const Color.from(
        alpha: 1,
        red: 0.9854239134,
        green: 0.9808246800,
        blue: 0.9762252936,
        colorSpace: ColorSpace.extendedSRGB,
      )).withValues(colorSpace: ColorSpace.displayP3);
  Color get taupe100 =>
      _taupe100 ??
      (const Color.from(
        alpha: 1,
        red: 0.9529609749,
        green: 0.9456480993,
        blue: 0.9456473297,
        colorSpace: ColorSpace.extendedSRGB,
      )).withValues(colorSpace: ColorSpace.displayP3);
  Color get taupe200 =>
      _taupe200 ??
      (const Color.from(
        alpha: 1,
        red: 0.9113293179,
        green: 0.8941443304,
        blue: 0.8898502243,
        colorSpace: ColorSpace.extendedSRGB,
      )).withValues(colorSpace: ColorSpace.displayP3);
  Color get taupe300 =>
      _taupe300 ??
      (const Color.from(
        alpha: 1,
        red: 0.8465771556,
        green: 0.8237039404,
        blue: 0.8160627691,
        colorSpace: ColorSpace.extendedSRGB,
      )).withValues(colorSpace: ColorSpace.displayP3);
  Color get taupe400 =>
      _taupe400 ??
      (const Color.from(
        alpha: 1,
        red: 0.6703284276,
        green: 0.6276249463,
        blue: 0.6120686637,
        colorSpace: ColorSpace.extendedSRGB,
      )).withValues(colorSpace: ColorSpace.displayP3);
  Color get taupe500 =>
      _taupe500 ??
      (const Color.from(
        alpha: 1,
        red: 0.4860066702,
        green: 0.4275667382,
        blue: 0.4041763266,
        colorSpace: ColorSpace.extendedSRGB,
      )).withValues(colorSpace: ColorSpace.displayP3);
  Color get taupe600 =>
      _taupe600 ??
      (const Color.from(
        alpha: 1,
        red: 0.3558764773,
        green: 0.3098052956,
        blue: 0.2944619278,
        colorSpace: ColorSpace.extendedSRGB,
      )).withValues(colorSpace: ColorSpace.displayP3);
  Color get taupe700 =>
      _taupe700 ??
      (const Color.from(
        alpha: 1,
        red: 0.2781685548,
        green: 0.2358151925,
        blue: 0.2242711508,
        colorSpace: ColorSpace.extendedSRGB,
      )).withValues(colorSpace: ColorSpace.displayP3);
  Color get taupe800 =>
      _taupe800 ??
      (const Color.from(
        alpha: 1,
        red: 0.1686417924,
        green: 0.1418180776,
        blue: 0.1341517386,
        colorSpace: ColorSpace.extendedSRGB,
      )).withValues(colorSpace: ColorSpace.displayP3);
  Color get taupe900 =>
      _taupe900 ??
      (const Color.from(
        alpha: 1,
        red: 0.1136555486,
        green: 0.0938806296,
        blue: 0.0859572156,
        colorSpace: ColorSpace.extendedSRGB,
      )).withValues(colorSpace: ColorSpace.displayP3);
  Color get taupe950 =>
      _taupe950 ??
      (const Color.from(
        alpha: 1,
        red: 0.0469566948,
        green: 0.0393577379,
        blue: 0.0355407548,
        colorSpace: ColorSpace.extendedSRGB,
      )).withValues(colorSpace: ColorSpace.displayP3);
  Color get black => _black ?? const Color(0xFF000000);
  Color get white => _white ?? const Color(0xFFFFFFFF);
  Color get transparent =>
      _transparent ??
      const Color.from(alpha: 0, red: 0 / 255, green: 0 / 255, blue: 0 / 255);
  Color get alphaWhite =>
      _alphaWhite ??
      (dark
          ? const Color.from(
              alpha: 1,
              red: 12 / 255,
              green: 14 / 255,
              blue: 18 / 255,
            )
          : const Color.from(
              alpha: 1,
              red: 255 / 255,
              green: 255 / 255,
              blue: 255 / 255,
            ));
  Color get alphaBlack =>
      _alphaBlack ??
      (dark
          ? const Color.from(
              alpha: 1,
              red: 255 / 255,
              green: 255 / 255,
              blue: 255 / 255,
            )
          : const Color.from(
              alpha: 1,
              red: 0 / 255,
              green: 0 / 255,
              blue: 0 / 255,
            ));
  Color get brand50 => _brand50 ?? const Color(0xFFFFFBE9);
  Color get brand100 => _brand100 ?? const Color(0xFFFFF3C2);
  Color get brand200 => _brand200 ?? const Color(0xFFFFE57B);
  Color get brand300 => _brand300 ?? const Color(0xFFFFD11B);
  Color get brand400 => _brand400 ?? const Color(0xFFFFBC00);
  Color get brand500 => _brand500 ?? const Color(0xFFFF9900);
  Color get brand600 => _brand600 ?? const Color(0xFFE87000);
  Color get brand700 => _brand700 ?? const Color(0xFFC24B00);
  Color get brand800 => _brand800 ?? const Color(0xFF9E3900);
  Color get brand900 => _brand900 ?? const Color(0xFF823000);
  Color get brand950 => _brand950 ?? const Color(0xFF4B1600);
  Color get utilityBlue50 => _utilityBlue50 ?? (dark ? blue950 : blue50);
  Color get utilityBlue100 => _utilityBlue100 ?? (dark ? blue900 : blue100);
  Color get utilityBlue200 => _utilityBlue200 ?? (dark ? blue800 : blue200);
  Color get utilityBlue300 => _utilityBlue300 ?? (dark ? blue700 : blue300);
  Color get utilityBlue400 => _utilityBlue400 ?? (dark ? blue600 : blue400);
  Color get utilityBlue500 => _utilityBlue500 ?? blue500;
  Color get utilityBlue600 => _utilityBlue600 ?? (dark ? blue400 : blue600);
  Color get utilityBlue700 => _utilityBlue700 ?? (dark ? blue300 : blue700);
  Color get utilityBrand50 => _utilityBrand50 ?? (dark ? brand950 : brand50);
  Color get utilityBrand50Alt =>
      _utilityBrand50Alt ?? (dark ? utilityNeutral50 : brand50);
  Color get utilityBrand100 => _utilityBrand100 ?? (dark ? brand900 : brand100);
  Color get utilityBrand100Alt =>
      _utilityBrand100Alt ?? (dark ? utilityNeutral100 : brand100);
  Color get utilityBrand200 => _utilityBrand200 ?? (dark ? brand800 : brand200);
  Color get utilityBrand200Alt =>
      _utilityBrand200Alt ?? (dark ? utilityNeutral200 : brand200);
  Color get utilityBrand300 => _utilityBrand300 ?? (dark ? brand700 : brand300);
  Color get utilityBrand300Alt =>
      _utilityBrand300Alt ?? (dark ? utilityNeutral300 : brand300);
  Color get utilityBrand400 => _utilityBrand400 ?? (dark ? brand600 : brand400);
  Color get utilityBrand400Alt =>
      _utilityBrand400Alt ?? (dark ? utilityNeutral400 : brand400);
  Color get utilityBrand500 => _utilityBrand500 ?? brand500;
  Color get utilityBrand500Alt =>
      _utilityBrand500Alt ?? (dark ? utilityNeutral500 : brand500);
  Color get utilityBrand600 => _utilityBrand600 ?? (dark ? brand400 : brand600);
  Color get utilityBrand600Alt =>
      _utilityBrand600Alt ?? (dark ? utilityNeutral600 : brand600);
  Color get utilityBrand700 => _utilityBrand700 ?? (dark ? brand300 : brand700);
  Color get utilityBrand700Alt =>
      _utilityBrand700Alt ?? (dark ? utilityNeutral700 : brand700);
  Color get utilityBrand800 => _utilityBrand800 ?? (dark ? brand200 : brand800);
  Color get utilityBrand800Alt =>
      _utilityBrand800Alt ?? (dark ? utilityNeutral800 : brand800);
  Color get utilityBrand900 => _utilityBrand900 ?? (dark ? brand100 : brand900);
  Color get utilityBrand900Alt =>
      _utilityBrand900Alt ?? (dark ? utilityNeutral900 : brand900);
  Color get utilityNeutral50 =>
      _utilityNeutral50 ?? (dark ? neutral900 : neutral50);
  Color get utilityNeutral100 =>
      _utilityNeutral100 ?? (dark ? neutral800 : neutral100);
  Color get utilityNeutral200 =>
      _utilityNeutral200 ?? (dark ? neutral700 : neutral200);
  Color get utilityNeutral300 =>
      _utilityNeutral300 ?? (dark ? neutral700 : neutral300);
  Color get utilityNeutral400 =>
      _utilityNeutral400 ?? (dark ? neutral600 : neutral400);
  Color get utilityNeutral500 => _utilityNeutral500 ?? neutral500;
  Color get utilityNeutral600 =>
      _utilityNeutral600 ?? (dark ? neutral400 : neutral600);
  Color get utilityNeutral700 =>
      _utilityNeutral700 ?? (dark ? neutral300 : neutral700);
  Color get utilityNeutral800 =>
      _utilityNeutral800 ?? (dark ? neutral200 : neutral800);
  Color get utilityNeutral900 =>
      _utilityNeutral900 ?? (dark ? neutral100 : neutral900);
  Color get utilityRed50 => _utilityRed50 ?? (dark ? red950 : red50);
  Color get utilityRed100 => _utilityRed100 ?? (dark ? red900 : red100);
  Color get utilityRed200 => _utilityRed200 ?? (dark ? red800 : red200);
  Color get utilityRed300 => _utilityRed300 ?? (dark ? red700 : red300);
  Color get utilityRed400 => _utilityRed400 ?? (dark ? red600 : red400);
  Color get utilityRed500 => _utilityRed500 ?? red500;
  Color get utilityRed600 => _utilityRed600 ?? (dark ? red400 : red600);
  Color get utilityRed700 => _utilityRed700 ?? (dark ? red300 : red700);
  Color get utilityYellow50 =>
      _utilityYellow50 ?? (dark ? yellow950 : yellow50);
  Color get utilityYellow100 =>
      _utilityYellow100 ?? (dark ? yellow900 : yellow100);
  Color get utilityYellow200 =>
      _utilityYellow200 ?? (dark ? yellow800 : yellow200);
  Color get utilityYellow300 =>
      _utilityYellow300 ?? (dark ? yellow700 : yellow300);
  Color get utilityYellow400 =>
      _utilityYellow400 ?? (dark ? yellow600 : yellow400);
  Color get utilityYellow500 => _utilityYellow500 ?? yellow500;
  Color get utilityYellow600 =>
      _utilityYellow600 ?? (dark ? yellow400 : yellow600);
  Color get utilityYellow700 =>
      _utilityYellow700 ?? (dark ? yellow300 : yellow700);
  Color get utilityGreen50 => _utilityGreen50 ?? (dark ? green950 : green50);
  Color get utilityGreen100 => _utilityGreen100 ?? (dark ? green900 : green100);
  Color get utilityGreen200 => _utilityGreen200 ?? (dark ? green800 : green200);
  Color get utilityGreen300 => _utilityGreen300 ?? (dark ? green700 : green300);
  Color get utilityGreen400 => _utilityGreen400 ?? (dark ? green600 : green400);
  Color get utilityGreen500 => _utilityGreen500 ?? green500;
  Color get utilityGreen600 => _utilityGreen600 ?? (dark ? green400 : green600);
  Color get utilityGreen700 => _utilityGreen700 ?? (dark ? green300 : green700);
  Color get utilityOrange50 =>
      _utilityOrange50 ?? (dark ? orange950 : orange50);
  Color get utilityOrange100 =>
      _utilityOrange100 ?? (dark ? orange900 : orange100);
  Color get utilityOrange200 =>
      _utilityOrange200 ?? (dark ? orange800 : orange200);
  Color get utilityOrange300 =>
      _utilityOrange300 ?? (dark ? orange700 : orange300);
  Color get utilityOrange400 =>
      _utilityOrange400 ?? (dark ? orange600 : orange400);
  Color get utilityOrange500 => _utilityOrange500 ?? orange500;
  Color get utilityOrange600 =>
      _utilityOrange600 ?? (dark ? orange400 : orange600);
  Color get utilityOrange700 =>
      _utilityOrange700 ?? (dark ? orange300 : orange700);
  Color get utilityIndigo50 =>
      _utilityIndigo50 ?? (dark ? indigo950 : indigo50);
  Color get utilityIndigo100 =>
      _utilityIndigo100 ?? (dark ? indigo900 : indigo100);
  Color get utilityIndigo200 =>
      _utilityIndigo200 ?? (dark ? indigo800 : indigo200);
  Color get utilityIndigo300 =>
      _utilityIndigo300 ?? (dark ? indigo700 : indigo300);
  Color get utilityIndigo400 =>
      _utilityIndigo400 ?? (dark ? indigo600 : indigo400);
  Color get utilityIndigo500 => _utilityIndigo500 ?? indigo500;
  Color get utilityIndigo600 =>
      _utilityIndigo600 ?? (dark ? indigo400 : indigo600);
  Color get utilityIndigo700 =>
      _utilityIndigo700 ?? (dark ? indigo300 : indigo700);
  Color get utilityFuchsia50 =>
      _utilityFuchsia50 ?? (dark ? fuchsia950 : fuchsia50);
  Color get utilityFuchsia100 =>
      _utilityFuchsia100 ?? (dark ? fuchsia900 : fuchsia100);
  Color get utilityFuchsia200 =>
      _utilityFuchsia200 ?? (dark ? fuchsia800 : fuchsia200);
  Color get utilityFuchsia300 =>
      _utilityFuchsia300 ?? (dark ? fuchsia700 : fuchsia300);
  Color get utilityFuchsia400 =>
      _utilityFuchsia400 ?? (dark ? fuchsia600 : fuchsia400);
  Color get utilityFuchsia500 => _utilityFuchsia500 ?? fuchsia500;
  Color get utilityFuchsia600 =>
      _utilityFuchsia600 ?? (dark ? fuchsia400 : fuchsia600);
  Color get utilityFuchsia700 =>
      _utilityFuchsia700 ?? (dark ? fuchsia300 : fuchsia700);
  Color get utilityPink50 => _utilityPink50 ?? (dark ? pink950 : pink50);
  Color get utilityPink100 => _utilityPink100 ?? (dark ? pink900 : pink100);
  Color get utilityPink200 => _utilityPink200 ?? (dark ? pink800 : pink200);
  Color get utilityPink300 => _utilityPink300 ?? (dark ? pink700 : pink300);
  Color get utilityPink400 => _utilityPink400 ?? (dark ? pink600 : pink400);
  Color get utilityPink500 => _utilityPink500 ?? pink500;
  Color get utilityPink600 => _utilityPink600 ?? (dark ? pink400 : pink600);
  Color get utilityPink700 => _utilityPink700 ?? (dark ? pink300 : pink700);
  Color get utilityPurple50 =>
      _utilityPurple50 ?? (dark ? purple950 : purple50);
  Color get utilityPurple100 =>
      _utilityPurple100 ?? (dark ? purple900 : purple100);
  Color get utilityPurple200 =>
      _utilityPurple200 ?? (dark ? purple800 : purple200);
  Color get utilityPurple300 =>
      _utilityPurple300 ?? (dark ? purple700 : purple300);
  Color get utilityPurple400 =>
      _utilityPurple400 ?? (dark ? purple600 : purple400);
  Color get utilityPurple500 => _utilityPurple500 ?? purple500;
  Color get utilityPurple600 =>
      _utilityPurple600 ?? (dark ? purple400 : purple600);
  Color get utilityPurple700 =>
      _utilityPurple700 ?? (dark ? purple300 : purple700);
  Color get utilitySky50 => _utilitySky50 ?? (dark ? sky950 : sky50);
  Color get utilitySky100 => _utilitySky100 ?? (dark ? sky900 : sky100);
  Color get utilitySky200 => _utilitySky200 ?? (dark ? sky800 : sky200);
  Color get utilitySky300 => _utilitySky300 ?? (dark ? sky700 : sky300);
  Color get utilitySky400 => _utilitySky400 ?? (dark ? sky600 : sky400);
  Color get utilitySky500 => _utilitySky500 ?? sky500;
  Color get utilitySky600 => _utilitySky600 ?? (dark ? sky400 : sky600);
  Color get utilitySky700 => _utilitySky700 ?? (dark ? sky300 : sky700);
  Color get utilitySlate50 => _utilitySlate50 ?? (dark ? slate950 : slate50);
  Color get utilitySlate100 => _utilitySlate100 ?? (dark ? slate900 : slate100);
  Color get utilitySlate200 => _utilitySlate200 ?? (dark ? slate800 : slate200);
  Color get utilitySlate300 => _utilitySlate300 ?? (dark ? slate700 : slate300);
  Color get utilitySlate400 => _utilitySlate400 ?? (dark ? slate600 : slate400);
  Color get utilitySlate500 => _utilitySlate500 ?? slate500;
  Color get utilitySlate600 => _utilitySlate600 ?? (dark ? slate400 : slate600);
  Color get utilitySlate700 => _utilitySlate700 ?? (dark ? slate300 : slate700);
  Color get utilityEmerald50 =>
      _utilityEmerald50 ?? (dark ? emerald950 : emerald50);
  Color get utilityEmerald100 =>
      _utilityEmerald100 ?? (dark ? emerald900 : emerald100);
  Color get utilityEmerald200 =>
      _utilityEmerald200 ?? (dark ? emerald800 : emerald200);
  Color get utilityEmerald300 =>
      _utilityEmerald300 ?? (dark ? emerald700 : emerald300);
  Color get utilityEmerald400 =>
      _utilityEmerald400 ?? (dark ? emerald600 : emerald400);
  Color get utilityEmerald500 => _utilityEmerald500 ?? emerald500;
  Color get utilityEmerald600 =>
      _utilityEmerald600 ?? (dark ? emerald400 : emerald600);
  Color get utilityEmerald700 =>
      _utilityEmerald700 ?? (dark ? emerald300 : emerald700);
  Color get utilityAmber50 => _utilityAmber50 ?? (dark ? amber950 : amber50);
  Color get utilityAmber100 => _utilityAmber100 ?? (dark ? amber900 : amber100);
  Color get utilityAmber200 => _utilityAmber200 ?? (dark ? amber800 : amber200);
  Color get utilityAmber300 => _utilityAmber300 ?? (dark ? amber700 : amber300);
  Color get utilityAmber400 => _utilityAmber400 ?? (dark ? amber600 : amber400);
  Color get utilityAmber500 => _utilityAmber500 ?? amber500;
  Color get utilityAmber600 => _utilityAmber600 ?? (dark ? amber400 : amber600);
  Color get utilityAmber700 => _utilityAmber700 ?? (dark ? amber300 : amber700);
  Color get textPrimary => _textPrimary ?? (dark ? neutral50 : neutral900);
  Color get textTertiary => _textTertiary ?? (dark ? neutral400 : neutral600);
  Color get textErrorPrimary => _textErrorPrimary ?? (dark ? red400 : red600);
  Color get textWarningPrimary =>
      _textWarningPrimary ?? (dark ? yellow400 : yellow600);
  Color get textSuccessPrimary =>
      _textSuccessPrimary ?? (dark ? green400 : green600);
  Color get textSecondary =>
      _textSecondary ?? (dark ? neutral300 : grayModern700);
  Color get textSecondaryHover =>
      _textSecondaryHover ?? (dark ? neutral200 : grayModern800);
  Color get textTertiaryHover =>
      _textTertiaryHover ?? (dark ? neutral300 : neutral700);
  Color get textBrandSecondary =>
      _textBrandSecondary ?? (dark ? neutral300 : brand700);
  Color get textPlaceholder => _textPlaceholder ?? neutral500;
  Color get textBrandTertiary =>
      _textBrandTertiary ?? (dark ? neutral400 : brand600);
  Color get textEditorIconFg => _textEditorIconFg ?? neutral400;
  Color get textEditorIconFgActive =>
      _textEditorIconFgActive ?? (dark ? white : neutral500);
  Color get textQuaternary =>
      _textQuaternary ?? (dark ? neutral400 : neutral500);
  Color get textBrandPrimary =>
      _textBrandPrimary ?? (dark ? neutral50 : brand900);
  Color get textPrimaryOnBrand =>
      _textPrimaryOnBrand ?? (dark ? neutral50 : white);
  Color get textSecondaryOnBrand =>
      _textSecondaryOnBrand ?? (dark ? neutral300 : brand200);
  Color get textTertiaryOnBrand =>
      _textTertiaryOnBrand ?? (dark ? neutral400 : brand200);
  Color get textQuaternaryOnBrand =>
      _textQuaternaryOnBrand ?? (dark ? neutral400 : brand300);
  Color get textBrandTertiaryAlt =>
      _textBrandTertiaryAlt ?? (dark ? neutral50 : brand600);
  Color get textErrorPrimaryHover =>
      _textErrorPrimaryHover ?? (dark ? red300 : red700);
  Color get textBrandSecondaryHover =>
      _textBrandSecondaryHover ?? (dark ? neutral200 : brand800);
  Color get borderPrimary =>
      _borderPrimary ?? (dark ? neutral700 : grayModern300);
  Color get borderSecondary =>
      _borderSecondary ?? (dark ? neutral800 : neutral200);
  Color get borderSecondaryAlt =>
      _borderSecondaryAlt ??
      (dark
          ? neutral800
          : const Color.from(
              alpha: 0.1,
              red: 0 / 255,
              green: 0 / 255,
              blue: 0 / 255,
            ));
  Color get borderTertiary =>
      _borderTertiary ?? (dark ? neutral800 : neutral100);
  Color get borderError => _borderError ?? (dark ? red400 : red500);
  Color get borderErrorSubtle => _borderErrorSubtle ?? (dark ? red500 : red300);
  Color get borderBrand => _borderBrand ?? (dark ? brand400 : brand500);
  Color get borderBrandAlt => _borderBrandAlt ?? (dark ? neutral700 : brand600);
  Color get fgSecondary => _fgSecondary ?? (dark ? neutral300 : neutral700);
  Color get fgWarningPrimary =>
      _fgWarningPrimary ?? (dark ? yellow500 : yellow600);
  Color get fgSuccessPrimary =>
      _fgSuccessPrimary ?? (dark ? green500 : green600);
  Color get fgWhite => _fgWhite ?? white;
  Color get fgSuccessSecondary =>
      _fgSuccessSecondary ?? (dark ? green400 : green500);
  Color get fgSecondaryHover =>
      _fgSecondaryHover ?? (dark ? neutral200 : neutral800);
  Color get fgPrimary => _fgPrimary ?? (dark ? white : neutral900);
  Color get fgBrandSecondary => _fgBrandSecondary ?? brand500;
  Color get fgBrandPrimary => _fgBrandPrimary ?? (dark ? brand500 : brand600);
  Color get fgQuaternary =>
      _fgQuaternary ?? (dark ? neutral600 : grayModern500);
  Color get fgQuaternaryHover => _fgQuaternaryHover ?? neutral500;
  Color get fgErrorPrimary => _fgErrorPrimary ?? (dark ? red500 : red600);
  Color get fgWarningSecondary =>
      _fgWarningSecondary ?? (dark ? yellow400 : yellow500);
  Color get fgErrorSecondary => _fgErrorSecondary ?? (dark ? red400 : red500);
  Color get fgTertiary => _fgTertiary ?? (dark ? neutral400 : neutral600);
  Color get fgTertiaryHover =>
      _fgTertiaryHover ?? (dark ? neutral300 : neutral700);
  Color get fgBrandPrimaryAlt =>
      _fgBrandPrimaryAlt ?? (dark ? neutral300 : fgBrandPrimary);
  Color get fgBrandSecondaryAlt =>
      _fgBrandSecondaryAlt ?? (dark ? neutral600 : fgBrandSecondary);
  Color get fgBrandSecondaryHover =>
      _fgBrandSecondaryHover ?? (dark ? neutral500 : brand600);
  Color get bgPrimary => _bgPrimary ?? (dark ? neutral950 : white);
  Color get bgTertiary => _bgTertiary ?? (dark ? neutral800 : neutral100);
  Color get bgBrandPrimary => _bgBrandPrimary ?? (dark ? brand500 : brand50);
  Color get bgErrorSecondary => _bgErrorSecondary ?? (dark ? red600 : red100);
  Color get bgWarningPrimary =>
      _bgWarningPrimary ?? (dark ? yellow950 : yellow50);
  Color get bgWarningSecondary =>
      _bgWarningSecondary ?? (dark ? yellow600 : yellow100);
  Color get bgSuccessPrimary =>
      _bgSuccessPrimary ?? (dark ? green950 : green50);
  Color get bgSuccessSecondary =>
      _bgSuccessSecondary ?? (dark ? green600 : green100);
  Color get bgBrandSolid => _bgBrandSolid ?? brand600;
  Color get bgSecondarySolid => _bgSecondarySolid ?? neutral600;
  Color get bgErrorSolid => _bgErrorSolid ?? red600;
  Color get bgWarningSolid => _bgWarningSolid ?? yellow600;
  Color get bgSuccessSolid => _bgSuccessSolid ?? green600;
  Color get bgSecondaryHover =>
      _bgSecondaryHover ?? (dark ? neutral800 : neutral100);
  Color get bgPrimaryHover =>
      _bgPrimaryHover ?? (dark ? neutral900 : neutral50);
  Color get bgBrandSolidHover =>
      _bgBrandSolidHover ?? (dark ? brand500 : brand700);
  Color get bgErrorPrimary => _bgErrorPrimary ?? (dark ? red950 : red50);
  Color get bgBrandSecondary =>
      _bgBrandSecondary ?? (dark ? brand600 : brand100);
  Color get bgSecondary => _bgSecondary ?? (dark ? neutral900 : neutral50);
  Color get bgQuaternary => _bgQuaternary ?? (dark ? neutral700 : neutral200);
  Color get bgPrimaryAlt => _bgPrimaryAlt ?? (dark ? bgSecondary : white);
  Color get bgBrandPrimaryAlt =>
      _bgBrandPrimaryAlt ?? (dark ? bgSecondary : brand50);
  Color get bgSecondaryAlt => _bgSecondaryAlt ?? (dark ? bgPrimary : neutral50);
  Color get bgOverlay => _bgOverlay ?? (dark ? neutral800 : neutral950);
  Color get bgBrandSection =>
      _bgBrandSection ?? (dark ? bgSecondary : brand800);
  Color get bgBrandSectionSubtle =>
      _bgBrandSectionSubtle ?? (dark ? bgPrimary : brand700);
  Color get bgPrimarySolid =>
      _bgPrimarySolid ?? (dark ? bgSecondary : neutral950);
  Color get bgErrorSolidHover => _bgErrorSolidHover ?? (dark ? red500 : red700);
  Color get appStoreBadgeBorder =>
      _appStoreBadgeBorder ??
      (dark
          ? white
          : const Color.from(
              alpha: 1,
              red: 166 / 255,
              green: 166 / 255,
              blue: 166 / 255,
            ));
  Color get avatarStylesBgNeutral =>
      _avatarStylesBgNeutral ??
      const Color.from(
        alpha: 1,
        red: 224 / 255,
        green: 224 / 255,
        blue: 224 / 255,
      );
  Color get featuredIconLightFgBrand =>
      _featuredIconLightFgBrand ?? (dark ? brand200 : brand600);
  Color get featuredIconLightFgError =>
      _featuredIconLightFgError ?? (dark ? red200 : red600);
  Color get featuredIconLightFgGray =>
      _featuredIconLightFgGray ?? (dark ? neutral200 : neutral500);
  Color get featuredIconLightFgSuccess =>
      _featuredIconLightFgSuccess ?? (dark ? green200 : green600);
  Color get featuredIconLightFgWarning =>
      _featuredIconLightFgWarning ?? (dark ? yellow200 : yellow600);
  Color get focusRingError => _focusRingError ?? red500;
  Color get focusRing => _focusRing ?? brand500;
  Color get footerButtonFg => _footerButtonFg ?? (dark ? neutral300 : brand200);
  Color get footerButtonFgHover =>
      _footerButtonFgHover ?? (dark ? neutral100 : white);
  Color get iconFgBrand => _iconFgBrand ?? (dark ? neutral400 : brand600);
  Color get iconFgBrandOnBrand =>
      _iconFgBrandOnBrand ?? (dark ? neutral400 : brand200);
  Color get screenMockupBorder =>
      _screenMockupBorder ?? (dark ? neutral700 : neutral900);
  Color get sliderHandleBg =>
      _sliderHandleBg ?? (dark ? fgBrandPrimary : white);
  Color get sliderHandleBorder =>
      _sliderHandleBorder ?? (dark ? bgPrimary : brand600);
  Color get toggleBorder => _toggleBorder ?? (dark ? transparent : neutral300);
  Color get toggleSlimBorderPressedHover =>
      _toggleSlimBorderPressedHover ?? (dark ? transparent : bgBrandSolidHover);
  Color get toggleSlimBorderPressed =>
      _toggleSlimBorderPressed ?? (dark ? transparent : bgBrandSolid);
  Color get tooltipSupportingText => _tooltipSupportingText ?? neutral300;
  Color get backgroundColorPrimary => _backgroundColorPrimary ?? bgPrimary;
  Color get backgroundColorTertiary => _backgroundColorTertiary ?? bgTertiary;
  Color get backgroundColorBrandPrimary =>
      _backgroundColorBrandPrimary ?? bgBrandPrimary;
  Color get backgroundColorErrorSecondary =>
      _backgroundColorErrorSecondary ?? bgErrorSecondary;
  Color get backgroundColorWarningPrimary =>
      _backgroundColorWarningPrimary ?? bgWarningPrimary;
  Color get backgroundColorWarningSecondary =>
      _backgroundColorWarningSecondary ?? bgWarningSecondary;
  Color get backgroundColorSuccessPrimary =>
      _backgroundColorSuccessPrimary ?? bgSuccessPrimary;
  Color get backgroundColorSuccessSecondary =>
      _backgroundColorSuccessSecondary ?? bgSuccessSecondary;
  Color get backgroundColorBrandSolid =>
      _backgroundColorBrandSolid ?? bgBrandSolid;
  Color get backgroundColorSecondarySolid =>
      _backgroundColorSecondarySolid ?? bgSecondarySolid;
  Color get backgroundColorErrorSolid =>
      _backgroundColorErrorSolid ?? bgErrorSolid;
  Color get backgroundColorWarningSolid =>
      _backgroundColorWarningSolid ?? bgWarningSolid;
  Color get backgroundColorSuccessSolid =>
      _backgroundColorSuccessSolid ?? bgSuccessSolid;
  Color get backgroundColorSecondaryHover =>
      _backgroundColorSecondaryHover ?? bgSecondaryHover;
  Color get backgroundColorPrimaryHover =>
      _backgroundColorPrimaryHover ?? bgPrimaryHover;
  Color get backgroundColorBrandSolidHover =>
      _backgroundColorBrandSolidHover ?? bgBrandSolidHover;
  Color get backgroundColorErrorPrimary =>
      _backgroundColorErrorPrimary ?? bgErrorPrimary;
  Color get backgroundColorBrandSecondary =>
      _backgroundColorBrandSecondary ?? bgBrandSecondary;
  Color get backgroundColorSecondary =>
      _backgroundColorSecondary ?? bgSecondary;
  Color get backgroundColorQuaternary =>
      _backgroundColorQuaternary ?? bgQuaternary;
  Color get backgroundColorPrimaryAlt =>
      _backgroundColorPrimaryAlt ?? bgPrimaryAlt;
  Color get backgroundColorBrandPrimaryAlt =>
      _backgroundColorBrandPrimaryAlt ?? bgBrandPrimaryAlt;
  Color get backgroundColorSecondaryAlt =>
      _backgroundColorSecondaryAlt ?? bgSecondaryAlt;
  Color get backgroundColorOverlay => _backgroundColorOverlay ?? bgOverlay;
  Color get backgroundColorBrandSection =>
      _backgroundColorBrandSection ?? bgBrandSection;
  Color get backgroundColorBrandSectionSubtle =>
      _backgroundColorBrandSectionSubtle ?? bgBrandSectionSubtle;
  Color get backgroundColorPrimarySolid =>
      _backgroundColorPrimarySolid ?? bgPrimarySolid;
  Color get backgroundColorErrorSolidHover =>
      _backgroundColorErrorSolidHover ?? bgErrorSolidHover;
  Color get backgroundColorBorderBrand =>
      _backgroundColorBorderBrand ?? borderBrand;
  Color get backgroundColorBorderBrandAlt =>
      _backgroundColorBorderBrandAlt ?? borderBrandAlt;
  Color get textWhite => _textWhite ?? white;
  Color get textColorPrimary => _textColorPrimary ?? textPrimary;
  Color get textColorSecondary => _textColorSecondary ?? textSecondary;
  Color get textColorSecondaryHover =>
      _textColorSecondaryHover ?? textSecondaryHover;
  Color get textColorTertiary => _textColorTertiary ?? textTertiary;
  Color get textColorTertiaryHover =>
      _textColorTertiaryHover ?? textTertiaryHover;
  Color get textColorErrorPrimary => _textColorErrorPrimary ?? textErrorPrimary;
  Color get textColorWarningPrimary =>
      _textColorWarningPrimary ?? textWarningPrimary;
  Color get textColorSuccessPrimary =>
      _textColorSuccessPrimary ?? textSuccessPrimary;
  Color get textColorBrandSecondary =>
      _textColorBrandSecondary ?? textBrandSecondary;
  Color get textColorPlaceholder => _textColorPlaceholder ?? textPlaceholder;
  Color get textColorBrandTertiary =>
      _textColorBrandTertiary ?? textBrandTertiary;
  Color get textColorEditorIconFg => _textColorEditorIconFg ?? textEditorIconFg;
  Color get textColorEditorIconFgActive =>
      _textColorEditorIconFgActive ?? textEditorIconFgActive;
  Color get textColorQuaternary => _textColorQuaternary ?? textQuaternary;
  Color get textColorBrandPrimary => _textColorBrandPrimary ?? textBrandPrimary;
  Color get textColorPrimaryOnBrand =>
      _textColorPrimaryOnBrand ?? textPrimaryOnBrand;
  Color get textColorSecondaryOnBrand =>
      _textColorSecondaryOnBrand ?? textSecondaryOnBrand;
  Color get textColorTertiaryOnBrand =>
      _textColorTertiaryOnBrand ?? textTertiaryOnBrand;
  Color get textColorQuaternaryOnBrand =>
      _textColorQuaternaryOnBrand ?? textQuaternaryOnBrand;
  Color get textColorBrandTertiaryAlt =>
      _textColorBrandTertiaryAlt ?? textBrandTertiaryAlt;
  Color get textColorErrorPrimaryHover =>
      _textColorErrorPrimaryHover ?? textErrorPrimaryHover;
  Color get textColorBrandSecondaryHover =>
      _textColorBrandSecondaryHover ?? textBrandSecondaryHover;
  Color get textColorTooltipSupportingText =>
      _textColorTooltipSupportingText ?? tooltipSupportingText;
  Color get borderColorPrimary => _borderColorPrimary ?? borderPrimary;
  Color get borderColorSecondary => _borderColorSecondary ?? borderSecondary;
  Color get borderColorSecondaryAlt =>
      _borderColorSecondaryAlt ?? borderSecondaryAlt;
  Color get borderColorTertiary => _borderColorTertiary ?? borderTertiary;
  Color get borderColorError => _borderColorError ?? borderError;
  Color get borderColorErrorSubtle =>
      _borderColorErrorSubtle ?? borderErrorSubtle;
  Color get borderColorBrand => _borderColorBrand ?? borderBrand;
  Color get borderColorBrandAlt => _borderColorBrandAlt ?? borderBrandAlt;
  Color get borderColorBrandSolid => _borderColorBrandSolid ?? bgBrandSolid;
  Color get borderColorBrandSolidHover =>
      _borderColorBrandSolidHover ?? bgBrandSolidHover;
  Color get ringColorPrimary => _ringColorPrimary ?? borderPrimary;
  Color get ringColorSecondary => _ringColorSecondary ?? borderSecondary;
  Color get ringColorSecondaryAlt =>
      _ringColorSecondaryAlt ?? borderSecondaryAlt;
  Color get ringColorTertiary => _ringColorTertiary ?? borderTertiary;
  Color get ringColorError => _ringColorError ?? borderError;
  Color get ringColorErrorSubtle => _ringColorErrorSubtle ?? borderErrorSubtle;
  Color get ringColorBrand => _ringColorBrand ?? borderBrand;
  Color get ringColorBrandAlt => _ringColorBrandAlt ?? borderBrandAlt;
  Color get ringColorBrandSolid => _ringColorBrandSolid ?? bgBrandSolid;
  Color get ringColorBrandSolidHover =>
      _ringColorBrandSolidHover ?? bgBrandSolidHover;
  Color get outlineColorPrimary => _outlineColorPrimary ?? borderPrimary;
  Color get outlineColorSecondary => _outlineColorSecondary ?? borderSecondary;
  Color get outlineColorSecondaryAlt =>
      _outlineColorSecondaryAlt ?? borderSecondaryAlt;
  Color get outlineColorTertiary => _outlineColorTertiary ?? borderTertiary;
  Color get outlineColorError => _outlineColorError ?? borderError;
  Color get outlineColorErrorSubtle =>
      _outlineColorErrorSubtle ?? borderErrorSubtle;
  Color get outlineColorBrand => _outlineColorBrand ?? borderBrand;
  Color get outlineColorBrandAlt => _outlineColorBrandAlt ?? borderBrandAlt;
  Color get outlineColorBrandSolid => _outlineColorBrandSolid ?? bgBrandSolid;
  Color get outlineColorBrandSolidHover =>
      _outlineColorBrandSolidHover ?? bgBrandSolidHover;
  Color get grayModern300 => _grayModern300 ?? const Color(0xFFD5D7DA);
  Color get grayModern500 => _grayModern500 ?? const Color(0xFF717680);
  Color get grayModern700 => _grayModern700 ?? const Color(0xFF414651);
  Color get grayModern800 => _grayModern800 ?? const Color(0xFF252B37);
  UiColors copyWith({
    bool? dark,
    Color? backgroundColorBorderTertiary,
    Color? red50,
    Color? red100,
    Color? red200,
    Color? red300,
    Color? red400,
    Color? red500,
    Color? red600,
    Color? red700,
    Color? red800,
    Color? red900,
    Color? red950,
    Color? orange50,
    Color? orange100,
    Color? orange200,
    Color? orange300,
    Color? orange400,
    Color? orange500,
    Color? orange600,
    Color? orange700,
    Color? orange800,
    Color? orange900,
    Color? orange950,
    Color? amber50,
    Color? amber100,
    Color? amber200,
    Color? amber300,
    Color? amber400,
    Color? amber500,
    Color? amber600,
    Color? amber700,
    Color? amber800,
    Color? amber900,
    Color? amber950,
    Color? yellow50,
    Color? yellow100,
    Color? yellow200,
    Color? yellow300,
    Color? yellow400,
    Color? yellow500,
    Color? yellow600,
    Color? yellow700,
    Color? yellow800,
    Color? yellow900,
    Color? yellow950,
    Color? lime50,
    Color? lime100,
    Color? lime200,
    Color? lime300,
    Color? lime400,
    Color? lime500,
    Color? lime600,
    Color? lime700,
    Color? lime800,
    Color? lime900,
    Color? lime950,
    Color? green50,
    Color? green100,
    Color? green200,
    Color? green300,
    Color? green400,
    Color? green500,
    Color? green600,
    Color? green700,
    Color? green800,
    Color? green900,
    Color? green950,
    Color? emerald50,
    Color? emerald100,
    Color? emerald200,
    Color? emerald300,
    Color? emerald400,
    Color? emerald500,
    Color? emerald600,
    Color? emerald700,
    Color? emerald800,
    Color? emerald900,
    Color? emerald950,
    Color? teal50,
    Color? teal100,
    Color? teal200,
    Color? teal300,
    Color? teal400,
    Color? teal500,
    Color? teal600,
    Color? teal700,
    Color? teal800,
    Color? teal900,
    Color? teal950,
    Color? cyan50,
    Color? cyan100,
    Color? cyan200,
    Color? cyan300,
    Color? cyan400,
    Color? cyan500,
    Color? cyan600,
    Color? cyan700,
    Color? cyan800,
    Color? cyan900,
    Color? cyan950,
    Color? sky50,
    Color? sky100,
    Color? sky200,
    Color? sky300,
    Color? sky400,
    Color? sky500,
    Color? sky600,
    Color? sky700,
    Color? sky800,
    Color? sky900,
    Color? sky950,
    Color? blue50,
    Color? blue100,
    Color? blue200,
    Color? blue300,
    Color? blue400,
    Color? blue500,
    Color? blue600,
    Color? blue700,
    Color? blue800,
    Color? blue900,
    Color? blue950,
    Color? indigo50,
    Color? indigo100,
    Color? indigo200,
    Color? indigo300,
    Color? indigo400,
    Color? indigo500,
    Color? indigo600,
    Color? indigo700,
    Color? indigo800,
    Color? indigo900,
    Color? indigo950,
    Color? violet50,
    Color? violet100,
    Color? violet200,
    Color? violet300,
    Color? violet400,
    Color? violet500,
    Color? violet600,
    Color? violet700,
    Color? violet800,
    Color? violet900,
    Color? violet950,
    Color? purple50,
    Color? purple100,
    Color? purple200,
    Color? purple300,
    Color? purple400,
    Color? purple500,
    Color? purple600,
    Color? purple700,
    Color? purple800,
    Color? purple900,
    Color? purple950,
    Color? fuchsia50,
    Color? fuchsia100,
    Color? fuchsia200,
    Color? fuchsia300,
    Color? fuchsia400,
    Color? fuchsia500,
    Color? fuchsia600,
    Color? fuchsia700,
    Color? fuchsia800,
    Color? fuchsia900,
    Color? fuchsia950,
    Color? pink50,
    Color? pink100,
    Color? pink200,
    Color? pink300,
    Color? pink400,
    Color? pink500,
    Color? pink600,
    Color? pink700,
    Color? pink800,
    Color? pink900,
    Color? pink950,
    Color? rose50,
    Color? rose100,
    Color? rose200,
    Color? rose300,
    Color? rose400,
    Color? rose500,
    Color? rose600,
    Color? rose700,
    Color? rose800,
    Color? rose900,
    Color? rose950,
    Color? slate50,
    Color? slate100,
    Color? slate200,
    Color? slate300,
    Color? slate400,
    Color? slate500,
    Color? slate600,
    Color? slate700,
    Color? slate800,
    Color? slate900,
    Color? slate950,
    Color? gray50,
    Color? gray100,
    Color? gray200,
    Color? gray300,
    Color? gray400,
    Color? gray500,
    Color? gray600,
    Color? gray700,
    Color? gray800,
    Color? gray900,
    Color? gray950,
    Color? zinc50,
    Color? zinc100,
    Color? zinc200,
    Color? zinc300,
    Color? zinc400,
    Color? zinc500,
    Color? zinc600,
    Color? zinc700,
    Color? zinc800,
    Color? zinc900,
    Color? zinc950,
    Color? neutral50,
    Color? neutral100,
    Color? neutral200,
    Color? neutral300,
    Color? neutral400,
    Color? neutral500,
    Color? neutral600,
    Color? neutral700,
    Color? neutral800,
    Color? neutral900,
    Color? neutral950,
    Color? stone50,
    Color? stone100,
    Color? stone200,
    Color? stone300,
    Color? stone400,
    Color? stone500,
    Color? stone600,
    Color? stone700,
    Color? stone800,
    Color? stone900,
    Color? stone950,
    Color? mauve50,
    Color? mauve100,
    Color? mauve200,
    Color? mauve300,
    Color? mauve400,
    Color? mauve500,
    Color? mauve600,
    Color? mauve700,
    Color? mauve800,
    Color? mauve900,
    Color? mauve950,
    Color? olive50,
    Color? olive100,
    Color? olive200,
    Color? olive300,
    Color? olive400,
    Color? olive500,
    Color? olive600,
    Color? olive700,
    Color? olive800,
    Color? olive900,
    Color? olive950,
    Color? mist50,
    Color? mist100,
    Color? mist200,
    Color? mist300,
    Color? mist400,
    Color? mist500,
    Color? mist600,
    Color? mist700,
    Color? mist800,
    Color? mist900,
    Color? mist950,
    Color? taupe50,
    Color? taupe100,
    Color? taupe200,
    Color? taupe300,
    Color? taupe400,
    Color? taupe500,
    Color? taupe600,
    Color? taupe700,
    Color? taupe800,
    Color? taupe900,
    Color? taupe950,
    Color? black,
    Color? white,
    Color? transparent,
    Color? alphaWhite,
    Color? alphaBlack,
    Color? brand50,
    Color? brand100,
    Color? brand200,
    Color? brand300,
    Color? brand400,
    Color? brand500,
    Color? brand600,
    Color? brand700,
    Color? brand800,
    Color? brand900,
    Color? brand950,
    Color? utilityBlue50,
    Color? utilityBlue100,
    Color? utilityBlue200,
    Color? utilityBlue300,
    Color? utilityBlue400,
    Color? utilityBlue500,
    Color? utilityBlue600,
    Color? utilityBlue700,
    Color? utilityBrand50,
    Color? utilityBrand50Alt,
    Color? utilityBrand100,
    Color? utilityBrand100Alt,
    Color? utilityBrand200,
    Color? utilityBrand200Alt,
    Color? utilityBrand300,
    Color? utilityBrand300Alt,
    Color? utilityBrand400,
    Color? utilityBrand400Alt,
    Color? utilityBrand500,
    Color? utilityBrand500Alt,
    Color? utilityBrand600,
    Color? utilityBrand600Alt,
    Color? utilityBrand700,
    Color? utilityBrand700Alt,
    Color? utilityBrand800,
    Color? utilityBrand800Alt,
    Color? utilityBrand900,
    Color? utilityBrand900Alt,
    Color? utilityNeutral50,
    Color? utilityNeutral100,
    Color? utilityNeutral200,
    Color? utilityNeutral300,
    Color? utilityNeutral400,
    Color? utilityNeutral500,
    Color? utilityNeutral600,
    Color? utilityNeutral700,
    Color? utilityNeutral800,
    Color? utilityNeutral900,
    Color? utilityRed50,
    Color? utilityRed100,
    Color? utilityRed200,
    Color? utilityRed300,
    Color? utilityRed400,
    Color? utilityRed500,
    Color? utilityRed600,
    Color? utilityRed700,
    Color? utilityYellow50,
    Color? utilityYellow100,
    Color? utilityYellow200,
    Color? utilityYellow300,
    Color? utilityYellow400,
    Color? utilityYellow500,
    Color? utilityYellow600,
    Color? utilityYellow700,
    Color? utilityGreen50,
    Color? utilityGreen100,
    Color? utilityGreen200,
    Color? utilityGreen300,
    Color? utilityGreen400,
    Color? utilityGreen500,
    Color? utilityGreen600,
    Color? utilityGreen700,
    Color? utilityOrange50,
    Color? utilityOrange100,
    Color? utilityOrange200,
    Color? utilityOrange300,
    Color? utilityOrange400,
    Color? utilityOrange500,
    Color? utilityOrange600,
    Color? utilityOrange700,
    Color? utilityIndigo50,
    Color? utilityIndigo100,
    Color? utilityIndigo200,
    Color? utilityIndigo300,
    Color? utilityIndigo400,
    Color? utilityIndigo500,
    Color? utilityIndigo600,
    Color? utilityIndigo700,
    Color? utilityFuchsia50,
    Color? utilityFuchsia100,
    Color? utilityFuchsia200,
    Color? utilityFuchsia300,
    Color? utilityFuchsia400,
    Color? utilityFuchsia500,
    Color? utilityFuchsia600,
    Color? utilityFuchsia700,
    Color? utilityPink50,
    Color? utilityPink100,
    Color? utilityPink200,
    Color? utilityPink300,
    Color? utilityPink400,
    Color? utilityPink500,
    Color? utilityPink600,
    Color? utilityPink700,
    Color? utilityPurple50,
    Color? utilityPurple100,
    Color? utilityPurple200,
    Color? utilityPurple300,
    Color? utilityPurple400,
    Color? utilityPurple500,
    Color? utilityPurple600,
    Color? utilityPurple700,
    Color? utilitySky50,
    Color? utilitySky100,
    Color? utilitySky200,
    Color? utilitySky300,
    Color? utilitySky400,
    Color? utilitySky500,
    Color? utilitySky600,
    Color? utilitySky700,
    Color? utilitySlate50,
    Color? utilitySlate100,
    Color? utilitySlate200,
    Color? utilitySlate300,
    Color? utilitySlate400,
    Color? utilitySlate500,
    Color? utilitySlate600,
    Color? utilitySlate700,
    Color? utilityEmerald50,
    Color? utilityEmerald100,
    Color? utilityEmerald200,
    Color? utilityEmerald300,
    Color? utilityEmerald400,
    Color? utilityEmerald500,
    Color? utilityEmerald600,
    Color? utilityEmerald700,
    Color? utilityAmber50,
    Color? utilityAmber100,
    Color? utilityAmber200,
    Color? utilityAmber300,
    Color? utilityAmber400,
    Color? utilityAmber500,
    Color? utilityAmber600,
    Color? utilityAmber700,
    Color? textPrimary,
    Color? textTertiary,
    Color? textErrorPrimary,
    Color? textWarningPrimary,
    Color? textSuccessPrimary,
    Color? textSecondary,
    Color? textSecondaryHover,
    Color? textTertiaryHover,
    Color? textBrandSecondary,
    Color? textPlaceholder,
    Color? textBrandTertiary,
    Color? textEditorIconFg,
    Color? textEditorIconFgActive,
    Color? textQuaternary,
    Color? textBrandPrimary,
    Color? textPrimaryOnBrand,
    Color? textSecondaryOnBrand,
    Color? textTertiaryOnBrand,
    Color? textQuaternaryOnBrand,
    Color? textBrandTertiaryAlt,
    Color? textErrorPrimaryHover,
    Color? textBrandSecondaryHover,
    Color? borderPrimary,
    Color? borderSecondary,
    Color? borderSecondaryAlt,
    Color? borderTertiary,
    Color? borderError,
    Color? borderErrorSubtle,
    Color? borderBrand,
    Color? borderBrandAlt,
    Color? fgSecondary,
    Color? fgWarningPrimary,
    Color? fgSuccessPrimary,
    Color? fgWhite,
    Color? fgSuccessSecondary,
    Color? fgSecondaryHover,
    Color? fgPrimary,
    Color? fgBrandSecondary,
    Color? fgBrandPrimary,
    Color? fgQuaternary,
    Color? fgQuaternaryHover,
    Color? fgErrorPrimary,
    Color? fgWarningSecondary,
    Color? fgErrorSecondary,
    Color? fgTertiary,
    Color? fgTertiaryHover,
    Color? fgBrandPrimaryAlt,
    Color? fgBrandSecondaryAlt,
    Color? fgBrandSecondaryHover,
    Color? bgPrimary,
    Color? bgTertiary,
    Color? bgBrandPrimary,
    Color? bgErrorSecondary,
    Color? bgWarningPrimary,
    Color? bgWarningSecondary,
    Color? bgSuccessPrimary,
    Color? bgSuccessSecondary,
    Color? bgBrandSolid,
    Color? bgSecondarySolid,
    Color? bgErrorSolid,
    Color? bgWarningSolid,
    Color? bgSuccessSolid,
    Color? bgSecondaryHover,
    Color? bgPrimaryHover,
    Color? bgBrandSolidHover,
    Color? bgErrorPrimary,
    Color? bgBrandSecondary,
    Color? bgSecondary,
    Color? bgQuaternary,
    Color? bgPrimaryAlt,
    Color? bgBrandPrimaryAlt,
    Color? bgSecondaryAlt,
    Color? bgOverlay,
    Color? bgBrandSection,
    Color? bgBrandSectionSubtle,
    Color? bgPrimarySolid,
    Color? bgErrorSolidHover,
    Color? appStoreBadgeBorder,
    Color? avatarStylesBgNeutral,
    Color? featuredIconLightFgBrand,
    Color? featuredIconLightFgError,
    Color? featuredIconLightFgGray,
    Color? featuredIconLightFgSuccess,
    Color? featuredIconLightFgWarning,
    Color? focusRingError,
    Color? focusRing,
    Color? footerButtonFg,
    Color? footerButtonFgHover,
    Color? iconFgBrand,
    Color? iconFgBrandOnBrand,
    Color? screenMockupBorder,
    Color? sliderHandleBg,
    Color? sliderHandleBorder,
    Color? toggleBorder,
    Color? toggleSlimBorderPressedHover,
    Color? toggleSlimBorderPressed,
    Color? tooltipSupportingText,
    Color? backgroundColorPrimary,
    Color? backgroundColorTertiary,
    Color? backgroundColorBrandPrimary,
    Color? backgroundColorErrorSecondary,
    Color? backgroundColorWarningPrimary,
    Color? backgroundColorWarningSecondary,
    Color? backgroundColorSuccessPrimary,
    Color? backgroundColorSuccessSecondary,
    Color? backgroundColorBrandSolid,
    Color? backgroundColorSecondarySolid,
    Color? backgroundColorErrorSolid,
    Color? backgroundColorWarningSolid,
    Color? backgroundColorSuccessSolid,
    Color? backgroundColorSecondaryHover,
    Color? backgroundColorPrimaryHover,
    Color? backgroundColorBrandSolidHover,
    Color? backgroundColorErrorPrimary,
    Color? backgroundColorBrandSecondary,
    Color? backgroundColorSecondary,
    Color? backgroundColorQuaternary,
    Color? backgroundColorPrimaryAlt,
    Color? backgroundColorBrandPrimaryAlt,
    Color? backgroundColorSecondaryAlt,
    Color? backgroundColorOverlay,
    Color? backgroundColorBrandSection,
    Color? backgroundColorBrandSectionSubtle,
    Color? backgroundColorPrimarySolid,
    Color? backgroundColorErrorSolidHover,
    Color? backgroundColorBorderBrand,
    Color? backgroundColorBorderBrandAlt,
    Color? textWhite,
    Color? textColorPrimary,
    Color? textColorSecondary,
    Color? textColorSecondaryHover,
    Color? textColorTertiary,
    Color? textColorTertiaryHover,
    Color? textColorErrorPrimary,
    Color? textColorWarningPrimary,
    Color? textColorSuccessPrimary,
    Color? textColorBrandSecondary,
    Color? textColorPlaceholder,
    Color? textColorBrandTertiary,
    Color? textColorEditorIconFg,
    Color? textColorEditorIconFgActive,
    Color? textColorQuaternary,
    Color? textColorBrandPrimary,
    Color? textColorPrimaryOnBrand,
    Color? textColorSecondaryOnBrand,
    Color? textColorTertiaryOnBrand,
    Color? textColorQuaternaryOnBrand,
    Color? textColorBrandTertiaryAlt,
    Color? textColorErrorPrimaryHover,
    Color? textColorBrandSecondaryHover,
    Color? textColorTooltipSupportingText,
    Color? borderColorPrimary,
    Color? borderColorSecondary,
    Color? borderColorSecondaryAlt,
    Color? borderColorTertiary,
    Color? borderColorError,
    Color? borderColorErrorSubtle,
    Color? borderColorBrand,
    Color? borderColorBrandAlt,
    Color? borderColorBrandSolid,
    Color? borderColorBrandSolidHover,
    Color? ringColorPrimary,
    Color? ringColorSecondary,
    Color? ringColorSecondaryAlt,
    Color? ringColorTertiary,
    Color? ringColorError,
    Color? ringColorErrorSubtle,
    Color? ringColorBrand,
    Color? ringColorBrandAlt,
    Color? ringColorBrandSolid,
    Color? ringColorBrandSolidHover,
    Color? outlineColorPrimary,
    Color? outlineColorSecondary,
    Color? outlineColorSecondaryAlt,
    Color? outlineColorTertiary,
    Color? outlineColorError,
    Color? outlineColorErrorSubtle,
    Color? outlineColorBrand,
    Color? outlineColorBrandAlt,
    Color? outlineColorBrandSolid,
    Color? outlineColorBrandSolidHover,
    Color? grayModern300,
    Color? grayModern500,
    Color? grayModern700,
    Color? grayModern800,
  }) => UiColors(
    dark: dark ?? this.dark,
    backgroundColorBorderTertiary:
        backgroundColorBorderTertiary ?? _backgroundColorBorderTertiary,
    red50: red50 ?? _red50,
    red100: red100 ?? _red100,
    red200: red200 ?? _red200,
    red300: red300 ?? _red300,
    red400: red400 ?? _red400,
    red500: red500 ?? _red500,
    red600: red600 ?? _red600,
    red700: red700 ?? _red700,
    red800: red800 ?? _red800,
    red900: red900 ?? _red900,
    red950: red950 ?? _red950,
    orange50: orange50 ?? _orange50,
    orange100: orange100 ?? _orange100,
    orange200: orange200 ?? _orange200,
    orange300: orange300 ?? _orange300,
    orange400: orange400 ?? _orange400,
    orange500: orange500 ?? _orange500,
    orange600: orange600 ?? _orange600,
    orange700: orange700 ?? _orange700,
    orange800: orange800 ?? _orange800,
    orange900: orange900 ?? _orange900,
    orange950: orange950 ?? _orange950,
    amber50: amber50 ?? _amber50,
    amber100: amber100 ?? _amber100,
    amber200: amber200 ?? _amber200,
    amber300: amber300 ?? _amber300,
    amber400: amber400 ?? _amber400,
    amber500: amber500 ?? _amber500,
    amber600: amber600 ?? _amber600,
    amber700: amber700 ?? _amber700,
    amber800: amber800 ?? _amber800,
    amber900: amber900 ?? _amber900,
    amber950: amber950 ?? _amber950,
    yellow50: yellow50 ?? _yellow50,
    yellow100: yellow100 ?? _yellow100,
    yellow200: yellow200 ?? _yellow200,
    yellow300: yellow300 ?? _yellow300,
    yellow400: yellow400 ?? _yellow400,
    yellow500: yellow500 ?? _yellow500,
    yellow600: yellow600 ?? _yellow600,
    yellow700: yellow700 ?? _yellow700,
    yellow800: yellow800 ?? _yellow800,
    yellow900: yellow900 ?? _yellow900,
    yellow950: yellow950 ?? _yellow950,
    lime50: lime50 ?? _lime50,
    lime100: lime100 ?? _lime100,
    lime200: lime200 ?? _lime200,
    lime300: lime300 ?? _lime300,
    lime400: lime400 ?? _lime400,
    lime500: lime500 ?? _lime500,
    lime600: lime600 ?? _lime600,
    lime700: lime700 ?? _lime700,
    lime800: lime800 ?? _lime800,
    lime900: lime900 ?? _lime900,
    lime950: lime950 ?? _lime950,
    green50: green50 ?? _green50,
    green100: green100 ?? _green100,
    green200: green200 ?? _green200,
    green300: green300 ?? _green300,
    green400: green400 ?? _green400,
    green500: green500 ?? _green500,
    green600: green600 ?? _green600,
    green700: green700 ?? _green700,
    green800: green800 ?? _green800,
    green900: green900 ?? _green900,
    green950: green950 ?? _green950,
    emerald50: emerald50 ?? _emerald50,
    emerald100: emerald100 ?? _emerald100,
    emerald200: emerald200 ?? _emerald200,
    emerald300: emerald300 ?? _emerald300,
    emerald400: emerald400 ?? _emerald400,
    emerald500: emerald500 ?? _emerald500,
    emerald600: emerald600 ?? _emerald600,
    emerald700: emerald700 ?? _emerald700,
    emerald800: emerald800 ?? _emerald800,
    emerald900: emerald900 ?? _emerald900,
    emerald950: emerald950 ?? _emerald950,
    teal50: teal50 ?? _teal50,
    teal100: teal100 ?? _teal100,
    teal200: teal200 ?? _teal200,
    teal300: teal300 ?? _teal300,
    teal400: teal400 ?? _teal400,
    teal500: teal500 ?? _teal500,
    teal600: teal600 ?? _teal600,
    teal700: teal700 ?? _teal700,
    teal800: teal800 ?? _teal800,
    teal900: teal900 ?? _teal900,
    teal950: teal950 ?? _teal950,
    cyan50: cyan50 ?? _cyan50,
    cyan100: cyan100 ?? _cyan100,
    cyan200: cyan200 ?? _cyan200,
    cyan300: cyan300 ?? _cyan300,
    cyan400: cyan400 ?? _cyan400,
    cyan500: cyan500 ?? _cyan500,
    cyan600: cyan600 ?? _cyan600,
    cyan700: cyan700 ?? _cyan700,
    cyan800: cyan800 ?? _cyan800,
    cyan900: cyan900 ?? _cyan900,
    cyan950: cyan950 ?? _cyan950,
    sky50: sky50 ?? _sky50,
    sky100: sky100 ?? _sky100,
    sky200: sky200 ?? _sky200,
    sky300: sky300 ?? _sky300,
    sky400: sky400 ?? _sky400,
    sky500: sky500 ?? _sky500,
    sky600: sky600 ?? _sky600,
    sky700: sky700 ?? _sky700,
    sky800: sky800 ?? _sky800,
    sky900: sky900 ?? _sky900,
    sky950: sky950 ?? _sky950,
    blue50: blue50 ?? _blue50,
    blue100: blue100 ?? _blue100,
    blue200: blue200 ?? _blue200,
    blue300: blue300 ?? _blue300,
    blue400: blue400 ?? _blue400,
    blue500: blue500 ?? _blue500,
    blue600: blue600 ?? _blue600,
    blue700: blue700 ?? _blue700,
    blue800: blue800 ?? _blue800,
    blue900: blue900 ?? _blue900,
    blue950: blue950 ?? _blue950,
    indigo50: indigo50 ?? _indigo50,
    indigo100: indigo100 ?? _indigo100,
    indigo200: indigo200 ?? _indigo200,
    indigo300: indigo300 ?? _indigo300,
    indigo400: indigo400 ?? _indigo400,
    indigo500: indigo500 ?? _indigo500,
    indigo600: indigo600 ?? _indigo600,
    indigo700: indigo700 ?? _indigo700,
    indigo800: indigo800 ?? _indigo800,
    indigo900: indigo900 ?? _indigo900,
    indigo950: indigo950 ?? _indigo950,
    violet50: violet50 ?? _violet50,
    violet100: violet100 ?? _violet100,
    violet200: violet200 ?? _violet200,
    violet300: violet300 ?? _violet300,
    violet400: violet400 ?? _violet400,
    violet500: violet500 ?? _violet500,
    violet600: violet600 ?? _violet600,
    violet700: violet700 ?? _violet700,
    violet800: violet800 ?? _violet800,
    violet900: violet900 ?? _violet900,
    violet950: violet950 ?? _violet950,
    purple50: purple50 ?? _purple50,
    purple100: purple100 ?? _purple100,
    purple200: purple200 ?? _purple200,
    purple300: purple300 ?? _purple300,
    purple400: purple400 ?? _purple400,
    purple500: purple500 ?? _purple500,
    purple600: purple600 ?? _purple600,
    purple700: purple700 ?? _purple700,
    purple800: purple800 ?? _purple800,
    purple900: purple900 ?? _purple900,
    purple950: purple950 ?? _purple950,
    fuchsia50: fuchsia50 ?? _fuchsia50,
    fuchsia100: fuchsia100 ?? _fuchsia100,
    fuchsia200: fuchsia200 ?? _fuchsia200,
    fuchsia300: fuchsia300 ?? _fuchsia300,
    fuchsia400: fuchsia400 ?? _fuchsia400,
    fuchsia500: fuchsia500 ?? _fuchsia500,
    fuchsia600: fuchsia600 ?? _fuchsia600,
    fuchsia700: fuchsia700 ?? _fuchsia700,
    fuchsia800: fuchsia800 ?? _fuchsia800,
    fuchsia900: fuchsia900 ?? _fuchsia900,
    fuchsia950: fuchsia950 ?? _fuchsia950,
    pink50: pink50 ?? _pink50,
    pink100: pink100 ?? _pink100,
    pink200: pink200 ?? _pink200,
    pink300: pink300 ?? _pink300,
    pink400: pink400 ?? _pink400,
    pink500: pink500 ?? _pink500,
    pink600: pink600 ?? _pink600,
    pink700: pink700 ?? _pink700,
    pink800: pink800 ?? _pink800,
    pink900: pink900 ?? _pink900,
    pink950: pink950 ?? _pink950,
    rose50: rose50 ?? _rose50,
    rose100: rose100 ?? _rose100,
    rose200: rose200 ?? _rose200,
    rose300: rose300 ?? _rose300,
    rose400: rose400 ?? _rose400,
    rose500: rose500 ?? _rose500,
    rose600: rose600 ?? _rose600,
    rose700: rose700 ?? _rose700,
    rose800: rose800 ?? _rose800,
    rose900: rose900 ?? _rose900,
    rose950: rose950 ?? _rose950,
    slate50: slate50 ?? _slate50,
    slate100: slate100 ?? _slate100,
    slate200: slate200 ?? _slate200,
    slate300: slate300 ?? _slate300,
    slate400: slate400 ?? _slate400,
    slate500: slate500 ?? _slate500,
    slate600: slate600 ?? _slate600,
    slate700: slate700 ?? _slate700,
    slate800: slate800 ?? _slate800,
    slate900: slate900 ?? _slate900,
    slate950: slate950 ?? _slate950,
    gray50: gray50 ?? _gray50,
    gray100: gray100 ?? _gray100,
    gray200: gray200 ?? _gray200,
    gray300: gray300 ?? _gray300,
    gray400: gray400 ?? _gray400,
    gray500: gray500 ?? _gray500,
    gray600: gray600 ?? _gray600,
    gray700: gray700 ?? _gray700,
    gray800: gray800 ?? _gray800,
    gray900: gray900 ?? _gray900,
    gray950: gray950 ?? _gray950,
    zinc50: zinc50 ?? _zinc50,
    zinc100: zinc100 ?? _zinc100,
    zinc200: zinc200 ?? _zinc200,
    zinc300: zinc300 ?? _zinc300,
    zinc400: zinc400 ?? _zinc400,
    zinc500: zinc500 ?? _zinc500,
    zinc600: zinc600 ?? _zinc600,
    zinc700: zinc700 ?? _zinc700,
    zinc800: zinc800 ?? _zinc800,
    zinc900: zinc900 ?? _zinc900,
    zinc950: zinc950 ?? _zinc950,
    neutral50: neutral50 ?? _neutral50,
    neutral100: neutral100 ?? _neutral100,
    neutral200: neutral200 ?? _neutral200,
    neutral300: neutral300 ?? _neutral300,
    neutral400: neutral400 ?? _neutral400,
    neutral500: neutral500 ?? _neutral500,
    neutral600: neutral600 ?? _neutral600,
    neutral700: neutral700 ?? _neutral700,
    neutral800: neutral800 ?? _neutral800,
    neutral900: neutral900 ?? _neutral900,
    neutral950: neutral950 ?? _neutral950,
    stone50: stone50 ?? _stone50,
    stone100: stone100 ?? _stone100,
    stone200: stone200 ?? _stone200,
    stone300: stone300 ?? _stone300,
    stone400: stone400 ?? _stone400,
    stone500: stone500 ?? _stone500,
    stone600: stone600 ?? _stone600,
    stone700: stone700 ?? _stone700,
    stone800: stone800 ?? _stone800,
    stone900: stone900 ?? _stone900,
    stone950: stone950 ?? _stone950,
    mauve50: mauve50 ?? _mauve50,
    mauve100: mauve100 ?? _mauve100,
    mauve200: mauve200 ?? _mauve200,
    mauve300: mauve300 ?? _mauve300,
    mauve400: mauve400 ?? _mauve400,
    mauve500: mauve500 ?? _mauve500,
    mauve600: mauve600 ?? _mauve600,
    mauve700: mauve700 ?? _mauve700,
    mauve800: mauve800 ?? _mauve800,
    mauve900: mauve900 ?? _mauve900,
    mauve950: mauve950 ?? _mauve950,
    olive50: olive50 ?? _olive50,
    olive100: olive100 ?? _olive100,
    olive200: olive200 ?? _olive200,
    olive300: olive300 ?? _olive300,
    olive400: olive400 ?? _olive400,
    olive500: olive500 ?? _olive500,
    olive600: olive600 ?? _olive600,
    olive700: olive700 ?? _olive700,
    olive800: olive800 ?? _olive800,
    olive900: olive900 ?? _olive900,
    olive950: olive950 ?? _olive950,
    mist50: mist50 ?? _mist50,
    mist100: mist100 ?? _mist100,
    mist200: mist200 ?? _mist200,
    mist300: mist300 ?? _mist300,
    mist400: mist400 ?? _mist400,
    mist500: mist500 ?? _mist500,
    mist600: mist600 ?? _mist600,
    mist700: mist700 ?? _mist700,
    mist800: mist800 ?? _mist800,
    mist900: mist900 ?? _mist900,
    mist950: mist950 ?? _mist950,
    taupe50: taupe50 ?? _taupe50,
    taupe100: taupe100 ?? _taupe100,
    taupe200: taupe200 ?? _taupe200,
    taupe300: taupe300 ?? _taupe300,
    taupe400: taupe400 ?? _taupe400,
    taupe500: taupe500 ?? _taupe500,
    taupe600: taupe600 ?? _taupe600,
    taupe700: taupe700 ?? _taupe700,
    taupe800: taupe800 ?? _taupe800,
    taupe900: taupe900 ?? _taupe900,
    taupe950: taupe950 ?? _taupe950,
    black: black ?? _black,
    white: white ?? _white,
    transparent: transparent ?? _transparent,
    alphaWhite: alphaWhite ?? _alphaWhite,
    alphaBlack: alphaBlack ?? _alphaBlack,
    brand50: brand50 ?? _brand50,
    brand100: brand100 ?? _brand100,
    brand200: brand200 ?? _brand200,
    brand300: brand300 ?? _brand300,
    brand400: brand400 ?? _brand400,
    brand500: brand500 ?? _brand500,
    brand600: brand600 ?? _brand600,
    brand700: brand700 ?? _brand700,
    brand800: brand800 ?? _brand800,
    brand900: brand900 ?? _brand900,
    brand950: brand950 ?? _brand950,
    utilityBlue50: utilityBlue50 ?? _utilityBlue50,
    utilityBlue100: utilityBlue100 ?? _utilityBlue100,
    utilityBlue200: utilityBlue200 ?? _utilityBlue200,
    utilityBlue300: utilityBlue300 ?? _utilityBlue300,
    utilityBlue400: utilityBlue400 ?? _utilityBlue400,
    utilityBlue500: utilityBlue500 ?? _utilityBlue500,
    utilityBlue600: utilityBlue600 ?? _utilityBlue600,
    utilityBlue700: utilityBlue700 ?? _utilityBlue700,
    utilityBrand50: utilityBrand50 ?? _utilityBrand50,
    utilityBrand50Alt: utilityBrand50Alt ?? _utilityBrand50Alt,
    utilityBrand100: utilityBrand100 ?? _utilityBrand100,
    utilityBrand100Alt: utilityBrand100Alt ?? _utilityBrand100Alt,
    utilityBrand200: utilityBrand200 ?? _utilityBrand200,
    utilityBrand200Alt: utilityBrand200Alt ?? _utilityBrand200Alt,
    utilityBrand300: utilityBrand300 ?? _utilityBrand300,
    utilityBrand300Alt: utilityBrand300Alt ?? _utilityBrand300Alt,
    utilityBrand400: utilityBrand400 ?? _utilityBrand400,
    utilityBrand400Alt: utilityBrand400Alt ?? _utilityBrand400Alt,
    utilityBrand500: utilityBrand500 ?? _utilityBrand500,
    utilityBrand500Alt: utilityBrand500Alt ?? _utilityBrand500Alt,
    utilityBrand600: utilityBrand600 ?? _utilityBrand600,
    utilityBrand600Alt: utilityBrand600Alt ?? _utilityBrand600Alt,
    utilityBrand700: utilityBrand700 ?? _utilityBrand700,
    utilityBrand700Alt: utilityBrand700Alt ?? _utilityBrand700Alt,
    utilityBrand800: utilityBrand800 ?? _utilityBrand800,
    utilityBrand800Alt: utilityBrand800Alt ?? _utilityBrand800Alt,
    utilityBrand900: utilityBrand900 ?? _utilityBrand900,
    utilityBrand900Alt: utilityBrand900Alt ?? _utilityBrand900Alt,
    utilityNeutral50: utilityNeutral50 ?? _utilityNeutral50,
    utilityNeutral100: utilityNeutral100 ?? _utilityNeutral100,
    utilityNeutral200: utilityNeutral200 ?? _utilityNeutral200,
    utilityNeutral300: utilityNeutral300 ?? _utilityNeutral300,
    utilityNeutral400: utilityNeutral400 ?? _utilityNeutral400,
    utilityNeutral500: utilityNeutral500 ?? _utilityNeutral500,
    utilityNeutral600: utilityNeutral600 ?? _utilityNeutral600,
    utilityNeutral700: utilityNeutral700 ?? _utilityNeutral700,
    utilityNeutral800: utilityNeutral800 ?? _utilityNeutral800,
    utilityNeutral900: utilityNeutral900 ?? _utilityNeutral900,
    utilityRed50: utilityRed50 ?? _utilityRed50,
    utilityRed100: utilityRed100 ?? _utilityRed100,
    utilityRed200: utilityRed200 ?? _utilityRed200,
    utilityRed300: utilityRed300 ?? _utilityRed300,
    utilityRed400: utilityRed400 ?? _utilityRed400,
    utilityRed500: utilityRed500 ?? _utilityRed500,
    utilityRed600: utilityRed600 ?? _utilityRed600,
    utilityRed700: utilityRed700 ?? _utilityRed700,
    utilityYellow50: utilityYellow50 ?? _utilityYellow50,
    utilityYellow100: utilityYellow100 ?? _utilityYellow100,
    utilityYellow200: utilityYellow200 ?? _utilityYellow200,
    utilityYellow300: utilityYellow300 ?? _utilityYellow300,
    utilityYellow400: utilityYellow400 ?? _utilityYellow400,
    utilityYellow500: utilityYellow500 ?? _utilityYellow500,
    utilityYellow600: utilityYellow600 ?? _utilityYellow600,
    utilityYellow700: utilityYellow700 ?? _utilityYellow700,
    utilityGreen50: utilityGreen50 ?? _utilityGreen50,
    utilityGreen100: utilityGreen100 ?? _utilityGreen100,
    utilityGreen200: utilityGreen200 ?? _utilityGreen200,
    utilityGreen300: utilityGreen300 ?? _utilityGreen300,
    utilityGreen400: utilityGreen400 ?? _utilityGreen400,
    utilityGreen500: utilityGreen500 ?? _utilityGreen500,
    utilityGreen600: utilityGreen600 ?? _utilityGreen600,
    utilityGreen700: utilityGreen700 ?? _utilityGreen700,
    utilityOrange50: utilityOrange50 ?? _utilityOrange50,
    utilityOrange100: utilityOrange100 ?? _utilityOrange100,
    utilityOrange200: utilityOrange200 ?? _utilityOrange200,
    utilityOrange300: utilityOrange300 ?? _utilityOrange300,
    utilityOrange400: utilityOrange400 ?? _utilityOrange400,
    utilityOrange500: utilityOrange500 ?? _utilityOrange500,
    utilityOrange600: utilityOrange600 ?? _utilityOrange600,
    utilityOrange700: utilityOrange700 ?? _utilityOrange700,
    utilityIndigo50: utilityIndigo50 ?? _utilityIndigo50,
    utilityIndigo100: utilityIndigo100 ?? _utilityIndigo100,
    utilityIndigo200: utilityIndigo200 ?? _utilityIndigo200,
    utilityIndigo300: utilityIndigo300 ?? _utilityIndigo300,
    utilityIndigo400: utilityIndigo400 ?? _utilityIndigo400,
    utilityIndigo500: utilityIndigo500 ?? _utilityIndigo500,
    utilityIndigo600: utilityIndigo600 ?? _utilityIndigo600,
    utilityIndigo700: utilityIndigo700 ?? _utilityIndigo700,
    utilityFuchsia50: utilityFuchsia50 ?? _utilityFuchsia50,
    utilityFuchsia100: utilityFuchsia100 ?? _utilityFuchsia100,
    utilityFuchsia200: utilityFuchsia200 ?? _utilityFuchsia200,
    utilityFuchsia300: utilityFuchsia300 ?? _utilityFuchsia300,
    utilityFuchsia400: utilityFuchsia400 ?? _utilityFuchsia400,
    utilityFuchsia500: utilityFuchsia500 ?? _utilityFuchsia500,
    utilityFuchsia600: utilityFuchsia600 ?? _utilityFuchsia600,
    utilityFuchsia700: utilityFuchsia700 ?? _utilityFuchsia700,
    utilityPink50: utilityPink50 ?? _utilityPink50,
    utilityPink100: utilityPink100 ?? _utilityPink100,
    utilityPink200: utilityPink200 ?? _utilityPink200,
    utilityPink300: utilityPink300 ?? _utilityPink300,
    utilityPink400: utilityPink400 ?? _utilityPink400,
    utilityPink500: utilityPink500 ?? _utilityPink500,
    utilityPink600: utilityPink600 ?? _utilityPink600,
    utilityPink700: utilityPink700 ?? _utilityPink700,
    utilityPurple50: utilityPurple50 ?? _utilityPurple50,
    utilityPurple100: utilityPurple100 ?? _utilityPurple100,
    utilityPurple200: utilityPurple200 ?? _utilityPurple200,
    utilityPurple300: utilityPurple300 ?? _utilityPurple300,
    utilityPurple400: utilityPurple400 ?? _utilityPurple400,
    utilityPurple500: utilityPurple500 ?? _utilityPurple500,
    utilityPurple600: utilityPurple600 ?? _utilityPurple600,
    utilityPurple700: utilityPurple700 ?? _utilityPurple700,
    utilitySky50: utilitySky50 ?? _utilitySky50,
    utilitySky100: utilitySky100 ?? _utilitySky100,
    utilitySky200: utilitySky200 ?? _utilitySky200,
    utilitySky300: utilitySky300 ?? _utilitySky300,
    utilitySky400: utilitySky400 ?? _utilitySky400,
    utilitySky500: utilitySky500 ?? _utilitySky500,
    utilitySky600: utilitySky600 ?? _utilitySky600,
    utilitySky700: utilitySky700 ?? _utilitySky700,
    utilitySlate50: utilitySlate50 ?? _utilitySlate50,
    utilitySlate100: utilitySlate100 ?? _utilitySlate100,
    utilitySlate200: utilitySlate200 ?? _utilitySlate200,
    utilitySlate300: utilitySlate300 ?? _utilitySlate300,
    utilitySlate400: utilitySlate400 ?? _utilitySlate400,
    utilitySlate500: utilitySlate500 ?? _utilitySlate500,
    utilitySlate600: utilitySlate600 ?? _utilitySlate600,
    utilitySlate700: utilitySlate700 ?? _utilitySlate700,
    utilityEmerald50: utilityEmerald50 ?? _utilityEmerald50,
    utilityEmerald100: utilityEmerald100 ?? _utilityEmerald100,
    utilityEmerald200: utilityEmerald200 ?? _utilityEmerald200,
    utilityEmerald300: utilityEmerald300 ?? _utilityEmerald300,
    utilityEmerald400: utilityEmerald400 ?? _utilityEmerald400,
    utilityEmerald500: utilityEmerald500 ?? _utilityEmerald500,
    utilityEmerald600: utilityEmerald600 ?? _utilityEmerald600,
    utilityEmerald700: utilityEmerald700 ?? _utilityEmerald700,
    utilityAmber50: utilityAmber50 ?? _utilityAmber50,
    utilityAmber100: utilityAmber100 ?? _utilityAmber100,
    utilityAmber200: utilityAmber200 ?? _utilityAmber200,
    utilityAmber300: utilityAmber300 ?? _utilityAmber300,
    utilityAmber400: utilityAmber400 ?? _utilityAmber400,
    utilityAmber500: utilityAmber500 ?? _utilityAmber500,
    utilityAmber600: utilityAmber600 ?? _utilityAmber600,
    utilityAmber700: utilityAmber700 ?? _utilityAmber700,
    textPrimary: textPrimary ?? _textPrimary,
    textTertiary: textTertiary ?? _textTertiary,
    textErrorPrimary: textErrorPrimary ?? _textErrorPrimary,
    textWarningPrimary: textWarningPrimary ?? _textWarningPrimary,
    textSuccessPrimary: textSuccessPrimary ?? _textSuccessPrimary,
    textSecondary: textSecondary ?? _textSecondary,
    textSecondaryHover: textSecondaryHover ?? _textSecondaryHover,
    textTertiaryHover: textTertiaryHover ?? _textTertiaryHover,
    textBrandSecondary: textBrandSecondary ?? _textBrandSecondary,
    textPlaceholder: textPlaceholder ?? _textPlaceholder,
    textBrandTertiary: textBrandTertiary ?? _textBrandTertiary,
    textEditorIconFg: textEditorIconFg ?? _textEditorIconFg,
    textEditorIconFgActive: textEditorIconFgActive ?? _textEditorIconFgActive,
    textQuaternary: textQuaternary ?? _textQuaternary,
    textBrandPrimary: textBrandPrimary ?? _textBrandPrimary,
    textPrimaryOnBrand: textPrimaryOnBrand ?? _textPrimaryOnBrand,
    textSecondaryOnBrand: textSecondaryOnBrand ?? _textSecondaryOnBrand,
    textTertiaryOnBrand: textTertiaryOnBrand ?? _textTertiaryOnBrand,
    textQuaternaryOnBrand: textQuaternaryOnBrand ?? _textQuaternaryOnBrand,
    textBrandTertiaryAlt: textBrandTertiaryAlt ?? _textBrandTertiaryAlt,
    textErrorPrimaryHover: textErrorPrimaryHover ?? _textErrorPrimaryHover,
    textBrandSecondaryHover:
        textBrandSecondaryHover ?? _textBrandSecondaryHover,
    borderPrimary: borderPrimary ?? _borderPrimary,
    borderSecondary: borderSecondary ?? _borderSecondary,
    borderSecondaryAlt: borderSecondaryAlt ?? _borderSecondaryAlt,
    borderTertiary: borderTertiary ?? _borderTertiary,
    borderError: borderError ?? _borderError,
    borderErrorSubtle: borderErrorSubtle ?? _borderErrorSubtle,
    borderBrand: borderBrand ?? _borderBrand,
    borderBrandAlt: borderBrandAlt ?? _borderBrandAlt,
    fgSecondary: fgSecondary ?? _fgSecondary,
    fgWarningPrimary: fgWarningPrimary ?? _fgWarningPrimary,
    fgSuccessPrimary: fgSuccessPrimary ?? _fgSuccessPrimary,
    fgWhite: fgWhite ?? _fgWhite,
    fgSuccessSecondary: fgSuccessSecondary ?? _fgSuccessSecondary,
    fgSecondaryHover: fgSecondaryHover ?? _fgSecondaryHover,
    fgPrimary: fgPrimary ?? _fgPrimary,
    fgBrandSecondary: fgBrandSecondary ?? _fgBrandSecondary,
    fgBrandPrimary: fgBrandPrimary ?? _fgBrandPrimary,
    fgQuaternary: fgQuaternary ?? _fgQuaternary,
    fgQuaternaryHover: fgQuaternaryHover ?? _fgQuaternaryHover,
    fgErrorPrimary: fgErrorPrimary ?? _fgErrorPrimary,
    fgWarningSecondary: fgWarningSecondary ?? _fgWarningSecondary,
    fgErrorSecondary: fgErrorSecondary ?? _fgErrorSecondary,
    fgTertiary: fgTertiary ?? _fgTertiary,
    fgTertiaryHover: fgTertiaryHover ?? _fgTertiaryHover,
    fgBrandPrimaryAlt: fgBrandPrimaryAlt ?? _fgBrandPrimaryAlt,
    fgBrandSecondaryAlt: fgBrandSecondaryAlt ?? _fgBrandSecondaryAlt,
    fgBrandSecondaryHover: fgBrandSecondaryHover ?? _fgBrandSecondaryHover,
    bgPrimary: bgPrimary ?? _bgPrimary,
    bgTertiary: bgTertiary ?? _bgTertiary,
    bgBrandPrimary: bgBrandPrimary ?? _bgBrandPrimary,
    bgErrorSecondary: bgErrorSecondary ?? _bgErrorSecondary,
    bgWarningPrimary: bgWarningPrimary ?? _bgWarningPrimary,
    bgWarningSecondary: bgWarningSecondary ?? _bgWarningSecondary,
    bgSuccessPrimary: bgSuccessPrimary ?? _bgSuccessPrimary,
    bgSuccessSecondary: bgSuccessSecondary ?? _bgSuccessSecondary,
    bgBrandSolid: bgBrandSolid ?? _bgBrandSolid,
    bgSecondarySolid: bgSecondarySolid ?? _bgSecondarySolid,
    bgErrorSolid: bgErrorSolid ?? _bgErrorSolid,
    bgWarningSolid: bgWarningSolid ?? _bgWarningSolid,
    bgSuccessSolid: bgSuccessSolid ?? _bgSuccessSolid,
    bgSecondaryHover: bgSecondaryHover ?? _bgSecondaryHover,
    bgPrimaryHover: bgPrimaryHover ?? _bgPrimaryHover,
    bgBrandSolidHover: bgBrandSolidHover ?? _bgBrandSolidHover,
    bgErrorPrimary: bgErrorPrimary ?? _bgErrorPrimary,
    bgBrandSecondary: bgBrandSecondary ?? _bgBrandSecondary,
    bgSecondary: bgSecondary ?? _bgSecondary,
    bgQuaternary: bgQuaternary ?? _bgQuaternary,
    bgPrimaryAlt: bgPrimaryAlt ?? _bgPrimaryAlt,
    bgBrandPrimaryAlt: bgBrandPrimaryAlt ?? _bgBrandPrimaryAlt,
    bgSecondaryAlt: bgSecondaryAlt ?? _bgSecondaryAlt,
    bgOverlay: bgOverlay ?? _bgOverlay,
    bgBrandSection: bgBrandSection ?? _bgBrandSection,
    bgBrandSectionSubtle: bgBrandSectionSubtle ?? _bgBrandSectionSubtle,
    bgPrimarySolid: bgPrimarySolid ?? _bgPrimarySolid,
    bgErrorSolidHover: bgErrorSolidHover ?? _bgErrorSolidHover,
    appStoreBadgeBorder: appStoreBadgeBorder ?? _appStoreBadgeBorder,
    avatarStylesBgNeutral: avatarStylesBgNeutral ?? _avatarStylesBgNeutral,
    featuredIconLightFgBrand:
        featuredIconLightFgBrand ?? _featuredIconLightFgBrand,
    featuredIconLightFgError:
        featuredIconLightFgError ?? _featuredIconLightFgError,
    featuredIconLightFgGray:
        featuredIconLightFgGray ?? _featuredIconLightFgGray,
    featuredIconLightFgSuccess:
        featuredIconLightFgSuccess ?? _featuredIconLightFgSuccess,
    featuredIconLightFgWarning:
        featuredIconLightFgWarning ?? _featuredIconLightFgWarning,
    focusRingError: focusRingError ?? _focusRingError,
    focusRing: focusRing ?? _focusRing,
    footerButtonFg: footerButtonFg ?? _footerButtonFg,
    footerButtonFgHover: footerButtonFgHover ?? _footerButtonFgHover,
    iconFgBrand: iconFgBrand ?? _iconFgBrand,
    iconFgBrandOnBrand: iconFgBrandOnBrand ?? _iconFgBrandOnBrand,
    screenMockupBorder: screenMockupBorder ?? _screenMockupBorder,
    sliderHandleBg: sliderHandleBg ?? _sliderHandleBg,
    sliderHandleBorder: sliderHandleBorder ?? _sliderHandleBorder,
    toggleBorder: toggleBorder ?? _toggleBorder,
    toggleSlimBorderPressedHover:
        toggleSlimBorderPressedHover ?? _toggleSlimBorderPressedHover,
    toggleSlimBorderPressed:
        toggleSlimBorderPressed ?? _toggleSlimBorderPressed,
    tooltipSupportingText: tooltipSupportingText ?? _tooltipSupportingText,
    backgroundColorPrimary: backgroundColorPrimary ?? _backgroundColorPrimary,
    backgroundColorTertiary:
        backgroundColorTertiary ?? _backgroundColorTertiary,
    backgroundColorBrandPrimary:
        backgroundColorBrandPrimary ?? _backgroundColorBrandPrimary,
    backgroundColorErrorSecondary:
        backgroundColorErrorSecondary ?? _backgroundColorErrorSecondary,
    backgroundColorWarningPrimary:
        backgroundColorWarningPrimary ?? _backgroundColorWarningPrimary,
    backgroundColorWarningSecondary:
        backgroundColorWarningSecondary ?? _backgroundColorWarningSecondary,
    backgroundColorSuccessPrimary:
        backgroundColorSuccessPrimary ?? _backgroundColorSuccessPrimary,
    backgroundColorSuccessSecondary:
        backgroundColorSuccessSecondary ?? _backgroundColorSuccessSecondary,
    backgroundColorBrandSolid:
        backgroundColorBrandSolid ?? _backgroundColorBrandSolid,
    backgroundColorSecondarySolid:
        backgroundColorSecondarySolid ?? _backgroundColorSecondarySolid,
    backgroundColorErrorSolid:
        backgroundColorErrorSolid ?? _backgroundColorErrorSolid,
    backgroundColorWarningSolid:
        backgroundColorWarningSolid ?? _backgroundColorWarningSolid,
    backgroundColorSuccessSolid:
        backgroundColorSuccessSolid ?? _backgroundColorSuccessSolid,
    backgroundColorSecondaryHover:
        backgroundColorSecondaryHover ?? _backgroundColorSecondaryHover,
    backgroundColorPrimaryHover:
        backgroundColorPrimaryHover ?? _backgroundColorPrimaryHover,
    backgroundColorBrandSolidHover:
        backgroundColorBrandSolidHover ?? _backgroundColorBrandSolidHover,
    backgroundColorErrorPrimary:
        backgroundColorErrorPrimary ?? _backgroundColorErrorPrimary,
    backgroundColorBrandSecondary:
        backgroundColorBrandSecondary ?? _backgroundColorBrandSecondary,
    backgroundColorSecondary:
        backgroundColorSecondary ?? _backgroundColorSecondary,
    backgroundColorQuaternary:
        backgroundColorQuaternary ?? _backgroundColorQuaternary,
    backgroundColorPrimaryAlt:
        backgroundColorPrimaryAlt ?? _backgroundColorPrimaryAlt,
    backgroundColorBrandPrimaryAlt:
        backgroundColorBrandPrimaryAlt ?? _backgroundColorBrandPrimaryAlt,
    backgroundColorSecondaryAlt:
        backgroundColorSecondaryAlt ?? _backgroundColorSecondaryAlt,
    backgroundColorOverlay: backgroundColorOverlay ?? _backgroundColorOverlay,
    backgroundColorBrandSection:
        backgroundColorBrandSection ?? _backgroundColorBrandSection,
    backgroundColorBrandSectionSubtle:
        backgroundColorBrandSectionSubtle ?? _backgroundColorBrandSectionSubtle,
    backgroundColorPrimarySolid:
        backgroundColorPrimarySolid ?? _backgroundColorPrimarySolid,
    backgroundColorErrorSolidHover:
        backgroundColorErrorSolidHover ?? _backgroundColorErrorSolidHover,
    backgroundColorBorderBrand:
        backgroundColorBorderBrand ?? _backgroundColorBorderBrand,
    backgroundColorBorderBrandAlt:
        backgroundColorBorderBrandAlt ?? _backgroundColorBorderBrandAlt,
    textWhite: textWhite ?? _textWhite,
    textColorPrimary: textColorPrimary ?? _textColorPrimary,
    textColorSecondary: textColorSecondary ?? _textColorSecondary,
    textColorSecondaryHover:
        textColorSecondaryHover ?? _textColorSecondaryHover,
    textColorTertiary: textColorTertiary ?? _textColorTertiary,
    textColorTertiaryHover: textColorTertiaryHover ?? _textColorTertiaryHover,
    textColorErrorPrimary: textColorErrorPrimary ?? _textColorErrorPrimary,
    textColorWarningPrimary:
        textColorWarningPrimary ?? _textColorWarningPrimary,
    textColorSuccessPrimary:
        textColorSuccessPrimary ?? _textColorSuccessPrimary,
    textColorBrandSecondary:
        textColorBrandSecondary ?? _textColorBrandSecondary,
    textColorPlaceholder: textColorPlaceholder ?? _textColorPlaceholder,
    textColorBrandTertiary: textColorBrandTertiary ?? _textColorBrandTertiary,
    textColorEditorIconFg: textColorEditorIconFg ?? _textColorEditorIconFg,
    textColorEditorIconFgActive:
        textColorEditorIconFgActive ?? _textColorEditorIconFgActive,
    textColorQuaternary: textColorQuaternary ?? _textColorQuaternary,
    textColorBrandPrimary: textColorBrandPrimary ?? _textColorBrandPrimary,
    textColorPrimaryOnBrand:
        textColorPrimaryOnBrand ?? _textColorPrimaryOnBrand,
    textColorSecondaryOnBrand:
        textColorSecondaryOnBrand ?? _textColorSecondaryOnBrand,
    textColorTertiaryOnBrand:
        textColorTertiaryOnBrand ?? _textColorTertiaryOnBrand,
    textColorQuaternaryOnBrand:
        textColorQuaternaryOnBrand ?? _textColorQuaternaryOnBrand,
    textColorBrandTertiaryAlt:
        textColorBrandTertiaryAlt ?? _textColorBrandTertiaryAlt,
    textColorErrorPrimaryHover:
        textColorErrorPrimaryHover ?? _textColorErrorPrimaryHover,
    textColorBrandSecondaryHover:
        textColorBrandSecondaryHover ?? _textColorBrandSecondaryHover,
    textColorTooltipSupportingText:
        textColorTooltipSupportingText ?? _textColorTooltipSupportingText,
    borderColorPrimary: borderColorPrimary ?? _borderColorPrimary,
    borderColorSecondary: borderColorSecondary ?? _borderColorSecondary,
    borderColorSecondaryAlt:
        borderColorSecondaryAlt ?? _borderColorSecondaryAlt,
    borderColorTertiary: borderColorTertiary ?? _borderColorTertiary,
    borderColorError: borderColorError ?? _borderColorError,
    borderColorErrorSubtle: borderColorErrorSubtle ?? _borderColorErrorSubtle,
    borderColorBrand: borderColorBrand ?? _borderColorBrand,
    borderColorBrandAlt: borderColorBrandAlt ?? _borderColorBrandAlt,
    borderColorBrandSolid: borderColorBrandSolid ?? _borderColorBrandSolid,
    borderColorBrandSolidHover:
        borderColorBrandSolidHover ?? _borderColorBrandSolidHover,
    ringColorPrimary: ringColorPrimary ?? _ringColorPrimary,
    ringColorSecondary: ringColorSecondary ?? _ringColorSecondary,
    ringColorSecondaryAlt: ringColorSecondaryAlt ?? _ringColorSecondaryAlt,
    ringColorTertiary: ringColorTertiary ?? _ringColorTertiary,
    ringColorError: ringColorError ?? _ringColorError,
    ringColorErrorSubtle: ringColorErrorSubtle ?? _ringColorErrorSubtle,
    ringColorBrand: ringColorBrand ?? _ringColorBrand,
    ringColorBrandAlt: ringColorBrandAlt ?? _ringColorBrandAlt,
    ringColorBrandSolid: ringColorBrandSolid ?? _ringColorBrandSolid,
    ringColorBrandSolidHover:
        ringColorBrandSolidHover ?? _ringColorBrandSolidHover,
    outlineColorPrimary: outlineColorPrimary ?? _outlineColorPrimary,
    outlineColorSecondary: outlineColorSecondary ?? _outlineColorSecondary,
    outlineColorSecondaryAlt:
        outlineColorSecondaryAlt ?? _outlineColorSecondaryAlt,
    outlineColorTertiary: outlineColorTertiary ?? _outlineColorTertiary,
    outlineColorError: outlineColorError ?? _outlineColorError,
    outlineColorErrorSubtle:
        outlineColorErrorSubtle ?? _outlineColorErrorSubtle,
    outlineColorBrand: outlineColorBrand ?? _outlineColorBrand,
    outlineColorBrandAlt: outlineColorBrandAlt ?? _outlineColorBrandAlt,
    outlineColorBrandSolid: outlineColorBrandSolid ?? _outlineColorBrandSolid,
    outlineColorBrandSolidHover:
        outlineColorBrandSolidHover ?? _outlineColorBrandSolidHover,
    grayModern300: grayModern300 ?? _grayModern300,
    grayModern500: grayModern500 ?? _grayModern500,
    grayModern700: grayModern700 ?? _grayModern700,
    grayModern800: grayModern800 ?? _grayModern800,
  );
  UiColors lerp(UiColors other, double t) {
    if (t == 0) return this;
    if (t == 1) return other;
    return UiColors(
      dark: t < .5 ? dark : other.dark,
      backgroundColorBorderTertiary: _lerpColor(
        backgroundColorBorderTertiary,
        other.backgroundColorBorderTertiary,
        t,
      ),
      red50: _lerpColor(red50, other.red50, t),
      red100: _lerpColor(red100, other.red100, t),
      red200: _lerpColor(red200, other.red200, t),
      red300: _lerpColor(red300, other.red300, t),
      red400: _lerpColor(red400, other.red400, t),
      red500: _lerpColor(red500, other.red500, t),
      red600: _lerpColor(red600, other.red600, t),
      red700: _lerpColor(red700, other.red700, t),
      red800: _lerpColor(red800, other.red800, t),
      red900: _lerpColor(red900, other.red900, t),
      red950: _lerpColor(red950, other.red950, t),
      orange50: _lerpColor(orange50, other.orange50, t),
      orange100: _lerpColor(orange100, other.orange100, t),
      orange200: _lerpColor(orange200, other.orange200, t),
      orange300: _lerpColor(orange300, other.orange300, t),
      orange400: _lerpColor(orange400, other.orange400, t),
      orange500: _lerpColor(orange500, other.orange500, t),
      orange600: _lerpColor(orange600, other.orange600, t),
      orange700: _lerpColor(orange700, other.orange700, t),
      orange800: _lerpColor(orange800, other.orange800, t),
      orange900: _lerpColor(orange900, other.orange900, t),
      orange950: _lerpColor(orange950, other.orange950, t),
      amber50: _lerpColor(amber50, other.amber50, t),
      amber100: _lerpColor(amber100, other.amber100, t),
      amber200: _lerpColor(amber200, other.amber200, t),
      amber300: _lerpColor(amber300, other.amber300, t),
      amber400: _lerpColor(amber400, other.amber400, t),
      amber500: _lerpColor(amber500, other.amber500, t),
      amber600: _lerpColor(amber600, other.amber600, t),
      amber700: _lerpColor(amber700, other.amber700, t),
      amber800: _lerpColor(amber800, other.amber800, t),
      amber900: _lerpColor(amber900, other.amber900, t),
      amber950: _lerpColor(amber950, other.amber950, t),
      yellow50: _lerpColor(yellow50, other.yellow50, t),
      yellow100: _lerpColor(yellow100, other.yellow100, t),
      yellow200: _lerpColor(yellow200, other.yellow200, t),
      yellow300: _lerpColor(yellow300, other.yellow300, t),
      yellow400: _lerpColor(yellow400, other.yellow400, t),
      yellow500: _lerpColor(yellow500, other.yellow500, t),
      yellow600: _lerpColor(yellow600, other.yellow600, t),
      yellow700: _lerpColor(yellow700, other.yellow700, t),
      yellow800: _lerpColor(yellow800, other.yellow800, t),
      yellow900: _lerpColor(yellow900, other.yellow900, t),
      yellow950: _lerpColor(yellow950, other.yellow950, t),
      lime50: _lerpColor(lime50, other.lime50, t),
      lime100: _lerpColor(lime100, other.lime100, t),
      lime200: _lerpColor(lime200, other.lime200, t),
      lime300: _lerpColor(lime300, other.lime300, t),
      lime400: _lerpColor(lime400, other.lime400, t),
      lime500: _lerpColor(lime500, other.lime500, t),
      lime600: _lerpColor(lime600, other.lime600, t),
      lime700: _lerpColor(lime700, other.lime700, t),
      lime800: _lerpColor(lime800, other.lime800, t),
      lime900: _lerpColor(lime900, other.lime900, t),
      lime950: _lerpColor(lime950, other.lime950, t),
      green50: _lerpColor(green50, other.green50, t),
      green100: _lerpColor(green100, other.green100, t),
      green200: _lerpColor(green200, other.green200, t),
      green300: _lerpColor(green300, other.green300, t),
      green400: _lerpColor(green400, other.green400, t),
      green500: _lerpColor(green500, other.green500, t),
      green600: _lerpColor(green600, other.green600, t),
      green700: _lerpColor(green700, other.green700, t),
      green800: _lerpColor(green800, other.green800, t),
      green900: _lerpColor(green900, other.green900, t),
      green950: _lerpColor(green950, other.green950, t),
      emerald50: _lerpColor(emerald50, other.emerald50, t),
      emerald100: _lerpColor(emerald100, other.emerald100, t),
      emerald200: _lerpColor(emerald200, other.emerald200, t),
      emerald300: _lerpColor(emerald300, other.emerald300, t),
      emerald400: _lerpColor(emerald400, other.emerald400, t),
      emerald500: _lerpColor(emerald500, other.emerald500, t),
      emerald600: _lerpColor(emerald600, other.emerald600, t),
      emerald700: _lerpColor(emerald700, other.emerald700, t),
      emerald800: _lerpColor(emerald800, other.emerald800, t),
      emerald900: _lerpColor(emerald900, other.emerald900, t),
      emerald950: _lerpColor(emerald950, other.emerald950, t),
      teal50: _lerpColor(teal50, other.teal50, t),
      teal100: _lerpColor(teal100, other.teal100, t),
      teal200: _lerpColor(teal200, other.teal200, t),
      teal300: _lerpColor(teal300, other.teal300, t),
      teal400: _lerpColor(teal400, other.teal400, t),
      teal500: _lerpColor(teal500, other.teal500, t),
      teal600: _lerpColor(teal600, other.teal600, t),
      teal700: _lerpColor(teal700, other.teal700, t),
      teal800: _lerpColor(teal800, other.teal800, t),
      teal900: _lerpColor(teal900, other.teal900, t),
      teal950: _lerpColor(teal950, other.teal950, t),
      cyan50: _lerpColor(cyan50, other.cyan50, t),
      cyan100: _lerpColor(cyan100, other.cyan100, t),
      cyan200: _lerpColor(cyan200, other.cyan200, t),
      cyan300: _lerpColor(cyan300, other.cyan300, t),
      cyan400: _lerpColor(cyan400, other.cyan400, t),
      cyan500: _lerpColor(cyan500, other.cyan500, t),
      cyan600: _lerpColor(cyan600, other.cyan600, t),
      cyan700: _lerpColor(cyan700, other.cyan700, t),
      cyan800: _lerpColor(cyan800, other.cyan800, t),
      cyan900: _lerpColor(cyan900, other.cyan900, t),
      cyan950: _lerpColor(cyan950, other.cyan950, t),
      sky50: _lerpColor(sky50, other.sky50, t),
      sky100: _lerpColor(sky100, other.sky100, t),
      sky200: _lerpColor(sky200, other.sky200, t),
      sky300: _lerpColor(sky300, other.sky300, t),
      sky400: _lerpColor(sky400, other.sky400, t),
      sky500: _lerpColor(sky500, other.sky500, t),
      sky600: _lerpColor(sky600, other.sky600, t),
      sky700: _lerpColor(sky700, other.sky700, t),
      sky800: _lerpColor(sky800, other.sky800, t),
      sky900: _lerpColor(sky900, other.sky900, t),
      sky950: _lerpColor(sky950, other.sky950, t),
      blue50: _lerpColor(blue50, other.blue50, t),
      blue100: _lerpColor(blue100, other.blue100, t),
      blue200: _lerpColor(blue200, other.blue200, t),
      blue300: _lerpColor(blue300, other.blue300, t),
      blue400: _lerpColor(blue400, other.blue400, t),
      blue500: _lerpColor(blue500, other.blue500, t),
      blue600: _lerpColor(blue600, other.blue600, t),
      blue700: _lerpColor(blue700, other.blue700, t),
      blue800: _lerpColor(blue800, other.blue800, t),
      blue900: _lerpColor(blue900, other.blue900, t),
      blue950: _lerpColor(blue950, other.blue950, t),
      indigo50: _lerpColor(indigo50, other.indigo50, t),
      indigo100: _lerpColor(indigo100, other.indigo100, t),
      indigo200: _lerpColor(indigo200, other.indigo200, t),
      indigo300: _lerpColor(indigo300, other.indigo300, t),
      indigo400: _lerpColor(indigo400, other.indigo400, t),
      indigo500: _lerpColor(indigo500, other.indigo500, t),
      indigo600: _lerpColor(indigo600, other.indigo600, t),
      indigo700: _lerpColor(indigo700, other.indigo700, t),
      indigo800: _lerpColor(indigo800, other.indigo800, t),
      indigo900: _lerpColor(indigo900, other.indigo900, t),
      indigo950: _lerpColor(indigo950, other.indigo950, t),
      violet50: _lerpColor(violet50, other.violet50, t),
      violet100: _lerpColor(violet100, other.violet100, t),
      violet200: _lerpColor(violet200, other.violet200, t),
      violet300: _lerpColor(violet300, other.violet300, t),
      violet400: _lerpColor(violet400, other.violet400, t),
      violet500: _lerpColor(violet500, other.violet500, t),
      violet600: _lerpColor(violet600, other.violet600, t),
      violet700: _lerpColor(violet700, other.violet700, t),
      violet800: _lerpColor(violet800, other.violet800, t),
      violet900: _lerpColor(violet900, other.violet900, t),
      violet950: _lerpColor(violet950, other.violet950, t),
      purple50: _lerpColor(purple50, other.purple50, t),
      purple100: _lerpColor(purple100, other.purple100, t),
      purple200: _lerpColor(purple200, other.purple200, t),
      purple300: _lerpColor(purple300, other.purple300, t),
      purple400: _lerpColor(purple400, other.purple400, t),
      purple500: _lerpColor(purple500, other.purple500, t),
      purple600: _lerpColor(purple600, other.purple600, t),
      purple700: _lerpColor(purple700, other.purple700, t),
      purple800: _lerpColor(purple800, other.purple800, t),
      purple900: _lerpColor(purple900, other.purple900, t),
      purple950: _lerpColor(purple950, other.purple950, t),
      fuchsia50: _lerpColor(fuchsia50, other.fuchsia50, t),
      fuchsia100: _lerpColor(fuchsia100, other.fuchsia100, t),
      fuchsia200: _lerpColor(fuchsia200, other.fuchsia200, t),
      fuchsia300: _lerpColor(fuchsia300, other.fuchsia300, t),
      fuchsia400: _lerpColor(fuchsia400, other.fuchsia400, t),
      fuchsia500: _lerpColor(fuchsia500, other.fuchsia500, t),
      fuchsia600: _lerpColor(fuchsia600, other.fuchsia600, t),
      fuchsia700: _lerpColor(fuchsia700, other.fuchsia700, t),
      fuchsia800: _lerpColor(fuchsia800, other.fuchsia800, t),
      fuchsia900: _lerpColor(fuchsia900, other.fuchsia900, t),
      fuchsia950: _lerpColor(fuchsia950, other.fuchsia950, t),
      pink50: _lerpColor(pink50, other.pink50, t),
      pink100: _lerpColor(pink100, other.pink100, t),
      pink200: _lerpColor(pink200, other.pink200, t),
      pink300: _lerpColor(pink300, other.pink300, t),
      pink400: _lerpColor(pink400, other.pink400, t),
      pink500: _lerpColor(pink500, other.pink500, t),
      pink600: _lerpColor(pink600, other.pink600, t),
      pink700: _lerpColor(pink700, other.pink700, t),
      pink800: _lerpColor(pink800, other.pink800, t),
      pink900: _lerpColor(pink900, other.pink900, t),
      pink950: _lerpColor(pink950, other.pink950, t),
      rose50: _lerpColor(rose50, other.rose50, t),
      rose100: _lerpColor(rose100, other.rose100, t),
      rose200: _lerpColor(rose200, other.rose200, t),
      rose300: _lerpColor(rose300, other.rose300, t),
      rose400: _lerpColor(rose400, other.rose400, t),
      rose500: _lerpColor(rose500, other.rose500, t),
      rose600: _lerpColor(rose600, other.rose600, t),
      rose700: _lerpColor(rose700, other.rose700, t),
      rose800: _lerpColor(rose800, other.rose800, t),
      rose900: _lerpColor(rose900, other.rose900, t),
      rose950: _lerpColor(rose950, other.rose950, t),
      slate50: _lerpColor(slate50, other.slate50, t),
      slate100: _lerpColor(slate100, other.slate100, t),
      slate200: _lerpColor(slate200, other.slate200, t),
      slate300: _lerpColor(slate300, other.slate300, t),
      slate400: _lerpColor(slate400, other.slate400, t),
      slate500: _lerpColor(slate500, other.slate500, t),
      slate600: _lerpColor(slate600, other.slate600, t),
      slate700: _lerpColor(slate700, other.slate700, t),
      slate800: _lerpColor(slate800, other.slate800, t),
      slate900: _lerpColor(slate900, other.slate900, t),
      slate950: _lerpColor(slate950, other.slate950, t),
      gray50: _lerpColor(gray50, other.gray50, t),
      gray100: _lerpColor(gray100, other.gray100, t),
      gray200: _lerpColor(gray200, other.gray200, t),
      gray300: _lerpColor(gray300, other.gray300, t),
      gray400: _lerpColor(gray400, other.gray400, t),
      gray500: _lerpColor(gray500, other.gray500, t),
      gray600: _lerpColor(gray600, other.gray600, t),
      gray700: _lerpColor(gray700, other.gray700, t),
      gray800: _lerpColor(gray800, other.gray800, t),
      gray900: _lerpColor(gray900, other.gray900, t),
      gray950: _lerpColor(gray950, other.gray950, t),
      zinc50: _lerpColor(zinc50, other.zinc50, t),
      zinc100: _lerpColor(zinc100, other.zinc100, t),
      zinc200: _lerpColor(zinc200, other.zinc200, t),
      zinc300: _lerpColor(zinc300, other.zinc300, t),
      zinc400: _lerpColor(zinc400, other.zinc400, t),
      zinc500: _lerpColor(zinc500, other.zinc500, t),
      zinc600: _lerpColor(zinc600, other.zinc600, t),
      zinc700: _lerpColor(zinc700, other.zinc700, t),
      zinc800: _lerpColor(zinc800, other.zinc800, t),
      zinc900: _lerpColor(zinc900, other.zinc900, t),
      zinc950: _lerpColor(zinc950, other.zinc950, t),
      neutral50: _lerpColor(neutral50, other.neutral50, t),
      neutral100: _lerpColor(neutral100, other.neutral100, t),
      neutral200: _lerpColor(neutral200, other.neutral200, t),
      neutral300: _lerpColor(neutral300, other.neutral300, t),
      neutral400: _lerpColor(neutral400, other.neutral400, t),
      neutral500: _lerpColor(neutral500, other.neutral500, t),
      neutral600: _lerpColor(neutral600, other.neutral600, t),
      neutral700: _lerpColor(neutral700, other.neutral700, t),
      neutral800: _lerpColor(neutral800, other.neutral800, t),
      neutral900: _lerpColor(neutral900, other.neutral900, t),
      neutral950: _lerpColor(neutral950, other.neutral950, t),
      stone50: _lerpColor(stone50, other.stone50, t),
      stone100: _lerpColor(stone100, other.stone100, t),
      stone200: _lerpColor(stone200, other.stone200, t),
      stone300: _lerpColor(stone300, other.stone300, t),
      stone400: _lerpColor(stone400, other.stone400, t),
      stone500: _lerpColor(stone500, other.stone500, t),
      stone600: _lerpColor(stone600, other.stone600, t),
      stone700: _lerpColor(stone700, other.stone700, t),
      stone800: _lerpColor(stone800, other.stone800, t),
      stone900: _lerpColor(stone900, other.stone900, t),
      stone950: _lerpColor(stone950, other.stone950, t),
      mauve50: _lerpColor(mauve50, other.mauve50, t),
      mauve100: _lerpColor(mauve100, other.mauve100, t),
      mauve200: _lerpColor(mauve200, other.mauve200, t),
      mauve300: _lerpColor(mauve300, other.mauve300, t),
      mauve400: _lerpColor(mauve400, other.mauve400, t),
      mauve500: _lerpColor(mauve500, other.mauve500, t),
      mauve600: _lerpColor(mauve600, other.mauve600, t),
      mauve700: _lerpColor(mauve700, other.mauve700, t),
      mauve800: _lerpColor(mauve800, other.mauve800, t),
      mauve900: _lerpColor(mauve900, other.mauve900, t),
      mauve950: _lerpColor(mauve950, other.mauve950, t),
      olive50: _lerpColor(olive50, other.olive50, t),
      olive100: _lerpColor(olive100, other.olive100, t),
      olive200: _lerpColor(olive200, other.olive200, t),
      olive300: _lerpColor(olive300, other.olive300, t),
      olive400: _lerpColor(olive400, other.olive400, t),
      olive500: _lerpColor(olive500, other.olive500, t),
      olive600: _lerpColor(olive600, other.olive600, t),
      olive700: _lerpColor(olive700, other.olive700, t),
      olive800: _lerpColor(olive800, other.olive800, t),
      olive900: _lerpColor(olive900, other.olive900, t),
      olive950: _lerpColor(olive950, other.olive950, t),
      mist50: _lerpColor(mist50, other.mist50, t),
      mist100: _lerpColor(mist100, other.mist100, t),
      mist200: _lerpColor(mist200, other.mist200, t),
      mist300: _lerpColor(mist300, other.mist300, t),
      mist400: _lerpColor(mist400, other.mist400, t),
      mist500: _lerpColor(mist500, other.mist500, t),
      mist600: _lerpColor(mist600, other.mist600, t),
      mist700: _lerpColor(mist700, other.mist700, t),
      mist800: _lerpColor(mist800, other.mist800, t),
      mist900: _lerpColor(mist900, other.mist900, t),
      mist950: _lerpColor(mist950, other.mist950, t),
      taupe50: _lerpColor(taupe50, other.taupe50, t),
      taupe100: _lerpColor(taupe100, other.taupe100, t),
      taupe200: _lerpColor(taupe200, other.taupe200, t),
      taupe300: _lerpColor(taupe300, other.taupe300, t),
      taupe400: _lerpColor(taupe400, other.taupe400, t),
      taupe500: _lerpColor(taupe500, other.taupe500, t),
      taupe600: _lerpColor(taupe600, other.taupe600, t),
      taupe700: _lerpColor(taupe700, other.taupe700, t),
      taupe800: _lerpColor(taupe800, other.taupe800, t),
      taupe900: _lerpColor(taupe900, other.taupe900, t),
      taupe950: _lerpColor(taupe950, other.taupe950, t),
      black: _lerpColor(black, other.black, t),
      white: _lerpColor(white, other.white, t),
      transparent: _lerpColor(transparent, other.transparent, t),
      alphaWhite: _lerpColor(alphaWhite, other.alphaWhite, t),
      alphaBlack: _lerpColor(alphaBlack, other.alphaBlack, t),
      brand50: _lerpColor(brand50, other.brand50, t),
      brand100: _lerpColor(brand100, other.brand100, t),
      brand200: _lerpColor(brand200, other.brand200, t),
      brand300: _lerpColor(brand300, other.brand300, t),
      brand400: _lerpColor(brand400, other.brand400, t),
      brand500: _lerpColor(brand500, other.brand500, t),
      brand600: _lerpColor(brand600, other.brand600, t),
      brand700: _lerpColor(brand700, other.brand700, t),
      brand800: _lerpColor(brand800, other.brand800, t),
      brand900: _lerpColor(brand900, other.brand900, t),
      brand950: _lerpColor(brand950, other.brand950, t),
      utilityBlue50: _lerpColor(utilityBlue50, other.utilityBlue50, t),
      utilityBlue100: _lerpColor(utilityBlue100, other.utilityBlue100, t),
      utilityBlue200: _lerpColor(utilityBlue200, other.utilityBlue200, t),
      utilityBlue300: _lerpColor(utilityBlue300, other.utilityBlue300, t),
      utilityBlue400: _lerpColor(utilityBlue400, other.utilityBlue400, t),
      utilityBlue500: _lerpColor(utilityBlue500, other.utilityBlue500, t),
      utilityBlue600: _lerpColor(utilityBlue600, other.utilityBlue600, t),
      utilityBlue700: _lerpColor(utilityBlue700, other.utilityBlue700, t),
      utilityBrand50: _lerpColor(utilityBrand50, other.utilityBrand50, t),
      utilityBrand50Alt: _lerpColor(
        utilityBrand50Alt,
        other.utilityBrand50Alt,
        t,
      ),
      utilityBrand100: _lerpColor(utilityBrand100, other.utilityBrand100, t),
      utilityBrand100Alt: _lerpColor(
        utilityBrand100Alt,
        other.utilityBrand100Alt,
        t,
      ),
      utilityBrand200: _lerpColor(utilityBrand200, other.utilityBrand200, t),
      utilityBrand200Alt: _lerpColor(
        utilityBrand200Alt,
        other.utilityBrand200Alt,
        t,
      ),
      utilityBrand300: _lerpColor(utilityBrand300, other.utilityBrand300, t),
      utilityBrand300Alt: _lerpColor(
        utilityBrand300Alt,
        other.utilityBrand300Alt,
        t,
      ),
      utilityBrand400: _lerpColor(utilityBrand400, other.utilityBrand400, t),
      utilityBrand400Alt: _lerpColor(
        utilityBrand400Alt,
        other.utilityBrand400Alt,
        t,
      ),
      utilityBrand500: _lerpColor(utilityBrand500, other.utilityBrand500, t),
      utilityBrand500Alt: _lerpColor(
        utilityBrand500Alt,
        other.utilityBrand500Alt,
        t,
      ),
      utilityBrand600: _lerpColor(utilityBrand600, other.utilityBrand600, t),
      utilityBrand600Alt: _lerpColor(
        utilityBrand600Alt,
        other.utilityBrand600Alt,
        t,
      ),
      utilityBrand700: _lerpColor(utilityBrand700, other.utilityBrand700, t),
      utilityBrand700Alt: _lerpColor(
        utilityBrand700Alt,
        other.utilityBrand700Alt,
        t,
      ),
      utilityBrand800: _lerpColor(utilityBrand800, other.utilityBrand800, t),
      utilityBrand800Alt: _lerpColor(
        utilityBrand800Alt,
        other.utilityBrand800Alt,
        t,
      ),
      utilityBrand900: _lerpColor(utilityBrand900, other.utilityBrand900, t),
      utilityBrand900Alt: _lerpColor(
        utilityBrand900Alt,
        other.utilityBrand900Alt,
        t,
      ),
      utilityNeutral50: _lerpColor(utilityNeutral50, other.utilityNeutral50, t),
      utilityNeutral100: _lerpColor(
        utilityNeutral100,
        other.utilityNeutral100,
        t,
      ),
      utilityNeutral200: _lerpColor(
        utilityNeutral200,
        other.utilityNeutral200,
        t,
      ),
      utilityNeutral300: _lerpColor(
        utilityNeutral300,
        other.utilityNeutral300,
        t,
      ),
      utilityNeutral400: _lerpColor(
        utilityNeutral400,
        other.utilityNeutral400,
        t,
      ),
      utilityNeutral500: _lerpColor(
        utilityNeutral500,
        other.utilityNeutral500,
        t,
      ),
      utilityNeutral600: _lerpColor(
        utilityNeutral600,
        other.utilityNeutral600,
        t,
      ),
      utilityNeutral700: _lerpColor(
        utilityNeutral700,
        other.utilityNeutral700,
        t,
      ),
      utilityNeutral800: _lerpColor(
        utilityNeutral800,
        other.utilityNeutral800,
        t,
      ),
      utilityNeutral900: _lerpColor(
        utilityNeutral900,
        other.utilityNeutral900,
        t,
      ),
      utilityRed50: _lerpColor(utilityRed50, other.utilityRed50, t),
      utilityRed100: _lerpColor(utilityRed100, other.utilityRed100, t),
      utilityRed200: _lerpColor(utilityRed200, other.utilityRed200, t),
      utilityRed300: _lerpColor(utilityRed300, other.utilityRed300, t),
      utilityRed400: _lerpColor(utilityRed400, other.utilityRed400, t),
      utilityRed500: _lerpColor(utilityRed500, other.utilityRed500, t),
      utilityRed600: _lerpColor(utilityRed600, other.utilityRed600, t),
      utilityRed700: _lerpColor(utilityRed700, other.utilityRed700, t),
      utilityYellow50: _lerpColor(utilityYellow50, other.utilityYellow50, t),
      utilityYellow100: _lerpColor(utilityYellow100, other.utilityYellow100, t),
      utilityYellow200: _lerpColor(utilityYellow200, other.utilityYellow200, t),
      utilityYellow300: _lerpColor(utilityYellow300, other.utilityYellow300, t),
      utilityYellow400: _lerpColor(utilityYellow400, other.utilityYellow400, t),
      utilityYellow500: _lerpColor(utilityYellow500, other.utilityYellow500, t),
      utilityYellow600: _lerpColor(utilityYellow600, other.utilityYellow600, t),
      utilityYellow700: _lerpColor(utilityYellow700, other.utilityYellow700, t),
      utilityGreen50: _lerpColor(utilityGreen50, other.utilityGreen50, t),
      utilityGreen100: _lerpColor(utilityGreen100, other.utilityGreen100, t),
      utilityGreen200: _lerpColor(utilityGreen200, other.utilityGreen200, t),
      utilityGreen300: _lerpColor(utilityGreen300, other.utilityGreen300, t),
      utilityGreen400: _lerpColor(utilityGreen400, other.utilityGreen400, t),
      utilityGreen500: _lerpColor(utilityGreen500, other.utilityGreen500, t),
      utilityGreen600: _lerpColor(utilityGreen600, other.utilityGreen600, t),
      utilityGreen700: _lerpColor(utilityGreen700, other.utilityGreen700, t),
      utilityOrange50: _lerpColor(utilityOrange50, other.utilityOrange50, t),
      utilityOrange100: _lerpColor(utilityOrange100, other.utilityOrange100, t),
      utilityOrange200: _lerpColor(utilityOrange200, other.utilityOrange200, t),
      utilityOrange300: _lerpColor(utilityOrange300, other.utilityOrange300, t),
      utilityOrange400: _lerpColor(utilityOrange400, other.utilityOrange400, t),
      utilityOrange500: _lerpColor(utilityOrange500, other.utilityOrange500, t),
      utilityOrange600: _lerpColor(utilityOrange600, other.utilityOrange600, t),
      utilityOrange700: _lerpColor(utilityOrange700, other.utilityOrange700, t),
      utilityIndigo50: _lerpColor(utilityIndigo50, other.utilityIndigo50, t),
      utilityIndigo100: _lerpColor(utilityIndigo100, other.utilityIndigo100, t),
      utilityIndigo200: _lerpColor(utilityIndigo200, other.utilityIndigo200, t),
      utilityIndigo300: _lerpColor(utilityIndigo300, other.utilityIndigo300, t),
      utilityIndigo400: _lerpColor(utilityIndigo400, other.utilityIndigo400, t),
      utilityIndigo500: _lerpColor(utilityIndigo500, other.utilityIndigo500, t),
      utilityIndigo600: _lerpColor(utilityIndigo600, other.utilityIndigo600, t),
      utilityIndigo700: _lerpColor(utilityIndigo700, other.utilityIndigo700, t),
      utilityFuchsia50: _lerpColor(utilityFuchsia50, other.utilityFuchsia50, t),
      utilityFuchsia100: _lerpColor(
        utilityFuchsia100,
        other.utilityFuchsia100,
        t,
      ),
      utilityFuchsia200: _lerpColor(
        utilityFuchsia200,
        other.utilityFuchsia200,
        t,
      ),
      utilityFuchsia300: _lerpColor(
        utilityFuchsia300,
        other.utilityFuchsia300,
        t,
      ),
      utilityFuchsia400: _lerpColor(
        utilityFuchsia400,
        other.utilityFuchsia400,
        t,
      ),
      utilityFuchsia500: _lerpColor(
        utilityFuchsia500,
        other.utilityFuchsia500,
        t,
      ),
      utilityFuchsia600: _lerpColor(
        utilityFuchsia600,
        other.utilityFuchsia600,
        t,
      ),
      utilityFuchsia700: _lerpColor(
        utilityFuchsia700,
        other.utilityFuchsia700,
        t,
      ),
      utilityPink50: _lerpColor(utilityPink50, other.utilityPink50, t),
      utilityPink100: _lerpColor(utilityPink100, other.utilityPink100, t),
      utilityPink200: _lerpColor(utilityPink200, other.utilityPink200, t),
      utilityPink300: _lerpColor(utilityPink300, other.utilityPink300, t),
      utilityPink400: _lerpColor(utilityPink400, other.utilityPink400, t),
      utilityPink500: _lerpColor(utilityPink500, other.utilityPink500, t),
      utilityPink600: _lerpColor(utilityPink600, other.utilityPink600, t),
      utilityPink700: _lerpColor(utilityPink700, other.utilityPink700, t),
      utilityPurple50: _lerpColor(utilityPurple50, other.utilityPurple50, t),
      utilityPurple100: _lerpColor(utilityPurple100, other.utilityPurple100, t),
      utilityPurple200: _lerpColor(utilityPurple200, other.utilityPurple200, t),
      utilityPurple300: _lerpColor(utilityPurple300, other.utilityPurple300, t),
      utilityPurple400: _lerpColor(utilityPurple400, other.utilityPurple400, t),
      utilityPurple500: _lerpColor(utilityPurple500, other.utilityPurple500, t),
      utilityPurple600: _lerpColor(utilityPurple600, other.utilityPurple600, t),
      utilityPurple700: _lerpColor(utilityPurple700, other.utilityPurple700, t),
      utilitySky50: _lerpColor(utilitySky50, other.utilitySky50, t),
      utilitySky100: _lerpColor(utilitySky100, other.utilitySky100, t),
      utilitySky200: _lerpColor(utilitySky200, other.utilitySky200, t),
      utilitySky300: _lerpColor(utilitySky300, other.utilitySky300, t),
      utilitySky400: _lerpColor(utilitySky400, other.utilitySky400, t),
      utilitySky500: _lerpColor(utilitySky500, other.utilitySky500, t),
      utilitySky600: _lerpColor(utilitySky600, other.utilitySky600, t),
      utilitySky700: _lerpColor(utilitySky700, other.utilitySky700, t),
      utilitySlate50: _lerpColor(utilitySlate50, other.utilitySlate50, t),
      utilitySlate100: _lerpColor(utilitySlate100, other.utilitySlate100, t),
      utilitySlate200: _lerpColor(utilitySlate200, other.utilitySlate200, t),
      utilitySlate300: _lerpColor(utilitySlate300, other.utilitySlate300, t),
      utilitySlate400: _lerpColor(utilitySlate400, other.utilitySlate400, t),
      utilitySlate500: _lerpColor(utilitySlate500, other.utilitySlate500, t),
      utilitySlate600: _lerpColor(utilitySlate600, other.utilitySlate600, t),
      utilitySlate700: _lerpColor(utilitySlate700, other.utilitySlate700, t),
      utilityEmerald50: _lerpColor(utilityEmerald50, other.utilityEmerald50, t),
      utilityEmerald100: _lerpColor(
        utilityEmerald100,
        other.utilityEmerald100,
        t,
      ),
      utilityEmerald200: _lerpColor(
        utilityEmerald200,
        other.utilityEmerald200,
        t,
      ),
      utilityEmerald300: _lerpColor(
        utilityEmerald300,
        other.utilityEmerald300,
        t,
      ),
      utilityEmerald400: _lerpColor(
        utilityEmerald400,
        other.utilityEmerald400,
        t,
      ),
      utilityEmerald500: _lerpColor(
        utilityEmerald500,
        other.utilityEmerald500,
        t,
      ),
      utilityEmerald600: _lerpColor(
        utilityEmerald600,
        other.utilityEmerald600,
        t,
      ),
      utilityEmerald700: _lerpColor(
        utilityEmerald700,
        other.utilityEmerald700,
        t,
      ),
      utilityAmber50: _lerpColor(utilityAmber50, other.utilityAmber50, t),
      utilityAmber100: _lerpColor(utilityAmber100, other.utilityAmber100, t),
      utilityAmber200: _lerpColor(utilityAmber200, other.utilityAmber200, t),
      utilityAmber300: _lerpColor(utilityAmber300, other.utilityAmber300, t),
      utilityAmber400: _lerpColor(utilityAmber400, other.utilityAmber400, t),
      utilityAmber500: _lerpColor(utilityAmber500, other.utilityAmber500, t),
      utilityAmber600: _lerpColor(utilityAmber600, other.utilityAmber600, t),
      utilityAmber700: _lerpColor(utilityAmber700, other.utilityAmber700, t),
      textPrimary: _lerpColor(textPrimary, other.textPrimary, t),
      textTertiary: _lerpColor(textTertiary, other.textTertiary, t),
      textErrorPrimary: _lerpColor(textErrorPrimary, other.textErrorPrimary, t),
      textWarningPrimary: _lerpColor(
        textWarningPrimary,
        other.textWarningPrimary,
        t,
      ),
      textSuccessPrimary: _lerpColor(
        textSuccessPrimary,
        other.textSuccessPrimary,
        t,
      ),
      textSecondary: _lerpColor(textSecondary, other.textSecondary, t),
      textSecondaryHover: _lerpColor(
        textSecondaryHover,
        other.textSecondaryHover,
        t,
      ),
      textTertiaryHover: _lerpColor(
        textTertiaryHover,
        other.textTertiaryHover,
        t,
      ),
      textBrandSecondary: _lerpColor(
        textBrandSecondary,
        other.textBrandSecondary,
        t,
      ),
      textPlaceholder: _lerpColor(textPlaceholder, other.textPlaceholder, t),
      textBrandTertiary: _lerpColor(
        textBrandTertiary,
        other.textBrandTertiary,
        t,
      ),
      textEditorIconFg: _lerpColor(textEditorIconFg, other.textEditorIconFg, t),
      textEditorIconFgActive: _lerpColor(
        textEditorIconFgActive,
        other.textEditorIconFgActive,
        t,
      ),
      textQuaternary: _lerpColor(textQuaternary, other.textQuaternary, t),
      textBrandPrimary: _lerpColor(textBrandPrimary, other.textBrandPrimary, t),
      textPrimaryOnBrand: _lerpColor(
        textPrimaryOnBrand,
        other.textPrimaryOnBrand,
        t,
      ),
      textSecondaryOnBrand: _lerpColor(
        textSecondaryOnBrand,
        other.textSecondaryOnBrand,
        t,
      ),
      textTertiaryOnBrand: _lerpColor(
        textTertiaryOnBrand,
        other.textTertiaryOnBrand,
        t,
      ),
      textQuaternaryOnBrand: _lerpColor(
        textQuaternaryOnBrand,
        other.textQuaternaryOnBrand,
        t,
      ),
      textBrandTertiaryAlt: _lerpColor(
        textBrandTertiaryAlt,
        other.textBrandTertiaryAlt,
        t,
      ),
      textErrorPrimaryHover: _lerpColor(
        textErrorPrimaryHover,
        other.textErrorPrimaryHover,
        t,
      ),
      textBrandSecondaryHover: _lerpColor(
        textBrandSecondaryHover,
        other.textBrandSecondaryHover,
        t,
      ),
      borderPrimary: _lerpColor(borderPrimary, other.borderPrimary, t),
      borderSecondary: _lerpColor(borderSecondary, other.borderSecondary, t),
      borderSecondaryAlt: _lerpColor(
        borderSecondaryAlt,
        other.borderSecondaryAlt,
        t,
      ),
      borderTertiary: _lerpColor(borderTertiary, other.borderTertiary, t),
      borderError: _lerpColor(borderError, other.borderError, t),
      borderErrorSubtle: _lerpColor(
        borderErrorSubtle,
        other.borderErrorSubtle,
        t,
      ),
      borderBrand: _lerpColor(borderBrand, other.borderBrand, t),
      borderBrandAlt: _lerpColor(borderBrandAlt, other.borderBrandAlt, t),
      fgSecondary: _lerpColor(fgSecondary, other.fgSecondary, t),
      fgWarningPrimary: _lerpColor(fgWarningPrimary, other.fgWarningPrimary, t),
      fgSuccessPrimary: _lerpColor(fgSuccessPrimary, other.fgSuccessPrimary, t),
      fgWhite: _lerpColor(fgWhite, other.fgWhite, t),
      fgSuccessSecondary: _lerpColor(
        fgSuccessSecondary,
        other.fgSuccessSecondary,
        t,
      ),
      fgSecondaryHover: _lerpColor(fgSecondaryHover, other.fgSecondaryHover, t),
      fgPrimary: _lerpColor(fgPrimary, other.fgPrimary, t),
      fgBrandSecondary: _lerpColor(fgBrandSecondary, other.fgBrandSecondary, t),
      fgBrandPrimary: _lerpColor(fgBrandPrimary, other.fgBrandPrimary, t),
      fgQuaternary: _lerpColor(fgQuaternary, other.fgQuaternary, t),
      fgQuaternaryHover: _lerpColor(
        fgQuaternaryHover,
        other.fgQuaternaryHover,
        t,
      ),
      fgErrorPrimary: _lerpColor(fgErrorPrimary, other.fgErrorPrimary, t),
      fgWarningSecondary: _lerpColor(
        fgWarningSecondary,
        other.fgWarningSecondary,
        t,
      ),
      fgErrorSecondary: _lerpColor(fgErrorSecondary, other.fgErrorSecondary, t),
      fgTertiary: _lerpColor(fgTertiary, other.fgTertiary, t),
      fgTertiaryHover: _lerpColor(fgTertiaryHover, other.fgTertiaryHover, t),
      fgBrandPrimaryAlt: _lerpColor(
        fgBrandPrimaryAlt,
        other.fgBrandPrimaryAlt,
        t,
      ),
      fgBrandSecondaryAlt: _lerpColor(
        fgBrandSecondaryAlt,
        other.fgBrandSecondaryAlt,
        t,
      ),
      fgBrandSecondaryHover: _lerpColor(
        fgBrandSecondaryHover,
        other.fgBrandSecondaryHover,
        t,
      ),
      bgPrimary: _lerpColor(bgPrimary, other.bgPrimary, t),
      bgTertiary: _lerpColor(bgTertiary, other.bgTertiary, t),
      bgBrandPrimary: _lerpColor(bgBrandPrimary, other.bgBrandPrimary, t),
      bgErrorSecondary: _lerpColor(bgErrorSecondary, other.bgErrorSecondary, t),
      bgWarningPrimary: _lerpColor(bgWarningPrimary, other.bgWarningPrimary, t),
      bgWarningSecondary: _lerpColor(
        bgWarningSecondary,
        other.bgWarningSecondary,
        t,
      ),
      bgSuccessPrimary: _lerpColor(bgSuccessPrimary, other.bgSuccessPrimary, t),
      bgSuccessSecondary: _lerpColor(
        bgSuccessSecondary,
        other.bgSuccessSecondary,
        t,
      ),
      bgBrandSolid: _lerpColor(bgBrandSolid, other.bgBrandSolid, t),
      bgSecondarySolid: _lerpColor(bgSecondarySolid, other.bgSecondarySolid, t),
      bgErrorSolid: _lerpColor(bgErrorSolid, other.bgErrorSolid, t),
      bgWarningSolid: _lerpColor(bgWarningSolid, other.bgWarningSolid, t),
      bgSuccessSolid: _lerpColor(bgSuccessSolid, other.bgSuccessSolid, t),
      bgSecondaryHover: _lerpColor(bgSecondaryHover, other.bgSecondaryHover, t),
      bgPrimaryHover: _lerpColor(bgPrimaryHover, other.bgPrimaryHover, t),
      bgBrandSolidHover: _lerpColor(
        bgBrandSolidHover,
        other.bgBrandSolidHover,
        t,
      ),
      bgErrorPrimary: _lerpColor(bgErrorPrimary, other.bgErrorPrimary, t),
      bgBrandSecondary: _lerpColor(bgBrandSecondary, other.bgBrandSecondary, t),
      bgSecondary: _lerpColor(bgSecondary, other.bgSecondary, t),
      bgQuaternary: _lerpColor(bgQuaternary, other.bgQuaternary, t),
      bgPrimaryAlt: _lerpColor(bgPrimaryAlt, other.bgPrimaryAlt, t),
      bgBrandPrimaryAlt: _lerpColor(
        bgBrandPrimaryAlt,
        other.bgBrandPrimaryAlt,
        t,
      ),
      bgSecondaryAlt: _lerpColor(bgSecondaryAlt, other.bgSecondaryAlt, t),
      bgOverlay: _lerpColor(bgOverlay, other.bgOverlay, t),
      bgBrandSection: _lerpColor(bgBrandSection, other.bgBrandSection, t),
      bgBrandSectionSubtle: _lerpColor(
        bgBrandSectionSubtle,
        other.bgBrandSectionSubtle,
        t,
      ),
      bgPrimarySolid: _lerpColor(bgPrimarySolid, other.bgPrimarySolid, t),
      bgErrorSolidHover: _lerpColor(
        bgErrorSolidHover,
        other.bgErrorSolidHover,
        t,
      ),
      appStoreBadgeBorder: _lerpColor(
        appStoreBadgeBorder,
        other.appStoreBadgeBorder,
        t,
      ),
      avatarStylesBgNeutral: _lerpColor(
        avatarStylesBgNeutral,
        other.avatarStylesBgNeutral,
        t,
      ),
      featuredIconLightFgBrand: _lerpColor(
        featuredIconLightFgBrand,
        other.featuredIconLightFgBrand,
        t,
      ),
      featuredIconLightFgError: _lerpColor(
        featuredIconLightFgError,
        other.featuredIconLightFgError,
        t,
      ),
      featuredIconLightFgGray: _lerpColor(
        featuredIconLightFgGray,
        other.featuredIconLightFgGray,
        t,
      ),
      featuredIconLightFgSuccess: _lerpColor(
        featuredIconLightFgSuccess,
        other.featuredIconLightFgSuccess,
        t,
      ),
      featuredIconLightFgWarning: _lerpColor(
        featuredIconLightFgWarning,
        other.featuredIconLightFgWarning,
        t,
      ),
      focusRingError: _lerpColor(focusRingError, other.focusRingError, t),
      focusRing: _lerpColor(focusRing, other.focusRing, t),
      footerButtonFg: _lerpColor(footerButtonFg, other.footerButtonFg, t),
      footerButtonFgHover: _lerpColor(
        footerButtonFgHover,
        other.footerButtonFgHover,
        t,
      ),
      iconFgBrand: _lerpColor(iconFgBrand, other.iconFgBrand, t),
      iconFgBrandOnBrand: _lerpColor(
        iconFgBrandOnBrand,
        other.iconFgBrandOnBrand,
        t,
      ),
      screenMockupBorder: _lerpColor(
        screenMockupBorder,
        other.screenMockupBorder,
        t,
      ),
      sliderHandleBg: _lerpColor(sliderHandleBg, other.sliderHandleBg, t),
      sliderHandleBorder: _lerpColor(
        sliderHandleBorder,
        other.sliderHandleBorder,
        t,
      ),
      toggleBorder: _lerpColor(toggleBorder, other.toggleBorder, t),
      toggleSlimBorderPressedHover: _lerpColor(
        toggleSlimBorderPressedHover,
        other.toggleSlimBorderPressedHover,
        t,
      ),
      toggleSlimBorderPressed: _lerpColor(
        toggleSlimBorderPressed,
        other.toggleSlimBorderPressed,
        t,
      ),
      tooltipSupportingText: _lerpColor(
        tooltipSupportingText,
        other.tooltipSupportingText,
        t,
      ),
      backgroundColorPrimary: _lerpColor(
        backgroundColorPrimary,
        other.backgroundColorPrimary,
        t,
      ),
      backgroundColorTertiary: _lerpColor(
        backgroundColorTertiary,
        other.backgroundColorTertiary,
        t,
      ),
      backgroundColorBrandPrimary: _lerpColor(
        backgroundColorBrandPrimary,
        other.backgroundColorBrandPrimary,
        t,
      ),
      backgroundColorErrorSecondary: _lerpColor(
        backgroundColorErrorSecondary,
        other.backgroundColorErrorSecondary,
        t,
      ),
      backgroundColorWarningPrimary: _lerpColor(
        backgroundColorWarningPrimary,
        other.backgroundColorWarningPrimary,
        t,
      ),
      backgroundColorWarningSecondary: _lerpColor(
        backgroundColorWarningSecondary,
        other.backgroundColorWarningSecondary,
        t,
      ),
      backgroundColorSuccessPrimary: _lerpColor(
        backgroundColorSuccessPrimary,
        other.backgroundColorSuccessPrimary,
        t,
      ),
      backgroundColorSuccessSecondary: _lerpColor(
        backgroundColorSuccessSecondary,
        other.backgroundColorSuccessSecondary,
        t,
      ),
      backgroundColorBrandSolid: _lerpColor(
        backgroundColorBrandSolid,
        other.backgroundColorBrandSolid,
        t,
      ),
      backgroundColorSecondarySolid: _lerpColor(
        backgroundColorSecondarySolid,
        other.backgroundColorSecondarySolid,
        t,
      ),
      backgroundColorErrorSolid: _lerpColor(
        backgroundColorErrorSolid,
        other.backgroundColorErrorSolid,
        t,
      ),
      backgroundColorWarningSolid: _lerpColor(
        backgroundColorWarningSolid,
        other.backgroundColorWarningSolid,
        t,
      ),
      backgroundColorSuccessSolid: _lerpColor(
        backgroundColorSuccessSolid,
        other.backgroundColorSuccessSolid,
        t,
      ),
      backgroundColorSecondaryHover: _lerpColor(
        backgroundColorSecondaryHover,
        other.backgroundColorSecondaryHover,
        t,
      ),
      backgroundColorPrimaryHover: _lerpColor(
        backgroundColorPrimaryHover,
        other.backgroundColorPrimaryHover,
        t,
      ),
      backgroundColorBrandSolidHover: _lerpColor(
        backgroundColorBrandSolidHover,
        other.backgroundColorBrandSolidHover,
        t,
      ),
      backgroundColorErrorPrimary: _lerpColor(
        backgroundColorErrorPrimary,
        other.backgroundColorErrorPrimary,
        t,
      ),
      backgroundColorBrandSecondary: _lerpColor(
        backgroundColorBrandSecondary,
        other.backgroundColorBrandSecondary,
        t,
      ),
      backgroundColorSecondary: _lerpColor(
        backgroundColorSecondary,
        other.backgroundColorSecondary,
        t,
      ),
      backgroundColorQuaternary: _lerpColor(
        backgroundColorQuaternary,
        other.backgroundColorQuaternary,
        t,
      ),
      backgroundColorPrimaryAlt: _lerpColor(
        backgroundColorPrimaryAlt,
        other.backgroundColorPrimaryAlt,
        t,
      ),
      backgroundColorBrandPrimaryAlt: _lerpColor(
        backgroundColorBrandPrimaryAlt,
        other.backgroundColorBrandPrimaryAlt,
        t,
      ),
      backgroundColorSecondaryAlt: _lerpColor(
        backgroundColorSecondaryAlt,
        other.backgroundColorSecondaryAlt,
        t,
      ),
      backgroundColorOverlay: _lerpColor(
        backgroundColorOverlay,
        other.backgroundColorOverlay,
        t,
      ),
      backgroundColorBrandSection: _lerpColor(
        backgroundColorBrandSection,
        other.backgroundColorBrandSection,
        t,
      ),
      backgroundColorBrandSectionSubtle: _lerpColor(
        backgroundColorBrandSectionSubtle,
        other.backgroundColorBrandSectionSubtle,
        t,
      ),
      backgroundColorPrimarySolid: _lerpColor(
        backgroundColorPrimarySolid,
        other.backgroundColorPrimarySolid,
        t,
      ),
      backgroundColorErrorSolidHover: _lerpColor(
        backgroundColorErrorSolidHover,
        other.backgroundColorErrorSolidHover,
        t,
      ),
      backgroundColorBorderBrand: _lerpColor(
        backgroundColorBorderBrand,
        other.backgroundColorBorderBrand,
        t,
      ),
      backgroundColorBorderBrandAlt: _lerpColor(
        backgroundColorBorderBrandAlt,
        other.backgroundColorBorderBrandAlt,
        t,
      ),
      textWhite: _lerpColor(textWhite, other.textWhite, t),
      textColorPrimary: _lerpColor(textColorPrimary, other.textColorPrimary, t),
      textColorSecondary: _lerpColor(
        textColorSecondary,
        other.textColorSecondary,
        t,
      ),
      textColorSecondaryHover: _lerpColor(
        textColorSecondaryHover,
        other.textColorSecondaryHover,
        t,
      ),
      textColorTertiary: _lerpColor(
        textColorTertiary,
        other.textColorTertiary,
        t,
      ),
      textColorTertiaryHover: _lerpColor(
        textColorTertiaryHover,
        other.textColorTertiaryHover,
        t,
      ),
      textColorErrorPrimary: _lerpColor(
        textColorErrorPrimary,
        other.textColorErrorPrimary,
        t,
      ),
      textColorWarningPrimary: _lerpColor(
        textColorWarningPrimary,
        other.textColorWarningPrimary,
        t,
      ),
      textColorSuccessPrimary: _lerpColor(
        textColorSuccessPrimary,
        other.textColorSuccessPrimary,
        t,
      ),
      textColorBrandSecondary: _lerpColor(
        textColorBrandSecondary,
        other.textColorBrandSecondary,
        t,
      ),
      textColorPlaceholder: _lerpColor(
        textColorPlaceholder,
        other.textColorPlaceholder,
        t,
      ),
      textColorBrandTertiary: _lerpColor(
        textColorBrandTertiary,
        other.textColorBrandTertiary,
        t,
      ),
      textColorEditorIconFg: _lerpColor(
        textColorEditorIconFg,
        other.textColorEditorIconFg,
        t,
      ),
      textColorEditorIconFgActive: _lerpColor(
        textColorEditorIconFgActive,
        other.textColorEditorIconFgActive,
        t,
      ),
      textColorQuaternary: _lerpColor(
        textColorQuaternary,
        other.textColorQuaternary,
        t,
      ),
      textColorBrandPrimary: _lerpColor(
        textColorBrandPrimary,
        other.textColorBrandPrimary,
        t,
      ),
      textColorPrimaryOnBrand: _lerpColor(
        textColorPrimaryOnBrand,
        other.textColorPrimaryOnBrand,
        t,
      ),
      textColorSecondaryOnBrand: _lerpColor(
        textColorSecondaryOnBrand,
        other.textColorSecondaryOnBrand,
        t,
      ),
      textColorTertiaryOnBrand: _lerpColor(
        textColorTertiaryOnBrand,
        other.textColorTertiaryOnBrand,
        t,
      ),
      textColorQuaternaryOnBrand: _lerpColor(
        textColorQuaternaryOnBrand,
        other.textColorQuaternaryOnBrand,
        t,
      ),
      textColorBrandTertiaryAlt: _lerpColor(
        textColorBrandTertiaryAlt,
        other.textColorBrandTertiaryAlt,
        t,
      ),
      textColorErrorPrimaryHover: _lerpColor(
        textColorErrorPrimaryHover,
        other.textColorErrorPrimaryHover,
        t,
      ),
      textColorBrandSecondaryHover: _lerpColor(
        textColorBrandSecondaryHover,
        other.textColorBrandSecondaryHover,
        t,
      ),
      textColorTooltipSupportingText: _lerpColor(
        textColorTooltipSupportingText,
        other.textColorTooltipSupportingText,
        t,
      ),
      borderColorPrimary: _lerpColor(
        borderColorPrimary,
        other.borderColorPrimary,
        t,
      ),
      borderColorSecondary: _lerpColor(
        borderColorSecondary,
        other.borderColorSecondary,
        t,
      ),
      borderColorSecondaryAlt: _lerpColor(
        borderColorSecondaryAlt,
        other.borderColorSecondaryAlt,
        t,
      ),
      borderColorTertiary: _lerpColor(
        borderColorTertiary,
        other.borderColorTertiary,
        t,
      ),
      borderColorError: _lerpColor(borderColorError, other.borderColorError, t),
      borderColorErrorSubtle: _lerpColor(
        borderColorErrorSubtle,
        other.borderColorErrorSubtle,
        t,
      ),
      borderColorBrand: _lerpColor(borderColorBrand, other.borderColorBrand, t),
      borderColorBrandAlt: _lerpColor(
        borderColorBrandAlt,
        other.borderColorBrandAlt,
        t,
      ),
      borderColorBrandSolid: _lerpColor(
        borderColorBrandSolid,
        other.borderColorBrandSolid,
        t,
      ),
      borderColorBrandSolidHover: _lerpColor(
        borderColorBrandSolidHover,
        other.borderColorBrandSolidHover,
        t,
      ),
      ringColorPrimary: _lerpColor(ringColorPrimary, other.ringColorPrimary, t),
      ringColorSecondary: _lerpColor(
        ringColorSecondary,
        other.ringColorSecondary,
        t,
      ),
      ringColorSecondaryAlt: _lerpColor(
        ringColorSecondaryAlt,
        other.ringColorSecondaryAlt,
        t,
      ),
      ringColorTertiary: _lerpColor(
        ringColorTertiary,
        other.ringColorTertiary,
        t,
      ),
      ringColorError: _lerpColor(ringColorError, other.ringColorError, t),
      ringColorErrorSubtle: _lerpColor(
        ringColorErrorSubtle,
        other.ringColorErrorSubtle,
        t,
      ),
      ringColorBrand: _lerpColor(ringColorBrand, other.ringColorBrand, t),
      ringColorBrandAlt: _lerpColor(
        ringColorBrandAlt,
        other.ringColorBrandAlt,
        t,
      ),
      ringColorBrandSolid: _lerpColor(
        ringColorBrandSolid,
        other.ringColorBrandSolid,
        t,
      ),
      ringColorBrandSolidHover: _lerpColor(
        ringColorBrandSolidHover,
        other.ringColorBrandSolidHover,
        t,
      ),
      outlineColorPrimary: _lerpColor(
        outlineColorPrimary,
        other.outlineColorPrimary,
        t,
      ),
      outlineColorSecondary: _lerpColor(
        outlineColorSecondary,
        other.outlineColorSecondary,
        t,
      ),
      outlineColorSecondaryAlt: _lerpColor(
        outlineColorSecondaryAlt,
        other.outlineColorSecondaryAlt,
        t,
      ),
      outlineColorTertiary: _lerpColor(
        outlineColorTertiary,
        other.outlineColorTertiary,
        t,
      ),
      outlineColorError: _lerpColor(
        outlineColorError,
        other.outlineColorError,
        t,
      ),
      outlineColorErrorSubtle: _lerpColor(
        outlineColorErrorSubtle,
        other.outlineColorErrorSubtle,
        t,
      ),
      outlineColorBrand: _lerpColor(
        outlineColorBrand,
        other.outlineColorBrand,
        t,
      ),
      outlineColorBrandAlt: _lerpColor(
        outlineColorBrandAlt,
        other.outlineColorBrandAlt,
        t,
      ),
      outlineColorBrandSolid: _lerpColor(
        outlineColorBrandSolid,
        other.outlineColorBrandSolid,
        t,
      ),
      outlineColorBrandSolidHover: _lerpColor(
        outlineColorBrandSolidHover,
        other.outlineColorBrandSolidHover,
        t,
      ),
      grayModern300: _lerpColor(grayModern300, other.grayModern300, t),
      grayModern500: _lerpColor(grayModern500, other.grayModern500, t),
      grayModern700: _lerpColor(grayModern700, other.grayModern700, t),
      grayModern800: _lerpColor(grayModern800, other.grayModern800, t),
    );
  }
}

// Flutter's Color.lerp does not accept extended sRGB. Align those palette
// entries to Display P3 before native theme interpolation.
Color _lerpColor(Color a, Color b, double t) {
  if (a == b) return a;
  if (a.colorSpace == ColorSpace.extendedSRGB ||
      b.colorSpace == ColorSpace.extendedSRGB) {
    a = a.withValues(colorSpace: ColorSpace.displayP3);
    b = b.withValues(colorSpace: ColorSpace.displayP3);
  }
  return Color.lerp(a, b, t)!;
}
