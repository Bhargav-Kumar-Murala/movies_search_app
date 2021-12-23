import 'package:bhargav_kumar_murala/Provider/app_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Consumer<AppState>(builder: (context, state, child) {
      return Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Home",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.w900),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      padding: const EdgeInsets.only(left: 20),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey, width: 2)),
                      child: TextFormField(
                        controller: _searchController,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          hintText: 'Search for movies',
                          hintStyle: const TextStyle(color: Colors.black),
                          border: InputBorder.none,
                          suffixIcon: IconButton(
                            icon: const Icon(Icons.search),
                            onPressed: () =>
                                Provider.of<AppState>(context, listen: false)
                                    .fetchMovie(_searchController.text),
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              //listbody
              state.isLoading == true
                  ? const Center(
                      child: CircularProgressIndicator(
                          backgroundColor: Colors.white, color: Colors.amber))
                  : Expanded(
                      child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: state.search?.length ?? 1,
                        itemBuilder: (context, index) => state.search?.length !=
                                null
                            ? Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 5),
                                child: Stack(
                                  alignment: Alignment.bottomLeft,
                                  children: [
                                    SizedBox(
                                      height: 130,
                                      width: double.infinity,
                                      child: Card(
                                        margin: const EdgeInsets.all(0),
                                        elevation: 0,
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 160, top: 15),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                state.search![index].title!,
                                                style: const TextStyle(
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Expanded(
                                                child: ListView.separated(
                                                    scrollDirection:
                                                        Axis.horizontal,
                                                    shrinkWrap: true,
                                                    itemBuilder: (context, i) {
                                                      return Text(
                                                        _genre(state
                                                            .search![index]
                                                            .genreIds![i]),
                                                        style: const TextStyle(
                                                            fontSize: 10,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w300),
                                                      );
                                                    },
                                                    separatorBuilder:
                                                        (context, index) =>
                                                            const Text(
                                                              ' | ',
                                                              style: TextStyle(
                                                                  fontSize: 10,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w300),
                                                            ),
                                                    itemCount: state
                                                        .search![index]
                                                        .genreIds!
                                                        .length),
                                              ),
                                              const SizedBox(height: 7),
                                              Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 15,
                                                        vertical: 3),
                                                decoration: BoxDecoration(
                                                    color: _ratingColors(
                                                        state, index),
                                                    borderRadius:
                                                        const BorderRadius.all(
                                                            Radius.circular(
                                                                15))),
                                                child: Text(
                                                  state.search![index]
                                                          .voteAverage!
                                                          .toString() +
                                                      " IMDB",
                                                  style: const TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 12),
                                                ),
                                              ),
                                              const Spacer(flex: 4),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.only(
                                          left: 10, bottom: 10),
                                      height: 170,
                                      width: 130,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        color: Colors.white,
                                        image: DecorationImage(
                                          image: _image(state, index),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            : SingleChildScrollView(
                                child: Center(
                                    child: Column(
                                  children: [
                                    Image.asset("assets/logo.jpg"),
                                    const SizedBox(height: 20),
                                    const Text('By Bhargav Kumar Murala')
                                  ],
                                )),
                              ),
                      ),
                    )
            ],
          ),
        ),
      );
    });
  }

  _ratingColors(state, index) {
    if (double.parse(state.search[index].voteAverage) >= 7) {
      return Colors.green;
    } else if (double.parse(state.search[index].voteAverage) >= 4 &&
        double.parse(state.search[index].voteAverage) < 7) {
      return Colors.blue;
    } else {
      return Colors.red;
    }
  }

  _image(state, index) {
    if (state.search[index].posterPath != null) {
      return NetworkImage('https://image.tmdb.org/t/p/original' +
          state.search[index].posterPath);
    } else {
      return const AssetImage("assets/logo.jpg");
    }
  }

  _genre(value) {
    switch (value) {
      case 28:
        return 'Action';
      case 12:
        return 'Adventure';
      case 16:
        return 'Animation';
      case 35:
        return 'Comedy';
      case 80:
        return 'Crime';
      case 99:
        return 'Documentary';
      case 18:
        return 'Drama';
      case 10751:
        return 'Family';
      case 14:
        return 'Fantasy';
      case 36:
        return 'History';
      case 27:
        return 'Horror';
      case 10402:
        return 'Music';
      case 9648:
        return 'Mystery';
      case 10749:
        return 'Romance';
      case 878:
        return 'Science Fiction';
      case 10770:
        return 'TV Movie ';
      case 53:
        return 'Thriller';
      case 10752:
        return 'War';
      case 37:
        return 'Western';
      case 10759:
        return 'Action & Adventure';
      case 10762:
        return 'Kids';
      case 10763:
        return 'News';
      case 10764:
        return 'Reality';
      case 10765:
        return 'Sci-Fi & Fantasy';
      case 10766:
        return 'Soap';
      case 10767:
        return 'Talk';
      case 10768:
        return 'War & Politics';
      default:
        return 'NA';
    }
  }
}
