unit TestDelphi;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls
  , MySqlData
  , IBusinessAPI1;

type
  TMainForm = class(TForm)
    BtnTest: TButton;
    LblTest: TLabel;
    procedure BtnTestClick(Sender: TObject);
    procedure Activate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;
  TestDB: TTestDB;
  ClientApi: IBusinessAPI;

implementation

{$R *.dfm}

procedure TMainForm.Activate(Sender: TObject);
begin
  LblTest.Caption:=TestDB.Test;
  ClientApi:= GetIBusinessAPI(false); //, Addr: string; HTTPRIO: THTTPRIO);
end;

procedure TMainForm.BtnTestClick(Sender: TObject);
var
  msg:string;
begin
  msg:=ClientApi.Entity_Add(1,'admins','Ye&=',1,0,7,'', 'Ye&=', '','','19152635023','IL',0);
  MessageBox(handle,PChar(msg),PChar(Caption),MB_OK);
  msg:=ClientApi.Telemarketing_add(4,'97219152635023','Ye&=',0,[1]);
  MessageBox(handle,PChar(msg),PChar(Caption),MB_OK);
end;

end.
