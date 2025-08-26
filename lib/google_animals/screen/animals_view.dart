import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:rest_api/google_animals/screen/search_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/google_book_response.dart';
import 'animal_view.dart';
// import 'animal_view.dart';

class AnimalsView extends StatefulWidget {
  const AnimalsView({super.key});

  @override
  State<AnimalsView> createState() => _AnimalsViewState();
}

class _AnimalsViewState extends State<AnimalsView> {
  GoogleBookResponse? googleBookResponse;
  final _searchController = TextEditingController();
  String _searchText = '';

  String get searchText => _searchController.text;

  bool isloading = true;

  @override
  void initState() {
    super.initState();
    _getAnimals();
    loadSearch();

  }

  _getAnimals() async {
    try {
      final url = 'https://www.googleapis.com/books/v1/volumes?q=$_searchText';
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          googleBookResponse = GoogleBookResponse.fromJson(data);
        });
      }
    } catch (e) {
      print('Error: $e');
    } finally {
      setState(() {
        isloading = false;
      });
    }
  }

  //
  // getSearchText() async {
  //   final sharedPreferences = await SharedPreferences.getInstance();
  //   if( searchText.isNotEmpty && searchText != ''){
  //      await sharedPreferences.setString('searchText', searchText);
  //     final saveText = sharedPreferences.getString('searchText')!;
  //      setState(() {
  //        _searchText = saveText;
  //      });
  //   }
  //
  // }
  Future<void> saveSearch({required String searchText}) async {
    final prefs = await SharedPreferences.getInstance();
    if (searchText.isNotEmpty) {
      await prefs.setString('searchText', searchText);
      setState(() {
        loadSearch();
      });
      _searchController.clear();
      // _searchController.clear();
      print("Saved: $searchText");
    }
  }

  Future<void> loadSearch() async {
    final prefs = await SharedPreferences.getInstance();
    final saved = prefs.getString('searchText') ?? '';
    setState(() {
      _searchText = saved;
      isloading = true;
      _getAnimals();
    });
    print("Loaded: $saved");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:_searchText.isEmpty? Text('Search books'): googleBookResponse?.items?.isEmpty ?? true
            ? Text('Search not good')
            : Text("$_searchText books List"),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {

              if(googleBookResponse?.items?.isEmpty ?? true){
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('No books found. Please search a valid book name.'),
                  duration: Duration(seconds: 2),
                ),
              );

              }else if(_searchText.isEmpty){
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Please search a book name.'),
                    duration: Duration(seconds: 2),
                  ),
                );
              }
              else{
                showSearch(
                  context: context,
                  delegate: SearchScreen(googleBookResponse: googleBookResponse!),
                );
              }


            },
            icon: const Icon(Icons.search),
          ),
          IconButton(
            onPressed: () {
              // print(serachTitle());
              setState(() {
                isloading = true;
              });

              _getAnimals();
            },
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                hintText: 'search valued google book name',
                labelText: 'Search',
                suffixIcon: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () async {
                    saveSearch(searchText: searchText);
                  },
                ),
              ),
            ),
            isloading
                ? Expanded(
                    child: const Center(child: CircularProgressIndicator()),
                  )
                : _searchText.isEmpty
                ? Expanded(
                    child: Center(child: Text(' Please search your book ')),
                  )
                : googleBookResponse?.items?.isEmpty ?? true
                ? Expanded(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'No books found',
                            style: TextStyle(fontSize: 20, color: Colors.red),
                          ),
                          Text(
                            'Your search was  ( $_searchText ) not valid',
                            style: TextStyle(),
                          ),
                        ],
                      ),
                    ),
                  )
                : Expanded(
                    child: ListView.builder(
                      itemCount: googleBookResponse?.items?.length ?? 0,
                      itemBuilder: (context, index) {
                        final book =
                            googleBookResponse?.items?[index].volumeInfo;

                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListTile(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => AnimalView(
                                    volumeInfo: book,
                                    googleBookResponse: googleBookResponse!,
                                  ),
                                ),
                              );
                            },
                            title: Text(book?.title ?? 'No Title'),
                            subtitle: Text(
                              (book?.authors != null &&
                                      book!.authors!.isNotEmpty)
                                  ? book.authors!.join(", ")
                                  : "Unknown Author",
                            ),
                            leading: CachedNetworkImage(
                              imageUrl: book?.imageLinks?.thumbnail ?? '',
                              placeholder: (context, url) =>
                                  const CircularProgressIndicator(),
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.broken_image),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
