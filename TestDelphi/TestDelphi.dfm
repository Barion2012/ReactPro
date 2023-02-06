object MainForm: TMainForm
  Left = 0
  Top = 0
  Caption = 'TestDelphi'
  ClientHeight = 299
  ClientWidth = 635
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnActivate = Activate
  PixelsPerInch = 96
  TextHeight = 13
  object LblTest: TLabel
    Left = 40
    Top = 40
    Width = 34
    Height = 13
    Caption = 'LblTest'
  end
  object BtnTest: TButton
    Left = 488
    Top = 266
    Width = 139
    Height = 25
    Caption = 'Do Test'
    TabOrder = 0
    OnClick = BtnTestClick
  end
end
