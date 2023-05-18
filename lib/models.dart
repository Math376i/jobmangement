class Problem {
  final int problemId;
  final String problemName;
  final String location;
  final String status;
  final String description;
  final String image;

  Problem(
      {required this.problemId,
      required this.problemName,
      required this.location,
      required this.description,
      required this.status,
      required this.image});

  static List<Problem> fromJson(List<dynamic> problem) {
    return problem
        .map((problem) => Problem(
            problemId: problem['problemId'],
            problemName: problem['problemName'],
            location: problem['location'],
            description: problem['description'],
            status: problem['status'],
            image: problem['image']))
        .toList();
  }

  Map<String, dynamic> toJson() {
    return {
      'problemId': problemId,
      'problemName': problemName,
      'location': location,
      'description': description,
      'image': image
    };
  }
}
