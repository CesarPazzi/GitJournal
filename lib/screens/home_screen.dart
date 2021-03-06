import 'package:flutter/material.dart';
import 'package:gitjournal/core/flattened_notes_folder.dart';
import 'package:gitjournal/iap.dart';
import 'package:provider/provider.dart';

import 'package:gitjournal/core/notes_folder_fs.dart';

import 'folder_view.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  FlattenedNotesFolder flattenedNotesFolder;

  @override
  void initState() {
    super.initState();

    InAppPurchases.confirmProPurchase();

    Future.delayed(Duration.zero, () {
      if (!mounted) return;
      final rootFolder = Provider.of<NotesFolderFS>(context);
      setState(() {
        flattenedNotesFolder = FlattenedNotesFolder(rootFolder);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (flattenedNotesFolder == null) {
      return Container();
    }

    return FolderView(notesFolder: flattenedNotesFolder);
  }
}
