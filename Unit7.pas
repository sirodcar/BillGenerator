unit Unit7;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, System.Actions, Vcl.ActnList, Data.DB,
  Datasnap.DBClient, Vcl.StdCtrls, Vcl.Mask, RzEdit, RzDBEdit, RzPanel,
  Vcl.ExtCtrls, Xml.xmldom, Datasnap.Provider, Datasnap.Xmlxform, cxGraphics,
  cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit,
  Vcl.ComCtrls, dxCore, cxDateUtils, dxSkinsCore, dxSkinBlack, dxSkinBlue,
  dxSkinBlueprint, dxSkinCaramel, dxSkinCoffee, dxSkinDarkRoom, dxSkinDarkSide,
  dxSkinDevExpressDarkStyle, dxSkinDevExpressStyle, dxSkinFoggy,
  dxSkinGlassOceans, dxSkinHighContrast, dxSkiniMaginary, dxSkinLilian,
  dxSkinLiquidSky, dxSkinLondonLiquidSky, dxSkinMcSkin, dxSkinMetropolis,
  dxSkinMetropolisDark, dxSkinMoneyTwins, dxSkinOffice2007Black,
  dxSkinOffice2007Blue, dxSkinOffice2007Green, dxSkinOffice2007Pink,
  dxSkinOffice2007Silver, dxSkinOffice2010Black, dxSkinOffice2010Blue,
  dxSkinOffice2010Silver, dxSkinOffice2013DarkGray, dxSkinOffice2013LightGray,
  dxSkinOffice2013White, dxSkinOffice2016Colorful, dxSkinOffice2016Dark,
  dxSkinPumpkin, dxSkinSeven, dxSkinSevenClassic, dxSkinSharp, dxSkinSharpPlus,
  dxSkinSilver, dxSkinSpringTime, dxSkinStardust, dxSkinSummer2008,
  dxSkinTheAsphaltWorld, dxSkinsDefaultPainters, dxSkinValentine,
  dxSkinVisualStudio2013Blue, dxSkinVisualStudio2013Dark,
  dxSkinVisualStudio2013Light, dxSkinVS2010, dxSkinWhiteprint,
  dxSkinXmas2008Blue, RzButton, RzLabel, cxTextEdit, cxMaskEdit, cxDropDownEdit,
  cxCalendar, cxStyles, dxSkinscxPCPainter, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxNavigator, cxDBData, cxGridLevel, cxClasses,
  cxGridCustomView, cxGridCustomTableView, cxGridTableView, cxGridDBTableView,
  cxGrid, frxClass, frxDBSet, RzDTP, RzDBDTP;

const
 MAX_RECS = 10000;
 MasterDataFile = 'Master.xml';
 DetailDataFile = 'Detail.xml';

