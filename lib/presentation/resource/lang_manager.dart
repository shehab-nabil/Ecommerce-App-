enum LanguagesType { arabic, english }

const String arabic = 'ar';
const String english = 'en';

extension LanguagesTypeExtension on LanguagesType {
  String getValue() {
    switch (this) {
      case LanguagesType.arabic:
        return arabic;
      case LanguagesType.english:
        return english;
    }
  }
}
