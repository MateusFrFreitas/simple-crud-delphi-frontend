object frmProduct: TfrmProduct
  Left = 0
  Top = 0
  Caption = 'Product'
  ClientHeight = 366
  ClientWidth = 716
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Padding.Left = 8
  Padding.Top = 8
  Padding.Right = 8
  Padding.Bottom = 8
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnClose = FormClose
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object DBGrid1: TDBGrid
    Left = 8
    Top = 49
    Width = 700
    Height = 239
    Align = alClient
    DataSource = dsProduct
    DrawingStyle = gdsGradient
    FixedColor = clInactiveCaption
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -13
    TitleFont.Name = 'Roboto'
    TitleFont.Pitch = fpFixed
    TitleFont.Style = [fsBold]
    Columns = <
      item
        Expanded = False
        FieldName = 'id'
        ReadOnly = True
        Title.Alignment = taCenter
        Width = 55
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'name'
        Title.Alignment = taCenter
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'price'
        Title.Alignment = taCenter
        Width = 126
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'productCategoryId'
        Title.Alignment = taCenter
        Width = 80
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'categoryList'
        Title.Alignment = taCenter
        Width = 128
        Visible = True
      end>
  end
  object Panel1: TPanel
    Left = 8
    Top = 8
    Width = 700
    Height = 41
    Align = alTop
    BevelOuter = bvNone
    Padding.Bottom = 4
    TabOrder = 0
    ExplicitWidth = 636
    object btnReload: TSpeedButton
      Left = 0
      Top = 0
      Width = 73
      Height = 37
      Align = alLeft
      Caption = 'Reload'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Roboto'
      Font.Style = [fsBold]
      Layout = blGlyphBottom
      ParentFont = False
      OnClick = btnReloadClick
      ExplicitHeight = 41
    end
    object lblTime: TLabel
      Left = 592
      Top = 14
      Width = 44
      Height = 13
      Caption = '00:00:00'
    end
    object Button1: TButton
      Left = 152
      Top = 9
      Width = 75
      Height = 25
      Caption = 'Button1'
      TabOrder = 0
      OnClick = Button1Click
    end
  end
  object Panel2: TPanel
    Left = 8
    Top = 288
    Width = 700
    Height = 70
    Align = alBottom
    TabOrder = 2
    object Button2: TButton
      Left = 72
      Top = 16
      Width = 75
      Height = 25
      Caption = 'Button2'
      TabOrder = 0
      OnClick = Button2Click
    end
  end
  object cdsProduct: TClientDataSet
    Aggregates = <>
    FieldDefs = <>
    IndexDefs = <
      item
        Name = 'cdsProductIndexId'
        Fields = 'id'
        Options = [ixPrimary]
      end>
    IndexName = 'cdsProductIndexId'
    Params = <>
    StoreDefs = True
    BeforePost = cdsProductBeforePost
    AfterPost = cdsProductAfterPost
    BeforeDelete = cdsProductBeforeDelete
    AfterDelete = cdsProductAfterDelete
    Left = 472
    Top = 176
    object cdsProductid: TIntegerField
      DisplayLabel = 'Id'
      FieldName = 'id'
    end
    object cdsProductname: TStringField
      DisplayLabel = 'Name'
      DisplayWidth = 20
      FieldName = 'name'
      Size = 100
    end
    object cdsProductprice: TFMTBCDField
      DisplayLabel = 'Price'
      FieldName = 'price'
      Size = 10
    end
    object cdsProductproductCategoryId: TIntegerField
      DisplayLabel = 'Category Id'
      FieldName = 'productCategoryId'
    end
    object cdsProductcategory2: TStringField
      DisplayLabel = 'Category Name'
      FieldKind = fkLookup
      FieldName = 'categoryList'
      LookupDataSet = cdsProductCategory
      LookupKeyFields = 'id'
      LookupResultField = 'name'
      KeyFields = 'productCategoryId'
      Size = 100
      Lookup = True
    end
  end
  object dsProduct: TDataSource
    DataSet = cdsProduct
    Left = 520
    Top = 192
  end
  object cdsProductCategory: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 272
    Top = 104
    object cdsProductCategoryid: TIntegerField
      DisplayLabel = 'Id'
      FieldName = 'id'
    end
    object cdsProductCategoryname: TStringField
      DisplayLabel = 'Name'
      FieldName = 'name'
      Size = 100
    end
  end
  object dsProductCategory: TDataSource
    DataSet = cdsProductCategory
    Left = 344
    Top = 120
  end
end
