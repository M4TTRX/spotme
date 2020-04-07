import 'dart:convert';

import 'package:home_workouts/model/week_overviews/friends_overview.dart';
import 'package:home_workouts/model/week_overviews/week_overview.dart';

class HomeInfo {
  String welcomeString;
  WeekOverview yourWeekOverview;
  List<FriendsOverview> friendsOverView;
  HomeInfo({
    this.welcomeString,
    this.yourWeekOverview,
    this.friendsOverView,
  });

  HomeInfo copyWith({
    String welcomeString,
    WeekOverview yourWeekOverview,
    List<FriendsOverview> friendsOverView,
  }) {
    return HomeInfo(
      welcomeString: welcomeString ?? this.welcomeString,
      yourWeekOverview: yourWeekOverview ?? this.yourWeekOverview,
      friendsOverView: friendsOverView ?? this.friendsOverView,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'welcomeString': welcomeString,
      'yourWeekOverview': yourWeekOverview.toMap(),
      'friendsOverView':
          List<dynamic>.from(friendsOverView.map((x) => x.toMap())),
    };
  }

  static HomeInfo fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return HomeInfo(
      welcomeString: map['welcomeString'],
      yourWeekOverview: WeekOverview.fromMap(map['yourWeekOverview']),
      friendsOverView: List<FriendsOverview>.from(
          map['friendsOverView']?.map((x) => FriendsOverview.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  static HomeInfo fromJson(String source) => fromMap(json.decode(source));

  @override
  String toString() =>
      'HomeInfo(welcomeString: $welcomeString, yourWeekOverview: $yourWeekOverview, friendsOverView: $friendsOverView)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is HomeInfo &&
        o.welcomeString == welcomeString &&
        o.yourWeekOverview == yourWeekOverview &&
        o.friendsOverView == friendsOverView;
  }

  @override
  int get hashCode =>
      welcomeString.hashCode ^
      yourWeekOverview.hashCode ^
      friendsOverView.hashCode;
}
