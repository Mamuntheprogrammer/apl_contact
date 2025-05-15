import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../models/contact_model.dart';

class ContactService {
  static const String dataUrl =
      'https://raw.githubusercontent.com/Mamuntheprogrammer/apl_contact/refs/heads/main/contact2.json';

  static Future<List<Contact>> fetchContacts() async {
    try {
      final response = await http.get(Uri.parse(dataUrl));

      if (response.statusCode == 200) {
        final jsonMap = json.decode(response.body);
        final List<dynamic> jsonList = jsonMap['contacts'];

        // Save to local storage
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('cachedContacts', response.body);

        return jsonList.map((json) => Contact.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load contacts');
      }
    } catch (e) {
      print('Error fetching data from network: $e');
      // Try loading from local cache
      return loadContactsFromCache();
    }
  }

  static Future<List<Contact>> loadContactsFromCache() async {
    final prefs = await SharedPreferences.getInstance();
    final cachedData = prefs.getString('cachedContacts');

    if (cachedData != null) {
      final jsonMap = json.decode(cachedData);
      final List<dynamic> jsonList = jsonMap['contacts'];
      return jsonList.map((json) => Contact.fromJson(json)).toList();
    } else {
      throw Exception('No cached data available.');
    }
  }
}
