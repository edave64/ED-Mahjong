import 'dart:ui';

class LocalizableString {
  static final LocalizableString empty = LocalizableString._("", {});

  LocalizableString._(this._default, this._localizations);

  final String _default;
  final Map<String, String> _localizations;

  String toString() {
    return _default;
  }

  String toLocaleString(Locale locale) {
    final lang = locale.languageCode;
    final country = locale.countryCode;
    var script = locale.scriptCode;
    if (script == 'latn') script = 'latin';
    final variants = [
      if (country != null && script != null) "${lang}_$country@$script",
      if (country != null) "${lang}_$country",
      if (script != null) "$lang@$script",
      "$lang"
    ];
    for (var variant in variants) {
      if (_localizations.containsKey(variant)) {
        return _localizations[variant]!;
      }
    }
    return _default;
  }
}

class LocalizableStringBuilder {
  String baseValue = "";
  Map<String, String> localizations = {};

  LocalizableString toLocalizableString() {
    return LocalizableString._(baseValue, Map.unmodifiable(localizations));
  }
}
