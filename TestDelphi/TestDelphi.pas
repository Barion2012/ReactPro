unit TestDelphi;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls
  , MySqlData, IBusinessAPI1, System.IniFiles, System.JSON;

type
  TMainForm = class(TForm)
    BtnTest: TButton;
    LblTest: TLabel;
    procedure BtnTestClick(Sender: TObject);
    procedure Activate(Sender: TObject);
  private
    procedure Reset();
  public
    { Public declarations }
  end;

  TMasterRec = class(TObject)
    Name:string;
    Pwd:string;
    Uid:integer;
  end;

var
  MainForm: TMainForm;
  TestDB: TTestDB;
  ClientApi: IBusinessAPI;
  MasterRec: TMasterRec;
implementation

{$R *.dfm}

procedure TMainForm.Reset();
begin
  if TestDB.Test then begin
    LblTest.Caption:=Format('There is %d unextacted callbacks in the moment.',
        [TestDB.CallbacksTable.RecordCount]);
    BtnTest.Enabled:=true;
  end
  else begin
    LblTest.Caption:='There isn''t not unextacted callbacks in the moment.';
    BtnTest.Enabled:=false;
  end;
end;

procedure TMainForm.Activate(Sender: TObject);
var
  IniFile :TIniFile;
begin
  IniFile := TIniFile.Create(ChangeFileExt(Application.ExeName,'.ini'));
  ClientApi:= GetIBusinessAPI(false, IniFile.ReadString('ISAPI','URL',''));

  MasterRec:=TMasterRec.Create();
  MasterRec.Name:=IniFile.ReadString('Mekasron','Master','');
  MasterRec.Pwd:=IniFile.ReadString('Mekasron','PWD','');
  MasterRec.Uid:=IniFile.ReadInteger('Mekasron','UID',0);

  Reset;

end;

procedure TMainForm.BtnTestClick(Sender: TObject);
const
  pwdBlank='qwerty';
  defBusinessId=1;
  defInt=0;
  defStr='';
  defCountry='IL';
  OK='OK';
  CUSTOMER_EXISTS='Customer exists';
  RETURN_MESSAGE='ResultMessage';
var
  Msg:string;
  JSonValue:TJSonValue;
  NewEntity:integer;
begin
  Msg:=ClientApi.Entity_Add(MasterRec.Uid,MasterRec.Name,MasterRec.Pwd,defBusinessId,
    defInt,defInt,defStr,pwdBlank,defStr,defStr
    ,TestDB.CallbacksTableNumber.Value
    , defCountry,defInt);
  JsonValue := TJSonObject.ParseJSONValue(Msg);
  Msg:=JsonValue.GetValue<string>(RETURN_MESSAGE);
  if Msg.Equals(OK) OR Msg.Equals(CUSTOMER_EXISTS) then begin
    NewEntity := JsonValue.GetValue<integer>('EntityId');
    JsonValue.Free();
    Msg:=ClientApi.Telemarketing_add(MasterRec.Uid,MasterRec.Name,MasterRec.Pwd
      , defInt
      ,[NewEntity]
    );

    JsonValue := TJSonObject.ParseJSONValue(Msg);
    Msg:=JsonValue.GetValue<string>(RETURN_MESSAGE);
    JsonValue.Free;

    if Msg.Equals(OK) then begin
      TestDB.CallbacksTable.Edit;
      TestDB.CallbacksTableisExtracted.Value:=1;
      TestDB.CallbacksTable.Post;

      reset;
    end
    else begin
      MessageBox(handle,PChar(Msg),PChar(Caption),MB_OK);
    end;
  end
  else begin
    MessageBox(handle,PChar(Msg),PChar(Caption),MB_OK);
  end;
end;
end.
