import 'dart:convert';
import 'package:http/http.dart' as http;

class GptService {
  static const String apiKey = '<YOUR_API_KEY>';
  static const String apiEndpoint = '<API_ENDPOINT>';

  Future<String> generateContract(String input) async {

    final response = await http.post(
      Uri.parse(apiEndpoint),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $apiKey',
      },
      body: json.encode({
        'prompt': input,
        'max_tokens': 1000,
      }),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['choices'][0]['text'];
    } else {
      throw Exception('Failed to generate contract');
    }

  }
}
