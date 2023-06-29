class Friend {
  final String uid;
  final bool accepted;

  Friend({
    required this.uid,
    required this.accepted,
  });

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'accepted': accepted,
    };
  }
}