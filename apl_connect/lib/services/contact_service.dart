import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/contact_model.dart';

class ContactService {
  // Replace this with your actual raw GitHub file URL
  static const String dataUrl =
      'https://raw.githubusercontent.com/Mamuntheprogrammer/apl_contact/refs/heads/main/contact.json';

  static Future<List<Contact>> fetchContacts() async {
    try {
      final response = await http.get(Uri.parse(dataUrl));

      if (response.statusCode == 200) {
        // Decode the response into a Map
        final Map<String, dynamic> jsonMap = json.decode(response.body);

        // Access the 'contacts' key and get the list of contacts
        final List<dynamic> jsonList = jsonMap['contacts'];

        // Map the list into a List of Contact objects
        return jsonList.map((json) => Contact.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load contacts');
      }
    } catch (e) {
      throw Exception('Error fetching data: $e');
    }
  }
}
