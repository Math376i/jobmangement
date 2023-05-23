class Problem {
  final int problemId;
  String problemName;
  String latitude;
  String longitude;
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
              problemId: problem['problemId'] as int,
              problemName: problem['problemName'] as String,
              latitude: problem['latitude'],
              longitude: problem['longitude'],
              description: problem['description'] as String,
              status: problem['status'] as String,
              image: problem['image'] as String,
            ))
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

  @override
  String toString() {
    // TODO: implement toString
    return 'Problem{name: $problemName, location: $latitude $longitude, status: $status}';
  }
}
