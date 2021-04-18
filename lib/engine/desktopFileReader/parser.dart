import 'localizable_string.dart';
import 'parse_spec.dart';

class Parser {
  Parser(this._spec);
  ParseSpec _spec;

  Map<String, Map<String, dynamic>> parse(String text) {
    final Map<String, Map<String, dynamic>> ret = {};
    final lines = text.split(RegExp(r"[\n\r]+"));
    for (var i = 0; lines.length > i; ++i) {
      final line = lines[i].trim();
      if (line.startsWith('#')) continue;
      if (line.isEmpty) continue;
      if (line.startsWith('[')) {
        final sectionName = line.substring(1, line.length - 1).trim();
        final sectionSpec = _spec[sectionName];
        final section = _readSection(lines, i + 1, sectionSpec);
        i = section.pos;
        ret[sectionName] = section.items;
        continue;
      }
      throw Error();
    }
    return ret;
  }

  Map<String, dynamic> parseSection(String text, String section) {
    final lines = text.split(RegExp(r"[\n\r]+"));
    final seek = "[$section]";
    final sectionSpec = _spec[section];
    assert(sectionSpec != null);
    for (var i = 0; lines.length > i; ++i) {
      if (seek == lines[i].trim()) {
        final section = _readSection(lines, i + 1, sectionSpec);
        return section.items;
      }
    }
    throw Error();
  }

  _SectionPair _readSection(
      List<String> lines, int pos, SectionSpec /*!*/ spec) {
    final Map<String, dynamic> ret = {};
    for (; lines.length > pos; ++pos) {
      final line = lines[pos].trim();
      if (line.startsWith('[')) break;
      if (line.isEmpty || line.startsWith('#')) continue;
      final equPos = line.indexOf('=');
      var key = line.substring(0, equPos).trim();
      String? locale;
      final localeIdx = key.indexOf('[');
      if (localeIdx > 0) {
        locale = key.substring(localeIdx + 1, key.length - 1).trim();
        key = key.substring(0, localeIdx).trim();
      }
      final value = line.substring(equPos + 1);
      final valueTrim = value.trim();
      if (!spec.has(key)) {
        assert(false);
      }
      final type = spec[key];
      if (type != ItemType.LocalizableString && locale != null) {
        throw new Error();
      }
      switch (type) {
        case ItemType.Bool:
          ret[key] = valueTrim == 'true'
              ? true
              : valueTrim == 'false'
                  ? false
                  : throw Error();
          break;
        case ItemType.String:
          ret[key] = value;
          break;
        case ItemType.Double:
          ret[key] = double.parse(valueTrim);
          break;
        case ItemType.Int:
          ret[key] = int.parse(valueTrim);
          break;
        case ItemType.LocalizableString:
          LocalizableStringBuilder localize =
              ret.putIfAbsent(key, () => LocalizableStringBuilder());
          if (locale == null) {
            localize.baseValue = value;
          } else {
            localize.localizations[locale] = value;
          }
      }
    }
    for (var key in ret.keys) {
      var val = ret[key];
      if (val is LocalizableStringBuilder) {
        ret[key] = val.toLocalizableString();
      }
    }
    return _SectionPair._(ret, pos);
  }
}

class _SectionPair {
  _SectionPair._(this.items, this.pos);

  final Map<String, dynamic> items;
  final int pos;
}
