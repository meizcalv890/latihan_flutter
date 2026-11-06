class CalculationModel {
  final String expression;
  final String result;
  final String date;

  CalculationModel({
    required this.expression,
    required this.result,
    required this.date,
  });

  Map<String, dynamic> toJson() {
    return {'expression': expression, 'result': result, 'date': date};
  }

  factory CalculationModel.fromJson(Map<String, dynamic> json) {
    return CalculationModel(
      expression: json['expression'] ?? '',
      result: json['result'] ?? '',
      date: json['date'] ?? '',
    );
  }
}
