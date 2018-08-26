import 'package:flutter/material.dart';
import 'package:news/screens/news_list.dart';
import 'blocs/stories_provider.dart';
import 'screens/news_details.dart';
import 'blocs/comments_provider.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CommentsProvider(
      child: StoriesProvider(
        child: MaterialApp(
          title: 'News',
          onGenerateRoute: routes,
        ),
      ),
    );
  }

  Route routes(RouteSettings settings) {
    if (settings.name == '/') {
      return MaterialPageRoute(
        builder: (context) {
          final storiesBloc = StoriesProvider.of(context);

          storiesBloc.fetchTopIds();

          return NewsList();
        },
      );
    } else {
      return MaterialPageRoute(
          builder: (context) {
            final commentsBloc = CommentsProvider.of(context);

            // extract the item id from the settings.name
            // and pass into NewsDetails
            final itemId = int.parse(settings.name.replaceFirst('/', ''));

            commentsBloc.fetchItemWithComments(itemId);

            return NewsDetails(
              itemId: itemId,
            );
          });
    }
  }
}
