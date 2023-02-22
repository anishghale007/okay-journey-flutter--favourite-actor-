import 'dart:convert';
import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_saver/models/actor.dart';
import 'package:path_provider/path_provider.dart';

final actorProvider = Provider((ref) => ActorProvider());
final actorDataProvider =
    FutureProvider<List<Actor>>((ref) => ActorProvider().getActors());

class ActorProvider {
  File? _file;
  final _fileName = "actor_file.txt";

  Future<File> initFile() async {
    final directory = await getApplicationDocumentsDirectory();
    final path = directory.path;
    return File('$path/$_fileName');
  }

  // Get the data file
  Future<File> get file async {
    if (_file != null) {
      return _file!;
    } else {
      _file = await initFile();
      return _file!;
    }
  }

  static Set<Actor> _actorSet = {};

  Future<String> addActor(
      {required String actorName, required String? imagePath}) async {
    try {
      final addedDate = DateTime.now();
      final File fl = await file;

      if (fl.existsSync()) {
        _actorSet.add(Actor(
          actorName: actorName,
          actorImage: imagePath!,
          addedDate: addedDate.toString(),
        ));
      }
      // converting the set into a list
      final _actorListMap = _actorSet.map((e) => e.toJson()).toList();
      await fl.writeAsString(jsonEncode(_actorListMap));
      return 'Success';
    } catch (err) {
      print(err);
      return 'Error';
    }
  }

  Future<List<Actor>> getActors() async {
    final File fl = await file;
    final _content = await fl.readAsString();

    final List<dynamic> _jsonData = jsonDecode(_content);
    final List<Actor> _actors = _jsonData
        .map((e) => Actor.fromJson(e as Map<String, dynamic>))
        .toList();
    return _actors;
  }
}
