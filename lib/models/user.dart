class MyUser {
  final String uid;

  MyUser({required this.uid });

  
  @override
  bool operator ==(Object other) {
    return other is MyUser && uid == other.uid;
  }
}