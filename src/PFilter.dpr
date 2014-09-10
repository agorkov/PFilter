program PFilter;

uses
  Vcl.Forms,
  UFMain in 'UFMain.pas' {FMain},
  UColorImages in '..\..\ImgSharedUnits\src\UColorImages.pas',
  UGrayscaleImages in '..\..\ImgSharedUnits\src\UGrayscaleImages.pas',
  UPixelConvert in '..\..\ImgSharedUnits\src\UPixelConvert.pas',
  UFileConvert in '..\..\ImgSharedUnits\src\UFileConvert.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFMain, FMain);
  Application.Run;

end.
