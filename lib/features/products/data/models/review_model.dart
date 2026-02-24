class Review {
  const Review({
    required this.id,
    required this.userId,
    required this.userName,
    required this.rating,
    required this.comment,
    required this.date,
  });

  final String id;
  final String userId;
  final String userName;
  final double rating;
  final String comment;
  final DateTime date;
}
