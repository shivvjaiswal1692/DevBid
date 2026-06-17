import 'package:devbid/models/listing_model.dart';
import 'package:flutter/foundation.dart';

class ListingService extends ChangeNotifier {
  final List<ListingModel> _listings = [];

  List<ListingModel> get listings => List.unmodifiable(_listings);

  void addListing({
    required String title,
    required String category,
    required double price,
    required String description,
    String? imageUrl,
  }) {
    _listings.insert(
      0,
      ListingModel(
        id: DateTime.now().microsecondsSinceEpoch.toString(),
        title: title.trim(),
        category: category.trim(),
        price: price,
        description: description.trim(),
        imageUrl: imageUrl?.trim().isEmpty ?? true ? null : imageUrl?.trim(),
        createdAt: DateTime.now(),
      ),
    );
    notifyListeners();
  }

  List<ListingModel> search(String query, {String category = 'All'}) {
    final normalizedQuery = query.trim().toLowerCase();

    final filteredByCategory = category == 'All'
        ? _listings
        : _listings.where((item) => item.category.toLowerCase() == category.toLowerCase()).toList();

    if (normalizedQuery.isEmpty) return filteredByCategory;

    final lower = query.toLowerCase();
    return filteredByCategory
        .where((item) => item.title.toLowerCase().contains(lower))
        .toList();
  }
}
