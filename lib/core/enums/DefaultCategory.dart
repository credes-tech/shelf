enum UserDefaultCategory {
  work("Work and Productivity"),
  personal("Personal and Home"), 
  research("Research and Learning"),
  social("Social Media and Web"),
  all("Almost Everything");

  final String label;
  const UserDefaultCategory(this.label);

  String getLabel() {
    return label;
  }
}
