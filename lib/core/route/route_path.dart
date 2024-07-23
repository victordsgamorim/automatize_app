class R {
  static String init = RoutePath.init;
  static String home = RoutePath.home;
  static String clients = RoutePath.clients;
  static String client = '${RoutePath.clients}/${RoutePath.client}';
  static String products = RoutePath.products;
  static String product = '${RoutePath.products}/${RoutePath.product}';
  static String newOS = RoutePath.newOS;
  static String settings = RoutePath.settings;
}

class RoutePath {
  static String init = '/';
  static String home = '/home';
  static String clients = '/clients';
  static String client = 'client';
  static String products = '/products';
  static String product = 'product';
  static String newOS = '/newOS';
  static String settings = '/settings';
}

class RouteName{
  static String home = 'Início';
  static String clients = 'Clientes';
  static String client = 'Novo Cliente';
  static String products = 'Produtos';
  static String product = 'Novo Produto';
  static String newOS = 'Novas OS';
  static String settings = 'Configurações';
}