class Strength {
  final String id;
  final String name;

  Strength({
    required this.id,
    required this.name,
  });

  static List<Strength> strengths = [

    Strength(id: '1', name: "Responsible Roles"),
    Strength(id: '2', name: "Good Team Players"),
    Strength(id: '3', name: "Excellent Mentors"),
    Strength(id: '4', name: "Good Work-Family Balancers"),
    Strength(id: '5', name: "Best Overall Workers"),
  ];
}

class Weaknesses{
  final String id;
  final String name;

  Weaknesses({
    required this.id,
    required this.name,
  });

  static List<Weaknesses> _weaknesses = [

    Weaknesses(id: '1', name: "Non Flexible"),
    Weaknesses(id: '2', name: "Competitive"),
    Weaknesses(id: '3', name: "Least Tech Savvy"),
    Weaknesses(id: '4', name: "Not satisfied with seniors"),
    Weaknesses(id: '5', name: "Weak Overall Workers"),
  ];
}