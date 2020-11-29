import 'package:http/http.dart' as http;

class SearchTipo {
  static Future<String> searchDjangoApi3(String query) async {
    String url = 'http://10.0.2.2:8000/InstitucionTipoApi/?search=$query';
    http.Response response = await http.get(Uri.encodeFull(url));
    return response.body;
  }
}
