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
    // final ids = problem['problemId'];
    // final locations = problem['location'];
    // final status = problem['status'];
    // final descriptions = problem['description'];
    // final image = problem['image'];

    // return List.generate(
    //     problem.length,
    //     (index) => Problem(
    //         problemId: ids[index],
    //         location: locations[index],
    //         description: descriptions[index],
    //         status: status[index],
    //         image: image[index]));

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
}
