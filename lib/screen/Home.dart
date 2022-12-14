import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:instagram/model/people.dart';
import 'package:instagram/provider/ApiProviders.dart';
import 'package:instagram/screen/History.dart';

class HomeP extends StatelessWidget {
  HomeP({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text('Instagram'),
          centerTitle: false,
          titleTextStyle: const TextStyle(color: Colors.black, fontSize: 25),
          actions: [
            IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.add_box_outlined,
                  color: Colors.black,
                )),
            IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.favorite_border_outlined,
                  color: Colors.black,
                )),
            IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.chat_bubble_outline,
                  color: Colors.black,
                )),
          ],
          backgroundColor: Colors.white,
          elevation: 0,
        ),
        bottomNavigationBar: BottomAppBar(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {},
                child: Container(
                  padding: const EdgeInsets.all(15),
                  child: const Icon(Icons.home_filled),
                ),
              ),
              GestureDetector(
                onTap: () {},
                child: Container(
                  padding: const EdgeInsets.all(15),
                  child: const Icon(Icons.search_outlined),
                ),
              ),
              GestureDetector(
                onTap: () {},
                child: Container(
                  padding: const EdgeInsets.all(15),
                  child: const Icon(Icons.movie_creation_outlined),
                ),
              ),
              GestureDetector(
                onTap: () {},
                child: Container(
                  padding: const EdgeInsets.all(15),
                  child: const Icon(Icons.local_mall_outlined),
                ),
              ),
              GestureDetector(
                onTap: () {},
                child: Container(
                  padding: const EdgeInsets.all(15),
                  child: const Icon(Icons.person),
                ),
              ),
            ],
          ),
        ),
        body: Column(
          children: [
            Consumer(
              builder: (context, ref, child) {
                final _data = ref.watch(userDataProvider('portrait'));

                return _data.when(
                    data: (data) {
                      return SizedBox(
                        height: 70,
                        child: ListView.builder(
                            cacheExtent: 99.999999,
                            itemCount: data.photos.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return Container(
                                margin: const EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.purple, width: 1.5),
                                    borderRadius: BorderRadius.circular(50)),
                                child: InkWell(
                                  borderRadius: BorderRadius.circular(10),
                                  onTap: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => History(
                                              photo: data.photos[index],
                                            )),
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(50),
                                    child: Image.network(
                                      data.photos[index].src.tiny,
                                      width: 55,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              );
                            }),
                      );
                    },
                    error: (error, stackTrace) =>
                        Center(child: Text(error.toString())),
                    loading: () =>
                        const Center(child: CircularProgressIndicator()));
              },
            ),
            Expanded(
              child: Consumer(builder: (context, ref, child) {
                final _data = ref.watch(userDataProvider(''));

                return _data.when(
                    data: (data) {
                      People people = data;

                      return ListView.builder(
                          cacheExtent: 9999999,
                          itemCount: data.photos.length,
                          scrollDirection: Axis.vertical,
                          itemBuilder: (context, index) {
                            return Container(
                              padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(5, 10, 10, 0),
                                    child: Row(
                                      children: [
                                        Container(
                                          margin: const EdgeInsets.all(5),
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Colors.grey,
                                                  width: 1.5),
                                              borderRadius:
                                                  BorderRadius.circular(30)),
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(30),
                                            child: Image.network(
                                              'https://yt3.ggpht.com/o20SwR0uf6WqFp_7Tum2ELXngxGQtvdP2ggYBWek1fg-tmGkdlsbg96c10N1YvdDeeRaJXRgrA=s900-c-k-c0x00ffffff-no-rj',
                                              width: 40,
                                              height: 40,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 5),
                                        Expanded(
                                            child: Text(
                                          people.photos[index].photographer,
                                          style: const TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold),
                                        )),
                                        const Icon(
                                          Icons.more_horiz,
                                          size: 20,
                                        )
                                      ],
                                    ),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Colors.white60, width: 1.5),
                                    ),
                                    child: CachedNetworkImage(
                                      width: MediaQuery.of(context).size.width,
                                      fit: BoxFit.cover,
                                      imageUrl: people.photos[index].src.large,
                                      progressIndicatorBuilder:
                                          (context, url, downloadProgress) =>
                                              SizedBox(
                                        height: 100,
                                        width: 100,
                                        child: Center(
                                          child: CircularProgressIndicator(
                                              value: downloadProgress.progress),
                                        ),
                                      ),
                                      errorWidget: (context, url, error) =>
                                          const Icon(Icons.error),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        10, 10, 10, 0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                            child: Row(
                                          children: [
                                            IconButton(
                                                onPressed: () {
                                                  ref.listen(userDataProvider('cyber'), (previous, next) { });
                                                },
                                                icon: const Icon(
                                                  Icons
                                                      .favorite_border_outlined,
                                                  size: 30,
                                                )),
                                            Icon(
                                                (people.photos[index].id) % 2 !=
                                                        0
                                                    ? Icons.favorite
                                                    : Icons
                                                        .favorite_border_outlined,
                                                size: 30,
                                                color:
                                                    (people.photos[index].id) %
                                                                2 !=
                                                            0
                                                        ? Colors.red
                                                        : Colors.black),
                                            const SizedBox(
                                              width: 15,
                                            ),
                                            const Icon(
                                                Icons.mode_comment_outlined,
                                                size: 30),
                                            const SizedBox(
                                              width: 15,
                                            ),
                                            const Icon(Icons.send_outlined,
                                                size: 30),
                                          ],
                                        )),
                                        const Icon(
                                            Icons.bookmark_border_outlined,
                                            size: 30),
                                      ],
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Colors.white,
                                                width: 1.5),
                                            borderRadius:
                                                BorderRadius.circular(50)),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          child: Image.network(
                                            'https://cdn.elnacional.com/wp-content/uploads/2019/11/John-Legend-Foto-Archivo.jpg',
                                            width: 20,
                                            height: 20,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      const Text(
                                        'Les gusta a juan.diego.z y otros',
                                        style: TextStyle(fontSize: 13),
                                      )
                                    ],
                                  ),
                                  const Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 10),
                                    child: Text(
                                      'Hace una hora',
                                      style: TextStyle(
                                          fontSize: 12, color: Colors.grey),
                                    ),
                                  )
                                ],
                              ),
                            );
                          });
                    },
                    error: (error, stackTrace) =>
                        Center(child: Text(error.toString())),
                    loading: () =>
                        const Center(child: CircularProgressIndicator()));
              }),
            ),
          ],
        ),
      ),
    );
  }
}
