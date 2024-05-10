import 'package:reader_tracker/models/book.dart';

class BookDetailsArguments {
  final Book itemBook;
  final bool isFromSavedScreen;

  BookDetailsArguments({
    required this.itemBook,
    required this.isFromSavedScreen,
  });
}
