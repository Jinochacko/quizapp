class CountryItem {
  final String name;
  final String code;
  final String region;
  final bool isSelected;

  CountryItem({
    required this.name,
    required this.code,
    required this.region,
    required this.isSelected
  });

  factory CountryItem.fromJson(Map<String, dynamic> item) {
    return CountryItem(
      name: item['name']['common'],
      code: item['cca2'],
      region: item['region'],
        isSelected: false
    );
  }
}