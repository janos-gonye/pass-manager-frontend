class Profile {
  String title;
  String username;
  String password;
  String notes;
  String url;

  Profile({
    this.title = "",
    this.username = "",
    this.password = "",
    this.notes = "",
    this.url = "",
  });

  bool isEmpty() {
    if (this.title.isEmpty &&
        this.username.isEmpty &&
        this.password.isEmpty &&
        this.notes.isEmpty &&
        this.url.isEmpty
    ) {
      return true;
    }
    return false;
  }
}
