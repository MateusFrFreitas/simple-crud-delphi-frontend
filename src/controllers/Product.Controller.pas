unit Product.Controller;

interface

uses
  System.SysUtils, Main.Controller, Product.DTO;

type
  TProductController = class(TMainController)
    class procedure store(const AProduct: TProductDTO);
    class function index: TProductsDTO;
    class function show(const AId: Integer): TProductDTO;
    class procedure update(const AProduct: TProductDTO);
    class procedure delete(const AId: Integer); overload;
  end;

implementation

{ TProductController }

class procedure TProductController.store(const AProduct: TProductDTO);
var
  Response: TBaseResponse;
begin
  Response := Post('/products', AProduct);
  try
    if (Response.Status <> 201) then
      raise Exception.Create('Resource not created!');

    AProduct.AsJsonFrom['data'] := Response.Json;
  finally
    Response.Clear;
  end;
end;

class function TProductController.index: TProductsDTO;
var
  Response: TBaseResponse;
  ProductsDTO: TProductsDTO;
begin
  Response := Get('/products');
  try
    ProductsDTO := TProductsDTO.Create;
    try
      ProductsDTO.AsJson := Response.Json;

      Result := ProductsDTO;
    except
      on E: Exception do
      begin
        ProductsDTO.Free;
        raise;
      end;
    end;
  finally
    Response.Clear;
  end;
end;

class function TProductController.show(const AId: Integer): TProductDTO;
var
  Response: TBaseResponse;
  ProductDTO: TProductDTO;
begin
  Response := Get('/products/' + IntToStr(AId));
  try
    if (Response.Status <> 200) then
      raise Exception.Create('Resource not found!');

    ProductDTO := TProductDTO.Create;
    try
      ProductDTO.AsJsonFrom['data'] := Response.Json;

      Result := ProductDTO;
    except
      on E: Exception do
      begin
        ProductDTO.Free;
        raise;
      end;
    end;
  finally
    Response.Clear;
  end;
end;

class procedure TProductController.update(const AProduct: TProductDTO);
var
  Response: TBaseResponse;
begin
  Response := Put('/products/' + IntToStr(AProduct.Id), AProduct);
  try
    if (Response.Status <> 200) then
      raise Exception.Create('Resource not updated!');
  finally
    Response.Clear;
  end;
end;

class procedure TProductController.delete(const AId: Integer);
var
  Response: TBaseResponse;
begin
  Response := Delete('/products/' + IntToStr(AId));
  try
    if (Response.Status <> 200) then
      raise Exception.Create('Resource not deleted!');
  finally
    Response.Clear;
  end;
end;

end.

