import 'package:flutter/material.dart';
import 'package:reader_tracker/db/database_helper.dart';
import 'package:reader_tracker/models/book.dart';
import 'package:reader_tracker/utils/book_details_arguments.dart';

class SavedScreen extends StatefulWidget {
  const SavedScreen({super.key});

  @override
  State<SavedScreen> createState() => _SavedScreenState();
}

class _SavedScreenState extends State<SavedScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: FutureBuilder(
          future: DatabaseHelper.instance.readAllBooks(),
          builder: (context, snapshot) => snapshot.hasData
              ? ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    Book book = snapshot.data![index];
                    // get each books fav status

                    //print("Books: ==> ${snapshot.data![index].toString()}");
                    return InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, '/details',
                            arguments: BookDetailsArguments(
                                itemBook: book, isFromSavedScreen: true));
                      },
                      child: Card(
                        child: ListTile(
                          title: Text(book.title),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () {
                              DatabaseHelper.instance.deleteBook(book.id);
                              setState(() {});
                            },
                          ),
                          leading: Image.network(
                            book.imageLinks['thumbnail'] ?? '',
                            fit: BoxFit.cover,
                          ),
                          subtitle: Column(
                            children: [
                              Text(book.authors.join(', ')),
                              ElevatedButton.icon(
                                  onPressed: () async {
                                    // toggle the favorite flag
                                    book.isFavorite = !book.isFavorite;
                                    await DatabaseHelper.instance
                                        .toggleFavoriteStatus(
                                            book.id, book.isFavorite);
                                    //refresh th UI
                                    setState(() {});
                                  },
                                  icon: Icon(
                                    book.isFavorite
                                        ? Icons.favorite
                                        : Icons.favorite_outline,
                                    color: book.isFavorite ? Colors.red : null,
                                  ),
                                  label: Text((book.isFavorite)
                                      ? 'Favorite'
                                      : 'Add to Favorites'))
                            ],
                          ),
                        ),
                      ),
                    );
                  })
              : const Center(child: CircularProgressIndicator())),
    );
  }
}
