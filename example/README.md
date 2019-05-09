# Josa example

    import 'package:josa/josa.dart';

    Josa.of('을').of('간장') == 간장을
    Josa.of('를').of('시계') == 시계를

## Support any type of josa

    Josa.of('를').of('간장') == 간장을
    Josa.of('을').of('간장') == 간장을
    Josa.of('을/를').of('간장') == 간장을

## Supported josa list

* 을/를
* 은/는
* 이/가
* 와/과
* 이여/여
* 으로/로
* 이에요/예요
* 이었/였
* 아/야
