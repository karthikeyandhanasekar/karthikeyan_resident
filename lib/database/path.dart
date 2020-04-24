class APIPath {
  static String senddata(String phoneno, String jobid) => '/$phoneno/$jobid';
  static String readdata(String phonono) => '/$phonono';
    static String sampledata() => '/9123565978';

  static String cab(String uniqueid) =>
      '/security@doorstep.com/type/Cab/$uniqueid';
  static String delivery(String uniqueid) =>
      '/security@doorstep.com/type/Delivery/$uniqueid';

  static String visitor(String uniqueid) =>
      '/security@doorstep.com/type/Visitor/$uniqueid';
}
