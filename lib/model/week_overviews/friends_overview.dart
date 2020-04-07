import 'dart:convert';

import 'package:home_workouts/model/week_overviews/week_overview.dart';

import '../user_model.dart';

class FriendsOverview {
  User friend;
  WeekOverview overview;
  FriendsOverview({
    this.friend,
    this.overview,
  });

  FriendsOverview copyWith({
    User friend,
    WeekOverview overview,
  }) {
    return FriendsOverview(
      friend: friend ?? this.friend,
      overview: overview ?? this.overview,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'friend': friend.toMap(),
      'overview': overview.toMap(),
    };
  }

  static FriendsOverview fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return FriendsOverview(
      friend: User.fromMap(map['friend']),
      overview: WeekOverview.fromMap(map['overview']),
    );
  }

  String toJson() => json.encode(toMap());

  static FriendsOverview fromJson(String source) =>
      fromMap(json.decode(source));

  @override
  String toString() => 'FriendsOverview(friend: $friend, overview: $overview)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is FriendsOverview && o.friend == friend && o.overview == overview;
  }

  @override
  int get hashCode => friend.hashCode ^ overview.hashCode;
}
