import 'package:flutter_test/flutter_test.dart';
import 'calculator.dart';

void main() {
  test('Addition', () {
    // Step 1:
    Calculator calc = Calculator();

    // Step 2:
    int result = calc.add(2, 3);

    // Step 3:
    expect(result, 5);
  });
}
