program PFilter;

uses
  Vcl.Forms,
  UFMain in 'UFMain.pas' {FMain},
  UImages in 'D:\ImgSharedUnits\src\UImages.pas',
  UPixelConvert in 'D:\ImgSharedUnits\src\UPixelConvert.pas',
  UFilter in 'D:\ImgSharedUnits\src\UFilter.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFMain, FMain);
  Application.Run;

end.
