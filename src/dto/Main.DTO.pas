unit Main.DTO;

interface

uses
  Windows, System.Generics.Collections, System.SysUtils, System.Classes,
  System.JSON, REST.Json.Types, REST.Json, Pkg.Json.DTO;

{$M+}

type
  TDTO = class(TJsonDTO)
  private
    function FindValue(const APath: string): string;

    { Getters / Setters }
    function GetAsJsonFrom(const APath: string): string;
    procedure SetAsJsonFrom(const APath, AJson: string);
  public
    property AsJsonFrom[const APath: string]: string read GetAsJsonFrom write SetAsJsonFrom;
  end;

  TDTOList<T: TDTO> = class(TDTO)
  strict private
    FData: TArray<T>;
  public
    destructor Destroy; override;
    function AsJsonArray: string;
    procedure Add(const AItem: T);
    function Count: Integer;
  published
    property Data: TArray<T> read FData write FData;
  end;

implementation

{ TDTO }

function TDTO.FindValue(const APath: string): string;
begin
  with TJSONObject.ParseJSONValue(Self.AsJson) do
  begin
    try
      Result := FindValue(APath).ToJSON;
    finally
      Free;
    end;
  end;
end;

function TDTO.GetAsJsonFrom(const APath: string): string;
begin
  with TJSONObject.ParseJSONValue(Self.AsJson) do
  begin
    try
      Result := FindValue(APath).ToJSON;
    finally
      Free;
    end;
  end;
end;

procedure TDTO.SetAsJsonFrom(const APath, AJson: string);
begin
  with TJSONObject.ParseJSONValue(AJson) do
  begin
    try
      Self.AsJson := FindValue(APath).ToJSON;
    finally
      Free;
    end;
  end;
end;

{ TDTOList<T> }

destructor TDTOList<T>.Destroy;
var
  Element: TObject;
begin
  for Element in FData do
    Element.Free;

  inherited;
end;

function TDTOList<T>.AsJsonArray: string;
begin
  Result := Self.FindValue('data');
end;

procedure TDTOList<T>.Add(const AItem: T);
begin
  Data := Data + [AItem];
end;

function TDTOList<T>.Count: Integer;
begin
  Result := Length(FData);
end;

end.

