import 'package:http/http.dart' as http;

class FirebaseAuthRemoteDataSource {
  final String url =
      'https://us-central1-jangjeon-8722f.cloudfunctions.net/createKakaoToken';

  Future<String> createKakaoToken(Map<String, dynamic> user) async {
    final tokenResponse = await http.post(Uri.parse(url), body: user);

    return tokenResponse.body;
  }
}
