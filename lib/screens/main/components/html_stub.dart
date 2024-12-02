// lib/html_stub.dart
class Blob {
  Blob(List<Object> parts);
}

class Url {
  static String createObjectUrlFromBlob(Blob blob) => '';
  static void revokeObjectUrl(String url) {}
}

class AnchorElement {
  AnchorElement({String? href});

  void click() {}

  set target(String? value) {}

  set download(String? value) {}
}
