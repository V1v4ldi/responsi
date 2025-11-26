import 'package:http/http.dart' as http;

final String baseArticles = 'https://api.spaceflightnewsapi.net/v4/articles/';
final String baseBlogs = 'https://api.spaceflightnewsapi.net/v4/blogs/';
final String baseReports = 'https://api.spaceflightnewsapi.net/v4/reports/';

class Wrapper {
  Future<http.Response> fetchArticles() async {
    final url = Uri.parse(baseArticles);
    return http.get(url);
  }

  Future<http.Response> fetchBlogs() async {
    final url = Uri.parse(baseBlogs);
    return http.get(url);
  }
  
  Future<http.Response> fetchReports() async {
    final url = Uri.parse(baseReports);
    return http.get(url);
  }
  
  Future<http.Response> fetchDetailArticles(int id) async {
    final url = Uri.parse('$baseArticles$id/');
    return http.get(url);
  }
  
  Future<http.Response> fetchDetailBlogs(int id) async {
    final url = Uri.parse('$baseBlogs$id/');
    return http.get(url);
  }
  
  Future<http.Response> fetchDetailReports(int id) async {
    final url = Uri.parse('$baseReports$id/');
    return http.get(url);
  }
}
