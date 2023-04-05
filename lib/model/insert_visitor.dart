/// VisitorType : 0
/// VisitingType : 1
/// VisitorID : 0
/// VistiorTypeName : "string"
/// VisitorPhoto : "string"
/// VisitorName : "string"
/// VisitorPhoneNo : "string"
/// VisitorEmailID : "string"
/// VisitorFrom : "string"
/// BloodGroup : "string"
/// IDProofTypeID : 0
/// IDProofNo : "string"
/// VehicleTypeID : 0
/// VehicleNo : "string"
/// VisitorTemprature : "string"
/// IsVirusInfected : true
/// PurposeOfVisitID : 0
/// PurposeofVisitName : "string"
/// VisitorTypeID : 0
/// VisitorTypeName : "string"
/// HostID : 0
/// HostName : "string"
/// AppoinmentID : 0
/// VisitingStatus : 0
/// VisitorsInTime : "string"
/// VisitorsOutTime : "string"
/// SystemID : "string"
/// GateID : 0
/// GateName : "string"
/// SecurityID : 0
/// SecurityName : "string"
/// ClientID : 0
/// AppoinmentOTP : 0
/// CUID : 0
/// IsAdditionalPerson : true
/// AdditionalPerson : [{"SNo":"string","PhoneNo":"string","VisitorName":"string","CompanyName":"string","EmailID":"string","AppoinmentOTP":0}]
/// IsAssetCarryon : true
/// AssetDetails : [{"SNo":"string","AccessoriesName":"string","SerialNo":"string","Brand":"string","Model":"string","AssetStatus":"string"}]

class InsertVisitor {

  InsertVisitor();

  /*InsertVisitor(
      this.visitorType, 
      this.visitingType, 
      this.visitorID, 
      this.vistiorTypeName, 
      this.visitorPhoto, 
      this.visitorName, 
      this.visitorPhoneNo, 
      this.visitorEmailID, 
      this.visitorFrom, 
      this.bloodGroup, 
      this.iDProofTypeID, 
      this.iDProofNo, 
      this.vehicleTypeID, 
      this.vehicleNo, 
      this.visitorTemprature, 
      this.isVirusInfected, 
      this.purposeOfVisitID, 
      this.purposeofVisitName, 
      this.visitorTypeID, 
      this.visitorTypeName, 
      this.hostID, 
      this.hostName, 
      this.appoinmentID, 
      this.visitingStatus, 
      this.visitorsInTime, 
      this.visitorsOutTime, 
      this.systemID, 
      this.gateID, 
      this.gateName, 
      this.securityID, 
      this.securityName, 
      this.clientID, 
      this.appoinmentOTP, 
      this.cuid, 
      this.isAdditionalPerson, 
      this.additionalPerson, 
      this.isAssetCarryon, 
      this.assetDetails,);*/

  InsertVisitor.fromJson(dynamic json) {
    visitorType = json['VisitorType'];
    visitorID = json['VisitorID'];
    visitorPhoto = json['VisitorPhoto'];
    visitorName = json['VisitorName'];
    visitorPhoneNo = json['VisitorPhoneNo'];
    visitorEmailID = json['VisitorEmailID'];
    visitorFrom = json['VisitorFrom'];
    bloodGroup = json['BloodGroup'];
    iDProofTypeID = json['IDProofTypeID'];
    iDProofNo = json['IDProofNo'];
    vehicleTypeID = json['VehicleTypeID'];
    vehicleNo = json['VehicleNo'];
    visitorTemprature = json['VisitorTemprature'];
    isVirusInfected = json['IsVirusInfected'];
    purposeOfVisitID = json['PurposeOfVisitID'];
    purposeofVisitName = json['PurposeofVisitName'];
    visitorTypeID = json['VisitorTypeID'];
    visitorTypeName = json['VisitorTypeName'];
    hostID = json['HostID'];
    hostName = json['HostName'];
    appoinmentID = json['AppoinmentID'];
    visitingStatus = json['VisitingStatus'];
    visitorsInTime = json['VisitorsInTime'];
    visitorsOutTime = json['VisitorsOutTime'];
    systemID = json['SystemID'];
    gateID = json['GateID'];
    gateName = json['GateName'];
    visitorPassNo = json['VisitorPassNo'];
    securityID = json['SecurityID'];
    securityName = json['SecurityName'];
    clientID = json['ClientID'];
    appoinmentOTP = json['AppoinmentOTP'];
    cuid = json['CUID'];
    isAdditionalPerson = json['IsAdditionalPerson'];
    if (json['AdditionalPerson'] != null) {
      additionalPerson = [];
      json['AdditionalPerson'].forEach((v) {
        additionalPerson.add(AdditionalPerson.fromJson(v));
      });
    }
    isAssetCarryon = json['IsAssetCarryon'];
    if (json['AssetDetails'] != null) {
      assetDetails = [];
      json['AssetDetails'].forEach((v) {
        assetDetails.add(AssetDetails.fromJson(v));
      });
    }
  }

