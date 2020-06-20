// import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:stream/services/app_localizations.dart';
import '../models/user_model.dart';
import '../services/database_services.dart';
import 'package:provider/provider.dart';
import '../models/user_data.dart';
import './messages_screen.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController _searchController = TextEditingController();
  Future<QuerySnapshot> _users;
  _buildUserTile(User user) {
    String preUser = user.name;
    String mePrompt = AppLocalizations.of(context).translate('me_searched');
    String userName =
        user.id == Provider.of<UserData>(context, listen: false).currentUserId
            ? '$preUser ($mePrompt)'
            : '$preUser';
    return ListTile(
      leading: CircleAvatar(
        radius: 20.0,
        // backgroundImage: user.imageUrl.isEmpty
        //     ? AssetImage('assets/images/user_placeholder.jpg')
        //     : CachedNetworkImageProvider(user.imageUrl),
        backgroundImage: AssetImage('assets/images/user_placeholder.jpg'),
      ),
      title: Text(userName),
      onTap: () {
        String me = Provider.of<UserData>(context, listen: false).currentUserId;
        var chatId = DatabaseService.getChatId(meId: me, user: user);
        var docRef = Firestore.instance.collection('messages').document(chatId);

        Firestore.instance.runTransaction((transaction) async {
          await transaction.set(docRef, {
            me: true,
            user.id: true,
          });
        }); //TODO: Make it happen on first message

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => MessagesScreen(
              chatId: DatabaseService.getChatId(meId: me, user: user),
              user: user,
            ),
          ),
        );
      },
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
        backgroundColor: Theme.of(context).primaryColor,
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          title: TextField(
            controller: _searchController,
            decoration: InputDecoration(
              fillColor: Theme.of(context).textTheme.headline4.color,
              contentPadding: EdgeInsets.symmetric(
                vertical: 15.0,
              ),
              border: InputBorder.none,
              hintText: AppLocalizations.of(context).translate('search_form'),
              prefixIcon: Icon(
                Icons.search,
                size: 30.0,
                color: Theme.of(context).accentColor,
              ),
              suffixIcon: IconButton(
                icon: Icon(Icons.clear),
                onPressed: _clearSearch,
                color: Theme.of(context).accentColor,
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
                child: Text(AppLocalizations.of(context)
                    .translate('search_screen_info')),
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
                      child: Text(AppLocalizations.of(context)
                          .translate('users_not_found')),
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
