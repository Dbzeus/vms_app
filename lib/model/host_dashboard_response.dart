/// RtnStatus : true
/// RtnMessage : "Visitor Count Details Loaded successfully"
/// RtnData : [{"ClientID":12,"TotalVisitor":15,"InVisitor":2,"OutVisitor":13,"ClientName":"Aparna uPVC Limited","LogoPath":"https://dbzmind.dbzapps.com//ImageStorage/429265eb-7311-4e87-ba11-fcbb44a36645.png"},{"ClientID":14,"TotalVisitor":19,"InVisitor":6,"OutVisitor":13,"ClientName":"Aparna Profiles Pvt Ltd","LogoPath":"https://dbzmind.dbzapps.com//ImageStorage/bf11ab47-55de-4397-b118-b1260f8b5ab7.png"}]

class HostDashboardResponse {
  HostDashboardResponse(
      this.rtnStatus, 
      this.rtnMessage, 
      this.rtnData,);

  HostDashboardResponse.fromJson(dynamic json) {
    rtnStatus = json['RtnStatus'];
    rtnMessage = json['RtnMessage'];
    if (json['RtnData'] != null) {
      rtnData = [];
      json['RtnData'].forEach((v) {
        rtnData.add(HostDashboard.fromJson(v));
      });
    }
  }
  late bool rtnStatus;
  late String rtnMessage;
  late List<HostDashboard> rtnData;

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

/// ClientID : 12
/// TotalVisitor : 15
/// InVisitor : 2
/// OutVisitor : 13
/// ClientName : "Aparna uPVC Limited"
/// LogoPath : "https://dbzmind.dbzapps.com//ImageStorage/429265eb-7311-4e87-ba11-fcbb44a36645.png"

class HostDashboard {
  HostDashboard(
      this.clientID, 
      this.totalVisitor, 
      this.inVisitor, 
      this.outVisitor, 
      this.clientName, 
      this.logoPath,);

  HostDashboard.fromJson(dynamic json) {
    clientID = json['ClientID'];
    totalVisitor = json['TotalVisitor'];
    inVisitor = json['InVisitor'];
    outVisitor = json['OutVisitor'];
    clientName = json['ClientName'];
    logoPath = json['LogoPath'];
  }
  late int clientID;
  late int totalVisitor;
  late int inVisitor;
  late int outVisitor;
  late String clientName;
  late String logoPath;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['ClientID'] = clientID;
    map['TotalVisitor'] = totalVisitor;
    map['InVisitor'] = inVisitor;
    map['OutVisitor'] = outVisitor;
    map['ClientName'] = clientName;
    map['LogoPath'] = logoPath;
    return map;
  }

}