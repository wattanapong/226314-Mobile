import 'dart:convert';
import 'package:http/http.dart' as http;

Future<Map<String, dynamic>> fetchData(String url, Map<String, String> body) async {
  final response = await http.post(
    Uri.parse(url),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(body),
  );

  if (response.statusCode == 200) {
    return jsonDecode(response.body);
  } else {
    throw Exception('Failed to fetch data');
  }
}

Future<void> main() async {
  final Map<String, String> requestBody = {
    'menu_level': '2',
    'menu': '22791',
    'skip': '0',
    'take': '16',
    'key': '5',
    'sort_promotion': '',
    'product_type': 'product',
  };

  String url = 'https://www.advice.co.th/avi/getProduct';

  try {
    final response = await fetchData(url, requestBody);
    print(response);
  } catch (e) {
    print('Error fetching data: $e');
  }
}


