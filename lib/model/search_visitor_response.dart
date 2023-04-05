/// RtnStatus : true
/// RtnMessage : "Details Loaded successfully"
/// RtnData : {"AppoinmentID":0,"VisitorPhoneNo":"9894407062","VisitorName":"Sakthi","VisitorFrom":"U4","VisitorPhoto":"","VisitorEmailID":"a.saktheeswaran@gmail.com","BloodGroup":"AB+","IDProofTypeID":1,"IDProofNo":"1234","VehicleTypeID":1,"VehicleNo":"2565","PurposeOfVisit":1003,"PurposeofVisitName":"Official","VisitingType":1,"VisitorTypeName":"Customers","HostID":51,"HostName":"Swapnil","HostPhoneNo":"9108259595"}

class SearchVisitorResponse {
  SearchVisitorResponse(
      this.rtnStatus, 
      this.rtnMessage, 
      this.rtnData,);

  SearchVisitorResponse.fromJson(dynamic json) {
    rtnStatus = json['RtnStatus'];
    rtnMessage = json['RtnMessage'];
    rtnData = json['RtnData'] != null ? SearchVisitor.fromJson(json['RtnData']) : null;
  }
  late bool rtnStatus;
  late String rtnMessage;
  late SearchVisitor? rtnData;

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

/// AppoinmentID : 0
/// VisitorPhoneNo : "9894407062"
/// VisitorName : "Sakthi"
/// VisitorFrom : "U4"
/// VisitorPhoto : ""
/// VisitorEmailID : "a.saktheeswaran@gmail.com"
/// BloodGroup : "AB+"
/// IDProofTypeID : 1
/// IDProofNo : "1234"
/// VehicleTypeID : 1
/// VehicleNo : "2565"
/// PurposeOfVisit : 1003
/// PurposeofVisitName : "Official"
/// VisitingType : 1
/// VisitorTypeName : "Customers"
/// HostID : 51
/// HostName : "Swapnil"
/// HostPhoneNo : "9108259595"

class SearchVisitor {
  SearchVisitor(
      this.appoinmentID, 
      this.visitorPhoneNo, 
      this.visitorName, 
      this.visitorFrom, 
      this.visitorPhoto, 
      this.visitorEmailID, 
      this.bloodGroup, 
      this.iDProofTypeID, 
      this.iDProofNo, 
      this.vehicleTypeID, 
      this.vehicleNo, 
      this.purposeOfVisit, 
      this.purposeofVisitName, 
      this.visitingType, 
      this.visitorTypeName, 
      this.hostID, 
      this.hostName, 
      this.hostPhoneNo,
      this.isReturnPass,
      this.returnMsg,
      );

  SearchVisitor.fromJson(dynamic json) {
    appoinmentID = json['AppoinmentID'];
    visitorPhoneNo = json['VisitorPhoneNo'];
    visitorName = json['VisitorName'];
    visitorFrom = json['VisitorFrom'];
    visitorPhoto = json['VisitorPhoto'];
    visitorEmailID = json['VisitorEmailID'];
    bloodGroup = json['BloodGroup'];
    iDProofTypeID = json['IDProofTypeID'];
    iDProofNo = json['IDProofNo'];
    vehicleTypeID = json['VehicleTypeID'];
    vehicleNo = json['VehicleNo'];
    purposeOfVisit = json['PurposeOfVisit'];
    purposeofVisitName = json['PurposeofVisitName'];
    visitingType = json['VisitingType'];
    visitorTypeName = json['VisitorTypeName'];
    hostID = json['HostID'];
    hostName = json['HostName'];
    hostPhoneNo = json['HostPhoneNo'];
    isReturnPass = json['IsReturnPass'];
    returnMsg = json['IsReturnPassMsg'];
    visitorPassNo = json['VisitorPassNo'] ?? "";
  }
  
  late int appoinmentID;
  late String visitorPhoneNo;
  late String visitorName;
  late String visitorFrom;
  late String visitorPhoto;
  late String visitorEmailID;
  late String bloodGroup;
  late int iDProofTypeID;
  late String iDProofNo;
  late int vehicleTypeID;
  late String vehicleNo;
  late int purposeOfVisit;
  late String purposeofVisitName;
  late int visitingType;
  late String visitorTypeName;
  late int hostID;
  late String hostName;
  late String hostPhoneNo;
  late bool isReturnPass;
  late String returnMsg;
  String visitorPassNo = "";

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['AppoinmentID'] = appoinmentID;
    map['VisitorPhoneNo'] = visitorPhoneNo;
    map['VisitorName'] = visitorName;
    map['VisitorFrom'] = visitorFrom;
    map['VisitorPhoto'] = visitorPhoto;
    map['VisitorEmailID'] = visitorEmailID;
    map['BloodGroup'] = bloodGroup;
    map['IDProofTypeID'] = iDProofTypeID;
    map['IDProofNo'] = iDProofNo;
    map['VehicleTypeID'] = vehicleTypeID;
    map['VehicleNo'] = vehicleNo;
    map['PurposeOfVisit'] = purposeOfVisit;
    map['PurposeofVisitName'] = purposeofVisitName;
    map['VisitingType'] = visitingType;
    map['VisitorTypeName'] = visitorTypeName;
    map['HostID'] = hostID;
    map['HostName'] = hostName;
    map['HostPhoneNo'] = hostPhoneNo;
    map['IsReturnPass'] = isReturnPass;
    map['IsReturnPassMsg'] = returnMsg;
    map['VisitorPassNo'] = visitorPassNo;
    return map;
  }

}