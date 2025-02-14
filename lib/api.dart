import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

class Api {
  static Future<Map<String, dynamic>?> uploadImage(File imageFile) async {
    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse(
            'https://miniprojetdrone.onrender.com/predict'), // Update this
      );

      request.files.add(
        await http.MultipartFile.fromPath('file', imageFile.path),
      );

      var response = await request.send();
      print('Status Code: ${response.statusCode}');
      var responseBody = await response.stream.bytesToString();
      print('Response: $responseBody');
      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(responseBody);
        return jsonResponse;
      } else {
        return {"error": "Failed to get prediction"};
      }
    } catch (e) {
      // Handle error
      print('Error uploading image: $e');
      return {"error": "Failed to upload image"};
    }
  }
}
