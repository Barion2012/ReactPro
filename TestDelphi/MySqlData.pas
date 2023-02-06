unit MySqlData;

interface

uses
  System.SysUtils, System.Classes
  , Vcl.Forms
  , Data.DB  ,mySQLDbTables;

type
  TTestDB = class(TDataModule)
    TestDB: TMySQLDatabase;
    CallbacksTable: TMySQLTable;
    CallackID: TAutoIncField;
    CallbacksTableDate: TDateTimeField;
    CallbacksTableDID: TWideStringField;
    CallbacksTableCID: TWideStringField;
    CallbacksTableNumber: TWideStringField;
    CallbacksTableConfirmed: TIntegerField;
    CallbacksTableLanguage: TWideMemoField;
    CallbacksTablePrefix: TWideMemoField;
    CallbacksTableisExtracted: TIntegerField;
    Destructor  Destroy; override;
  public
    function Test():string;
    function Connect():boolean;
  private
    procedure Disconn();
  end;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

function TTestDB.Connect():boolean;
begin

  if not TestDB.Connected then begin
     TestDB.Params.Clear;
     TestDB.Params.LoadFromFile(ChangeFileExt(Application.ExeName,'.ini'));
     TestDB.Open;
  end;

  if not CallbacksTable.Active then
    CallbacksTable.Open;

  Result:=TestDB.Connected AND CallbacksTable.Active;

end;


procedure TTestDB.Disconn();
begin
  if CallbacksTable.Active then
    CallbacksTable.Active:=false;
  if TestDB.Connected then
    TestDB.Connected:=false;
end;

destructor TTestDB.Destroy;
begin
  Disconn();
  inherited;
end;



function TTestDB.Test():string;

begin
  if Connect() then begin

    if CallbacksTable.FindFirst then begin
        Result:= Format('There is %d unconfirmed callbacks in the moment.',
          [CallbacksTable.RecordCount]);
        {CallbacksTable.Edit;
        CallbacksTableConfirmed.Value:=1;
        CallbacksTable.Post;}
    end
    else begin
        Result:= 'There isn''t not unconfirmed callbacks in the moment.'

    end;

  end;

end;



end.
