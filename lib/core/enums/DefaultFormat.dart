enum UserFileFormats {
  files("Files"),
  media("Media"),
  audios("Audio"),
  texts("Texts"),
  links("Links"),
  chats("Chats");

  final String label;
  const UserFileFormats(this.label);

  String getLabel() {
    return label;
  }

}


