/// RtnStatus : true
/// RtnMessage : "Visitor Count Details Loaded successfully"
/// RtnData : [{"VisitorID":86,"VisitorName":"Saktheeswaran","VisitorPhoneNo":"9894407062","VisitorFrom":"Madu","VisitorPhoto":"https://dbzmind.dbzapps.com/ImageStorage/NoImage.png","VisitorIDProofID":3,"IDProof":"Aadhar ID","VisitorIDProofNo":"2565","VehicleTypeID":6,"VehType":"4 Wheeler","VehicleNo":"2565","Temprature":"","PurposeofVisitID":1003,"PurposeofVisitName":"Discussion","VisitorsTypeID":1,"VisitorTypeName":"Customers","HostID":51,"HostName":"Swapnil","VisitingStatus":1,"VisitorsInTime":null,"VisitorsOutTime":"-","SystemID":2,"SystemName":"Syetem 1","GateID":3,"GateName":"Main Gate2","SecurityID":83,"SecurityName":"Profiles","LocationID":15,"LocationName":"Miyapur","ClientID":14,"ClientName":"Aparna Profiles Pvt Ltd"}]

class HostVisitorResponse {
  HostVisitorResponse(
      this.rtnStatus, 
      this.rtnMessage, 
      this.rtnData,);

