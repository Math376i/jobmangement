class Problem {
  final int problemId;
  String problemName;
  num latitude;
  num longitude;
  String status;
  String description;
  String image;

  Problem(
      {required this.problemId,
      required this.problemName,
      required this.latitude,
      required this.longitude,
      required this.description,
      required this.status,
      required this.image});

  static List<Problem> fromJson(List<dynamic> problem) {
    return problem
        .map((problem) => Problem(
            problemId: problem['problemId'],
            problemName: problem['problemName'],
            latitude: problem['latitude'],
            longitude: problem['longitude'],
            description: problem['description'],
            status: problem['status'],
            image: problem['image']))
        .toList();
  }

  Map<String, dynamic> toJson() {
    return {
      'problemId': problemId,
      'problemName': problemName,
      'latitude': latitude,
      'longitude': longitude,
      'description': description,
      'image': image
    };
  }
}
