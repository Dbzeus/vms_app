/// RtnStatus : true
/// RtnMessage : "User Details Loaded successfully"
/// RtnData : [{"VisitorType":0,"VisitorID":42,"VisitorPhoto":"https://dbzvms.dbzapps.com/img/NoImage.png","VisitorName":"Giri","VisitorPhoneNo":"7729994237","VisitorFrom":"Aparna","PurposeofVisitName":"Official","VisitorTypeName":"Delivery","HostName":"Swapnil","VisitorsInTime":"01-02-2022 01:09 PM","VisitorsOutTime":"","GateName":"Main Gate","SecurityName":"UPVC","AppoinmentOTP":608245,"ClientName":"Aparna uPVC Limited","ClientGroupName":"Aparna Enterprises Limited","LocationName":"Miyapur","VisitorPassNo":"00042"}]

class VisitorResponse {
  VisitorResponse(
      this.rtnStatus, 
      this.rtnMessage, 
      this.rtnData,);

  VisitorResponse.fromJson(dynamic json) {
    rtnStatus = json['RtnStatus'];
    rtnMessage = json['RtnMessage'];
    if (json['RtnData'] != null) {
      rtnData = [];
      json['RtnData'].forEach((v) {
        rtnData.add(Visitor.fromJson(v));
      });
    }
  }
  late bool rtnStatus;
  late String rtnMessage;
  late List<Visitor> rtnData;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['RtnStatus'] = rtnStatus;
    map['RtnMessage'] = rtnMessage;
    map['RtnData'] = rtnData.map((v) => v.toJson()).toList();
    return map;
  }

}

/// VisitorType : 0
/// VisitorID : 42
/// VisitorPhoto : "https://dbzvms.dbzapps.com/img/NoImage.png"
/// VisitorName : "Giri"
/// VisitorPhoneNo : "7729994237"
/// VisitorFrom : "Aparna"
/// PurposeofVisitName : "Official"
/// VisitorTypeName : "Delivery"
/// HostName : "Swapnil"
/// VisitorsInTime : "01-02-2022 01:09 PM"
/// VisitorsOutTime : ""
/// GateName : "Main Gate"
/// SecurityName : "UPVC"
/// AppoinmentOTP : 608245
/// ClientName : "Aparna uPVC Limited"
/// ClientGroupName : "Aparna Enterprises Limited"
/// LocationName : "Miyapur"
/// VisitorPassNo : "00042"

class Visitor {
  // Visitor(
  //     this.visitorType,
  //     this.visitorID,
  //     this.visitorPhoto,
  //     this.visitorName,
  //     this.visitorPhoneNo,
  //     this.visitorFrom,
  //     this.purposeofVisitName,
  //     this.visitorTypeName,
  //     this.hostName,
  //     this.visitorsInTime,
  //     this.visitorsOutTime,
  //     this.gateName,
  //     this.securityName,
  //     this.appointmentOTP,
  //     this.clientName,
  //     this.clientGroupName,
  //     this.locationName,
  //     this.visitorPassNo,);

  Visitor(
      this.visitorID
      );

  Visitor.fromJson(dynamic json) {
    visitorType = json['VisitorType'];
    visitorID = json['VisitorID'];
    visitorPhoto = json['VisitorPhoto'];
    visitorName = json['VisitorName'];
    visitorPhoneNo = json['VisitorPhoneNo'];
    visitorFrom = json['VisitorFrom'];
    purposeofVisitName = json['PurposeofVisitName'];
    visitorTypeName = json['VisitorTypeName'];
    hostName = json['HostName'];
    visitorsInTime = json['VisitorsInTime'];
    visitorsOutTime = json['VisitorsOutTime'];
    gateName = json['GateName'];
    securityName = json['SecurityName'];
    appointmentOTP = json['AppoinmentOTP'];
    clientName = json['ClientName'];
    clientGroupName = json['ClientGroupName'];
    locationName = json['LocationName'];
    visitorPassNo = json['VisitorPassNo'];
    visitingStatusName = json['VisitingStatusName'];
    statusId = json['VisitingStatus'] ?? -1;
  }
  
  late int visitorType;
  late int visitorID;
  late String visitorPhoto;
  late String visitorName;
  late String visitorPhoneNo;
  late String visitorFrom;
  late String purposeofVisitName;
  late String visitorTypeName;
  late String hostName;
  late String visitorsInTime;
  late String visitorsOutTime;
  late String gateName;
  late String securityName;
  late int appointmentOTP;
  late String clientName;
  late String clientGroupName;
  late String locationName;
  late String visitorPassNo;
  late String visitingStatusName;
  late int statusId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['VisitorType'] = visitorType;
    map['VisitorID'] = visitorID;
    map['VisitorPhoto'] = visitorPhoto;
    map['VisitorName'] = visitorName;
    map['VisitorPhoneNo'] = visitorPhoneNo;
    map['VisitorFrom'] = visitorFrom;
    map['PurposeofVisitName'] = purposeofVisitName;
    map['VisitorTypeName'] = visitorTypeName;
    map['HostName'] = hostName;
    map['VisitorsInTime'] = visitorsInTime;
    map['VisitorsOutTime'] = visitorsOutTime;
    map['GateName'] = gateName;
    map['SecurityName'] = securityName;
    map['AppoinmentOTP'] = appointmentOTP;
    map['ClientName'] = clientName;
    map['ClientGroupName'] = clientGroupName;
    map['LocationName'] = locationName;
    map['VisitorPassNo'] = visitorPassNo;
    map['VisitingStatusName'] = visitingStatusName;
    map['VisitingStatus'] = statusId;
    return map;
  }

}