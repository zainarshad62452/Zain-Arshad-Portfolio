class DetailsModel {
  String? myName;
  String? title;
  String? residence;
  String? city;
  String? age;
  List<String>? skills;
  List<double>? skillsPercentage;
  List<String>? languages;
  List<double>? languagesPercentage;
  List<String>? knowledges;
  String? cvLink;
  String? linkedIn;
  String? github;
  String? fiverr;
  String? upwork;
  String? qoute;
  List<String>? headlines;
  String? profileImage;
  String? bannerImage;
  String? subHeadlines;
  String? tag;

  DetailsModel({
    this.myName,
    this.title,
    this.residence,
    this.city,
    this.age,
    this.skills,
    this.skillsPercentage,
    this.languages,
    this.languagesPercentage,
    this.knowledges,
    this.cvLink,
    this.linkedIn,
    this.github,
    this.fiverr,
    this.upwork,
    this.qoute,
    this.headlines,
    this.profileImage,
    this.bannerImage,
    this.subHeadlines,
    this.tag,
  });

  DetailsModel.fromJson(Map<String, dynamic> json) {
    myName = json['myName'];
    title = json['title'];
    residence = json['residence'];
    city = json['city'];
    age = json['age'];
    skills = List<String>.from(json['skills'] ?? []);
    skillsPercentage = List<double>.from(json['skillsPercentage'] ?? []);
    languages = List<String>.from(json['languages'] ?? []);
    languagesPercentage = List<double>.from(json['languagesPercentage'] ?? []);
    knowledges = List<String>.from(json['knowledges'] ?? []);
    cvLink = json['cvLink'];
    linkedIn = json['linkedIn'];
    github = json['github'];
    fiverr = json['fiverr'];
    upwork = json['upwork'];
    qoute = json['qoute'];
    headlines = List<String>.from(json['headlines'] ?? []);
    profileImage = json['profileImage'];
    bannerImage = json['bannerImage'];
    subHeadlines = json['subHeadlines'];
    tag = json['tag'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['myName'] = this.myName;
    data['title'] = this.title;
    data['residence'] = this.residence;
    data['city'] = this.city;
    data['age'] = this.age;
    data['skills'] = this.skills;
    data['skillsPercentage'] = this.skillsPercentage;
    data['languages'] = this.languages;
    data['languagesPercentage'] = this.languagesPercentage;
    data['knowledges'] = this.knowledges;
    data['cvLink'] = this.cvLink;
    data['linkedIn'] = this.linkedIn;
    data['github'] = this.github;
    data['fiverr'] = this.fiverr;
    data['upwork'] = this.upwork;
    data['qoute'] = this.qoute;
    data['headlines'] = this.headlines;
    data['profileImage'] = this.profileImage;
    data['bannerImage'] = this.bannerImage;
    data['subHeadlines'] = this.subHeadlines;
    data['tag'] = this.tag;
    return data;
  }
}