type
  TForm7 = class(TForm)
    RzStatusBar1: TRzStatusBar;
    rztlbr1: TRzToolbar;
    btnPrint: TRzToolButton;
    btnDesign: TRzToolButton;
    rzspcr1: TRzSpacer;
    btnLoad: TRzToolButton;
    btnSave: TRzToolButton;
    rzspcr2: TRzSpacer;
    btnGenerate: TRzToolButton;
    actlst1: TActionList;
    actLoad: TAction;
    actSave: TAction;
    actPrint: TAction;
    actDesign: TAction;
    actGenerate: TAction;
    btnExit: TRzToolButton;
    actExit: TAction;
    RzPanel1: TRzPanel;
    RzLabel1: TRzLabel;
    RzLabel3: TRzLabel;
    RzLabel5: TRzLabel;
    edtPersons: TRzDBEdit;
    edtcashier: TRzDBEdit;
    edtName: TRzDBEdit;
    RzLabel2: TRzLabel;
    RzLabel4: TRzLabel;
    RzLabel6: TRzLabel;
    edtTableNo: TRzDBEdit;
    edtmobile: TRzDBEdit;
    RzLabel7: TRzLabel;
    edtGST: TRzDBEdit;
    dsMaster: TDataSource;
    RzPanel2: TRzPanel;
    dsDetail: TDataSource;
    cdsDetail: TClientDataSet;
    RzLabel8: TRzLabel;
    edtTableNo1: TRzDBEdit;
    cdsMaster: TClientDataSet;
    strngfldcds1cashier: TStringField;
    cdsMasterPersons: TBCDField;
    cdsMastermobile: TBCDField;
    cdsMasterBillDate: TDateTimeField;
    cdsMasterTableNo: TBCDField;
    cdsMasterBillNumber: TBCDField;
    cdsDetailID: TIntegerField;
    strngfldDetailItemDesc: TStringField;
    cdsDetailAmount: TCurrencyField;
    frxReport1: TfrxReport;
    frxDBDatasetMaster: TfrxDBDataset;
    frxDBDatasetDetail: TfrxDBDataset;
    strngfldMasterNameAndMobile: TStringField;
    strngfldMasterName: TStringField;
    bcdfldMasterSGST: TBCDField;
    bcdfldMasterCGST: TBCDField;
    RzLabel9: TRzLabel;
    edtSGST: TRzDBEdit;
    crncyfldDetailPrice: TCurrencyField;
    cxgrd1: TcxGrid;
    cxgrdbtblvwGrid1DBTableView1: TcxGridDBTableView;
    cxgrdlvlGrid1Level1: TcxGridLevel;
    cxgrdbclmnGrid1DBTableView1ID: TcxGridDBColumn;
    cxgrdbclmnGrid1DBTableView1ItemDesc: TcxGridDBColumn;
    cxgrdbclmnGrid1DBTableView1Amount: TcxGridDBColumn;
    cxgrdbclmnGrid1DBTableView1Price: TcxGridDBColumn;
    rzdbdtmpckrBillDate: TRzDBDateTimePicker;
    bcdfldDetailQty: TBCDField;
    cxgrdbclmnGrid1DBTableView1Qty: TcxGridDBColumn;
    procedure FormCreate(Sender: TObject);
    procedure actLoadExecute(Sender: TObject);
    procedure actSaveExecute(Sender: TObject);
    procedure actPrintExecute(Sender: TObject);
    procedure strngfldMasterNameAndMobileGetText(Sender: TField;
      var Text: string; DisplayText: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form7: TForm7;
  Path: String;

implementation

{$R *.dfm}

procedure TForm7.actLoadExecute(Sender: TObject);
begin
  if Path <> '' then
  begin
    cdsMaster.Close;
    cdsDetail.Close ;
    cdsMaster.FileName := ExtractFilePath(Application.ExeName) + MasterDataFile ;
    cdsDetail.FileName := ExtractFilePath(Application.ExeName) + DetailDataFile;

    if FileExists(cdsMaster.FileName) and FileExists(cdsDetail.FileName) then
    begin
      cdsMaster.Open;
      cdsDetail.Open;
    end
    else
    begin
      cdsMaster.CreateDataSet;
      cdsDetail.CreateDataSet;
    end ;
    cdsMaster.Edit ;
    cdsDetail.Edit;
  end;
end;

procedure TForm7.actPrintExecute(Sender: TObject);
begin
  frxReport1.showreport;
end;

procedure TForm7.actSaveExecute(Sender: TObject);
begin
  cdsMaster.SaveToFile(Path + 'Master.XML', dfXML);
  cdsDetail.SaveToFile(Path + 'Detail.XML', dfXML);
end;

procedure TForm7.FormCreate(Sender: TObject);
begin
  Path:= ExtractFilePath(Application.ExeName);
end;

procedure TForm7.strngfldMasterNameAndMobileGetText(Sender: TField;
  var Text: string; DisplayText: Boolean);
begin
   //Text := strngfldMasterName + '( ' +  IntToStr (cdsMasterBillNumber ) +')';
end;

end.
