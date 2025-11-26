class BlogsModels {
  final int id;
  final String title;
  final List<Author> author;
  final String url;
  final String imgUrl;
  final String newsSite;
  final String summary;

  BlogsModels({
    required this.id,
    required this.title,
    required this.author,
    required this.url,
    required this.imgUrl,
    required this.newsSite,
    required this.summary,
  });

  factory BlogsModels.fromJson(Map<String, dynamic> json) {
    return BlogsModels(
      id: json['id'],
      title: json['title'],
      author: (json['author'] as List<dynamic>)
          .map((e) => Author.fromJson(e))
          .toList(),
      url: json['url'],
      imgUrl: json['imgUrl'],
      newsSite: json['newsSite'],
      summary: json['summary'],
    );
  }
}

class Author {
  final String name;
  final List<Social> social;

  Author({required this.name, required this.social});

  factory Author.fromJson(Map<String, dynamic> json) {
    return Author(
      name: json['name'],
      social: (json['social'] as List<dynamic>)
          .map((e) => Social.fromJson(e))
          .toList(),
    );
  }
}

class Social {
  final String X;
  final String youtube;
  final String instagram;
  final String linkedin;
  final String mastodon;
  final String bluesky;

  Social({
    required this.X,
    required this.youtube,
    required this.instagram,
    required this.linkedin,
    required this.mastodon,
    required this.bluesky,
  });

  factory Social.fromJson(Map<String, dynamic> json) {
    return Social(
      X: json['X'],
      youtube: json['youtube'],
      instagram: json['instagram'],
      linkedin: json['linkedin'],
      mastodon: json['mastodon'],
      bluesky: json['bluesky'],
    );
  }
}