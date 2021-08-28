class StringUtils {
  static String enumToName(String enumToString) {
    final paths = enumToString.split('.');
    return paths[1];
  }

  static String capitalize(String value) {
    return (value.isNotEmpty)
        ? value[0].toUpperCase() + value.substring(1)
        : value[0].toUpperCase();
  }

  static String removeAllHtmlTags(String htmlText) {
    final pattern = RegExp(
      '<.*?>|&.*?;',
      multiLine: true,
      caseSensitive: false,
    );
    return htmlText.replaceAll(pattern, '');
  }
}
