class HttpException implements Exception{
    String? excep;

    HttpException(this.excep);
     @override
     String toString() {
    Object? excep = this.excep;
    if (excep == null) return "Exception";
    return "Exception: $excep";
  }

}