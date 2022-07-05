import 'package:usta_bor_android/translations/en_translations.dart';
import 'package:usta_bor_android/translations/ru_translations.dart';
import 'package:usta_bor_android/translations/uz_translations.dart';

abstract class AppTranslation {
  static Map<String, Map<String, String>> translations = {
    'en': en,
    'ru': ru,
    'uz': uz,
  };
}
