/// RtnStatus : true
/// RtnMessage : "Login successfully..."
/// RtnData : {"UserID":75,"UserKey":"80C3AEA0-4101-4508-AE1E-D7634867BE9A","FirstName":"UPVC","LastName":"Gate","UserName":"upvcgate","MobileNo":"9894407062","MailID":"info@dbzeus.com","ImagePath":"","RoleID":19,"Designation":"Main Gate","Address":"Hy","IsTechnician":false,"IsSuperAdmin":false,"IsAdmin":false,"IsTenant":false,"IsSecurity":true,"ClientGroupID":19,"ClientGroupName":"Aparna Enterprises Limited","ClientID":12,"ClientName":"Aparna uPVC Limited"}

class LoginResponse {
  LoginResponse(
      this.rtnStatus, 
      this.rtnMessage, 
      this.rtnData,);

  LoginResponse.fromJson(dynamic json) {
    rtnStatus = json['RtnStatus'];
    rtnMessage = json['RtnMessage'];
    rtnData = json['RtnData'] != null ? RtnData.fromJson(json['RtnData']) : null;
  }
  late bool rtnStatus;
  late String rtnMessage;
  RtnData? rtnData;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['RtnStatus'] = rtnStatus;
    map['RtnMessage'] = rtnMessage;
    if (rtnData != null) {
      map['RtnData'] = rtnData?.toJson();
    }
    return map;
  }

}

/// UserID : 75
/// UserKey : "80C3AEA0-4101-4508-AE1E-D7634867BE9A"
/// FirstName : "UPVC"
/// LastName : "Gate"
/// UserName : "upvcgate"
/// MobileNo : "9894407062"
/// MailID : "info@dbzeus.com"
/// ImagePath : ""
/// RoleID : 19
/// Designation : "Main Gate"
/// Address : "Hy"
/// IsTechnician : false
/// IsSuperAdmin : false
/// IsAdmin : false
/// IsTenant : false
/// IsSecurity : true
/// ClientGroupID : 19
/// ClientGroupName : "Aparna Enterprises Limited"
/// ClientID : 12
/// ClientName : "Aparna uPVC Limited"

class RtnData {
  RtnData(
      this.userID, 
      this.userKey, 
      this.firstName, 
      this.lastName, 
      this.userName, 
      this.mobileNo, 
      this.mailID, 
      this.imagePath, 
      this.roleID, 
      this.designation, 
      this.address, 
      this.isTechnician, 
      this.isSuperAdmin, 
      this.isAdmin, 
      this.isTenant, 
      this.isSecurity, 
      this.clientGroupID, 
      this.clientGroupName, 
      this.clientID, 
      this.clientName,);

  RtnData.fromJson(dynamic json) {
    userID = json['UserID'];
    userKey = json['UserKey'];
    firstName = json['FirstName'];
    lastName = json['LastName'];
    userName = json['UserName'];
    mobileNo = json['MobileNo'];
    mailID = json['MailID'];
    imagePath = json['ImagePath'];
    roleID = json['RoleID'];
    designation = json['Designation'];
    address = json['Address'];
    isTechnician = json['IsTechnician'];
    isSuperAdmin = json['IsSuperAdmin'];
    isAdmin = json['IsAdmin'];
    isTenant = json['IsTenant'];
    isSecurity = json['IsSecurity'];
    clientGroupID = json['ClientGroupID'];
    clientGroupName = json['ClientGroupName'];
    clientID = json['ClientID'];
    clientName = json['ClientName'];
    clientLogo = json['ClientGroupLogo'];
  }
  late int userID;
  late String userKey;
  late String firstName;
  late String lastName;
  late String userName;
  late String mobileNo;
  late String mailID;
  late String imagePath;
  late int roleID;
  late String designation;
  late String address;
  late bool isTechnician;
  late bool isSuperAdmin;
  late bool isAdmin;
  late bool isTenant;
  late bool isSecurity;
  late int clientGroupID;
  late String clientGroupName;
  late int clientID;
  late String clientName;
  late String? clientLogo;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['UserID'] = userID;
    map['UserKey'] = userKey;
    map['FirstName'] = firstName;
    map['LastName'] = lastName;
    map['UserName'] = userName;
    map['MobileNo'] = mobileNo;
    map['MailID'] = mailID;
    map['ImagePath'] = imagePath;
    map['RoleID'] = roleID;
    map['Designation'] = designation;
    map['Address'] = address;
    map['IsTechnician'] = isTechnician;
    map['IsSuperAdmin'] = isSuperAdmin;
    map['IsAdmin'] = isAdmin;
    map['IsTenant'] = isTenant;
    map['IsSecurity'] = isSecurity;
    map['ClientGroupID'] = clientGroupID;
    map['ClientGroupName'] = clientGroupName;
    map['ClientID'] = clientID;
    map['ClientName'] = clientName;
    map['ClientGroupLogo'] = clientLogo;
    return map;
  }

}