  HostVisitorResponse.fromJson(dynamic json) {
    rtnStatus = json['RtnStatus'];
    rtnMessage = json['RtnMessage'];
    if (json['RtnData'] != null) {
      rtnData = [];
      json['RtnData'].forEach((v) {
        rtnData.add(HostVisitor.fromJson(v));
      });
    }
  }
  late bool rtnStatus;
  late String rtnMessage;
  late List<HostVisitor> rtnData;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['RtnStatus'] = rtnStatus;
    map['RtnMessage'] = rtnMessage;
    if (rtnData != null) {
      map['RtnData'] = rtnData.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// VisitorID : 86
/// VisitorName : "Saktheeswaran"
/// VisitorPhoneNo : "9894407062"
/// VisitorFrom : "Madu"
/// VisitorPhoto : "https://dbzmind.dbzapps.com/ImageStorage/NoImage.png"
/// VisitorIDProofID : 3
/// IDProof : "Aadhar ID"
/// VisitorIDProofNo : "2565"
/// VehicleTypeID : 6
/// VehType : "4 Wheeler"
/// VehicleNo : "2565"
/// Temprature : ""
/// PurposeofVisitID : 1003
/// PurposeofVisitName : "Discussion"
/// VisitorsTypeID : 1
/// VisitorTypeName : "Customers"
/// HostID : 51
/// HostName : "Swapnil"
/// VisitingStatus : 1
/// VisitorsInTime : null
/// VisitorsOutTime : "-"
/// SystemID : 2
/// SystemName : "Syetem 1"
/// GateID : 3
/// GateName : "Main Gate2"
/// SecurityID : 83
/// SecurityName : "Profiles"
/// LocationID : 15
/// LocationName : "Miyapur"
/// ClientID : 14
/// ClientName : "Aparna Profiles Pvt Ltd"

class HostVisitor {
  HostVisitor(
      this.visitorID, 
      this.visitorName, 
      this.visitorPhoneNo, 
      this.visitorFrom, 
      this.visitorPhoto, 
      this.visitorIDProofID, 
      this.iDProof, 
      this.visitorIDProofNo, 
      this.vehicleTypeID, 
      this.vehType, 
      this.vehicleNo, 
      this.temprature, 
      this.purposeofVisitID, 
      this.purposeofVisitName, 
      this.visitorsTypeID, 
      this.visitorTypeName, 
      this.hostID, 
      this.hostName, 
      this.visitingStatus, 
      this.visitorsInTime, 
      this.visitorsOutTime, 
      this.systemID, 
      this.systemName, 
      this.gateID, 
      this.gateName, 
      this.securityID, 
      this.securityName, 
      this.locationID, 
      this.locationName, 
      this.clientID, 
      this.clientName,);

  HostVisitor.fromJson(dynamic json) {
    visitorID = json['VisitorID'];
    visitorName = json['VisitorName'];
    visitorPhoneNo = json['VisitorPhoneNo'];
    visitorFrom = json['VisitorFrom'];
    visitorPhoto = json['VisitorPhoto'];
    visitorIDProofID = json['VisitorIDProofID'];
    iDProof = json['IDProof'];
    visitorIDProofNo = json['VisitorIDProofNo'];
    vehicleTypeID = json['VehicleTypeID'];
    vehType = json['VehType'];
    vehicleNo = json['VehicleNo'];
    temprature = json['Temprature'];
    purposeofVisitID = json['PurposeofVisitID'];
    purposeofVisitName = json['PurposeofVisitName'];
    visitorsTypeID = json['VisitorsTypeID'];
    visitorTypeName = json['VisitorTypeName'];
    hostID = json['HostID'];
    hostName = json['HostName'];
    visitingStatus = json['VisitingStatus'];
    visitorsInTime = json['VisitorsInTime'];
    visitorsOutTime = json['VisitorsOutTime'];
    systemID = json['SystemID'];
    systemName = json['SystemName'];
    gateID = json['GateID'];
    gateName = json['GateName'];
    securityID = json['SecurityID'];
    securityName = json['SecurityName'];
    locationID = json['LocationID'];
    locationName = json['LocationName'];
    clientID = json['ClientID'];
    clientName = json['ClientName'];
    visitingStatusName = json['VisitingStatusText'];
  }
  late int visitorID;
  late String visitorName;
  late String visitorPhoneNo;
  late String visitorFrom;
  late String visitorPhoto;
  late int visitorIDProofID;
  late String iDProof;
  late String visitorIDProofNo;
  late int vehicleTypeID;
  late String vehType;
  late String vehicleNo;
  late String temprature;
  late int purposeofVisitID;
  late String purposeofVisitName;
  late int visitorsTypeID;
  late String visitorTypeName;
  late int hostID;
  late String hostName;
  late int visitingStatus;
  late String visitorsInTime;
  late String visitorsOutTime;
  late int systemID;
  late String systemName;
  late int gateID;
  late String gateName;
  late int securityID;
  late String securityName;
  late int locationID;
  late String locationName;
  late int clientID;
  late String clientName;
  late String visitingStatusName;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['VisitorID'] = visitorID;
    map['VisitorName'] = visitorName;
    map['VisitorPhoneNo'] = visitorPhoneNo;
    map['VisitorFrom'] = visitorFrom;
    map['VisitorPhoto'] = visitorPhoto;
    map['VisitorIDProofID'] = visitorIDProofID;
    map['IDProof'] = iDProof;
    map['VisitorIDProofNo'] = visitorIDProofNo;
    map['VehicleTypeID'] = vehicleTypeID;
    map['VehType'] = vehType;
    map['VehicleNo'] = vehicleNo;
    map['Temprature'] = temprature;
    map['PurposeofVisitID'] = purposeofVisitID;
    map['PurposeofVisitName'] = purposeofVisitName;
    map['VisitorsTypeID'] = visitorsTypeID;
    map['VisitorTypeName'] = visitorTypeName;
    map['HostID'] = hostID;
    map['HostName'] = hostName;
    map['VisitingStatus'] = visitingStatus;
    map['VisitorsInTime'] = visitorsInTime;
    map['VisitorsOutTime'] = visitorsOutTime;
    map['SystemID'] = systemID;
    map['SystemName'] = systemName;
    map['GateID'] = gateID;
    map['GateName'] = gateName;
    map['SecurityID'] = securityID;
    map['SecurityName'] = securityName;
    map['LocationID'] = locationID;
    map['LocationName'] = locationName;
    map['ClientID'] = clientID;
    map['ClientName'] = clientName;
    map['VisitingStatusText'] = visitingStatusName;
    return map;
  }

}