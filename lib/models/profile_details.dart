class ProfileDetails {
  final String name;
  final String imgUrl;
  final int age;
  final String country;
  final String email;
   

  ProfileDetails({required this.name, required this.imgUrl, required this.age, required this.country, required this.email});
}

final List<ProfileDetails> dummyProfile = [
  ProfileDetails(
    name: 'Mays Khalil',
    imgUrl:
        'https://i.pinimg.com/736x/9d/0c/dd/9d0cdd6ec0f42e148ecfa1622ea8e261.jpg',
    age: 23,
    country: 'Palestine, Qalqilia',
    email: 'mays.najjar2001@gmail.com'
  ),

];