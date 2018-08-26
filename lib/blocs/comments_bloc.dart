import 'package:rxdart/rxdart.dart';
import 'package:news/models/item_model.dart';
import 'package:news/resources/repository.dart';
import 'dart:async';

class CommentsBloc {
  final _repository = Repository();
  final _commentsFetcher = PublishSubject<int>();
  final _commentsOutput = BehaviorSubject<Map<int, Future<ItemModel>>>();

  //Stream getters
  Observable<Map<int, Future<ItemModel>>> get itemWIthComments =>
      _commentsOutput.stream;

  //sink getters
  Function(int) get fetchItemWithComments => _commentsFetcher.sink.add;

  CommentsBloc() {
    _commentsFetcher.stream
        .transform(_commentsTransformer())
        .pipe(_commentsOutput);
  }

  _commentsTransformer() {
    return ScanStreamTransformer<int, Map<int, Future<ItemModel>>>(
    (cache, int id, index) {
      //print(index);
      cache[id] = _repository.fetchItem(id);
      cache[id].then((ItemModel item) {
        item.kids.forEach((kidId) => fetchItemWithComments(kidId));
      });

      return cache;
    },
      <int, Future<ItemModel>> {}
    );
  }

  dispose() {
    _commentsFetcher.close();
    _commentsOutput.close();
  }
}
