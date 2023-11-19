import '../libraries.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Image.asset(
              'assets/images/think.jpg',
            ),
            Padding(
              padding: const EdgeInsets.only(top: 200),
              child: Container(
                height: double.infinity,
                width: double.infinity,
                // color: Colors.red,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(35),
                  ),
                  color: Color.fromARGB(255, 231, 234, 235),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Image.asset(
                          'assets/images/bell.png',
                          height: 50,
                        ),
                        const Text(
                          'REMINDERS',
                          style: TextStyle(
                            fontSize: 35,
                            height: 2,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primaryColor,
                          ),
                        ),
                        IconButton(
                          icon: const Icon(
                            Icons.logout,
                            color: AppColors.primaryColor,
                            size: 30,
                          ),
                          onPressed: () async {
                            await authProvider.signOutUser(context);
                          },
                        )
                      ],
                    ),
                    const ListTile(
                      title: Text('title'),
                      subtitle: Text('description'),
                      trailing: Text('Date Time'),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, RouteName.createScreen);
        },
        backgroundColor: AppColors.primaryColor,
        child: const Icon(Icons.add),
      ),
    );
  }
}
