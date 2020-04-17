// import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:stream/screens/thread_list_screen.dart';
import '../models/user_model.dart';
// import 'package:instagram/screens/profile_screen.dart';
import '../services/database_services.dart';
import 'package:cached_network_image/cached_network_image.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController _searchController = TextEditingController();
  Future<QuerySnapshot> _users;
  _buildUserTile(User user) {
    return ListTile(
      leading: CircleAvatar(
        radius: 20.0,
        // backgroundImage: user.imageUrl.isEmpty
        //     ? AssetImage('assets/images/user_placeholder.jpg')
        //     : CachedNetworkImageProvider(user.imageUrl),
        backgroundImage: AssetImage('assets/images/user_placeholder.jpg'),
      ),
      title: Text(user.name),
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          // builder: (_) => ProfileScreen(
          //   userId: user.id,
          // ),
          builder: (_) => ThreadListScreen(),
        ),
      ),
    );
  }

  _clearSearch() {
    WidgetsBinding.instance
        .addPostFrameCallback((_) => _searchController.clear());
    setState(() {
      _users = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: TextField(
            controller: _searchController,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(
                vertical: 15.0,
              ),
              border: InputBorder.none,
              hintText: 'Search',
              prefixIcon: Icon(
                Icons.search,
                size: 30.0,
                color: Color.fromRGBO(255, 182, 185, 1),
              ),
              suffixIcon: IconButton(
                icon: Icon(Icons.clear),
                onPressed: _clearSearch,
                color: Color.fromRGBO(255, 182, 185, 1),
              ),
              filled: true,
            ),
            onSubmitted: (input) {
              if (input.isNotEmpty) {
                setState(() {
                  _users = DatabaseService.searchUsers(input);
                });
              }
            },
          ),
        ),
        body: _users == null
            ? Center(
                child: Text('Wyszukaj użytkownika'),
              )
            : FutureBuilder(
                future: _users,
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (snapshot.data.documents.length == 0) {
                    return Center(
                      child: Text('Nie znaleziono użytkowników'),
                    );
                  }
                  return ListView.builder(
                    itemCount: snapshot.data.documents.length,
                    itemBuilder: (BuildContext context, int index) {
                      User user = User.fromDoc(snapshot.data.documents[index]);
                      return _buildUserTile(user);
                    },
                  );
                },
              ));
  }
}
