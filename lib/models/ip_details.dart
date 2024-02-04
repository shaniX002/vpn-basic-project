class IpDetails {
  late final String country;
  late final String regionName;
  late final String city;
  late final String zip;
  late final String timezone;
  late final String isp;
  late final String query;

  IpDetails({
    required this.country,
    required this.regionName,
    required this.city,
    required this.zip,
    required this.timezone,
    required this.isp,
    required this.query,
  });

  IpDetails.fromJson(Map<String, dynamic> json) {
    country = json['country'] ?? '';
    regionName = json['regionName'] ?? '';
    city = json['city'] ?? '';
    zip = json['zip'] ?? '- - - -';
    timezone = json['timezone'] ?? 'Unknow';
    isp = json['isp'] ?? 'Unknow';
    query = json['query'] ?? 'Not Available';
  }
}
