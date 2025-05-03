import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_application_1/common_widget/print_hub_app_bar.dart';
import 'package:flutter_application_1/common_widget/print_hub_gradient_button.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String name = "John Doe";
  String email = "john.doe@example.com";
  String phone = "+1 234 567 890";
  String address = "123 Street Name\nCity, State 12345\nCountry";
  String language = "English";
  bool emailNotifications = true;
  bool smsNotifications = true;
  bool pushNotifications = false;
  String? profileImagePath;

  void updateProfile({
    required String newName,
    required String newEmail,
    required String newPhone,
    required String newAddress,
    required String newLanguage,
    required bool newEmailNotifications,
    required bool newSmsNotifications,
    required bool newPushNotifications,
    String? newImagePath,
  }) {
    setState(() {
      name = newName;
      email = newEmail;
      phone = newPhone;
      address = newAddress;
      language = newLanguage;
      emailNotifications = newEmailNotifications;
      smsNotifications = newSmsNotifications;
      pushNotifications = newPushNotifications;
      if (newImagePath != null) profileImagePath = newImagePath;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FBFB),
      appBar: const PrintHubAppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 5,
                    blurRadius: 10,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 20),
              child: Column(
                children: [
                  Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      CircleAvatar(
                        radius: 55,
                        backgroundColor: Colors.white,
                        child: CircleAvatar(
                          radius: 50,
                          backgroundImage:
                              profileImagePath != null
                                  ? FileImage(File(profileImagePath!))
                                  : null,
                          child:
                              profileImagePath == null
                                  ? Text(
                                    name.isNotEmpty ? name[0] : '?',
                                    style: const TextStyle(
                                      fontSize: 30,
                                      color: Colors.white,
                                    ),
                                  )
                                  : null,
                        ),
                      ),
                      CircleAvatar(
                        radius: 18,
                        backgroundColor: Colors.grey[350],
                        child: IconButton(
                          icon: Icon(
                            Icons.edit,
                            size: 14,
                            color: Colors.blueAccent[700],
                          ),
                          onPressed: () async {
                            final updated = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder:
                                    (context) => EditProfilePage(
                                      name: name,
                                      email: email,
                                      phone: phone,
                                      address: address,
                                      language: language,
                                      emailNotifications: emailNotifications,
                                      smsNotifications: smsNotifications,
                                      pushNotifications: pushNotifications,
                                      imagePath: profileImagePath,
                                    ),
                              ),
                            );

                            if (updated != null) {
                              updateProfile(
                                newName: updated['name'],
                                newEmail: updated['email'],
                                newPhone: updated['phone'],
                                newAddress: updated['address'],
                                newLanguage: updated['language'],
                                newEmailNotifications:
                                    updated['emailNotifications'],
                                newSmsNotifications:
                                    updated['smsNotifications'],
                                newPushNotifications:
                                    updated['pushNotifications'],
                                newImagePath: updated['imagePath'],
                              );
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  
                  _buildProfileItem(Icons.person, "Full Name", name),
                  _buildProfileItem(Icons.email, "Email", email),
                  _buildProfileItem(Icons.phone, "Phone", phone),
                  _buildProfileItem(Icons.home, "Address", address),
                  _buildProfileItem(
                    Icons.language,
                    "Preferred Language",
                    language,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileItem(IconData icon, String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(width: 20),
          Icon(icon, color: Colors.indigo, size: 20),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[700],
                    
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCheckboxDisplay(String label, bool value) {
    return Row(
      children: [Checkbox(value: value, onChanged: null), Text(label)],
    );
  }
}

// -------------------------
// EDIT PROFILE PAGE BELOW
// -------------------------

class EditProfilePage extends StatefulWidget {
  final String name;
  final String email;
  final String phone;
  final String address;
  final String language;
  final bool emailNotifications;
  final bool smsNotifications;
  final bool pushNotifications;
  final String? imagePath;

  const EditProfilePage({
    super.key,
    required this.name,
    required this.email,
    required this.phone,
    required this.address,
    required this.language,
    required this.emailNotifications,
    required this.smsNotifications,
    required this.pushNotifications,
    this.imagePath,
  });

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;
  late TextEditingController _addressController;
  late String _selectedLanguage;
  late bool _emailNotifications;
  late bool _smsNotifications;
  late bool _pushNotifications;
  String? _imagePath;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.name);
    _emailController = TextEditingController(text: widget.email);
    _phoneController = TextEditingController(text: widget.phone);
    _addressController = TextEditingController(text: widget.address);
    _selectedLanguage = widget.language;
    _emailNotifications = widget.emailNotifications;
    _smsNotifications = widget.smsNotifications;
    _pushNotifications = widget.pushNotifications;
    _imagePath = widget.imagePath;
  }

  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      setState(() {
        _imagePath = pickedFile.path;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FBFB),
      appBar: AppBar(title: const Text("Edit Profile"), backgroundColor: Colors.white,),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.grey[200],
                  backgroundImage:
                      _imagePath != null ? FileImage(File(_imagePath!)) : null,
                  child: _imagePath == null ? const Text("100×100") : null,
                ),

                Positioned(
                  bottom: 6,
                  right: 3,
                  child: InkWell(
                    onTap: _pickImage,
                    child: CircleAvatar(
                      radius: 14,
                      backgroundColor: Colors.grey[350],
                      child: Icon(
                        Icons.camera_alt,
                        size: 14,
                        color: Colors.blueAccent[700],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            _buildTextField("Full Name", _nameController),
            _buildTextField("Email", _emailController),
            _buildTextField("Phone", _phoneController),
            _buildTextField("Address", _addressController, maxLines: 3),
            const SizedBox(height: 12),
            _buildLanguageDropdown(),
            const SizedBox(height: 16),
            // _buildNotificationPreferences(),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: GradientButton(
                  text: "Save",
                  onPressed: () {
                    Navigator.pop(context, {
                      'name': _nameController.text,
                      'email': _emailController.text,
                      'phone': _phoneController.text,
                      'address': _addressController.text,
                      'language': _selectedLanguage,
                      'emailNotifications': _emailNotifications,
                      'smsNotifications': _smsNotifications,
                      'pushNotifications': _pushNotifications,
                      'imagePath': _imagePath,
                    });
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(
    String label,
    TextEditingController controller, {
    int maxLines = 1,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextField(
        controller: controller,
        maxLines: maxLines,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
    );
  }

  Widget _buildLanguageDropdown() {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        labelText: "Preferred Language",
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      ),
       borderRadius: BorderRadius.circular(10),
       dropdownColor: Colors.white,
      value: _selectedLanguage,
      items:
          ['English', 'Spanish', 'French']
              .map((lang) => DropdownMenuItem(value: lang, child: Text(lang)))
              .toList(),
      onChanged: (value) => setState(() => _selectedLanguage = value!),
    );
  }

  Widget _buildNotificationPreferences() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Notification Preferences", style: TextStyle(fontSize: 16)),
        CheckboxListTile(
          value: _emailNotifications,
          onChanged: (val) => setState(() => _emailNotifications = val!),
          title: const Text("Email notifications"),
        ),
        CheckboxListTile(
          value: _smsNotifications,
          onChanged: (val) => setState(() => _smsNotifications = val!),
          title: const Text("SMS notifications"),
        ),
        CheckboxListTile(
          value: _pushNotifications,
          onChanged: (val) => setState(() => _pushNotifications = val!),
          title: const Text("Push notifications"),
        ),
      ],
    );
  }
}
