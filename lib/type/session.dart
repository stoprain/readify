// "config": {
//     "icons_dir": "feed-icons",
//     "icons_url": "feed-icons",
//     "daemon_is_running": true,
//     "custom_sort_types": [],
//     "num_feeds": 123
// },
// "api_level": 21

class Session {
  final String session_id;

  Session({required this.session_id});

  factory Session.fromJson(Map<String, dynamic> json) {
    return Session(session_id: json["session_id"]);
  }
}
