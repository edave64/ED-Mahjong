class ParseSpec {
  ParseSpec._(this._sections);
  Map<String, SectionSpec> _sections;
  operator [](String str) => _sections[str];
}

class ParseSpecBuilder {
  Map<String, SectionSpecBuilder> _sections = {};

  SectionSpecBuilder section(String key) {
    return _sections.putIfAbsent(key, () => SectionSpecBuilder._());
  }

  ParseSpec finish() {
    return ParseSpec._(Map.unmodifiable(
        _sections.map((key, value) => MapEntry(key, value.finish()))));
  }
}

class SectionSpec {
  SectionSpec._(this._items);
  Map<String, ItemType> _items;

  bool has(String str) => _items.containsKey(str);

  operator [](String str) => _items[str];
}

class SectionSpecBuilder {
  SectionSpecBuilder._();
  Map<String, ItemType> _items = {};

  operator []=(String str, ItemType type) {
    _items[str] = type;
  }

  SectionSpec finish() {
    return SectionSpec._(Map.unmodifiable(_items));
  }
}

enum ItemType { String, LocalizableString, Int, Double, Bool }
