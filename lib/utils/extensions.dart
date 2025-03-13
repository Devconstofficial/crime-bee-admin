extension MyExtensions on String {
  String convertToCamelCase() {
    String name = this;
    if(name.isEmpty) {
      return name;
    }
    final values = name.split('');
    values[0] = values.first.toUpperCase();
    return values.join();
  }
}