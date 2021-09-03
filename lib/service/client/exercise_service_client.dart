import 'dart:convert' as convert;

import 'package:home_workouts/model/account_model.dart';
import 'package:home_workouts/model/exercise_model.dart';
import 'package:http/http.dart' as http;

class ExerciseServiceClient {
  final _exerciseServiceURL = "exercise-service-zkyisgimeq-uc.a.run.app";

  Future<List<Exercise>> getRecommendedExercises(Account account) async {
    var url = Uri.https(_exerciseServiceURL, '/recommended-exercises',
        {'token': 'secret-query-token'});

    // Await the http get response, then decode the json-formatted response.
    var response = await http.get(url, headers: {
      "x-token": "fake-super-secret-token",
      "accept": "application/json"
    });
    if (response.statusCode == 200 || response.statusCode == 204) {
      List<dynamic> jsonResponse = convert.jsonDecode(response.body);
      List<Exercise> exercises =
          jsonResponse.map((e) => Exercise.fromMap(e) ?? Exercise()).toList();
      return exercises;
    } else {
      print('Request failed with status: ${response.statusCode}.');
      return [];
    }
  }
}
