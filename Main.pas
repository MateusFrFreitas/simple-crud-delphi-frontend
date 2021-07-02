unit Main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.StdCtrls, Vcl.Menus;

type
  TfrmMain = class(TForm)
    MainMenu1: TMainMenu;
    CRUD: TMenuItem;
    Product: TMenuItem;
    Button1: TButton;
    procedure ProductClick(Sender: TObject);
  private
    function FormExists(const AForm: TForm): Boolean;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmMain: TfrmMain;

implementation

uses
  Product.DTO, Product.Controller, untProduct;

{$R *.dfm}

procedure TfrmMain.ProductClick(Sender: TObject);
begin
  if (FormExists(frmProduct)) then
    Exit;

  frmProduct := TfrmProduct.Create(Self);
  frmProduct.Show;
end;

function TfrmMain.FormExists(const AForm: TForm): Boolean;
var
  i: Word;
begin
  Result := False;
  for i := 0 to Screen.FormCount - 1 do
  begin
    if (Screen.Forms[i] = AForm) then
    begin
      Result := True;
      Break;
    end;
  end;
end;

end.

