import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../models/calculation_model.dart';

class KalkulatorController extends GetxController {
  final storage = GetStorage();

  // Dipertahankan untuk kompatibilitas dengan kode lama.
  final txtA = TextEditingController();
  final txtB = TextEditingController();

  final hasil = '0'.obs;
  final errorMessage = ''.obs;
  final history = <CalculationModel>[].obs;

  // State untuk kalkulator keypad.
  final display = '0'.obs;
  final expressionPreview = ''.obs;

  double? _storedValue;
  String _pendingOperator = '';

  bool _startNewEntry = true;

  @override
  void onInit() {
    super.onInit();
    loadHistory();
  }

  // ==========================================
  // KEYPAD
  // ==========================================

  void pressDigit(String digit) {
    errorMessage.value = '';

    if (_startNewEntry || display.value == '0') {
      display.value = digit;
      _startNewEntry = false;
    } else {
      if (display.value.replaceAll('-', '').length >= 15) {
        return;
      }

      display.value += digit;
    }

    hasil.value = display.value;
  }

  void pressDecimal() {
    errorMessage.value = '';

    if (_startNewEntry) {
      display.value = '0.';
      _startNewEntry = false;
    } else if (!display.value.contains('.')) {
      display.value += '.';
    }

    hasil.value = display.value;
  }

  void setOperator(String operator) {
    errorMessage.value = '';

    final currentValue = _parseDisplay();

    if (currentValue == null) {
      return;
    }

    if (_storedValue != null &&
        _pendingOperator.isNotEmpty &&
        !_startNewEntry) {
      _calculateIntermediate();
    }

    _storedValue = _parseDisplay();
    _pendingOperator = operator;

    if (_storedValue == null) return;

    expressionPreview.value = '${formatNumber(_storedValue!)} $operator';

    _startNewEntry = true;
  }

  void calculate() {
    if (_storedValue == null || _pendingOperator.isEmpty) {
      return;
    }

    final secondValue = _parseDisplay();

    if (secondValue == null) {
      return;
    }

    final firstValue = _storedValue!;
    final operator = _pendingOperator;

    final result = _performCalculation(firstValue, secondValue, operator);

    if (result == null) return;

    final formattedResult = formatNumber(result);

    final expression =
        '${formatNumber(firstValue)} $operator ${formatNumber(secondValue)}';

    saveCalculation(expression, formattedResult);

    display.value = formattedResult;
    hasil.value = formattedResult;

    expressionPreview.value = '$expression =';

    _storedValue = null;
    _pendingOperator = '';
    _startNewEntry = true;
    errorMessage.value = '';
  }

  void applyPercent() {
    final value = _parseDisplay();

    if (value == null) return;

    final result = value / 100;
    final formattedResult = formatNumber(result);

    display.value = formattedResult;
    hasil.value = formattedResult;

    expressionPreview.value = '${formatNumber(value)}%';

    _startNewEntry = true;
    errorMessage.value = '';
  }

  void toggleSign() {
    final value = _parseDisplay();

    if (value == null || value == 0) return;

    final result = -value;
    display.value = formatNumber(result);
    hasil.value = display.value;

    _startNewEntry = false;
    errorMessage.value = '';
  }

  void backspace() {
    errorMessage.value = '';

    if (_startNewEntry) {
      display.value = '0';
      hasil.value = '0';
      _startNewEntry = true;
      return;
    }

    if (display.value.length <= 1 ||
        (display.value.length == 2 && display.value.startsWith('-'))) {
      display.value = '0';
      _startNewEntry = true;
    } else {
      display.value = display.value.substring(0, display.value.length - 1);
    }

    hasil.value = display.value;
  }

  void _calculateIntermediate() {
    final secondValue = _parseDisplay();

    if (secondValue == null || _storedValue == null) {
      return;
    }

    final result = _performCalculation(
      _storedValue!,
      secondValue,
      _pendingOperator,
    );

    if (result == null) return;

    display.value = formatNumber(result);
    hasil.value = display.value;

    _storedValue = result;
    _startNewEntry = true;
  }

