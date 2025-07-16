import 'package:flutter/material.dart';

class FeaturePage extends StatefulWidget {
  final String title;
  final IconData icon;
  final String description;

  const FeaturePage({
    super.key,
    required this.title,
    required this.icon,
    required this.description,
  });

  @override
  State<FeaturePage> createState() => _FeaturePageState();
}

class _FeaturePageState extends State<FeaturePage> {
  final TextEditingController upiController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  final TextEditingController bankAccController = TextEditingController();
  final TextEditingController ifscController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController searchController = TextEditingController();

  List<String> _filteredItems = [];

  final List<Map<String, String>> upiContacts = [
    {'name': 'Adithya Paul Naijo', 'contact': '+91 79072 71258'},
    {'name': 'ADITHYA PAUL NAIJO', 'contact': '7907271258@superyes'},
    {'name': 'ADITHYAN V S', 'contact': '+91 96335 41720'},
    {'name': 'alan thomas paul', 'contact': '+91 89212 51719'},
    {'name': 'Ananya Brini', 'contact': '+91 88914 22410'},
  ];

  @override
  void initState() {
    super.initState();
    searchController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    upiController.dispose();
    amountController.dispose();
    bankAccController.dispose();
    ifscController.dispose();
    mobileController.dispose();
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bgColor = isDark ? Colors.black : Colors.white;
    final textColor = isDark ? Colors.white : Colors.black87;
    final subTextColor = isDark ? Colors.white70 : Colors.grey[700];

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: isDark ? Colors.grey[900] : Colors.blue[50],
        title: Text(widget.title, style: TextStyle(color: textColor)),
        iconTheme: IconThemeData(color: textColor),
        elevation: 1,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            Container(
              width: 90,
              height: 90,
              decoration: gradientCircle(Colors.blue),
              child: Center(
                child: Icon(widget.icon, size: 40, color: Colors.white),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              widget.title,
              style: TextStyle(
                  fontSize: 28, fontWeight: FontWeight.w900, color: textColor),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              widget.description,
              style: TextStyle(fontSize: 15, color: subTextColor, height: 1.5),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            _buildFeatureUI(widget.title),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureUI(String title) {
    final lower = title.toLowerCase();
    if (lower.contains('bank transfer')) {
      return _styledBox(child: _buildBankTransferForm());
    } else if (lower.contains('mobile') || lower.contains('recharge')) {
      return _styledBox(child: _buildMobileRechargeForm());
    } else if (lower.contains('pay anyone') || lower.contains('pay')) {
      return _styledBox(child: _buildPayAnyoneUI());
    } else if (lower.contains('dth') || lower.contains('tv')) {
      return _styledBox(
          child: _buildSearchableList(dthProviders(), "DTH/TV Providers"));
    } else if (lower.contains('electricity')) {
      return _styledBox(
          child: _buildSearchableList(
              electricitySuppliers(), "Electricity Suppliers"));
    } else if (lower.contains('postpaid')) {
      return _styledBox(
          child: _buildSearchableList(
              postpaidOperators(), "Postpaid Mobile Operators"));
    } else {
      return _styledBox(child: _buildGenericInfo(Colors.white));
    }
  }

  Widget _buildPayAnyoneUI() {
    final query = searchController.text.toLowerCase();
    final filtered = upiContacts
        .where((c) =>
            c['name']!.toLowerCase().contains(query) ||
            c['contact']!.toLowerCase().contains(query))
        .toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          controller: searchController,
          decoration: const InputDecoration(
            hintText: "Pay anyone on UPI",
            prefixIcon: Icon(Icons.search),
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 20),
        const Text("Suggested categories",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        const SizedBox(height: 10),
        Wrap(
          spacing: 12,
          children: [
            _chip("Mobile recharge"),
            _chip("DTH / Cable TV"),
            _chip("Electricity"),
            _chip("LIC / Insurance"),
            _chip("Credit card"),
          ],
        ),
        const SizedBox(height: 20),
        const Text("All people on UPI",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        const SizedBox(height: 10),
        ListTile(
          leading: const CircleAvatar(child: Icon(Icons.group)),
          title: const Text("New group"),
          subtitle: const Text("Start group chat or split an expense"),
          onTap: () {},
        ),
        ...filtered.map((entry) => ListTile(
              leading: CircleAvatar(
                  child: Text(entry['name']![0].toUpperCase())),
              title: Text(entry['name']!),
              subtitle: Text(entry['contact']!),
              onTap: () {},
            ))
      ],
    );
  }

  Widget _chip(String label) => Chip(
        label: Text(label),
        backgroundColor: Colors.blue.shade50,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      );

  Widget _buildBankTransferForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Receiver’s bank details",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        const SizedBox(height: 12),
        TextField(
          controller: bankAccController,
          decoration: const InputDecoration(
              labelText: 'Bank account number', border: OutlineInputBorder()),
          keyboardType: TextInputType.number,
        ),
        const SizedBox(height: 16),
        TextField(
          controller: ifscController,
          decoration: InputDecoration(
            labelText: 'IFSC code',
            suffix: TextButton(onPressed: () {}, child: const Text("Search")),
            border: const OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 20),
        ElevatedButton(onPressed: () {}, child: const Text("Continue")),
        const SizedBox(height: 20),
        const Divider(),
        const Text("Recent transfers", style: TextStyle(fontSize: 16)),
        const SizedBox(height: 12),
        Row(children: const [
          CircleAvatar(child: Text('P')),
          SizedBox(width: 10),
          CircleAvatar(child: Text('A')),
          SizedBox(width: 10),
          CircleAvatar(child: Text('R')),
        ]),
      ],
    );
  }

  Widget _buildMobileRechargeForm() {
    final recent = [
      {'name': 'New Shop', 'number': '+91 81298 84028', 'validTill': '23 Jul'},
      {'name': 'Linda Peter', 'number': '+91 99952 25538', 'validTill': '20 Jul'},
      {'name': 'Jithin', 'number': '+91 79077 86475'},
      {'name': 'Aneeta', 'number': '+91 94966 00778'},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Enter mobile number"),
        const SizedBox(height: 8),
        TextField(
          controller: mobileController,
          keyboardType: TextInputType.phone,
          decoration: const InputDecoration(
            hintText: '+91 00000 00000',
            border: OutlineInputBorder(),
            prefixIcon: Icon(Icons.flag),
            suffixIcon: Icon(Icons.person),
          ),
        ),
        const SizedBox(height: 20),
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("My recharges", style: TextStyle(fontSize: 16)),
            Text("See more", style: TextStyle(color: Colors.blue)),
          ],
        ),
        const SizedBox(height: 12),
        ...recent.map((entry) {
          return ListTile(
            leading: CircleAvatar(child: Text(entry['name']![0])),
            title: Text(entry['name']!),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(entry['number']!),
                if (entry.containsKey('validTill'))
                  Text("Plan valid till ${entry['validTill']!}"),
              ],
            ),
          );
        })
      ],
    );
  }

  Widget _buildSearchableList(List<String> items, String label) {
    final query = searchController.text.toLowerCase();
    final filtered =
        items.where((item) => item.toLowerCase().contains(query)).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          controller: searchController,
          decoration: InputDecoration(
            hintText: "Search $label",
            prefixIcon: const Icon(Icons.search),
            border: const OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 12),
        Text("All $label",
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        ...filtered.map((name) => ListTile(
              leading: const Icon(Icons.account_circle),
              title: Text(name),
              onTap: () {},
            )),
      ],
    );
  }

  Widget _buildGenericInfo(Color textColor, {String? message}) {
    return Column(
      children: [
        Icon(Icons.info_outline, size: 80, color: textColor),
        const SizedBox(height: 16),
        Text(message ?? "This feature is coming soon!",
            style: TextStyle(fontSize: 16, color: textColor),
            textAlign: TextAlign.center),
      ],
    );
  }

  Widget _styledBox({required Widget child}) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? Colors.grey[850] : Colors.grey[100],
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 6,
            offset: const Offset(0, 4),
          )
        ],
      ),
      child: child,
    );
  }

  BoxDecoration gradientCircle(Color color) => BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          colors: [color.withOpacity(0.9), color.withOpacity(0.6)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.3),
            blurRadius: 12,
            offset: const Offset(0, 6),
          )
        ],
      );

  List<String> dthProviders() => [
        'Tata Play DTH',
        'Airtel Digital TV',
        'D2H',
        'Sun Direct',
        'Dish TV',
        'ACT Digital TV',
        'Alka Vishwadarshan',
        'Amrita Cable Networks',
      ];

  List<String> electricitySuppliers() => [
        'Kerala Electricity (KSEB)',
        'Thrissur Electricity (TCED)',
        'Kanan Devan Hills Plantations (KDHP)',
        'Adani Electricity',
        'Ajmer Vidyut (AVVNL)',
        'Andhra Pradesh Central Power Distribution Corporation',
        'Arunachal Pradesh Power (DOPAP) - Bill Payment',
        'Arunachal Pradesh Power (DOPAP) - Prepaid Meter Recharge',
      ];

  List<String> postpaidOperators() => [
        'Airtel Postpaid Mobile',
        'BSNL Postpaid Mobile',
        'Jio Postpaid Mobile',
        'MTNL Delhi - Dolphin',
        'MTNL Dolphin - Mumbai Postpaid Mobile',
        'Vi Postpaid Mobile',
        'Wiwantet Solution',
      ];
}