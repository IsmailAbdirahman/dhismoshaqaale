import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shaqalahadhismoapp/model/project_names_model.dart';
import 'package:shaqalahadhismoapp/service/service.dart';

final projectNamesProvider =
    ChangeNotifierProvider((ref) => ProjectNamesState());

class ProjectNamesState extends ChangeNotifier {
  Service _service = Service();

  String? _currentProjectName;

  String? get currentProjectName => _currentProjectName;

  getCurrentProjectName(String name) {
    _currentProjectName = name;
    notifyListeners();
  }

  Stream<List<ProjectsNames>> get getCreatedProjectNames {
    return _service.projects.snapshots().map(_service.getProjectNamesList);
  }
}
