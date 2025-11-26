class ArticlesModels {
  final int id;
  final String title;
  final List<Author> author;
  final String url;
  final String imgUrl;
  final String newsSite;
  final String summary;

  ArticlesModels({
    required this.id,
    required this.title,
    required this.author,
    required this.url,
    required this.imgUrl,
    required this.newsSite,
    required this.summary,
  });

  factory ArticlesModels.fromJson(Map<String, dynamic> json) {
    return ArticlesModels(
      id: json['id'],
      title: json['title'],
      author: (json['authors'] as List<dynamic>)
          .map((e) => Author.fromJson(e))
          .toList(),
      url: json['url'],
      imgUrl: json['image_url'],
      newsSite: json['news_site'],
      summary: json['summary'],
    );
  }
}

class Author {
  final String name;
  final Social? social;

  Author({required this.name, required this.social});

  factory Author.fromJson(Map<String, dynamic> json) {
    return Author(
      name: json['name'],
      social: json['socials'] != null 
          ? Social.fromJson(json['socials']) 
          : null,
    );
  }
}

class Social {
  final String x;
  final String youtube;
  final String instagram;
  final String linkedin;
  final String mastodon;
  final String bluesky;

  Social({
    required this.x,
    required this.youtube,
    required this.instagram,
    required this.linkedin,
    required this.mastodon,
    required this.bluesky,
  });

  factory Social.fromJson(Map<String, dynamic> json) {
    return Social(
      x: json['x'],
      youtube: json['youtube'],
      instagram: json['instagram'],
      linkedin: json['linkedin'],
      mastodon: json['mastodon'],
      bluesky: json['bluesky'],
    );
  }
}