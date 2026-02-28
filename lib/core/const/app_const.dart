class AppConst {
  /// supabase — loaded via --dart-define at build time, never hardcode here
  static const supabaseUrl = String.fromEnvironment('SUPABASE_URL');
  static const supabaseKey = String.fromEnvironment('SUPABASE_ANON_KEY');

  // google client id — loaded via --dart-define at build time
  static const googleClientId = String.fromEnvironment('GOOGLE_CLIENT_ID');

  // tabel profile users
  static const tabelProfileUser = 'profiles';

  // tabel orders
  static const tabelOrders = 'orders';

  // cart box
  static const cartBox = 'cart';

  // favorite box
  static const favoriteBox = 'favorite';

  // products box
  static const String productsBox = 'products';
}
