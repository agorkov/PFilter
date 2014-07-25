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
  URGBImages, UGrayscaleImages, UFilter, Math, JPEG;

procedure TFMain.BFilterClick(Sender: TObject);
var
  RGBI: TRGBImage;
  BM: TBitmap;
  FilterN, FilterM: byte;
  T: TDateTime;
begin
  LTime.Caption := 'Выполняется фильтрация...';
  FMain.Refresh;
  BM := TBitmap.Create;
  BM.Assign(IIn.Picture);
  RGBI := LoadRGBIFromBitMap(BM);
  BM.Free;
  FilterN := StrToInt(LEFilterN.Text);
  FilterM := StrToInt(LEFilterM.Text);
  T := Now;
  case RGFilterSelect.ItemIndex of
  0:
    begin
      AVGFilter(RGBI.R, FilterN, FilterM);
      AVGFilter(RGBI.G, FilterN, FilterM);
      AVGFilter(RGBI.B, FilterN, FilterM);
    end;
  1:
    begin
      UFilter.WeightedAVGFilter(RGBI.R, FilterN, FilterM);
      UFilter.WeightedAVGFilter(RGBI.G, FilterN, FilterM);
      UFilter.WeightedAVGFilter(RGBI.B, FilterN, FilterM);
    end;
  2:
    begin
      UFilter.GeometricMeanFilter(RGBI.R, FilterN, FilterM);
      UFilter.GeometricMeanFilter(RGBI.G, FilterN, FilterM);
      UFilter.GeometricMeanFilter(RGBI.B, FilterN, FilterM);
    end;
  3:
    begin
      UFilter.MedianFilter(RGBI.R, FilterN, FilterM);
      UFilter.MedianFilter(RGBI.G, FilterN, FilterM);
      UFilter.MedianFilter(RGBI.B, FilterN, FilterM);
    end;
  4:
    begin
      UFilter.MaxFilter(RGBI.R, FilterN, FilterM);
      UFilter.MaxFilter(RGBI.G, FilterN, FilterM);
      UFilter.MaxFilter(RGBI.B, FilterN, FilterM);
    end;
  5:
    begin
      UFilter.MinFilter(RGBI.R, FilterN, FilterM);
      UFilter.MinFilter(RGBI.G, FilterN, FilterM);
      UFilter.MinFilter(RGBI.B, FilterN, FilterM);
    end;
  6:
    begin
      UFilter.MiddlePointFilter(RGBI.R, FilterN, FilterM);
      UFilter.MiddlePointFilter(RGBI.G, FilterN, FilterM);
      UFilter.MiddlePointFilter(RGBI.B, FilterN, FilterM);
    end;
  7:
    begin
      UFilter.TruncatedAVGFilter(RGBI.R, FilterN, FilterM, StrToInt(LEFilterd.Text));
      UFilter.TruncatedAVGFilter(RGBI.G, FilterN, FilterM, StrToInt(LEFilterd.Text));
      UFilter.TruncatedAVGFilter(RGBI.B, FilterN, FilterM, StrToInt(LEFilterd.Text));
    end;
  8:
    begin
      UFilter.PrevittFilter(RGBI.R, CBAddToOriginal.Checked);
      UFilter.PrevittFilter(RGBI.G, CBAddToOriginal.Checked);
      UFilter.PrevittFilter(RGBI.B, CBAddToOriginal.Checked);
    end;
  9:
    begin
      UFilter.SobelFilter(RGBI.R, CBAddToOriginal.Checked);
      UFilter.SobelFilter(RGBI.G, CBAddToOriginal.Checked);
      UFilter.SobelFilter(RGBI.B, CBAddToOriginal.Checked);
    end;
  10:
    begin
      UFilter.SharrFilter(RGBI.R, CBAddToOriginal.Checked);
      UFilter.SharrFilter(RGBI.G, CBAddToOriginal.Checked);
      UFilter.SharrFilter(RGBI.B, CBAddToOriginal.Checked);
    end;
  11:
    begin
      UFilter.LaplaceFilter(RGBI.R, CBAddToOriginal.Checked);
      UFilter.LaplaceFilter(RGBI.G, CBAddToOriginal.Checked);
      UFilter.LaplaceFilter(RGBI.B, CBAddToOriginal.Checked);
    end;
  end;
  BM := SaveRGBImgToBitMap(RGBI);
  IOut.Picture.Assign(BM);
  BM.Free;
  LTime.Caption := 'Время фильтрации: ' + TimeToStr(Now - T);
end;

procedure TFMain.BGammaClick(Sender: TObject);

var
  RGBI: TRGBImage;
  BM: TBitmap;
  T: TDateTime;
  c, gamma: double;
