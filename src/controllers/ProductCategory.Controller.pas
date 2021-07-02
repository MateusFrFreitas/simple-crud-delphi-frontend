unit ProductCategory.Controller;

interface

uses
  System.SysUtils, Main.Controller, ProductCategory.DTO;

type
  TProductCategoryController = class(TMainController)
    class procedure store(const ACategory: TProductCategoryDTO);
    class function index: TProductCategoriesDTO;
    class function show(const AId: Integer): TProductCategoryDTO;
    class procedure update(const ACategory: TProductCategoryDTO);
    class procedure delete(const AId: Integer); overload;
  end;

implementation

{ TProductController }

class procedure TProductCategoryController.store(const ACategory: TProductCategoryDTO);
var
  Response: TBaseResponse;
begin
  Response := Post('/product-categories', ACategory);
  try
    if (Response.Status <> 201) then
      raise Exception.Create('Resource not created!');
  finally
    Response.Clear;
  end;
end;

class function TProductCategoryController.index: TProductCategoriesDTO;
var
  Response: TBaseResponse;
  CategoriesDTO: TProductCategoriesDTO;
begin
  Response := Get('/product-categories');
  try
    CategoriesDTO := TProductCategoriesDTO.Create;
    try
      CategoriesDTO.AsJson := Response.Json;

      Result := CategoriesDTO;
    except
      on E: Exception do
      begin
        CategoriesDTO.Free;
        raise;
      end;
    end;
  finally
    Response.Clear;
  end;
end;

class function TProductCategoryController.show(const AId: Integer): TProductCategoryDTO;
var
  Response: TBaseResponse;
  CategoryDTO: TProductCategoryDTO;
begin
  Response := Get('/product-categories/' + IntToStr(AId));
  try
    if (Response.Status <> 200) then
      raise Exception.Create('Resource not found!');

    CategoryDTO := TProductCategoryDTO.Create;
    try
      CategoryDTO.AsJsonFrom['data'] := Response.Json;

      Result := CategoryDTO;
    except
      on E: Exception do
      begin
        CategoryDTO.Free;
        raise;
      end;
    end;
  finally
    Response.Clear;
  end;
end;

class procedure TProductCategoryController.update(const ACategory: TProductCategoryDTO);
var
  Response: TBaseResponse;
begin
  Response := Put('/product-categories/' + IntToStr(ACategory.Id), ACategory);
  try
    if (Response.Status <> 200) then
      raise Exception.Create('Resource not updated!');
  finally
    Response.Clear;
  end;
end;

class procedure TProductCategoryController.delete(const AId: Integer);
var
  Response: TBaseResponse;
begin
  Response := Delete('/product-categories/' + IntToStr(AId));
  try
    if (Response.Status <> 200) then
      raise Exception.Create('Resource not deleted!');
  finally
    Response.Clear;
  end;
end;

end.

