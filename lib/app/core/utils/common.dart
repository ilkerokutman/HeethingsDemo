import 'dart:math';

class CommonUtils {
  static String generateDemoId() {
    String randomPart(int length) => String.fromCharCodes(
        List.generate(length, (index) => Random().nextInt(26) + 97));

    return '${randomPart(3)}-${randomPart(4)}-${randomPart(3)}';
  }

  static bool validateTextPattern(String text) {
    RegExp pattern = RegExp(r'^[a-z]{3}-[a-z]{4}-[a-z]{3}$');

    return pattern.hasMatch(text);
  }
}
