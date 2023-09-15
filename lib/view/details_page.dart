import 'package:flutter/material.dart';
import 'package:xpay_web/model/user_details.dart';

class DetailsPage extends StatelessWidget {
  final UserDetailsModel userDetailsModel;
  const DetailsPage({super.key, required this.userDetailsModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Details'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: LayoutBuilder(
              builder: (context, constraints) {
                if (constraints.maxWidth <= 600) {
                  // Mobile layout
                  return buildMobileLayout();
                } else if (constraints.maxWidth <= 1200) {
                  // Tablet layout
                  return buildTabletLayout();
                } else {
                  // Desktop layout
                  return buildDesktopLayout();
                }
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget buildMobileLayout() {
    return SingleChildScrollView(
      child: Column(
        children: [
          CircleAvatar(
            radius: 60,
            backgroundImage: NetworkImage(userDetailsModel.image),
          ),
          const SizedBox(
            height: 16,
          ),
          Text(
            '${userDetailsModel.firstName} ${userDetailsModel.lastName}',
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.phone_android_rounded,
                size: 20,
              ),
              Text(" ${userDetailsModel.phone}"),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.email_outlined,
                size: 20,
              ),
              Text(" ${userDetailsModel.email}"),
            ],
          ),
          const SizedBox(
            height: 24,
          ),
          buildDetailsCard(),
        ],
      ),
    );
  }

  Widget buildTabletLayout() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 2,
          child: CircleAvatar(
            radius: 60,
            backgroundImage: NetworkImage(userDetailsModel.image),
          ),
        ),
        Expanded(
          flex: 3,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${userDetailsModel.firstName} ${userDetailsModel.lastName}',
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Icon(
                      Icons.phone_android_rounded,
                      size: 20,
                    ),
                    Text(" ${userDetailsModel.phone}"),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Icon(
                      Icons.email_outlined,
                      size: 20,
                    ),
                    Text(" ${userDetailsModel.email}"),
                  ],
                ),
                const SizedBox(
                  height: 24,
                ),
                buildDetailsCard(),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget buildDesktopLayout() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 2,
          child: CircleAvatar(
            radius: 60,
            backgroundImage: NetworkImage(userDetailsModel.image),
          ),
        ),
        Expanded(
          flex: 3,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${userDetailsModel.firstName} ${userDetailsModel.lastName}',
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Icon(
                      Icons.phone_android_rounded,
                      size: 20,
                    ),
                    Text(" ${userDetailsModel.phone}"),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Icon(
                      Icons.email_outlined,
                      size: 20,
                    ),
                    Text(" ${userDetailsModel.email}"),
                  ],
                ),
                const SizedBox(
                  height: 24,
                ),
                buildDetailsCard(),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget buildDetailsCard() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Other Details',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            ListTile(
              title: const Text(
                'Age',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              trailing: Text(userDetailsModel.age.toString()),
            ),
            const ListTile(
              title: Text(
                'Gender',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              trailing: Text('Male'),
            ),
            ListTile(
              title: const Text(
                'Date of Birth',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              trailing: Text(userDetailsModel.birthDate),
            ),
            ListTile(
              title: const Text(
                'City',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              trailing: Text(userDetailsModel.city),
            ),
            ListTile(
              title: const Text(
                'Address',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              trailing: Text(userDetailsModel.address),
            ),
            ListTile(
              title: const Text(
                'Blood Group',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              trailing: Text(userDetailsModel.bloodGroup),
            ),
            ListTile(
              title: const Text(
                'Height',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              trailing: Text('${userDetailsModel.height} cm'),
            ),
            ListTile(
              title: const Text(
                'Weight',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              trailing: Text('${userDetailsModel.weight} kg'),
            ),
          ],
        ),
      ),
    );
  }
}
