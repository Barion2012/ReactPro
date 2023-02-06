program Test;

uses
  Vcl.Forms,
  TestDelphi in 'TestDelphi.pas' {MainForm},
  MySqlData in 'MySqlData.pas' {TestDB: TDataModule},
  IBusinessAPI1 in 'IBusinessAPI1.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TMainForm, MainForm);
  Application.CreateForm(TTestDB, TestDB);
  Application.Run;
end.
