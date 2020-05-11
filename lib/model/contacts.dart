class Contact {
  final String name;
  final String avatar;
  Contact({this.name, this.avatar});
}

List<Contact> createContactSampleData() {
  return [
    Contact(
      name: "Justin Lee",
      avatar: "https://i.pravatar.cc/300?img=3",
    ),
    Contact(
      name: "Micheal Yang",
      avatar: "https://i.pravatar.cc/300?img=2",
    ),
    Contact(
      name: "Jeff Morie",
      avatar: "https://i.pravatar.cc/300?img=1",
    ),
    Contact(
      name: "Peter Gonza",
      avatar: "https://i.pravatar.cc/300?img=5",
    ),
    Contact(
      name: "David Due",
      avatar: "https://i.pravatar.cc/300?img=15",
    ),
  ];
}
