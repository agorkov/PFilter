unit UFMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtDlgs, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.ComCtrls;

type
  TFMain = class(TForm)
    IIn: TImage;
    IOut: TImage;
    OPD: TOpenPictureDialog;
    BFilter: TButton;
    RGFilterSelect: TRadioGroup;
    GBFilterParams: TGroupBox;
    LEFilterN: TLabeledEdit;
    UDFilterN: TUpDown;
    UDFilterM: TUpDown;
    LEFilterM: TLabeledEdit;
    LTime: TLabel;
    LEFilterd: TLabeledEdit;
    UDFilterD: TUpDown;
    CBAddToOriginal: TCheckBox;
    BLinear: TButton;
    GBLinear: TGroupBox;
    LELinearK: TLabeledEdit;
    LELinearb: TLabeledEdit;
    GBLog: TGroupBox;
    BLog: TButton;
    LELogC: TLabeledEdit;
    BHist: TButton;
    SPD: TSaveDialog;
    BConvertToGreyscale: TButton;
    PCOperations: TPageControl;
    TSFilter: TTabSheet;
    TSGradation: TTabSheet;
    TSHistogram: TTabSheet;
    GBGamma: TGroupBox;
    BGamma: TButton;
    LEGammaC: TLabeledEdit;
    LEGammaGamma: TLabeledEdit;
    IHistR: TImage;
    IHistG: TImage;
    IHistB: TImage;
    BHistogram: TButton;
    procedure FormActivate(Sender: TObject);
    procedure IInDblClick(Sender: TObject);
    procedure BFilterClick(Sender: TObject);
    procedure IOutDblClick(Sender: TObject);
    procedure LEFilterNChange(Sender: TObject);
    procedure LEFilterMChange(Sender: TObject);
    procedure RGFilterSelectClick(Sender: TObject);
    procedure BLinearClick(Sender: TObject);
    procedure FormCanResize(Sender: TObject; var NewWidth, NewHeight: Integer; var Resize: Boolean);
    procedure BLogClick(Sender: TObject);
    procedure BGammaClick(Sender: TObject);
    procedure BHistClick(Sender: TObject);
    procedure IOutMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure BConvertToGreyscaleClick(Sender: TObject);
    procedure TSHistogramShow(Sender: TObject);
    procedure BHistogramClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FMain: TFMain;

implementation

{$R *.dfm}

uses
  Math, JPEG, UColorImages, UGrayscaleImages, UPixelConvert;

procedure TFMain.BFilterClick(Sender: TObject);
var
  T: TDateTime;
  FilterN, FilterM: byte;
  RGB: TCColorImage;
begin
  T := Now;
  LTime.Caption := 'Выполняется фильтрация...';
  FMain.Refresh;

  RGB := TCColorImage.Create;
  RGB.LoadFromBitMap(IIn.Picture.Bitmap);
  FilterN := StrToInt(LEFilterN.Text);
  FilterM := StrToInt(LEFilterM.Text);

  case RGFilterSelect.ItemIndex of
  0:
    begin
      RGB.AVGFilter(ccRed, FilterN, FilterM);
      RGB.AVGFilter(ccGreen, FilterN, FilterM);
      RGB.AVGFilter(ccBlue, FilterN, FilterM);
    end;
  1:
    begin
      RGB.WeightedAVGFilter(ccRed, FilterN, FilterM);
      RGB.WeightedAVGFilter(ccGreen, FilterN, FilterM);
      RGB.WeightedAVGFilter(ccBlue, FilterN, FilterM);
    end;
  2:
    begin
      RGB.GeometricMeanFilter(ccRed, FilterN, FilterM);
      RGB.GeometricMeanFilter(ccGreen, FilterN, FilterM);
      RGB.GeometricMeanFilter(ccBlue, FilterN, FilterM);
    end;
  3:
    begin
      RGB.MedianFilter(ccRed, FilterN, FilterM);
      RGB.MedianFilter(ccGreen, FilterN, FilterM);
      RGB.MedianFilter(ccBlue, FilterN, FilterM);
    end;
  4:
    begin
      RGB.MaxFilter(ccRed, FilterN, FilterM);
      RGB.MaxFilter(ccGreen, FilterN, FilterM);
      RGB.MaxFilter(ccBlue, FilterN, FilterM);
    end;
  5:
    begin
      RGB.MinFilter(ccRed, FilterN, FilterM);
      RGB.MinFilter(ccGreen, FilterN, FilterM);
      RGB.MinFilter(ccBlue, FilterN, FilterM);
    end;
  6:
    begin
      RGB.MiddlePointFilter(ccRed, FilterN, FilterM);
      RGB.MiddlePointFilter(ccGreen, FilterN, FilterM);
      RGB.MiddlePointFilter(ccBlue, FilterN, FilterM);
    end;
  7:
    begin
      RGB.TruncatedAVGFilter(ccRed, FilterN, FilterM, StrToInt(LEFilterd.Text));
      RGB.TruncatedAVGFilter(ccGreen, FilterN, FilterM, StrToInt(LEFilterd.Text));
      RGB.TruncatedAVGFilter(ccBlue, FilterN, FilterM, StrToInt(LEFilterd.Text));
    end;
  8:
    begin
      RGB.PrevittFilter(ccRed, CBAddToOriginal.Checked);
      RGB.PrevittFilter(ccGreen, CBAddToOriginal.Checked);
      RGB.PrevittFilter(ccBlue, CBAddToOriginal.Checked);
    end;
  9:
    begin
      RGB.SobelFilter(ccRed, CBAddToOriginal.Checked);
      RGB.SobelFilter(ccGreen, CBAddToOriginal.Checked);
      RGB.SobelFilter(ccBlue, CBAddToOriginal.Checked);
    end;
  10:
    begin
      RGB.SharrFilter(ccRed, CBAddToOriginal.Checked);
      RGB.SharrFilter(ccGreen, CBAddToOriginal.Checked);
      RGB.SharrFilter(ccBlue, CBAddToOriginal.Checked);
    end;
  11:
    begin
      RGB.LaplaceFilter(ccRed, CBAddToOriginal.Checked);
      RGB.LaplaceFilter(ccGreen, CBAddToOriginal.Checked);
      RGB.LaplaceFilter(ccBlue, CBAddToOriginal.Checked);
    end;
  end;
  IOut.Picture.Assign(RGB.SaveToBitMap);
  RGB.Free;

  LTime.Caption := 'Время фильтрации: ' + TimeToStr(Now - T);
