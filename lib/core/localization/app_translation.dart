import 'package:get/get_navigation/src/root/internacionalization.dart';

import 'en_us.dart';
import 'hi_in.dart';

class AppTranslation extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {'en_US': enUS, 'hi_IN': hiIN};
}
