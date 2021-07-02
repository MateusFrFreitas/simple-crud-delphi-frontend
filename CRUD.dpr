program CRUD;

uses
  Vcl.Forms,
  SysUtils,
  Main in 'Main.pas' {frmMain},
  Splash in 'Splash.pas' {frmSplash},
  Pkg.Json.DTO in 'src\packages\Pkg.Json.DTO.pas',
  Product.Controller in 'src\controllers\Product.Controller.pas',
  Product.DTO in 'src\dto\Product.DTO.pas',
  Main.Controller in 'src\controllers\Main.Controller.pas',
  ProductCategory.DTO in 'src\dto\ProductCategory.DTO.pas',
  ProductCategory.Controller in 'src\controllers\ProductCategory.Controller.pas',
  untProduct in 'src\forms\untProduct.pas' {frmProduct},
  DataSetConverter4D.Helper in 'src\packages\DataSetConverter4Delphi\DataSetConverter4D.Helper.pas',
  DataSetConverter4D.Impl in 'src\packages\DataSetConverter4Delphi\DataSetConverter4D.Impl.pas',
  DataSetConverter4D in 'src\packages\DataSetConverter4Delphi\DataSetConverter4D.pas',
  DataSetConverter4D.Util in 'src\packages\DataSetConverter4Delphi\DataSetConverter4D.Util.pas',
  Main.DTO in 'src\dto\Main.DTO.pas';

{$R *.res}

begin
  ReportMemoryLeaksOnShutdown := DebugHook <> 0;

  frmSplash := TfrmSplash.Create(Application);

  frmSplash.Show;
  frmSplash.Update;

  Sleep(2000);

  Application.Initialize;
  Application.MainFormOnTaskbar := True;

  Application.CreateForm(TfrmMain, frmMain);

  frmSplash.Hide;
  frmSplash.Free;

  Application.Run;
end.

