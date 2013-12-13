program PFilter;

uses
  Vcl.Forms, UFMain in 'UFMain.pas' {Form1} , UImages in 'D:\ImgSharedUnits\src\UImages.pas', UPixelConvert in 'D:\ImgSharedUnits\src\UPixelConvert.pas', UFilter in 'UFilter.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;

end.
