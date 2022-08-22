import 'package:documentary_approval/Model/Documents.dart';

class  Request {
  int prType  ; // PR_TYPE
   int prNO  ; // PR_NO
  String prDate  ; // PR_DATE
  String reqName  ;
  int whCode  ; // WH_CODE
  String whName  ;
  int refNO  ;   // REF_NO
  String  approveDate  ; // APRV_DATE
  double prSer  ; //PR_SER
    String prDesc ; // PR_DESC
   int cashBankId ;  //CashBank_id
   String payType ;  //VOUCHER_PAY_TYPE
  int isFinancial   ;
   Documents requestDoc ;
   int approved    = 0 ;
   String itemID;
   String itemName  ;
   String itemUnit ;
   double itemQty ;
   double itemPrice  ;
   double vat  ;
   String costCentral;
    String  bankName  ;
     String accountName  ;
     String accountId  ;
     String currency ;
     double debit  ;
     double credit  ;
     double vatAmount  ;
     double cashAmount ;







  Request({this.prType, this.prNO, this.prDate, this.whCode, this.refNO,
      this.approveDate, this.prSer, this.prDesc , this.cashBankId ,
    this.payType , this.isFinancial , this.approved , this.reqName ,this.itemID
    , this.itemName , this.itemQty ,this.itemPrice , this.itemUnit , this.whName
    , this.bankName , this.costCentral  , this.accountId , this.accountName , this.currency , this.cashAmount});

  factory Request.fromJson (Map<String  ,dynamic> json ){
    return Request(
  approveDate: json[ "APRV_DATE" ] ,
       prDate: json["PR_DATE"] ,
       prDesc: json["PR_DESC"] ,
       reqName: json["PR_L_NAME"],
       prNO: json[ "PR_NO"],
        prSer:json["PR_SER"] ,
        prType: json["PR_TYPE"] ,
        refNO: json["refNO"] ,
        whCode: json["WH_CODE"],
        approved: json["APPROVED"],
      isFinancial: 0
    );
  }  factory Request.fromJsonJ (Map<String  ,dynamic> json ){
    return Request(
      approveDate: json[ "APRV_DATE" ] ,//
       prDate: json["J_DATE"] ,//
       prDesc: json["T_DESC"] ,//
       prNO: json[ "J_DM_ID"],
        prSer:json["J_SER"] ,//
        prType: json["SUB_TYPE"] ,
       cashAmount: json["J_AMT"],
        reqName: json["JV_NAME"],
        costCentral:json["CST_CNT_ID"] == null?"":json["CST_CNT_ID"],

        // refNO: json["refNO"] ,//
        approved: json["APPROVED"],

        isFinancial: 2
    );
  }
  factory Request.fromJsonClient (Map<String  ,dynamic> json ){
    return Request(
  approveDate: json[ "APRV_DATE" ] ,//
       prDate: json["ORDER_DATE"] ,//
       prDesc: json["A_DESC"] ,//
       prNO: json[ "ORDER_NO"],//
        prSer:json["ORDER_SER"] , //
        prType: json["SO_TYPE"] ,
        reqName: json["SO_L_NAME"],
     //   refNO: json["refNO"] ,

        whCode: json["WH_CODE"], //
        approved: json["APPROVED"],

        isFinancial: 0
    );
  }
  factory Request.fromJsonPay (Map<String  ,dynamic> json ){
    return Request(
  approveDate: json["APRV_DATE" ] ,
       prDate: json["VOUCHER_DATE"] ,
       prDesc: json["A_DESC"] ,
       reqName: json["VOUCHER_TYPE_NAME"],
       prNO: json[ "VOUCHER_NO"],
        prSer:json["V_SER"] ,
        prType: json["VOUCHER_TYPE"] ,
        refNO: int.parse(json["REF_NO"]) ,
      cashBankId: json["CASH_NO"] ,
      payType: json["LST_NAME"] ,
      approved: json["APPROVED"],
      bankName: json["CASH_BANK"],
      cashAmount: json["CASH_AMT"],
       costCentral:json["CST_CNT_ID"]==null?"":json["CST_CNT_ID"] +"-" + json["CC_L_NAME"],
      isFinancial: 1 ,
    );
  }
  factory Request.fromJsPurORDR (Map<String  ,dynamic> json ){
    return Request(
      approveDate: json[ "APRV_DATE" ] ,
      prDate: json["PO_DATE"] ,
      prDesc: json["PO_DESC"] ,
      prNO: json[ "PO_NO"],
      prSer:json["PO_SER"] ,
      prType: json["PO_TYPE"] ,
      refNO: json["REF_NO"] ,
      approved: json["APPROVED"],
      reqName: json["PO_L_NAME"],
      itemName: json["I_NAME"],
      itemUnit: json["UNIT"],
      itemID: json["ITEM_ID"],
      itemQty: json["ITM_QUANTY"],
      itemPrice: json["ITM_PRICE"],
      whName: json["W_NAME"],
      isFinancial: 0 ,

    );
  }

   Request fromJsPurORDRDtl (Map<String  ,dynamic> json ){
      this.itemName= json["I_NAME"];
      this.itemUnit= json["UNIT"];
      this.itemID= json["ITEM_ID"];
      this.itemQty= json["ITM_QUANTY"];
      this.itemPrice= json["ITM_PRICE"]== null? 0.0 :json["ITM_PRICE"];
      this.whName = json["W_NAME"] ;
    return this;
  }   Request fromJsFinancialDtl (Map<String  ,dynamic> json ){
      this.accountName= json["FJFJKF"];
      this.accountId= json["AC_ID"];
      this.currency= json["A_CY"];
    return this;
  }
  Request fromJsJDtl (Map<String  ,dynamic> json ){
    this.accountName= json["FJFJKF"];
    this.accountId= json["AC_ID"];
    this.currency= json["A_CY"];
    this.cashBankId= json["CSBK_ID"];
    this.costCentral= json["CST_CNT_ID"]== null? "":json["CST_CNT_ID"];
     double amt  =  json["J_AMT"] ;
     if( amt>0 ) {
       this.debit  = amt ;
       this.credit  = 0 ;
     }
     else {
       this.credit  = amt ;
       this.debit  = 0 ;
     }
    return this;
  }
  factory Request.fromJsPriceORDR (Map<String  ,dynamic> json ){
    double approved  =  json["APPROVED"] ;
    return Request(
      approveDate: json[ "APRV_DATE" ] ,
      prDate: json["QUOT_DATE"] ,
      prDesc: json["A_DESC"] ,
      prNO: json[ "QT_NO"],
      prSer:json["QT_SER"] ,
      prType: json["QT_TYPE"] ,
      refNO: json["REF_NO"] ,
      whCode: json["WH_CODE"] ,
      whName: json["W_NAME"],
      reqName: json["QT_L_NAME"],
      approved:approved.toInt(),
      isFinancial: 0 ,

    );
  }
}