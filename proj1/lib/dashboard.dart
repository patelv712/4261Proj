import 'package:flutter/material.dart';

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _selectedIndex = 0; // Current index for the bottom nav bar
  TextEditingController _searchController = TextEditingController();

  // Dummy list of data to simulate search
  List<String> _allItems = ['computer', 'pencil', 'shirt', 'desk', 'headphone', 'backpack', 'book'];
  List<String> _searchResults = [];

  // This method is called whenever the text field changes
  void _runFilter(String enteredKeyword) {
    List<String> results = [];
    if (enteredKeyword.isEmpty) {
      // If the search field is empty or only contains white-space, we'll display all data
      results = _allItems;
    } else {
      results = _allItems
          .where((item) =>
              item.toLowerCase().contains(enteredKeyword.toLowerCase()))
          .toList();
    }
    // Refresh the UI
    setState(() {
      _searchResults = results;
    });
  }

  @override
  void initState() {
    super.initState();
    // Start with all items in the search result
    _searchResults = _allItems;
    // Listener for search field
    _searchController.addListener(() {
      _runFilter(_searchController.text);
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  static List<Widget> _widgetOptions(dynamic searchResults, TextEditingController searchController) {
    // Home Screen Widget
    Widget homeWidget = Text('Home Screen', style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold));

    // Search Screen Widget
    Widget searchWidget = Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: TextField(
            controller: searchController,
            decoration: InputDecoration(
              labelText: 'Search',
              suffixIcon: Icon(Icons.search),
            ),
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: searchResults.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(searchResults[index]),
              );
            },
          ),
        ),
      ],
    );

    // Profile Screen Widget
    Widget profileWidget = Text('Profile', style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold));

    return [homeWidget, searchWidget, profileWidget];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
      ),
      body: Center(
        child: _widgetOptions(_searchResults, _searchController).elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.deepPurple,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }
}
