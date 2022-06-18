class Profile {
  final String uid;
  String username;
  String bio = "";
  int followers = 0;
  int following = 0; 

  Profile({required this.uid, required this.username, String bio = "", int followers = 0, int following = 0});
}