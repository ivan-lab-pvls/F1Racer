import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String _notesKey = '_notesKey';

class NotesController extends ChangeNotifier {
  NotesController(this._bd) {
    _init();
  }

  final SharedPreferences _bd;

  final List<String> _notes = [];

  List<String> get notes => _notes;

  void _init() {
    final cachedNotes = _bd.getString(_notesKey) ?? '';

    if (cachedNotes.isEmpty) {
      return;
    }

    final decodedNotes = jsonDecode(cachedNotes) as List<dynamic>;
    final notesList = decodedNotes.map((e) => e.toString()).toList();

    _notes.addAll(notesList);
    notifyListeners();
  }

  void addNote(String note) {
    _notes.add(note);
    _cacheNotes();
    notifyListeners();
  }

  void deleteNote(int index) {
    _notes.removeAt(index);
    _cacheNotes();
    notifyListeners();
  }

  Future<void> _cacheNotes() async {
    final encodedNotes = jsonEncode(_notes);
    await _bd.setString(_notesKey, encodedNotes);
  }
}