  late int visitorType;
  late int visitorID;
  late String visitorPhoto;
  late String visitorName;
  late String visitorPhoneNo;
  late String visitorEmailID;
  late String visitorFrom;
  late String bloodGroup;
  late int iDProofTypeID;
  late String iDProofNo;
  late int vehicleTypeID;
  late String vehicleNo;
  late String visitorTemprature;
  late bool isVirusInfected;
  late int purposeOfVisitID;
  late String purposeofVisitName;
  late int visitorTypeID;
  late String visitorTypeName;
  late int hostID;
  late String hostName;
  late int appoinmentID;
  late int visitingStatus;
  late String visitorsInTime;
  late String visitorsOutTime;
  late String systemID;
  late int gateID;
  late String gateName;
  late int securityID;
  late String securityName;
  late String visitorPassNo;
  late int clientID;
  late int appoinmentOTP;
  late int cuid;
  // late int Level=1;
  late bool isAdditionalPerson;
  late List<AdditionalPerson> additionalPerson;
  late bool isAssetCarryon;
  late List<AssetDetails> assetDetails;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['VisitorType'] = visitorType;
    map['VisitorID'] = visitorID;
    map['VisitorPhoto'] = visitorPhoto;
    map['VisitorName'] = visitorName;
    map['VisitorPhoneNo'] = visitorPhoneNo;
    map['VisitorEmailID'] = visitorEmailID;
    map['VisitorFrom'] = visitorFrom;
    map['BloodGroup'] = bloodGroup;
    map['IDProofTypeID'] = iDProofTypeID;
    map['IDProofNo'] = iDProofNo;
    map['VehicleTypeID'] = vehicleTypeID;
    map['VehicleNo'] = vehicleNo;
    map['VisitorTemprature'] = visitorTemprature;
    map['IsVirusInfected'] = isVirusInfected;
    map['PurposeOfVisitID'] = purposeOfVisitID;
    map['PurposeofVisitName'] = purposeofVisitName;
    map['VisitorTypeID'] = visitorTypeID;
    map['VisitorTypeName'] = visitorTypeName;
    map['HostID'] = hostID;
    map['HostName'] = hostName;
    map['AppoinmentID'] = appoinmentID;
    map['VisitingStatus'] = visitingStatus;
    map['VisitorsInTime'] = visitorsInTime;
    map['VisitorsOutTime'] = visitorsOutTime;
    map['SystemID'] = systemID;
    map['GateID'] = gateID;
    map['GateName'] = gateName;
    map['SecurityID'] = securityID;
    map['SecurityName'] = securityName;
    map['ClientID'] = clientID;
    map['AppoinmentOTP'] = appoinmentOTP;
    map['VisitorPassNo'] = visitorPassNo;
    map['CUID'] = cuid;
    map['IsAdditionalPerson'] = isAdditionalPerson;
    if (additionalPerson != null) {
      map['AdditionalPerson'] = additionalPerson.map((v) => v.toJson()).toList();
    }
    map['IsAssetCarryon'] = isAssetCarryon;
    if (assetDetails != null) {
      map['AssetDetails'] = assetDetails.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// SNo : "string"
/// AccessoriesName : "string"
/// SerialNo : "string"
/// Brand : "string"
/// Model : "string"
/// AssetStatus : "string"

class AssetDetails {
  AssetDetails(
      this.sNo, 
      this.accessoriesName, 
      this.serialNo, 
      this.brand, 
      this.model, 
      this.assetStatus,);

  AssetDetails.fromJson(dynamic json) {
    sNo = json['SNo'];
    accessoriesName = json['AccessoriesName'];
    serialNo = json['SerialNo'];
    brand = json['Brand'];
    model = json['Model'];
    assetStatus = json['AssetStatus'];
  }
  late String sNo;
  late String accessoriesName;
  late String serialNo;
  late String brand;
  late String model;
  late String assetStatus;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['SNo'] = sNo;
    map['AccessoriesName'] = accessoriesName;
    map['SerialNo'] = serialNo;
    map['Brand'] = brand;
    map['Model'] = model;
    map['AssetStatus'] = assetStatus;
    return map;
  }

}

/// SNo : "string"
/// PhoneNo : "string"
/// VisitorName : "string"
/// CompanyName : "string"
/// EmailID : "string"
/// AppoinmentOTP : 0

class AdditionalPerson {
  AdditionalPerson(
      this.sNo, 
      this.phoneNo, 
      this.visitorName, 
      this.companyName, 
      this.emailID, 
      this.appoinmentOTP,);

  AdditionalPerson.fromJson(dynamic json) {
    sNo = json['SNo'];
    phoneNo = json['PhoneNo'];
    visitorName = json['VisitorName'];
    companyName = json['CompanyName'];
    emailID = json['EmailID'];
    appoinmentOTP = json['AppoinmentOTP'];
  }

  late String sNo;
  late String phoneNo;
  late String visitorName;
  late String companyName;
  late String emailID;
  late int appoinmentOTP;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['SNo'] = sNo;
    map['PhoneNo'] = phoneNo;
    map['VisitorName'] = visitorName;
    map['CompanyName'] = companyName;
    map['EmailID'] = emailID;
    map['AppoinmentOTP'] = appoinmentOTP;
    return map;
  }

}