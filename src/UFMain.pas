unit UFMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtDlgs, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.ComCtrls;

type
  TFMain = class(TForm)
    IIn: TImage;
    IOut: TImage;
    OPD1: TOpenPictureDialog;
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
    procedure FormActivate(Sender: TObject);
    procedure IInDblClick(Sender: TObject);
    procedure BFilterClick(Sender: TObject);
    procedure IOutDblClick(Sender: TObject);
    procedure LEFilterNChange(Sender: TObject);
    procedure LEFilterMChange(Sender: TObject);
    procedure RGFilterSelectClick(Sender: TObject);
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
  UPixelConvert, UImages, UFilter;

procedure TFMain.BFilterClick(Sender: TObject);
var
  GSI: UImages.TGreyscaleImage;
  BM: TBitmap;
  FilterN, FilterM: byte;
  T: TDateTime;
  OutFileName: string;
begin
  LTime.Caption := 'Выполняется фильтрация...';
  FMain.Refresh;
  BM := TBitmap.Create;
  BM.Assign(IIn.Picture);
  UImages.LoadGSIFromBitMap(GSI, BM);
  BM.Free;
  FilterN := StrToInt(LEFilterN.Text);
  FilterM := StrToInt(LEFilterM.Text);
  T := Now;
  OutFileName := ExtractFileName(OPD1.FileName);
  Delete(OutFileName, pos(ExtractFileExt(OutFileName), OutFileName), length(OutFileName));
  OutFileName := OutFileName + '_';
  case RGFilterSelect.ItemIndex of
  0:
    begin
      UFilter.AVGFilter(GSI, FilterN, FilterM);
      OutFileName := OutFileName + inttostr(FilterN) + 'x' + inttostr(FilterM) + '_' + 'AVG';
    end;
  1:
    begin
      UFilter.WeightedAVGFilter(GSI, FilterN, FilterM);
      OutFileName := OutFileName + inttostr(FilterN) + 'x' + inttostr(FilterM) + '_' + 'WeightedAVG';
    end;
  2:
    begin
      UFilter.GeometricMeanFilter(GSI, FilterN, FilterM);
      OutFileName := OutFileName + inttostr(FilterN) + 'x' + inttostr(FilterM) + '_' + 'GeometricMean';
    end;
  3:
    begin
      UFilter.MedianFilter(GSI, FilterN, FilterM);
      OutFileName := OutFileName + inttostr(FilterN) + 'x' + inttostr(FilterM) + '_' + 'Median';
    end;
  4:
    begin
      UFilter.MaxFilter(GSI, FilterN, FilterM);
      OutFileName := OutFileName + inttostr(FilterN) + 'x' + inttostr(FilterM) + '_' + 'Max';
    end;
  5:
    begin
      UFilter.MinFilter(GSI, FilterN, FilterM);
      OutFileName := OutFileName + inttostr(FilterN) + 'x' + inttostr(FilterM) + '_' + 'Min';
    end;
  6:
    begin
      UFilter.MiddlePointFilter(GSI, FilterN, FilterM);
      OutFileName := OutFileName + inttostr(FilterN) + 'x' + inttostr(FilterM) + '_' + 'MiddlePoint';
    end;
  7:
    begin
      UFilter.TruncatedAVGFilter(GSI, FilterN, FilterM, StrToInt(LEFilterd.Text));
      OutFileName := OutFileName + inttostr(FilterN) + 'x' + inttostr(FilterM) + '_' + LEFilterd.Text + '_TrancetedAVG';
    end;
  8:
    begin
      UFilter.LaplaceFilter(GSI, CBAddToOriginal.Checked);
      if CBAddToOriginal.Checked then
        OutFileName := OutFileName + '+';
      OutFileName := OutFileName + 'Laplacian';
    end;
  9:
    begin
      UFilter.SobelFilter(GSI, CBAddToOriginal.Checked);
      if CBAddToOriginal.Checked then
        OutFileName := OutFileName + '+';
      OutFileName := OutFileName + 'Sobel';
    end;
  10:
    begin
      UFilter.PrevittFilter(GSI, CBAddToOriginal.Checked);
      if CBAddToOriginal.Checked then
        OutFileName := OutFileName + '+';
      OutFileName := OutFileName + 'Previtt';
    end;
  end;
  OutFileName := OutFileName + '.bmp';
  BM := UImages.SaveGreyscaleImgToBitMap(GSI);
  IOut.Picture.Assign(BM);
  BM.SaveToFile(OutFileName);
  BM.Free;
  LTime.Caption := 'Время фильтрации: ' + TimeToStr(Now - T);
end;

procedure TFMain.FormActivate(Sender: TObject);
begin
  IIn.Canvas.Rectangle(1, 1, IIn.Width, IIn.Height);
  IOut.Canvas.Rectangle(1, 1, IOut.Width, IOut.Height);
end;

procedure TFMain.IInDblClick(Sender: TObject);
var
  row, col: word;
  BM: TBitmap;
  color: TColor;
  r, g, b, Y, I, Q: double;
begin
  if OPD1.Execute then
  begin
    IIn.Picture.LoadFromFile(OPD1.FileName);
    BM := TBitmap.Create;
    BM.Assign(IIn.Picture);
    for row := 1 to BM.Height do
      for col := 1 to BM.Width do
      begin
        color := BM.Canvas.Pixels[col, row];
        UPixelConvert.TColorToRGB(color, r, g, b);
        UPixelConvert.RGBToYIQ(r, g, b, Y, I, Q);
        color := UPixelConvert.RGBToColor(Y, Y, Y);
        BM.Canvas.Pixels[col, row] := color;
      end;
    IIn.Picture.Assign(BM);
    BM.Free;
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

end.
