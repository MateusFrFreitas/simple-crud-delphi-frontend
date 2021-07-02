unit ProductCategory.DTO;

interface

uses
  System.SysUtils, Main.DTO;

{$M+}

type
  TProductCategoryDTO = class(TDTO)
  strict private
    FId: Integer;
    FName: string;
  published
    property Id: Integer read FId write FId;
    property Name: string read FName write FName;
  end;

  TProductCategoriesDTO = class(TDTOList<TProductCategoryDTO>);

implementation

end.

