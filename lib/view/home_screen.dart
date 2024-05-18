import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mvvm_project1/data/response/status.dart';
import 'package:mvvm_project1/utility/routes/routes_name.dart';
import 'package:mvvm_project1/utility/utils.dart';
import 'package:mvvm_project1/view_model/home_view_model.dart';
import 'package:mvvm_project1/view_model/user_view_model.dart';
import 'package:provider/provider.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final HomeViewviewModel _homeViewviewModel = HomeViewviewModel();
  @override
  void initState() {
    _homeViewviewModel.fetchMoviesListApi();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final userPreferences = Provider.of<UserViewModel>(context);
    return Scaffold(
      appBar: AppBar(automaticallyImplyLeading: false, actions: [
        InkWell(
          onTap: () {
            userPreferences
                .remove()
                .then((value) => Navigator.pushNamed(context, Routename.login));
          },
          child: const Text(
            "Movies List",
          ),
        )
      ]),
      backgroundColor: const Color.fromARGB(255, 250, 247, 247),
      body: ChangeNotifierProvider<HomeViewviewModel>(
        create: (context) => _homeViewviewModel,
        child: Consumer<HomeViewviewModel>(
          builder: (context, value, child) {
            switch (value.moviesList.status) {
              case Status.LOADING:
                return const Center(child: CircularProgressIndicator());
              case Status.ERROR:
                return Center(child: Text(value.moviesList.message.toString()));
              case Status.COMPLETED:
                return ListView.builder(
                    itemCount: value.moviesList.data!.movies!.length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: ListTile(
                          leading: Image.network(
                            height: 40,
                            width: 40,
                            fit: BoxFit.cover,
                            value.moviesList.data!.movies![index].posterurl
                                .toString(),
                            errorBuilder: (context, error, stack) {
                              return const Icon(Icons.error);
                            },
                          ),
                          title: Text(value
                              .moviesList.data!.movies![index].title
                              .toString()),
                          subtitle: Text(value
                              .moviesList.data!.movies![index].year
                              .toString()),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(Utils.averageRating(value
                                      .moviesList.data!.movies![index].ratings!)
                                  .toStringAsFixed(1)),
                              const Icon(
                                Icons.star,
                                color: Colors.yellow,
                              )
                            ],
                          ),
                        ),
                      );
                    });
              case null:
            }

            return Container();
          },
        ),
      ),
    );
  }
}
