import 'dart:async';
import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
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
  bool isConnected = true;
  bool erroSearch = false;
  StreamSubscription<List<ConnectivityResult>>? subscription;

  @override
  void initState() {
    super.initState();
    subscription = Connectivity().onConnectivityChanged.listen((result) {
      if (result.contains(ConnectivityResult.mobile) ||
          result.contains(ConnectivityResult.wifi)) {
        _getAnimals();
        setState(() {
          isConnected = true;
        });
      } else {
        // isloading = true;
        setState(() {
          isConnected = false;
          _getAnimals();
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('No internet connection'),
            duration: Duration(seconds: 2),
          ),
        );
      }
    });
    loadSearch();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    subscription?.cancel();
  }

  Future<bool> isConectionCheck() async {
    final result = await Connectivity().checkConnectivity();
    return (result.contains(ConnectivityResult.mobile) ||
        result.contains(ConnectivityResult.wifi));
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
        if (googleBookResponse!.items != null) {
          erroSearch = false;
        } else {
          erroSearch = true;
        }
      });
    }
  }

  Future<void> saveSearch({required String searchText}) async {
    final prefs = await SharedPreferences.getInstance();
    if (searchText.isNotEmpty) {
      await prefs.setString('searchText', searchText);
      setState(() {
        isloading = true;
        loadSearch();
      });
      _searchController.clear();
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
      backgroundColor: Colors.blueGrey.withOpacity(0.3),
      appBar: AppBar(
        backgroundColor: Colors.transparent.withOpacity(0.3),
        title: _searchText.isEmpty
            ? Text('Search books')
            : googleBookResponse!.items!.isEmpty
            ? Text('Search not good')
            : RichText(
                text: TextSpan(
                  text: _searchText.toUpperCase(),style: TextStyle(color:Colors.black,fontSize: 20,fontWeight: FontWeight.bold),
                  children: [TextSpan(text: ' book list',style: TextStyle(color:Colors.white,))],
                ),
              ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              if (googleBookResponse?.items?.isEmpty ?? true) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      'No books found. Please search a valid book name.',
                    ),
                    duration: Duration(seconds: 2),
                  ),
                );
              } else if (_searchText.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Please search a book name.'),
                    duration: Duration(seconds: 2),
                  ),
                );
              } else {
                showSearch(
                  context: context,
                  delegate: SearchScreen(
                    googleBookResponse: googleBookResponse!,
                  ),
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
            if (_searchText.isEmpty)
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

            googleBookResponse != null
                ? Expanded(
                    child: Stack(
                      children: [
                        Column(
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

                            if (!erroSearch && !isloading)
                              Expanded(
                                child: ListView.builder(
                                  itemCount:
                                      googleBookResponse?.items?.length ?? 0,
                                  itemBuilder: (context, index) {
                                    final book = googleBookResponse
                                        ?.items?[index]
                                        .volumeInfo;

                                    return Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: ListTile(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => AnimalView(
                                                volumeInfo: book,
                                                googleBookResponse:
                                                    googleBookResponse!,
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
                                          imageUrl:
                                              book?.imageLinks?.thumbnail ?? '',
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
                            if (isloading)
                              Expanded(
                                child: Container(
                                  child: const Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                ),
                              ),
                            if (erroSearch)
                              Expanded(
                                child: Center(
                                  child: Text('Your Search book not found'),
                                ),
                              ),
                          ],
                        ),

                        if (!isConnected)
                          Container(
                            height: double.infinity,
                            width: double.infinity,
                            color: Colors.black.withOpacity(0.7),
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.all(15),
                                child: Container(
                                  width: double.infinity,
                                  height: 30,
                                  color: Colors.black.withOpacity(0.5),
                                  child: Center(
                                    child: Text(
                                      'Internet connection is failed',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  )
                : _searchText.isEmpty
                ? Expanded(
                    child: Center(child: Text('Please search your book')),
                  )
                : !isConnected
                ? Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(
                          child: Text(
                            'Internet connection fail.. \nPlease check your internet connection',
                          ),
                        ),
                        SizedBox(height: 20),
                        CircularProgressIndicator(),
                      ],
                    ),
                  )
                : isloading
                ? Expanded(
                    child: const Center(child: CircularProgressIndicator()),
                  )
                : Center(child: CircularProgressIndicator()),
          ],
        ),
      ),
    );
  }
}
