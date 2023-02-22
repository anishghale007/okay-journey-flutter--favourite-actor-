class Actor {
  final String actorName;
  final String actorImage;
  final String addedDate;

  Actor({
    required this.actorName,
    required this.actorImage,
    required this.addedDate,
  });

  factory Actor.fromJson(Map<String, dynamic> map) {
    return Actor(
      actorName: map['actorName'] as String,
      actorImage: map['actorImage'] as String,
      addedDate: map['addedDate'] as String,
     );
  }

  Map<String, dynamic> toJson() {
    return {
      'actorName': actorName,
      'actorImage': actorImage,
      'addedDate': addedDate,
    };
  }
}
