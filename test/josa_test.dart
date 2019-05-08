import 'package:flutter_test/flutter_test.dart';

import 'package:josa/josa.dart';

void main() {
  test('Josa type', () {
    final josa = Josa.of('을', withValue: false);
    expect(josa.group.forClosedSyllable, '을');
    expect(josa.group.forOpenedSyllable, '를');
    expect(Josa.of('을', withValue: false).group.forClosedSyllable, '을');
    expect(Josa.of('을/를', withValue: false).group.forClosedSyllable, '을');
    expect(Josa.of('을를 ', withValue: false).group.forClosedSyllable, '을');
    expect(Josa.of('사람을', withValue: false).group.forClosedSyllable, '을');
    expect(() => Josa.of('몰랑', withValue: false), throwsStateError);
  });

  test('을', () {
    final josa = Josa.of('을', withValue: false);
    expect(josa.of('동물원'), '을');
    expect(josa.of('농장'), '을');
    expect(josa.of('머리'), '를');
  });

  test('으로', () {
    final josa = Josa.of('으로/로', withValue: false);
    expect(josa.of('적진'), '으로');
    expect(josa.of('타워'), '로');
  });

  test('Exception: 으로', () {
    final josa = Josa.of('으로/로', withValue: false);
    // Exception!
    expect(josa.of('건물'), '로');
  });
}
