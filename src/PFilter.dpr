program PFilter;

uses
  Vcl.Forms,
  UFMain in 'UFMain.pas' {Form1},
  UFilter in 'UFilter.pas',
  UImages in '..\..\ImgSharedUnits\src\UImages.pas',
  UPixelConvert in '..\..\ImgSharedUnits\src\UPixelConvert.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;

end.
