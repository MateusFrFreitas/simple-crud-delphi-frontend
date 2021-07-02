object frmMain: TfrmMain
  Left = 0
  Top = 0
  Caption = 'CRUD'
  ClientHeight = 299
  ClientWidth = 545
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Button1: TButton
    Left = 88
    Top = 152
    Width = 75
    Height = 25
    Caption = 'Button1'
    TabOrder = 0
  end
  object MainMenu1: TMainMenu
    Left = 88
    object CRUD: TMenuItem
      Caption = 'CRUD'
      object Product: TMenuItem
        Caption = 'Product'
        OnClick = ProductClick
      end
    end
  end
end
