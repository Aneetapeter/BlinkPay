import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'feature_page.dart';
import 'profile_page.dart';
import 'notifications_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? _firstName;
  String? _lastName;
  String? _upiId;
  File? _profileImage;
  ThemeMode _themeMode = ThemeMode.system;

  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _upiController = TextEditingController();
  final ImagePicker _picker = ImagePicker();

  final Map<String, IconData> _features = {
    'Scan any QR': Icons.qr_code,
    'Pay anyone': Icons.person,
    'Bank transfer': Icons.account_balance,
    'Mobile Recharge': Icons.bolt,
    'DTH / TV': Icons.tv,
    'Electricity': Icons.electrical_services,
    'Postpaid': Icons.phone_android,
    'Loan EMI': Icons.money,
    'Broadband': Icons.router,
    'Credit Cards': Icons.credit_card,
    'Google Play': Icons.play_arrow,
    'Rewards': Icons.card_giftcard,
    'Offers': Icons.local_offer,
    'Referrals': Icons.people,
    'Gift Cards': Icons.card_giftcard,
    'Subscriptions': Icons.subscriptions,
    'Check your CIBIL score for free': Icons.score,
    'See transaction history': Icons.history,
    'Check bank balance': Icons.account_balance_wallet,
  };

  final List<String> _ads = [
    'Instant loans up to ₹8 Lakhs',
    'Get cashback on every recharge!',
    'Refer friends and earn rewards',
    'Buy gift cards and win prizes!',
    'Check your credit score instantly',
  ];

  int _currentAd = 0;
  final List<String> _recentFeatures = [];

  @override
  void initState() {
    super.initState();
    _loadUserData();
    _startAdRotation();
  }

  void _startAdRotation() {
    Future.delayed(const Duration(seconds: 0), () async {
      while (mounted) {
        await Future.delayed(const Duration(seconds: 3));
        if (!mounted) break;
        setState(() {
          _currentAd = (_currentAd + 1) % _ads.length;
        });
      }
    });
  }

  Future<void> _loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _firstName = prefs.getString('first_name');
      _lastName = prefs.getString('last_name');
      _upiId = prefs.getString('upi_id');
      final imagePath = prefs.getString('profile_image');
      if (imagePath != null && File(imagePath).existsSync()) {
        _profileImage = File(imagePath);
      }
    });
    if (_firstName == null || _upiId == null) {
      Future.delayed(Duration.zero, _promptForUserInfo);
    }
  }

  Future<void> _promptForUserInfo() async {
    if (!mounted) return;
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Enter Profile Details'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              GestureDetector(
                onTap: _pickImage,
                child: CircleAvatar(
                  radius: 40,
                  backgroundImage:
                      _profileImage != null ? FileImage(_profileImage!) : null,
                  child: _profileImage == null
                      ? const Icon(Icons.add_a_photo, size: 40)
                      : null,
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _firstNameController,
                decoration: const InputDecoration(labelText: 'First Name'),
              ),
              TextField(
                controller: _lastNameController,
                decoration: const InputDecoration(labelText: 'Last Name'),
              ),
              TextField(
                controller: _upiController,
                decoration: const InputDecoration(labelText: 'UPI ID'),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () async {
              final prefs = await SharedPreferences.getInstance();
              await prefs.setString(
                  'first_name', _firstNameController.text.trim());
              await prefs.setString(
                  'last_name', _lastNameController.text.trim());
              await prefs.setString('upi_id', _upiController.text.trim());
              if (_profileImage != null) {
                await prefs.setString('profile_image', _profileImage!.path);
              }
              if (!mounted) return;
              setState(() {
                _firstName = _firstNameController.text.trim();
                _lastName = _lastNameController.text.trim();
                _upiId = _upiController.text.trim();
              });
              Navigator.of(context).pop();
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  Future<void> _pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() => _profileImage = File(image.path));
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('profile_image', image.path);
    }
  }

  Future<void> _logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    setState(() {
      _firstName = null;
      _lastName = null;
      _upiId = null;
      _profileImage = null;
    });
    Future.delayed(Duration.zero, _promptForUserInfo);
  }

  void _navigateToFeature(String title, IconData icon, String description) {
    setState(() {
      _recentFeatures.remove(title);
      _recentFeatures.insert(0, title);
      if (_recentFeatures.length > 6) {
        _recentFeatures.removeLast();
      }
    });
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FeaturePage(
          title: title,
          icon: icon,
          description: description,
        ),
      ),
    );
  }

  void _openProfilePage() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ProfilePage(onLogout: _logout),
      ),
    );
  }

  void _openNotifications() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const NotificationsPage()),
    );
  }

  void _openSearch() {
    showSearch(
      context: context,
      delegate: FeatureSearchDelegate(_features, _navigateToFeature),
    );
  }

  Color _generateColorFromName(String name) {
    final colors = Colors.primaries;
    final hash = name.codeUnits.fold(0, (a, b) => a + b);
    return colors[hash % colors.length];
  }

  String _getInitials() {
    final f =
        _firstName?.isNotEmpty == true ? _firstName![0].toUpperCase() : '';
    final l = _lastName?.isNotEmpty == true ? _lastName![0].toUpperCase() : '';
    return '$f$l';
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDark ? Colors.white : Colors.black;
    final subTextColor = isDark ? Colors.white60 : Colors.grey;

    return Scaffold(
      backgroundColor: isDark ? Colors.black : Colors.grey[50],
      appBar: AppBar(
        backgroundColor: isDark ? Colors.grey[900] : Colors.lightBlue.shade100,
        elevation: 1,
        title: Row(
          children: [
            GestureDetector(
              onTap: _pickImage,
              child: _profileImage != null
                  ? CircleAvatar(
                      radius: 22,
                      backgroundImage: FileImage(_profileImage!),
                    )
                  : CircleAvatar(
                      radius: 22,
                      backgroundColor:
                          _generateColorFromName(_firstName ?? "User"),
                      child: Text(
                        _getInitials(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _firstName != null ? 'Hey $_firstName' : 'Hey User',
                  style: TextStyle(
                      color: textColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ),
                Text(
                  _upiId ?? 'your-upi@okbank',
                  style: TextStyle(color: subTextColor, fontSize: 12),
                ),
              ],
            ),
          ],
        ),
        actions: [
          IconButton(
              icon: Icon(Icons.notifications, color: textColor),
              onPressed: _openNotifications),
          IconButton(
              icon: Icon(Icons.search, color: textColor),
              onPressed: _openSearch),
          IconButton(
              icon: Icon(Icons.settings, color: textColor),
              onPressed: _openProfilePage),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Container(
            height: 80,
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: Colors
                  .primaries[_currentAd % Colors.primaries.length].shade100,
              borderRadius: BorderRadius.circular(12),
            ),
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 500),
              child: Text(
                _ads[_currentAd],
                key: ValueKey(_ads[_currentAd]),
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          if (_recentFeatures.isNotEmpty) ...[
            const Text("Recently Used",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: _recentFeatures.map((title) {
                final icon = _features[title]!;
                return GestureDetector(
                  onTap: () => _navigateToFeature(
                    title,
                    icon,
                    'You selected $title. Here you can use this feature.',
                  ),
                  child: Container(
                    width: 100,
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.lightGreen.shade100,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      children: [
                        Icon(icon, size: 28, color: Colors.green.shade800),
                        const SizedBox(height: 6),
                        Text(title,
                            textAlign: TextAlign.center,
                            style: const TextStyle(fontSize: 12)),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 20),
          ],
          GridView.count(
            crossAxisCount: 3,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            children: _features.entries.map((entry) {
              return GestureDetector(
                onTap: () => _navigateToFeature(
                  entry.key,
                  entry.value,
                  'You selected ${entry.key}. Here you can use this feature.',
                ),
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors
                        .primaries[entry.key.length % Colors.primaries.length]
                        .shade100,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(entry.value,
                          color: Colors.indigo.shade900, size: 24),
                      const SizedBox(height: 8),
                      Text(
                        entry.key,
                        style: const TextStyle(fontSize: 12),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}

class FeatureSearchDelegate extends SearchDelegate {
  final Map<String, IconData> items;
  final void Function(String, IconData, String) onSelect;

  FeatureSearchDelegate(this.items, this.onSelect);

  @override
  List<Widget>? buildActions(BuildContext context) => [
        IconButton(
          icon: const Icon(Icons.clear),
          onPressed: () => query = '',
        ),
      ];

  @override
  Widget? buildLeading(BuildContext context) => IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () => close(context, null),
      );

  @override
  Widget buildResults(BuildContext context) {
    final results = items.keys
        .where((e) => e.toLowerCase().contains(query.toLowerCase()))
        .toList();
    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (_, index) {
        final title = results[index];
        return ListTile(
          leading: Icon(items[title]),
          title: Text(title),
          onTap: () {
            close(context, null);
            onSelect(
              title,
              items[title]!,
              'You selected $title. Here you can use this feature.',
            );
          },
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) => buildResults(context);
}
