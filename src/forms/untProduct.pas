unit untProduct;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB,
  Vcl.Grids, Vcl.DBGrids, Vcl.DBCtrls, Vcl.StdCtrls, Vcl.Mask, Datasnap.DBClient,
  DataSetConverter4D.Impl, System.Json, System.Win.TaskbarCore, Vcl.Taskbar,
  Vcl.Buttons, Vcl.ExtCtrls;

type
  TfrmProduct = class(TForm)
    cdsProduct: TClientDataSet;
    cdsProductid: TIntegerField;
    cdsProductproductCategoryId: TIntegerField;
    dsProduct: TDataSource;
    DBGrid1: TDBGrid;
    cdsProductname: TStringField;
    cdsProductCategory: TClientDataSet;
    cdsProductCategoryid: TIntegerField;
    cdsProductCategoryname: TStringField;
    dsProductCategory: TDataSource;
    cdsProductcategory2: TStringField;
    Panel1: TPanel;
    btnReload: TSpeedButton;
    cdsProductprice: TFMTBCDField;
    Button1: TButton;
    lblTime: TLabel;
    Panel2: TPanel;
    Button2: TButton;
    procedure FormShow(Sender: TObject);
    procedure cdsProductBeforePost(DataSet: TDataSet);
    procedure cdsProductAfterPost(DataSet: TDataSet);
    procedure cdsProductBeforeDelete(DataSet: TDataSet);
    procedure btnReloadClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure cdsProductAfterDelete(DataSet: TDataSet);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    procedure LoadProductCategories;
    procedure LoadProducts;
    procedure Load;

    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmProduct: TfrmProduct;

implementation

uses
  Product.Controller, Product.DTO, ProductCategory.Controller,
  ProductCategory.DTO;

{$R *.dfm}

(*

  http://docwiki.embarcadero.com/RADStudio/Sydney/en/Defining_a_Lookup_Field

*)

procedure TfrmProduct.btnReloadClick(Sender: TObject);
begin
  Load;
end;

procedure TfrmProduct.Button1Click(Sender: TObject);
var
  I: Integer;
begin
  cdsProduct.AfterPost := nil;
  try
    for I := 1 to 200 do
    begin
      cdsProduct.Insert;
      try
        cdsProductname.AsString := 'Product ' + IntToStr(I);
        cdsProductprice.AsBCD := Random * 10000 + 0.01;
        cdsProductproductCategoryId.AsInteger := I;

        cdsProduct.Post;
      except
        on E: Exception do
        begin
          cdsProduct.Cancel;
          raise;
        end;
      end;
    end;
  finally
    cdsProduct.AfterPost := cdsProductAfterPost;
  end;
end;

procedure TfrmProduct.Button2Click(Sender: TObject);
begin
  TProductController.show(cdsProductid.AsInteger);
end;

procedure TfrmProduct.cdsProductAfterDelete(DataSet: TDataSet);
begin
  Load;
end;

procedure TfrmProduct.cdsProductAfterPost(DataSet: TDataSet);
begin
  Load;
end;

procedure TfrmProduct.cdsProductBeforeDelete(DataSet: TDataSet);
begin
  if (DataSet.FieldByName('id').AsInteger <> 0) then
    TProductController.delete(DataSet.FieldByName('id').AsInteger);
end;

procedure TfrmProduct.cdsProductBeforePost(DataSet: TDataSet);
var
  jo: TJSONObject;
  ProductDTO: TProductDTO;
begin
  jo := TConverter.New.DataSet.Source(DataSet).AsJSONObject;
  try
    ProductDTO := TProductDTO.Create;
    try
      ProductDTO.AsJson := jo.ToString;

      if (ProductDTO.Id <> 0) then
        TProductController.update(ProductDTO);

      if (ProductDTO.Id = 0) then
      begin
        TProductController.store(ProductDTO);
        DataSet.FieldByName('id').AsInteger := ProductDTO.Id;
      end;
    finally
      FreeAndNil(ProductDTO);
    end;
  finally
    jo.Free;
  end;
end;

procedure TfrmProduct.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
  Self := nil;
end;

procedure TfrmProduct.FormShow(Sender: TObject);
begin
  cdsProductCategory.CreateDataSet;
  cdsProduct.CreateDataSet;

  Load;
end;

procedure TfrmProduct.LoadProductCategories;
var
  Categories: TProductCategoriesDTO;
  ja: TJSONArray;
begin
  cdsProductCategory.EmptyDataSet;

  Categories := TProductCategoryController.index;
  try
    ja := TJSONObject.ParseJSONValue(TEncoding.ASCII.GetBytes(Categories.AsJsonArray), 0) as TJSONArray;
    try
      TConverter.New.JSON.Source(ja).ToDataSet(cdsProductCategory);
    finally
      ja.Free;
    end;
  finally
    Categories.Free;
  end;
end;

procedure TfrmProduct.LoadProducts;
var
  Products: TProductsDTO;
  ja: TJSONArray;
  i: Integer;
  start: TDateTime;
begin
  start := now;

  Products := TProductController.index;
  try
    ja := TJSONObject.ParseJSONValue(TEncoding.ASCII.GetBytes(Products.AsJsonArray), 0) as TJSONArray;
    try
      cdsProduct.BeforePost := nil;
      cdsProduct.AfterPost := nil;
      cdsProduct.DisableControls;
      try
        i := cdsProduct.RecNo;

        cdsProduct.EmptyDataSet;

        TConverter.New.JSON.Source(ja).ToDataSet(cdsProduct);

        if (i > 0) then
          cdsProduct.RecNo := i;
      finally
        cdsProduct.BeforePost := cdsProductBeforePost;
        cdsProduct.AfterPost := cdsProductAfterPost;
        cdsProduct.EnableControls;
      end;
    finally
      ja.Free;
    end;
  finally
    Products.Free;
  end;

  lblTime.Caption := FormatDateTime('HH:MM:SS', Now - start);
end;

procedure TfrmProduct.Load;
begin
  LoadProductCategories;
  LoadProducts;
end;

initialization
  RegisterClass(TfrmProduct);

end.

