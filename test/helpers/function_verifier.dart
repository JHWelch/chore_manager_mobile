import 'package:mocktail/mocktail.dart';

class FunctionVerifierToMock {
  void functionCall() {
    // this page intentionally left blank
  }
}

class FunctionVerifier extends Mock implements FunctionVerifierToMock {}
