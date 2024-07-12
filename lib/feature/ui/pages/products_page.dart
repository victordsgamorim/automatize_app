import 'package:automatize_app/common_libs.dart';

class ProductsPage extends StatefulWidget {
  const ProductsPage({super.key});

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {

  @override
  void initState() {
    print('product page');
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Container(color: Colors.purpleAccent,);
  }
}
