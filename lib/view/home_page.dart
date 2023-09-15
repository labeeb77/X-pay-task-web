import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xpay_web/controller/api_service.dart';

import '../controller/user_provider.dart';
import '../model/user_details.dart';
import '../model/user_model.dart';
import 'details_page.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<UserProvider>(context, listen: false);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Stack(children: [
            LayoutBuilder(
              builder: (context, constraints) {
                if (constraints.maxWidth <= 600) {
                  // Mobile layout
                  return buildMobileLayout(context);
                } else if (constraints.maxWidth <= 1200) {
                  // Tablet layout
                  return buildTabletLayout(context);
                } else {
                  // Desktop layout
                  return buildDesktopLayout(context);
                }
              },
            ),
            Positioned(
              bottom: 5,
              left: 0,
              right: 0,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            Provider.of<UserProvider>(context, listen: false)
                                .loadPreviousPage(context);
                          },
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                              side: const BorderSide(
                                  color: Color.fromARGB(255, 186, 167, 231)),
                            ),
                          ),
                          child: const Text('Previous'),
                        ),
                        const SizedBox(width: 5),
                        for (int page = 1; page < 10; page++)
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            child: ElevatedButton(
                              onPressed: () {
                                Provider.of<UserProvider>(context,
                                        listen: false)
                                    .loadPage(context, page);
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: page == provider.currentPage
                                    ? Colors.deepPurple
                                    : Colors.transparent,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18.0),
                                  side: const BorderSide(
                                      color:
                                          Color.fromARGB(255, 186, 167, 231)),
                                ),
                              ),
                              child: Text('$page'),
                            ),
                          ),
                        const SizedBox(width: 5),
                        provider.currentPage == 9
                            ? const SizedBox()
                            : ElevatedButton(
                                onPressed: () {
                                  Provider.of<UserProvider>(context,
                                          listen: false)
                                      .loadNextPage(context);
                                },
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18.0),
                                    side: const BorderSide(
                                        color:
                                            Color.fromARGB(255, 186, 167, 231)),
                                  ),
                                ),
                                child: const Text('Next'),
                              ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}

Widget buildMobileLayout(BuildContext context) {
  return FutureBuilder<List<User>>(
    future: fetchResults(context),
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return const Center(child: CircularProgressIndicator());
      } else if (snapshot.hasError) {
        return Center(child: Text('Error: ${snapshot.error}'));
      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
        return const Center(child: Text('No data available.'));
      } else {
        List<User> users = snapshot.data!;

        return ListView.builder(
          itemCount: users.length,
          itemBuilder: (context, index) {
            User user = users[index];
            return buildUserCard(context, user);
          },
        );
      }
    },
  );
}

Widget buildTabletLayout(BuildContext context) {
  return FutureBuilder<List<User>>(
    future: fetchResults(context),
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return const Center(child: CircularProgressIndicator());
      } else if (snapshot.hasError) {
        return Center(child: Text('Error: ${snapshot.error}'));
      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
        return const Center(child: Text('No data available.'));
      } else {
        List<User> users = snapshot.data!;

        return GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 1.2,
          ),
          itemCount: users.length,
          itemBuilder: (context, index) {
            User user = users[index];
            return buildUserCard(context, user);
          },
        );
      }
    },
  );
}

Widget buildDesktopLayout(BuildContext context) {
  return FutureBuilder<List<User>>(
    future: fetchResults(context),
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return const Center(child: CircularProgressIndicator());
      } else if (snapshot.hasError) {
        return Center(child: Text('Error: ${snapshot.error}'));
      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
        return const Center(child: Text('No data available.'));
      } else {
        List<User> users = snapshot.data!;

        return ListView.builder(
          itemCount: users.length,
          itemBuilder: (context, index) {
            User user = users[index];
            return buildUserCard(context, user);
          },
        );
      }
    },
  );
}

Widget buildUserCard(BuildContext context, User user) {
  return Card(
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
        onTap: () async {
          UserDetailsModel? userDetails = await fetchUserDetails(user.id);

          if (userDetails != null) {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => DetailsPage(
                  userDetailsModel: userDetails,
                ),
              ),
            );
          } else {
            log('Error occurred while getting user data');
          }
        },
        leading: CircleAvatar(
          radius: 30,
          backgroundImage: NetworkImage(user.image),
        ),
        title: Text(
          "${user.firstName} ${user.lastName}",
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              user.phone,
              style: TextStyle(fontSize: 13, color: Colors.grey[500]),
            ),
            Text(
              user.email,
              style: TextStyle(fontSize: 13, color: Colors.grey[500]),
            ),
          ],
        ),
      ),
    ),
  );
}
