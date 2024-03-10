enum RequestsUrl {
  api('/Api'),
  token('/token'),
  employee('/employee');

  const RequestsUrl(this.value);
  final String value;
}
