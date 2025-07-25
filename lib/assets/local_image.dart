String getImageForTitle(String title) {
  switch (title.toLowerCase()) {
    case 'abc':
      return 'assets/images/abc.png';
    case 'xyz':
      return 'assets/images/imgxyz.png';
    case 'animals':
      return 'assets/images/animal.png';
    case 'birds':
      return 'assets/images/birds.png';
    default:
      return 'assets/images/default.png';
  }
}
