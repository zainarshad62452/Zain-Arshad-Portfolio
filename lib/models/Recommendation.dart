class Recommendation {
  String? name;
  String? source;
  String? text;
  String? image;

  Recommendation({this.name, this.source, this.text,this.image});

  factory Recommendation.fromJson(Map<String, dynamic> json) {
    return Recommendation(
      name: json['name'] as String?,
      source: json['source'] as String?,
      text: json['text'] as String?,
      image: json['image'] as String?,
    );
  }

  // Method to convert an instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'source': source,
      'text': text,
      'image': image,
    };
  }
}

final List<Recommendation> demo_recommendations = [
  Recommendation(
    name: "Bachelors of Software Engineering",
    source: "Comsats University Islamabad",
    text:
        "Studying Software Engineering at Comsats University Islamabad was an enriching experience that provided me with a strong foundation in software development. The university's rigorous curriculum, experienced faculty, and state-of-the-art facilities fostered a dynamic learning environment. Moreover, the diverse student community and extracurricular opportunities enhanced my overall growth and prepared me for a successful career in the software industry.",
  ),
  Recommendation(
    name: "Game Development",
    source: "Aptech Media",
    text:
        "Earning a Game Development certificate from Aptech Media was a valuable step in my journey as a game developer. The program equipped me with essential skills in game design, programming, and graphics, laying the groundwork for a career in the exciting world of game development. This certification has been instrumental in pursuing my passion for creating interactive and immersive gaming experiences.",
  ),
  Recommendation(
    name: "UI/UX Design",
    source: "Coursera",
    text:
        "Completing a UI/UX Design course has been instrumental in honing my skills as a designer. This program provided in-depth knowledge of user interface and user experience principles, enabling me to create intuitive and visually appealing digital products. The hands-on experience and industry-relevant projects I undertook during the course have prepared me to design engaging and user-centric interfaces.",
  ),
  Recommendation(
    name: "Flutter Development",
    source: "Udemy",
    text:
        "Enrolling in a Flutter development course on Udemy was a transformative experience in my journey as a mobile app developer. This comprehensive course provided me with a strong grasp of Flutter's framework, enabling me to build cross-platform applications efficiently. The practical projects and hands-on learning approach on Udemy have equipped me with the skills needed to create robust and engaging mobile apps using Flutter.",
  ),
];
