import 'dart:convert';

String decodePackage(String package)  {
  String charFin = package.substring(0, 3);
  String charSpot = package.substring(package.length - 4);
  String data = '';

  if (charFin == "FIN" && charSpot == "SPOT") {
    String data_ = package.substring(3, package.length - 4);
    String split1 = data_.substring(0, 4);
    String split2 = data_.substring(data_.length - 4);
    String base64 = split2 + data_.substring(4, data_.length - 4) + split1;
    List<int> binaryData = base64Decode(base64);
    String asciiString = utf8.decode(binaryData);
    data = asciiString;
  }

  return data;
}

String encodePackage(String package) {
  String str1 = base64Encode(utf8.encode(package));
  String char1 = str1.substring(0, 4);
  String char2 = str1.substring(str1.length - 4);
  String char3 = str1.substring(4, str1.length - 4);
  String data = char2 + char3 + char1;
  data = "FIN${data}SPOT";
  return data;
}
