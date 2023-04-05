/// appoinmentMasterDTO : {"AppoinmentID":0,"LocationID":0,"AppoinmentTitle":"string","AppoinmentDate":"string","PurposeOfVisit":0,"VisitingType":0,"ApprovalLevel1":0,"ApprovalLevel2":0,"ApprovalLevel3":0,"ClientGroupID":0,"ClientID":0,"TenantID":0,"IsActive":true,"CUID":0}
/// visitorDetailsDTO : [{"SNo":"string","PhoneNo":"string","VisitorName":"string","CompanyName":"string","EmailID":"string","AppoinmentOTP":0}]

class InsertAppointment {
  InsertAppointment(
      this.appoinmentMasterDTO, 
      this.visitorDetailsDTO,);

  InsertAppointment.fromJson(dynamic json) {
    appoinmentMasterDTO = (json['appoinmentMasterDTO'] != null ? AppoinmentMasterDTO.fromJson(json['appoinmentMasterDTO']) : null)!;
    if (json['visitorDetailsDTO'] != null) {
      visitorDetailsDTO = [];
      json['visitorDetailsDTO'].forEach((v) {
        visitorDetailsDTO.add(VisitorDetailsDTO.fromJson(v));
      });
    }
  }
  late AppoinmentMasterDTO appoinmentMasterDTO;
  late List<VisitorDetailsDTO> visitorDetailsDTO;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (appoinmentMasterDTO != null) {
      map['appoinmentMasterDTO'] = appoinmentMasterDTO.toJson();
    }
    if (visitorDetailsDTO != null) {
      map['visitorDetailsDTO'] = visitorDetailsDTO.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// SNo : "string"
/// PhoneNo : "string"
/// VisitorName : "string"
/// CompanyName : "string"
/// EmailID : "string"
/// AppoinmentOTP : 0

class VisitorDetailsDTO {
  VisitorDetailsDTO(
      this.sNo, 
      this.phoneNo, 
      this.visitorName, 
      this.companyName, 
      this.emailID, 
      this.appoinmentOTP,);

  VisitorDetailsDTO.fromJson(dynamic json) {
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

/// AppoinmentID : 0
/// LocationID : 0
/// AppoinmentTitle : "string"
/// AppoinmentDate : "string"
/// PurposeOfVisit : 0
/// VisitingType : 0
/// ApprovalLevel1 : 0
/// ApprovalLevel2 : 0
/// ApprovalLevel3 : 0
/// ClientGroupID : 0
/// ClientID : 0
/// TenantID : 0
/// IsActive : true
/// CUID : 0

class AppoinmentMasterDTO {
  AppoinmentMasterDTO(
      this.appoinmentID, 
      this.locationID, 
      this.appoinmentTitle, 
      this.appoinmentDate, 
      this.purposeOfVisit, 
      this.visitingType, 
      this.approvalLevel1, 
      this.approvalLevel2, 
      this.approvalLevel3, 
      this.clientGroupID, 
      this.clientID, 
      this.tenantID, 
      this.isActive, 
      this.cuid,);

  AppoinmentMasterDTO.fromJson(dynamic json) {
    appoinmentID = json['AppoinmentID'];
    locationID = json['LocationID'];
    appoinmentTitle = json['AppoinmentTitle'];
    appoinmentDate = json['AppoinmentDate'];
    purposeOfVisit = json['PurposeOfVisit'];
    visitingType = json['VisitingType'];
    approvalLevel1 = json['ApprovalLevel1'];
    approvalLevel2 = json['ApprovalLevel2'];
    approvalLevel3 = json['ApprovalLevel3'];
    clientGroupID = json['ClientGroupID'];
    clientID = json['ClientID'];
    tenantID = json['TenantID'];
    isActive = json['IsActive'];
    cuid = json['CUID'];
  }
  late int appoinmentID;
  late int locationID;
  late String appoinmentTitle;
  late String appoinmentDate;
  late int purposeOfVisit;
  late int visitingType;
  late int approvalLevel1;
  late int approvalLevel2;
  late int approvalLevel3;
  late int clientGroupID;
  late int clientID;
  late int tenantID;
  late bool isActive;
  late int cuid;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['AppoinmentID'] = appoinmentID;
    map['LocationID'] = locationID;
    map['AppoinmentTitle'] = appoinmentTitle;
    map['AppoinmentDate'] = appoinmentDate;
    map['PurposeOfVisit'] = purposeOfVisit;
    map['VisitingType'] = visitingType;
    map['ApprovalLevel1'] = approvalLevel1;
    map['ApprovalLevel2'] = approvalLevel2;
    map['ApprovalLevel3'] = approvalLevel3;
    map['ClientGroupID'] = clientGroupID;
    map['ClientID'] = clientID;
    map['TenantID'] = tenantID;
    map['IsActive'] = isActive;
    map['CUID'] = cuid;
    return map;
  }

}