import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:racing/c_theme.dart';
import 'package:racing/pages/favorite_news/favorite_news_page.dart';
import 'package:racing/pages/notes/notes_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  File? _image;
  String? _name;
  String? _email;
  late SharedPreferences _p;
  @override
  void initState() {
    super.initState();
    _init();
  }

  void _init() async {
    _p = await SharedPreferences.getInstance();
    final imagePath = _p.getString('imagePath');
    setState(() {
      _name = _p.getString('name');
      _email = _p.getString('email');

      _image = imagePath == null ? null : File(imagePath);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: CTheme.darkGreyColor,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SvgPicture.asset('images/bell.svg'),
          ],
        ),
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: CTheme.darkGreyColor,
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(32),
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 8),
                _image == null
                    ? GestureDetector(
                        onTap: () async {
                          final image = await ImagePicker()
                              .pickImage(source: ImageSource.gallery);

                          if (image == null) {
                            return;
                          }

                          setState(() {
                            _image = File(image.path);
                          });

                          _p.setString('imagePath', image.path);
                        },
                        child: Container(
                          height: 100,
                          width: 100,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: CTheme.darkColor,
                          ),
                          child:
                              const Icon(Icons.photo, color: CTheme.whiteColor),
                        ),
                      )
                    : CircleAvatar(
                        backgroundColor: CTheme.darkColor,
                        radius: 50,
                        backgroundImage: FileImage(
                          _image!,
                        ),
                      ),
                const SizedBox(height: 16),
                Text(
                  _name ?? 'Your name',
                  style: const TextStyle(
                    fontSize: 20,
                    color: CTheme.whiteColor,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  _email ?? 'Your email',
                  style: const TextStyle(
                    fontSize: 16,
                    color: CTheme.textGreyColor,
                  ),
                ),
                const SizedBox(height: 24),
                GestureDetector(
                  onTap: () async {
                    final editResult = await showModalBottomSheet<EditResult?>(
                      isScrollControlled: true,
                      backgroundColor:
                          Theme.of(context).scaffoldBackgroundColor,
                      context: context,
                      builder: (context) {
                        return EditBottomSheet(
                          initName: _name ?? '',
                          initEmail: _email ?? '',
                        );
                      },
                    );

                    if (editResult == null) {
                      return;
                    }

                    setState(() {
                      _name = editResult.name;
                      _email = editResult.email;
                    });
                    if (editResult.name != null) {
                      _p.setString('name', editResult.name!);
                    } else {
                      _p.remove('name');
                    }
                    if (editResult.email != null) {
                      _p.setString('email', editResult.email!);
                    } else {
                      _p.remove('email');
                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    width: MediaQuery.of(context).size.width * 0.3,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      gradient: const LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: [
                          Color(0xFFb76a27),
                          Color(0xFFe88c2b),
                        ],
                      ),
                    ),
                    child: const Text(
                      'EDIT',
                      style: TextStyle(
                        color: CTheme.blackColor,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Row(
              children: [
                Expanded(
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: GestureDetector(
                      onTap: () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const NotesPage(),
                        ),
                      ),
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: CTheme.darkGreyColor,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SvgPicture.asset('images/list_icon.svg'),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Expanded(
                                  child: Text(
                                    'My notes',
                                    style: TextStyle(
                                      color: CTheme.whiteColor,
                                    ),
                                  ),
                                ),
                                SvgPicture.asset('images/arrow_right.svg'),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: GestureDetector(
                      onTap: () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const FavoriteNewsPage(),
                        ),
                      ),
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: CTheme.darkGreyColor,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SvgPicture.asset('images/favorite_icon.svg'),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Expanded(
                                  child: Text(
                                    'Favorite news',
                                    style: TextStyle(
                                      color: CTheme.whiteColor,
                                    ),
                                  ),
                                ),
                                SvgPicture.asset('images/arrow_right.svg'),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class EditResult {
  const EditResult({
    required this.name,
    required this.email,
  });

  final String? name;
  final String? email;
}

class EditBottomSheet extends StatefulWidget {
  const EditBottomSheet({
    super.key,
    required this.initName,
    required this.initEmail,
  });

  final String initName;
  final String initEmail;

  @override
  State<EditBottomSheet> createState() => _EditBottomSheetState();
}

class _EditBottomSheetState extends State<EditBottomSheet> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _nameController.text = widget.initName;
    _emailController.text = widget.initEmail;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _nameController,
              style: const TextStyle(color: CTheme.whiteColor),
              decoration: InputDecoration(
                hintStyle: const TextStyle(
                  color: CTheme.textGreyColor,
                ),
                hintText: 'Your name',
                filled: true,
                fillColor: CTheme.darkGreyColor,
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(16),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _emailController,
              style: const TextStyle(color: CTheme.whiteColor),
              decoration: InputDecoration(
                hintStyle: const TextStyle(
                  color: CTheme.textGreyColor,
                ),
                hintText: 'Your email',
                filled: true,
                fillColor: CTheme.darkGreyColor,
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(16),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
            ),
            const SizedBox(height: 16),
            GestureDetector(
              onTap: () {
                Navigator.of(context).pop(
                  EditResult(
                    name: _nameController.text.isEmpty
                        ? null
                        : _nameController.text,
                    email: _emailController.text.isEmpty
                        ? null
                        : _emailController.text,
                  ),
                );
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 12),
                width: MediaQuery.of(context).size.width * 0.3,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  gradient: const LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [
                      Color(0xFFb76a27),
                      Color(0xFFe88c2b),
                    ],
                  ),
                ),
                child: const Text(
                  'EDIT',
                  style: TextStyle(
                    color: CTheme.blackColor,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
