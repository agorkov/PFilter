program PFilter;

uses
  Vcl.Forms,
  UColorImages in 'D:\ImgSharedUnits\src\UColorImages.pas',
  UGrayscaleImages in 'D:\ImgSharedUnits\src\UGrayscaleImages.pas',
  UPixelConvert in 'D:\ImgSharedUnits\src\UPixelConvert.pas',
  UFileConvert in 'D:\ImgSharedUnits\src\UFileConvert.pas',
  UFFilter in 'UFFilter.pas' {FFilter};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFFilter, FFilter);
  Application.CreateForm(TFFilter, FFilter);
  Application.Run;

end.
