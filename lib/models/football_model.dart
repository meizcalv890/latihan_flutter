class FootballModel {
  final String? id;
  final String name;
  final String position;
  final String team;
  final String country;
  final int number;
  final String description;
  final bool isCustom;

  FootballModel({
    this.id,
    required this.name,
    required this.position,
    required this.team,
    required this.country,
    required this.number,
    required this.description,
    this.isCustom = false,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'position': position,
      'team': team,
      'country': country,
      'number': number,
      'description': description,
      'isCustom': isCustom,
    };
  }

  factory FootballModel.fromMap(Map<String, dynamic> map) {
    return FootballModel(
      id: map['id']?.toString(),
      name: map['name']?.toString() ?? '',
      position: map['position']?.toString() ?? 'Forward',
      team: map['team']?.toString() ?? '',
      country: map['country']?.toString() ?? '',
      number: int.tryParse(map['number'].toString()) ?? 0,
      description: map['description']?.toString() ?? '',
      isCustom: map['isCustom'] == true,
    );
  }
}
