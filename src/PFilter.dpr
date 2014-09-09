program PFilter;

uses
  Vcl.Forms,
  UFMain in 'UFMain.pas' {FMain},
  UBinarization in '..\..\ImgSharedUnits\src\UBinarization.pas',
  UBinaryImages in '..\..\ImgSharedUnits\src\UBinaryImages.pas',
  UFilter in '..\..\ImgSharedUnits\src\UFilter.pas',
  UGrayscaleImages in '..\..\ImgSharedUnits\src\UGrayscaleImages.pas',
  UMorphology in '..\..\ImgSharedUnits\src\UMorphology.pas',
  UPixelConvert in '..\..\ImgSharedUnits\src\UPixelConvert.pas',
  URGBImages in '..\..\ImgSharedUnits\src\URGBImages.pas',
  UColorImages in 'UColorImages.pas',
  UGrayscale in 'UGrayscale.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFMain, FMain);
  Application.Run;

end.
