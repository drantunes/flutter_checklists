import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_checklist/data/mocks/checklists_json.dart';
import 'package:http/http.dart' as http;

const url = 'https://68261459397e48c91314eaed.mockapi.io/api';

class ChecklistApiService {
  Future<List<dynamic>> getChecklist() async {
    try {
      final response = await http.get(Uri.parse("$url/checklists"));
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      }
    } catch (e) {
      debugPrint(e.toString());
      return checklistsJson;
    } finally {
      postSyncedDate();
    }
    return checklistsJson;
  }

  postSyncedDate() async {
    try {
      await http.post(
        Uri.parse("$url/syncedDate"),
        body: {'date': DateTime.now().toIso8601String()},
        // headers: {
        //   'Authorization': 'Tokasdasd...123123123123'
        // },
      );
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