end;

procedure TFMain.BGammaClick(Sender: TObject);

var
  T: TDateTime;
  c, gamma: double;
  RGB: TCColorImage;
begin
  T := Now;
  LTime.Caption := 'Выполняется фильтрация...';
  FMain.Refresh;

  RGB := TCColorImage.Create;
  RGB.LoadFromBitMap(IIn.Picture.Bitmap);
  c := strtofloat(LEGammaC.Text);
  gamma := strtofloat(LEGammaGamma.Text);
  RGB.GammaTransform(ccRed, c, gamma);
  RGB.GammaTransform(ccGreen, c, gamma);
  RGB.GammaTransform(ccBlue, c, gamma);
  IOut.Picture.Assign(RGB.SaveToBitMap);
  RGB.Free;

  LTime.Caption := 'Время фильтрации: ' + TimeToStr(Now - T);
end;

procedure TFMain.BHistClick(Sender: TObject);
var
  RGB: TCColorImage;
  T: TDateTime;
begin
  T := Now;
  LTime.Caption := 'Выполняется фильтрация...';
  FMain.Refresh;

  RGB := TCColorImage.Create;
  RGB.LoadFromBitMap(IIn.Picture.Bitmap);
  RGB.HistogramEqualization(ccRed);
  RGB.HistogramEqualization(ccGreen);
  RGB.HistogramEqualization(ccBlue);
  IOut.Picture.Assign(RGB.SaveToBitMap);

  LTime.Caption := 'Время фильтрации: ' + TimeToStr(Now - T);
end;

procedure TFMain.BHistogramClick(Sender: TObject);
var
  RGBI: TCColorImage;
  T: TDateTime;
begin
  T := Now;
  LTime.Caption := 'Выполняется фильтрация...';
  FMain.Refresh;
  RGBI := TCColorImage.Create;
  RGBI.LoadFromBitMap(IIn.Picture.Bitmap);
  IHistR.Picture.Assign(RGBI.Histogram(ccRed));
  IHistG.Picture.Assign(RGBI.Histogram(ccGreen));
  IHistB.Picture.Assign(RGBI.Histogram(ccBlue));
  LTime.Caption := 'Время фильтрации: ' + TimeToStr(Now - T);
end;

procedure TFMain.BLinearClick(Sender: TObject);
var
  T: TDateTime;
  k, B: double;
  RGB: TCColorImage;
begin
  T := Now;
  LTime.Caption := 'Выполняется фильтрация...';
  FMain.Refresh;

  RGB := TCColorImage.Create;
  RGB.LoadFromBitMap(IIn.Picture.Bitmap);
  k := strtofloat(LELinearK.Text);
  B := strtofloat(LELinearb.Text);
  RGB.LinearTransform(ccRed, k, B);
  RGB.LinearTransform(ccGreen, k, B);
  RGB.LinearTransform(ccBlue, k, B);
  IOut.Picture.Assign(RGB.SaveToBitMap);
  RGB.Free;

  LTime.Caption := 'Время фильтрации: ' + TimeToStr(Now - T);
end;