begin
  T := Now;
  LTime.Caption := 'Выполняется фильтрация...';
  FMain.Refresh;
  BM := TBitmap.Create;
  BM.Assign(IIn.Picture);
  RGBI := LoadRGBIFromBitMap(BM);
  BM.Free;
  c := strtofloat(LEGammaC.Text);
  gamma := strtofloat(LEGammaGamma.Text);
  GammaTransform(RGBI.R, c, gamma);
  GammaTransform(RGBI.G, c, gamma);
  GammaTransform(RGBI.B, c, gamma);
  BM := SaveRGBImgToBitMap(RGBI);
  IOut.Picture.Assign(BM);
  BM.Free;
  LTime.Caption := 'Время фильтрации: ' + TimeToStr(Now - T);
end;

procedure TFMain.BHistClick(Sender: TObject);
var
  { RGBI: UImages.TGreyscaleImage;
    BM: TBitmap;
    T: TDateTime; }
  RGB: TRGBImage;
  T: TDateTime;
  BM: TBitmap;
begin
  T := Now;
  LTime.Caption := 'Выполняется фильтрация...';
  FMain.Refresh;
  BM := TBitmap.Create;
  BM.Assign(IIn.Picture);
  RGB := LoadRGBIFromBitMap(BM);
  BM.Free;
  HistogramEqualization(RGB.R);
  HistogramEqualization(RGB.G);
  HistogramEqualization(RGB.B);
  BM := SaveRGBImgToBitMap(RGB);
  IOut.Picture.Assign(BM);
  BM.Free;
  LTime.Caption := 'Время фильтрации: ' + TimeToStr(Now - T);
end;

procedure TFMain.BHistogramClick(Sender: TObject);
var
  RGBI: TRGBImage;
  BM: TBitmap;
  T: TDateTime;
begin
  T := Now;
  LTime.Caption := 'Выполняется фильтрация...';
  FMain.Refresh;
  BM := TBitmap.Create;
  BM.Assign(IIn.Picture);
  RGBI := LoadRGBIFromBitMap(BM);
  BM.Free;
  BM := UFilter.Histogram(RGBI, 1);
  IHistR.Picture.Assign(BM);
  BM.Free;
  BM := UFilter.Histogram(RGBI, 2);
  IHistG.Picture.Assign(BM);
  BM.Free;
  BM := UFilter.Histogram(RGBI, 3);
  IHistB.Picture.Assign(BM);
  BM.Free;
  LTime.Caption := 'Время фильтрации: ' + TimeToStr(Now - T);
end;

procedure TFMain.BLinearClick(Sender: TObject);
var
  RGB: TRGBImage;
  BM: TBitmap;
  T: TDateTime;
  k, B: double;
begin
  T := Now;
  LTime.Caption := 'Выполняется фильтрация...';
  FMain.Refresh;
  BM := TBitmap.Create;
  BM.Assign(IIn.Picture);
  RGB := LoadRGBIFromBitMap(BM);
  BM.Free;
  k := strtofloat(LELinearK.Text);
  B := strtofloat(LELinearb.Text);
  LinearTransform(RGB.R, k, B);
  LinearTransform(RGB.G, k, B);
  LinearTransform(RGB.B, k, B);
  BM := SaveRGBImgToBitMap(RGB);
  IOut.Picture.Assign(BM);
  BM.Free;
  LTime.Caption := 'Время фильтрации: ' + TimeToStr(Now - T);
end;

procedure TFMain.BLogClick(Sender: TObject);
var
  RGBI: TRGBImage;
  BM: TBitmap;
  T: TDateTime;
  c: double;
begin
  T := Now;
  LTime.Caption := 'Выполняется фильтрация...';
  FMain.Refresh;
  BM := TBitmap.Create;
  BM.Assign(IIn.Picture);
  RGBI := LoadRGBIFromBitMap(BM);
  BM.Free;
  c := strtofloat(LELogC.Text);
  LogTransform(RGBI.R, c);
  LogTransform(RGBI.G, c);
  LogTransform(RGBI.B, c);
  BM := SaveRGBImgToBitMap(RGBI);
  IOut.Picture.Assign(BM);
  BM.Free;
  LTime.Caption := 'Время фильтрации: ' + TimeToStr(Now - T);
end;

procedure TFMain.BConvertToGreyscaleClick(Sender: TObject);
var
  RGBI: TRGBImage;
  BM: TBitmap;
  GSI: TGreyscaleImage;
  T: TDateTime;
begin
  T := Now;
  LTime.Caption := 'Выполняется фильтрация...';
  FMain.Refresh;
  BM := TBitmap.Create;
  BM.Assign(IIn.Picture);
  RGBI := LoadRGBIFromBitMap(BM);
  BM.Free;
  GSI := ConvertRGBIToGSI(RGBI);
  IOut.Picture.Assign(SaveGreyscaleImgToBitMap(GSI));
  BM.Free;
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
