import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shaqalahadhismoapp/model/project_names_model.dart';
import 'package:shaqalahadhismoapp/signIn/sign_in.dart';
import 'package:shaqalahadhismoapp/widegts/bottom_navigation_screen.dart';

import 'project_names_state.dart';

class ProjectNamesList extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final newUserProvider = watch(projectNamesProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text("Project List"),
        centerTitle: true,
      ),
      body: (Column(
        children: [
          Expanded(
            child: StreamBuilder<List<ProjectsNames>>(
                stream: newUserProvider.getCreatedProjectNames,
                builder: (BuildContext context, snapshot) {
                  if (snapshot.hasData) {
                    var projectNameList = snapshot.data;
                    return ListView.builder(
                        itemCount: projectNameList!.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ListTile(
                              onTap: () {
                                context
                                    .read(projectNamesProvider)
                                    .getCurrentProjectName(
                                        projectNameList[index].projectName!);
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => SignInScreen()));
                              },
                              title: Text(projectNameList[index].projectName!),
                              subtitle: Divider(),
                            ),
                          );
                        });
                  }
                  return Center(child: CircularProgressIndicator());
                }),
          ),
        ],
      )),
    );
  }
}
