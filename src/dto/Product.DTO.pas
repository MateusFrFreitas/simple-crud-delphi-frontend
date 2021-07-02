unit Product.DTO;

interface

uses
  System.SysUtils, Main.DTO;

{$M+}

type
  TProductDTO = class(TDTO)
  strict private
    FId: Integer;
    FName: string;
    FPrice: Extended;
    FProductCategoryId: Integer;
  published
    property Id: Integer read FId write FId;
    property Name: string read FName write FName;
    property Price: Extended read FPrice write FPrice;
    property ProductCategoryId: Integer read FProductCategoryId write FProductCategoryId;
  end;

  TProductsDTO = class sealed(TDTOList<TProductDTO>);

implementation

end.

