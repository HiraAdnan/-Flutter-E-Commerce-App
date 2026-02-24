class Address {
  const Address({
    required this.fullName,
    required this.street,
    required this.city,
    required this.state,
    required this.zipCode,
    required this.country,
    this.phone,
  });

  final String fullName;
  final String street;
  final String city;
  final String state;
  final String zipCode;
  final String country;
  final String? phone;

  String get formatted => '$street, $city, $state $zipCode, $country';
}
