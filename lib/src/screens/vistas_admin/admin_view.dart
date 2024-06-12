import 'package:flutt/src/screens/vistas_admin/vistas_secundarias/familias_view.dart';
import 'package:flutter/material.dart';

class AdminView extends StatelessWidget {
  const AdminView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(),
          endDrawer: NavigationDrawer(
            children: [
              UserAccountsDrawerHeader(
                accountName: const Text('accountName'),
                accountEmail: const Text('accountEmail'),
                currentAccountPicture: CircleAvatar(
                  child: ClipOval(
                    child: Image.network(
                        "https://pbs.twimg.com/media/E6Rc-cmXIAgVcma.jpg"),
                  ),
                ),
              ),
            ],
          ),
          body: ListView(
            padding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
            children: [
              Container(
                padding: const EdgeInsets.only(bottom: 25.0),
                child: const Center(
                  child: Text(
                    'Panel de Administrador',
                    style:
                        TextStyle(fontSize: 22.0, fontWeight: FontWeight.w500),
                  ),
                ),
              ),
              ListTile(
                leading: const Icon(Icons.article),
                title: const Text('Familias'),
                onTap: () {
                  Navigator.of(context).push(
                      MaterialPageRoute<Null>(builder: (BuildContext context) {
                    return const FamiliasPage();
                  }));
                },
              ),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.category),
                title: const Text('Categorías'),
                onTap: () {},
              ),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.sell),
                title: const Text('Subcategorías'),
                onTap: () {},
              ),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.shopping_cart_rounded),
                title: const Text('Productos'),
                onTap: () {},
              ),
              const Divider(),
            ],
          )),
    );
  }
}
