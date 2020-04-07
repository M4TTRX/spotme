import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:home_workouts/model/challenges/challenge_progress.dart';
import 'package:home_workouts/model/user_model.dart';

class HomeViewData {
  User user;
  String welcomeString;
  List<ChallengeProgress> challengesProgress;
  HomeViewData({
    this.user,
    this.welcomeString,
    this.challengesProgress,
  });

  HomeViewData copyWith({
    User user,
    String welcomeString,
    List<ChallengeProgress> challengesProgress,
  }) {
    return HomeViewData(
      user: user ?? this.user,
      welcomeString: welcomeString ?? this.welcomeString,
      challengesProgress: challengesProgress ?? this.challengesProgress,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'user': user.toMap(),
      'welcomeString': welcomeString,
      'challengesProgress':
          List<dynamic>.from(challengesProgress.map((x) => x.toMap())),
    };
  }

  static HomeViewData fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return HomeViewData(
      user: User.fromMap(map['user']),
      welcomeString: map['welcomeString'],
      challengesProgress: List<ChallengeProgress>.from(
          map['challengesProgress']?.map((x) => ChallengeProgress.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  static HomeViewData fromJson(String source) => fromMap(json.decode(source));

  @override
  String toString() =>
      'HomeViewData(user: $user, welcomeString: $welcomeString, challengesProgress: $challengesProgress)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is HomeViewData &&
        o.user == user &&
        o.welcomeString == welcomeString &&
        listEquals(o.challengesProgress, challengesProgress);
  }

  @override
  int get hashCode =>
      user.hashCode ^ welcomeString.hashCode ^ challengesProgress.hashCode;
}
