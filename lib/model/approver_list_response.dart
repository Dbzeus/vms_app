/// RtnStatus : true
/// RtnMessage : "Approver List Loaded successfully"
/// RtnData : [{"ApprovalID":2,"LocationID":0,"VisitorType":1,"VistiorTypeName":"Customers","ApprovalLevel":"Level 1","ApprovalName":"HR uPVC","ApproverID":52,"ApprovalOrder":1,"MailID":"hr.upvc@aparnaenterprisesltd.com","MobileNo":"9705103334"}]

class ApproverListResponse {
  ApproverListResponse(
      this.rtnStatus, 
      this.rtnMessage, 
      this.rtnData,);

  ApproverListResponse.fromJson(dynamic json) {
    rtnStatus = json['RtnStatus'];
    rtnMessage = json['RtnMessage'];
    if (json['RtnData'] != null) {
      rtnData = [];
      json['RtnData'].forEach((v) {
        rtnData.add(ApproverList.fromJson(v));
      });
    }
  }
  late bool rtnStatus;
  late String rtnMessage;
  late List<ApproverList> rtnData;

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

/// ApprovalID : 2
/// LocationID : 0
/// VisitorType : 1
/// VistiorTypeName : "Customers"
/// ApprovalLevel : "Level 1"
/// ApprovalName : "HR uPVC"
/// ApproverID : 52
/// ApprovalOrder : 1
/// MailID : "hr.upvc@aparnaenterprisesltd.com"
/// MobileNo : "9705103334"

class ApproverList {
  ApproverList(
      this.approvalID, 
      this.locationID, 
      this.visitorType,
      this.approvalLevel, 
      this.approvalName, 
      this.approverID, 
      this.approvalOrder, 
      this.mailID, 
      this.mobileNo,);

  ApproverList.fromJson(dynamic json) {
    approvalID = json['ApprovalID'];
    locationID = json['LocationID'];
    visitorType = json['VisitorType'];
    approvalLevel = json['ApprovalLevel'];
    approvalName = json['ApprovalName'];
    approverID = json['ApproverID'];
    approvalOrder = json['ApprovalOrder'];
    mailID = json['MailID'];
    mobileNo = json['MobileNo'];
  }
  
  late int approvalID;
  late int locationID;
  late int visitorType;
  late String approvalLevel;
  late String approvalName;
  late int approverID;
  late int approvalOrder;
  late String mailID;
  late String mobileNo;
  
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['ApprovalID'] = approvalID;
    map['LocationID'] = locationID;
    map['VisitorType'] = visitorType;
    map['ApprovalLevel'] = approvalLevel;
    map['ApprovalName'] = approvalName;
    map['ApproverID'] = approverID;
    map['ApprovalOrder'] = approvalOrder;
    map['MailID'] = mailID;
    map['MobileNo'] = mobileNo;
    return map;
  }

}