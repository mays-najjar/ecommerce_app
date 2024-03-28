class ApiPaths {

  static String products() => 'products/';
  static String ann(String id) => 'announcements/$id';

  static String product(String id) => 'products/$id';
  static String category(String name) => 'categories/$name';
  static String categories() => 'categories/';
  static announcements() => 'announcements/';
  static String user(String uid) => 'users/$uid';
  static String cartItem(String uid, String cartItemId) =>
      'users/$uid/cartItems/$cartItemId';
  static String cartItems(String uid) => 'users/$uid/cartItems/';
  static String profiles() => 'profiles/';
  static String profile(String id) => 'profiles/$id';
  static String favItem(String uid, String favItemId) =>
      'users/$uid/favItems/$favItemId';
      static String favItems(String uid) =>
      'users/$uid/favItems/';
}
