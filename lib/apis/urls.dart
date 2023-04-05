const BASE_URL="https://dbzvms.dbzapps.com/api/";

const LOGIN_URL="DbzMind/Account/UserLogin";

//gate apis
const GET_CLIENT_URL="DbzMind/Client/GetClientByUserID"; //?UserID=75
const GET_LOCATION_URL="DbzMind/Region/GetLocationByClientID"; //?ClientID=12
const GET_GATE_URL="Admin/Master/GetGateList"; //?GroupID=0&ClientID=12&LocationID=15&GateID=0
const GET_SYSTEM_URL="Admin/Master/GetGateSystemList"; //?ClientID=0&LocationID=0&GateID=2&SystemID=0

const GET_VISITOR_URL="Gate/GetVisitorDetails"; //?OTP=0&PhoneNo=9894407062
const GET_VISITOR_LIST_URL="Gate/GetVisitorsListByGate"; //?SystemID=1&VisitorID=0
const GET_VISITOR_TYPE_URL="Admin/Master/GetVisitorType"; //?GroupID=19&VisitorTypeID=0
const GET_GATE_VISITOR_TYPE_URL="Gate/GetGateVisitorType"; //?GroupID=19&VisitorTypeID=0
const GET_PURPOSE_URL="Admin/Master/GetPurposeOfVisit"; //?GroupID=19&PurposeOfVisitID=0
const GET_PROOF_VEH_URL="Admin/Master/GetDropdownList"; // use type (1 proof, 2 veh)
const GET_USER_BY_CLIENT_URL="DBZMind/User/GetUserByClientTenantID"; //?ClientID=12&TenantID=0
const INSERT_VISITOR_URL="Gate/InsertVisitingDetails";
const REQUEST_VISITOR_URL="Gate/InsertWalkInVisitor";
const VISITOR_INTIME_URL="Gate/UpdateVisitorInTime"; //?VisitorID=29
const VISITOR_OUTTIME_URL="Gate/UpdateVisitorOutTime"; //?VisitorID=29
const GET_APPROVER_LIST="Admin/Master/GetApprovalList"; //?ClientID=12&LocationID=15&TenantID=0&VisitorTypeID=1&ApprovalID=0
const INSERT_APPOINTMENT="Host/InsertAppoinmentDetails";
//host dashboard
const HOST_DAHBOARD="Host/GetDashboardVisitorCount";
const HOST_VISITOR_LIST="Host/GetVisitorsList"; //?GroupID=19&ClientID=0&UserID=51&FromDate=02/07/2022&ToDate=02/07/2022&VisitorID=0
const HOST_ACTION_URL="Gate/InsertWalkInVisit";

const NOTIFICATION_URL="Communication/NotificationHistory";

