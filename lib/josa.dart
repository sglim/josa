library josa;

/// JosaType
///
/// Type6 has a exception. If jong seong is ㄹ, result will be opposite.
enum JosaType {
  type1, // 을/를
  type2, // 은/는
  type3, // 이/가
  type4, // 와/과
  type5, // 이여/여
  type6, // 으로/로
  type7, // 이에요/예요
  type8, // 이었/였
  type9, // 아/야
}

class JosaGroup {
  final JosaType type;
  final String forClosedSyllable;
  final String forOpenedSyllable;

  JosaGroup(this.type, this.forClosedSyllable, this.forOpenedSyllable);

  factory JosaGroup.of(JosaType type) {
    switch (type) {
      case JosaType.type1:
        return JosaGroup(type, '을', '를');
      case JosaType.type2:
        return JosaGroup(type, '은', '는');
      case JosaType.type3:
        return JosaGroup(type, '이', '가');
      case JosaType.type4:
        return JosaGroup(type, '와', '과');
      case JosaType.type5:
        return JosaGroup(type, '이여', '여');
      case JosaType.type6:
        return JosaGroup(type, '으로', '로');
      case JosaType.type7:
        return JosaGroup(type, '이예요', '예요');
      case JosaType.type8:
        return JosaGroup(type, '이었', '였');
      case JosaType.type9:
        return JosaGroup(type, '아', '야');
    }
    assert(false);
    return null;
  }

  static final List<JosaGroup> groups =
      JosaType.values.map((type) => JosaGroup.of(type)).toList();

  bool isPartOf(String value) {
    return value.contains(forOpenedSyllable) ||
        value.contains(forClosedSyllable);
  }
}

class Josa {
  final JosaGroup group;
  final bool withValue;

  Josa(this.group, this.withValue);

  factory Josa.of(String josa, {bool withValue = true}) {
    final group = JosaGroup.groups.firstWhere((group) => group.isPartOf(josa));
    return Josa(group, withValue);
  }

  int _getLastSyllableCode(String value) {
    int codeUnit = value.codeUnitAt(value.length - 1);
    return (codeUnit - 0xac00) % 28;
  }

  bool _hasClosedSyllable(String value) {
    final lastSyllable = _getLastSyllableCode(value);
    final isClosed = lastSyllable > 0;
    if (group.type == JosaType.type6 && lastSyllable == 8) {
      // Note: 으로/로 has a exception when there is ㄹ as a last syllable
      return !isClosed;
    }
    return isClosed;
  }

  String getJosaFor(String value) {
    _getLastSyllableCode(value);
    if (_hasClosedSyllable(value)) {
      return group.forClosedSyllable;
    }
    return group.forOpenedSyllable;
  }

  String of(String value) {
    String josa = getJosaFor(value);
    if (withValue) {
      return '$value$josa';
    }
    return josa;
  }
}
