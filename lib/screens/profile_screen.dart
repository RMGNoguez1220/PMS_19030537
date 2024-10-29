import 'dart:io';
import 'package:flutter/material.dart';
import 'package:pmsn2024b/settings/colors_settings.dart';
import 'package:image_picker/image_picker.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  XFile? _image;
  final ImagePicker _picker = ImagePicker();

  // Controladores para capturar los datos del usuario
  final TextEditingController _nameController =
      TextEditingController(text: "Ricardo Miguel Garcia Noguez");
  final TextEditingController _emailController =
      TextEditingController(text: '19030537@itcelaya.edu.mx');
  final TextEditingController _telefonoController =
      TextEditingController(text: '4612986578');
  final TextEditingController _githubController =
      TextEditingController(text: 'https://github.com/RMGNoguez1220');

  @override
  void initState() {
    super.initState();
    _loadProfileImage();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _telefonoController.dispose();
    _githubController.dispose();
    super.dispose();
  }

  // Método para seleccionar una imagen desde la galería o la cámara
  Future<void> _pickImage(ImageSource source) async {
    final XFile? selectedImage = await _picker.pickImage(source: source);
    if (selectedImage != null) {
      setState(() {
        _image = selectedImage;
      });
      _saveProfileImage(selectedImage.path);
    }
  }

  // Método para cargar la imagen guardada
  Future<void> _loadProfileImage() async {
    final prefs = await SharedPreferences.getInstance();
    final imagePath = prefs.getString('profile_image_path');
    if (imagePath != null && imagePath.isNotEmpty) {
      setState(() {
        _image = XFile(imagePath);
      });
    }
  }

  // Método para guardar la imagen seleccionada
  Future<void> _saveProfileImage(String path) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('profile_image_path', path);
  }

  // Método para eliminar la imagen actual
  Future<void> _removeProfileImage() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('profile_image_path');
    setState(() {
      _image = null; // Actualiza el estado para que la imagen se quite
    });
  }

  // Métodos para abrir las aplicaciones externas
  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      print('No se pudo abrir la URL: $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Perfil de usuario',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: ColorsSettings.navColor,
        automaticallyImplyLeading: false, // Esto oculta el botón de regreso
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Sección para la imagen de perfil
            GestureDetector(
              onTap: () {
                _showImagePickerDialog();
              },
              child: CircleAvatar(
                  radius: 60,
                  backgroundImage: _image != null
                      ? FileImage(File(_image!.path)) as ImageProvider
                      : const AssetImage('assets/superintendente.png'),
                  child: _image == null
                      ? const Icon(
                          Icons.camera_alt,
                          size: 50,
                          color: Colors.black54,
                        )
                      : null),
            ),
            const SizedBox(height: 20),

            //Campo de nombre completo
            TextField(
              controller: _nameController,
              readOnly: true,
              decoration: const InputDecoration(
                labelText: 'Nombre completo',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 30),

            //Campo de correo electrónico
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _emailController,
                    readOnly: true,
                    decoration: const InputDecoration(
                      labelText: 'Correo electrónico',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.launch),
                  onPressed: () =>
                      _launchURL('mailto:${_emailController.text}'),
                ),
              ],
            ),
            const SizedBox(height: 30),

            //Campo del teléfono
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _telefonoController,
                    readOnly: true,
                    decoration: const InputDecoration(
                      labelText: 'Teléfono',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.launch),
                  onPressed: () =>
                      _launchURL('tel:${_telefonoController.text}'),
                ),
              ],
            ),
            const SizedBox(height: 30),

            //Campo direccionamiento a GitHub
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _githubController,
                    readOnly: true,
                    decoration: const InputDecoration(
                      labelText: 'GitHub',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.launch),
                  onPressed: () => _launchURL(_githubController.text),
                ),
              ],
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  // Método para mostrar un diálogo con opciones para seleccionar imagen
  void _showImagePickerDialog() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text('Tomar una foto'),
              onTap: () {
                Navigator.of(context).pop();
                _pickImage(ImageSource.camera);
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo),
              title: const Text('Seleccionar desde galería'),
              onTap: () {
                Navigator.of(context).pop();
                _pickImage(ImageSource.gallery);
              },
            ),
            ListTile(
              leading: const Icon(Icons.image_not_supported_outlined),
              title: const Text('Borrar imagen'),
              onTap: () {
                Navigator.of(context).pop();
                _removeProfileImage();
              },
            ),
          ],
        );
      },
    );
  }
}