procedure TFMain.BLogClick(Sender: TObject);
var
  T: TDateTime;
  c: double;
  RGB: TCColorImage;
begin
  T := Now;
  LTime.Caption := 'Выполняется фильтрация...';
  FMain.Refresh;

  RGB := TCColorImage.Create;
  RGB.LoadFromBitMap(IIn.Picture.Bitmap);
  c := strtofloat(LELogC.Text);
  RGB.LogTransform(ccRed, c);
  RGB.LogTransform(ccGreen, c);
  RGB.LogTransform(ccBlue, c);
  IOut.Picture.Assign(RGB.SaveToBitMap);
  RGB.Free;

  LTime.Caption := 'Время фильтрации: ' + TimeToStr(Now - T);
end;

procedure TFMain.BConvertToGreyscaleClick(Sender: TObject);
var
  T: TDateTime;
  GS: TCGrayscaleImage;
begin
  T := Now;
  LTime.Caption := 'Выполняется фильтрация...';
  FMain.Refresh;
  GS := TCGrayscaleImage.Create;
  GS.LoadFromBitMap(IIn.Picture.Bitmap);
  IOut.Picture.Assign(GS.SaveToBitMap);
  GS.Free;
  LTime.Caption := 'Время фильтрации: ' + TimeToStr(Now - T);
end;

procedure TFMain.FormActivate(Sender: TObject);
begin
  IIn.Canvas.Rectangle(1, 1, IIn.Width, IIn.Height);
  IOut.Canvas.Rectangle(1, 1, IOut.Width, IOut.Height);
end;

procedure TFMain.FormCanResize(Sender: TObject; var NewWidth, NewHeight: Integer; var Resize: Boolean);
begin
  Resize := false;
end;

procedure JPEGtoBMP(const FileName: TFileName);
var
  JPEG: TJPEGImage;
  bmp: TBitmap;
begin
  JPEG := TJPEGImage.Create;
  try
    JPEG.CompressionQuality := 100;
    JPEG.LoadFromFile(FileName);
    bmp := TBitmap.Create;
    try
      bmp.Assign(JPEG);
      bmp.SaveToFile(ChangeFileExt(FileName, '.bmp'));
    finally
      bmp.Free
    end;
  finally
    JPEG.Free
  end;
end;

procedure TFMain.IInDblClick(Sender: TObject);
var
  str: string;
  fl: Boolean;
begin
  fl := false;
  if OPD.Execute then
  begin
    str := ANSIUpperCase(OPD.FileName);
    if (ExtractFileExt(str) = '.JPG') or (ExtractFileExt(str) = '.JPEG') then
    begin
      JPEGtoBMP(str);
      str := ChangeFileExt(str, '.bmp');
      fl := true;
    end;
    IIn.Picture.LoadFromFile(str);
    if fl then
      DeleteFile(str);
  end;
end;

procedure TFMain.IOutDblClick(Sender: TObject);
var
  BM: TBitmap;
begin
  BM := TBitmap.Create;
  BM.Assign(IOut.Picture);
  IIn.Picture.Assign(BM);
  BM.Free;
end;

procedure TFMain.IOutMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if ssCtrl in Shift then
    if SPD.Execute then
      IOut.Picture.SaveToFile(SPD.FileName);
end;

procedure TFMain.LEFilterMChange(Sender: TObject);
var
  FilterN, FilterM: word;
begin
  FilterN := StrToInt(LEFilterN.Text);
  FilterM := StrToInt(LEFilterM.Text);
  FilterN := 2 * FilterN + 1;
  FilterM := 2 * FilterM + 1;
  LEFilterd.Text := inttostr(FilterN * FilterM div 3);
  UDFilterD.Max := (FilterN * FilterM - 1) div 2;
end;

procedure TFMain.LEFilterNChange(Sender: TObject);
var
  FilterN, FilterM: word;
begin
  FilterN := StrToInt(LEFilterN.Text);
  FilterM := StrToInt(LEFilterM.Text);
  FilterN := 2 * FilterN + 1;
  FilterM := 2 * FilterM + 1;
  LEFilterd.Text := inttostr(FilterN * FilterM div 3);
  UDFilterD.Max := (FilterN * FilterM - 1) div 2;
end;

procedure TFMain.RGFilterSelectClick(Sender: TObject);
begin

  LEFilterd.Visible := false;
  UDFilterD.Visible := false;
  CBAddToOriginal.Visible := false;
  if RGFilterSelect.ItemIndex = 7 then
  begin
    LEFilterd.Visible := true;
    UDFilterD.Visible := true;
  end;
  if RGFilterSelect.ItemIndex > 7 then
    CBAddToOriginal.Visible := true;
end;

procedure TFMain.TSHistogramShow(Sender: TObject);
begin
  BHistogramClick(nil);
end;

end.
