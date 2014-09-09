program PFilter;

uses
  Vcl.Forms,
  UFMain in 'UFMain.pas' {FMain},
  UPixelConvert in 'D:\ImgSharedUnits\src\UPixelConvert.pas',
  UColorImages in 'D:\ImgSharedUnits\src\UColorImages.pas',
  UGrayscaleImages in 'D:\ImgSharedUnits\src\UGrayscaleImages.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFMain, FMain);
  Application.Run;

end.
