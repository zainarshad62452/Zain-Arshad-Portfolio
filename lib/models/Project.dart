// ignore: file_names
class Project {
  String? title, description, skillsUsed,uid,mainImage,projectUrl,sourceCodeUrl;
  List<String>? projectImages;

  Project({this.title, this.description,this.skillsUsed,this.projectImages,this.uid,this.mainImage,this.projectUrl,this.sourceCodeUrl});

    Project.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    description = json['description'];
    skillsUsed = json['skillsUsed'];
    projectUrl = json['projectUrl']??"";
    sourceCodeUrl = json['sourceCodeUrl']??"";
    uid = json['uid'];
    mainImage = json['mainImage'];
    if (json['projectImages'] != null) {
      projectImages = List<String>.from(json['projectImages']);
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['description'] = description;
    data['skillsUsed'] = skillsUsed;
    data['projectUrl'] = projectUrl;
    data['sourceCodeUrl'] = sourceCodeUrl;
    data['uid'] = uid;
    data['mainImage'] = mainImage;
    data['projectImages'] = projectImages!;
    return data;
  }
}

List<Project> demo_projects = [
  Project(
    title: "Buraq-A cab services app - Final year project",
    description:
        "Buraq is a cutting-edge cab services app developed using the Flutter framework. Offering a seamless user experience, it provides convenient and reliable transportation solutions with a user-friendly interface, real-time tracking, and a range of payment options.",
  ),
  Project(
    title: "Feed The Needy - Flutter app",
    description:
        "Feed The Needy is a compassionate Flutter app dedicated to addressing food scarcity. This platform facilitates food donations by connecting donors with local charities and individuals in need. With an intuitive interface, it empowers users to easily contribute surplus food, reducing food wastage and making a positive impact on communities.",
  ),
  Project(
    title: "Solvify - Flutter App",
    description:
        "Solvify is an innovative Flutter app harnessing the power of AI to simplify math problem-solving. Users can effortlessly input mathematical equations or problems, and the app's AI-driven algorithms provide step-by-step solutions, making complex math concepts more accessible and promoting learning. Solvify is your go-to tool for conquering math challenges with ease.",
  ),
  Project(
    title: "House Hub - Flutter App",
    description:
        "House Hub is a convenient Flutter app designed to empower hostel students in managing their living spaces. With House Hub, students can effortlessly oversee their hostel rooms, track maintenance requests, and communicate with roommates and hostel administrators. This user-friendly platform simplifies the hostel experience, fostering better organization and community interaction.",
  ),
  Project(
    title: "VCredit - Flutter App",
    description:
        "VCredit is an efficient Flutter app tailored for businesses and entrepreneurs to streamline credit management and transactions. With VCredit, users can securely store and manage their business credits, track transactions, and facilitate seamless financial interactions with other users. This app simplifies credit management, promoting transparency and efficiency in business operations.",
  ),
  Project(
    title: "Toy Exchange App - Flutter App",
    description:
        "The Toy Exchange App is a user-friendly Flutter application designed to facilitate the exchange of toys among parents and families. This platform allows users to list, browse, and connect with others in their community to exchange toys, reducing waste and promoting sustainable toy sharing. With its intuitive interface and safety features, the Toy Exchange App makes it easy for families to find new homes for their toys while fostering a sense of community and environmentally conscious toy ownership.",
  ),
];
