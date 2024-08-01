import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

import '../pages/login_page.dart';
import '../services/firebase_auth.dart';
import '../utils/image_picer_util.dart'; // Импортируем ImagePickerUtil

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key, required this.toggleTheme});
  final Function toggleTheme;

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _authenticationService =
      AuthenticationService(); // Экземпляр AuthenticationService
  File? _selectedImage; // Переменная для хранения выбранного изображения
  bool _showSaveButton = false; // Флаг для отображения кнопки "Сохранить"

  @override
  Widget build(BuildContext context) {
    final user =
        _authenticationService.currentUser; // Получаем текущего пользователя

    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Аватар
          Stack(
            children: [
              CircleAvatar(
                radius: 50,
                backgroundImage: _selectedImage != null
                    ? FileImage(_selectedImage!)
                        as ImageProvider // Используем выбранное изображение, если оно есть
                    : user?.photoURL != null
                        ? NetworkImage(user!.photoURL!)
                        : const AssetImage('assets/_1.png') as ImageProvider,
              ),
              Positioned(
                  bottom: -16,
                  right: -16,
                  child: IconButton(
                    icon: const Icon(
                      Icons.camera_alt,
                      color: Colors.blue,
                    ),
                    onPressed: () {
                      _showImagePickerDialog(context);
                    },
                  )),
            ],
          ),
          const SizedBox(height: 20),
          if (_showSaveButton)
            ElevatedButton(
              onPressed: () {
                // Сохранение нового аватара
              },
              child: const Text('Сохранить'),
            ),
          ElevatedButton(
            onPressed: () {
              // Выйти из аккаунта
              _authenticationService
                  .signOut()
                  .then((value) => Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                LoginPage(toggleTheme: widget.toggleTheme)),
                      ));
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red, // Красный цвет для кнопки выхода
            ),
            child: const Text('Выйти'),
          ),
        ],
      ),
    );
  }

  // Диалог выбора изображения
  void _showImagePickerDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Выберите изображение'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Из галереи'),
                onTap: () async {
                  // Выбор изображения из галереи
                  File? imageFile =
                      await ImagePickerUtil.pickImageFromGallery();
                  if (imageFile != null) {
                    setState(() {
                      _selectedImage = imageFile;
                      _showSaveButton = true; // Показываем кнопку "Сохранить"
                    });
                  }
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text('Сделать снимок'),
                onTap: () async {
                  // Съемка изображения с камеры
                  File? imageFile = await ImagePickerUtil.pickImageFromCamera();
                  if (imageFile != null) {
                    setState(() {
                      _selectedImage = imageFile;
                      _showSaveButton = true; // Показываем кнопку "Сохранить"
                    });
                  }
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
