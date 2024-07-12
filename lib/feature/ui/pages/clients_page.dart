import 'package:automatize_app/common_libs.dart';
import 'package:go_router/go_router.dart';

class ClientsPage extends StatelessWidget {
  const ClientsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        onPressed: () {
          context.pop();
        },
        icon: Icon(Icons.arrow_back_rounded),
      ),
    );
  }
}
