import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/kalkulator_controller.dart';
import '../routes/routes.dart';

class KalkulatorPage extends GetView<KalkulatorController> {
  const KalkulatorPage({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text('calculator_title'.tr),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        foregroundColor: colors.onSurface,
        actions: [
          IconButton(
            tooltip: 'history_title'.tr,
            onPressed: () => Get.toNamed(Routes.calculatorHistory),
            icon: const Icon(Icons.history_rounded),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 480),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(18, 8, 18, 16),
                  child: Column(
                    children: [
                      SizedBox(
                        height: (constraints.maxHeight * 0.29).clamp(
                          145.0,
                          215.0,
                        ),
                        child: _buildDisplay(colors),
                      ),
                      const SizedBox(height: 15),
                      Expanded(child: _buildKeypad(colors)),
                      const SizedBox(height: 10),
                      _buildHistoryShortcut(colors),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildDisplay(ColorScheme colors) {
    return Obx(() {
      final hasError = controller.errorMessage.value.isNotEmpty;

      return Container(
        width: double.infinity,
        padding: const EdgeInsets.fromLTRB(22, 20, 22, 20),
        decoration: BoxDecoration(
          color: colors.primary,
          borderRadius: BorderRadius.circular(23),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Row(
              children: [
                Icon(
                  Icons.calculate_rounded,
                  color: colors.onPrimary.withValues(alpha: 0.75),
                  size: 19,
                ),
                const SizedBox(width: 9),
                Text(
                  'calculator_title'.tr.toUpperCase(),
                  style: TextStyle(
                    color: colors.onPrimary.withValues(alpha: 0.65),
                    fontSize: 10,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 1.5,
                  ),
                ),
                const Spacer(),
                Text(
                  '${controller.history.length} ${'history_total'.tr.toUpperCase()}',
                  style: TextStyle(
                    color: colors.onPrimary.withValues(alpha: 0.8),
                    fontSize: 9,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.8,
                  ),
                ),
                const SizedBox(width: 5),
                IconButton(
                  tooltip: 'calculator_delete_last_digit'.tr,
                  visualDensity: VisualDensity.compact,
                  onPressed: controller.backspace,
                  icon: Icon(
                    Icons.backspace_outlined,
                    color: colors.onPrimary,
                    size: 19,
                  ),
                ),
              ],
            ),
            const Spacer(),
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                controller.expressionPreview.value.isEmpty
                    ? 'calculator_ready'.tr
                    : controller.expressionPreview.value,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: colors.onPrimary.withValues(alpha: 0.65),
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const SizedBox(height: 8),
            SizedBox(
              width: double.infinity,
              child: Align(
                alignment: Alignment.centerRight,
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 160),
                  child: FittedBox(
                    key: ValueKey(controller.display.value),
                    fit: BoxFit.scaleDown,
                    alignment: Alignment.centerRight,
                    child: Text(
                      controller.display.value,
                      maxLines: 1,
                      style: TextStyle(
                        color: colors.onPrimary,
                        fontSize: 48,
                        fontWeight: FontWeight.w700,
                        letterSpacing: -1.5,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            if (hasError) ...[
              const SizedBox(height: 8),
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  controller.errorMessage.value,
                  maxLines: 2,
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    color: colors.errorContainer,
                    fontSize: 11,
                  ),
                ),
              ),
            ],
          ],
        ),
      );
    });
  }

  Widget _buildKeypad(ColorScheme colors) {
    return Column(
      children: [
        _buildKeyRow([
          _key('AC', type: _KeyType.utility),
          _key('+/-', type: _KeyType.utility),
          _key('%', type: _KeyType.utility),
          _key('÷', type: _KeyType.operator),
        ], colors),
        _buildKeyRow([
          _key('7'),
          _key('8'),
          _key('9'),
          _key('×', type: _KeyType.operator),
        ], colors),
        _buildKeyRow([
          _key('4'),
          _key('5'),
          _key('6'),
          _key('-', type: _KeyType.operator),
        ], colors),
        _buildKeyRow([
          _key('1'),
          _key('2'),
          _key('3'),
          _key('+', type: _KeyType.operator),
        ], colors),
        _buildKeyRow([
          _key('0', flex: 2),
          _key('.'),
          _key('=', type: _KeyType.equals),
        ], colors),
      ],
    );
  }

  Widget _buildKeyRow(
    List<_CalculatorKeyData> keys,
    ColorScheme colors,
  ) {
    return Expanded(
      child: Row(
        children: [
          for (int i = 0; i < keys.length; i++) ...[
            if (i > 0) const SizedBox(width: 10),
            Expanded(
              flex: keys[i].flex,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: _buildKey(keys[i], colors),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildKey(
    _CalculatorKeyData key,
    ColorScheme colors,
  ) {
    late final Color background;
    late final Color foreground;

    switch (key.type) {
      case _KeyType.number:
        background = colors.surfaceContainerLow;
        foreground = colors.onSurface;
        break;

      case _KeyType.utility:
        background = colors.surfaceContainerHighest;
        foreground = colors.onSurfaceVariant;
        break;

      case _KeyType.operator:
        background = colors.secondaryContainer;
        foreground = colors.onSecondaryContainer;
        break;

      case _KeyType.equals:
        background = colors.primary;
        foreground = colors.onPrimary;
        break;
    }

    return Material(
      color: background,
      borderRadius: BorderRadius.circular(17),
      child: InkWell(
        borderRadius: BorderRadius.circular(17),
        onTap: () => _handleKey(key.label),
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(17),
            border: key.type == _KeyType.number
                ? Border.all(color: colors.outlineVariant)
                : null,
          ),
          child: key.label == '⌫'
              ? Icon(
                  Icons.backspace_outlined,
                  color: foreground,
                  size: 22,
                )
              : Text(
                  key.label,
                  style: TextStyle(
                    color: foreground,
                    fontSize: key.type == _KeyType.number ? 22 : 19,
                    fontWeight: FontWeight.w700,
                  ),
                ),
        ),
      ),
    );
  }

  void _handleKey(String label) {
    switch (label) {
      case 'AC':
        controller.reset();
        break;
      case '⌫':
        controller.backspace();
        break;
      case '+/-':
        controller.toggleSign();
        break;
      case '%':
        controller.applyPercent();
        break;
      case '.':
        controller.pressDecimal();
        break;
      case '+':
        controller.setOperator('+');
        break;
      case '-':
        controller.setOperator('-');
        break;
      case '×':
        controller.setOperator('*');
        break;
      case '÷':
        controller.setOperator('/');
        break;
      case '=':
        controller.calculate();
        break;
      default:
        controller.pressDigit(label);
    }
  }

  Widget _buildHistoryShortcut(ColorScheme colors) {
    return Obx(
      () => Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () => Get.toNamed(Routes.calculatorHistory),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 8,
              vertical: 9,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.history_rounded,
                  size: 18,
                  color: colors.onSurfaceVariant,
                ),
                const SizedBox(width: 8),
                Text(
                  'calculator_history'.tr,
                  style: TextStyle(
                    color: colors.onSurfaceVariant,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(width: 6),
                Text(
                  '(${controller.history.length})',
                  style: TextStyle(
                    color: colors.primary,
                    fontSize: 12,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(width: 4),
                Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 11,
                  color: colors.onSurfaceVariant,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _CalculatorKeyData _key(
    String label, {
    _KeyType type = _KeyType.number,
    int flex = 1,
  }) {
    return _CalculatorKeyData(
      label: label,
      type: type,
      flex: flex,
    );
  }
}

enum _KeyType {
  number,
  utility,
  operator,
  equals,
}

class _CalculatorKeyData {
  final String label;
  final _KeyType type;
  final int flex;

  const _CalculatorKeyData({
    required this.label,
    required this.type,
    this.flex = 1,
  });
}