  // ==========================================
  // PERHITUNGAN
  // ==========================================

  double? _parseDisplay() {
    final value = double.tryParse(display.value.trim().replaceAll(',', '.'));

    if (value == null || !value.isFinite) {
      _showError('Angka tidak valid.');
      return null;
    }

    return value;
  }

  double? _performCalculation(double a, double b, String operator) {
    double result;

    switch (operator) {
      case '+':
        result = a + b;
        break;

      case '-':
        result = a - b;
        break;

      case '*':
        result = a * b;
        break;

      case '/':
        if (b == 0) {
          _showError('Tidak dapat membagi dengan nol.');
          return null;
        }
        result = a / b;
        break;

      default:
        _showError('Operator tidak dikenal.');
        return null;
    }

    if (!result.isFinite) {
      _showError('Hasil perhitungan berada di luar batas angka.');
      return null;
    }

    return result;
  }

  // ==========================================
  // KOMPATIBILITAS DENGAN KODE LAMA
  // ==========================================

  void hitung(String operator) {
    final a = double.tryParse(txtA.text.trim().replaceAll(',', '.'));

    final b = double.tryParse(txtB.text.trim().replaceAll(',', '.'));

    if (a == null || b == null) {
      _showError('Masukkan kedua angka dengan benar.');
      return;
    }

    final result = _performCalculation(a, b, operator);

    if (result == null) return;

    final formattedResult = formatNumber(result);

    hasil.value = formattedResult;
    display.value = formattedResult;
    expressionPreview.value =
        '${formatNumber(a)} $operator ${formatNumber(b)} =';

    saveCalculation(
      '${formatNumber(a)} $operator ${formatNumber(b)}',
      formattedResult,
    );

    _storedValue = null;
    _pendingOperator = '';
    _startNewEntry = true;
    errorMessage.value = '';
  }

  void _showError(String message) {
    errorMessage.value = message;
  }

  String formatNumber(double number) {
    if (!number.isFinite) {
      return 'Error';
    }

    if (number == number.truncateToDouble()) {
      return number.toInt().toString();
    }

    return number
        .toStringAsFixed(6)
        .replaceFirst(RegExp(r'0+$'), '')
        .replaceFirst(RegExp(r'\.$'), '');
  }

  // ==========================================
  // HISTORY
  // ==========================================

  void saveCalculation(String expression, String result) {
    final item = CalculationModel(
      expression: expression,
      result: result,
      date: DateTime.now().toIso8601String(),
    );

    history.insert(0, item);

    storage.write(
      'calculator_history',
      history.map((item) => item.toJson()).toList(),
    );
  }

  void loadHistory() {
    final savedData = storage.read('calculator_history');

    if (savedData is! List) return;

    try {
      final loadedHistory = savedData.map((item) {
        return CalculationModel.fromJson(
          Map<String, dynamic>.from(item as Map),
        );
      }).toList();

      history.assignAll(loadedHistory);
    } catch (e) {
      debugPrint('Failed to load calculator history: $e');
      history.clear();
    }
  }

  void clearHistory() {
    history.clear();
    storage.remove('calculator_history');

    Get.snackbar(
      'History cleared',
      'Your calculation history has been deleted.',
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  // ==========================================
  // RESET DAN RIWAYAT
  // ==========================================

  void reset() {
    txtA.clear();
    txtB.clear();

    display.value = '0';
    hasil.value = '0';
    expressionPreview.value = '';
    errorMessage.value = '';

    _storedValue = null;
    _pendingOperator = '';
    _startNewEntry = true;
  }

  void useHistory(CalculationModel item) {
    display.value = item.result;
    hasil.value = item.result;

    expressionPreview.value = item.expression;

    errorMessage.value = '';

    _storedValue = null;
    _pendingOperator = '';
    _startNewEntry = true;

    Get.back();
  }

  @override
  void onClose() {
    txtA.dispose();
    txtB.dispose();
    super.onClose();
  }
}
