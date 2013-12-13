unit UFilter;

interface

uses
  UImages;
procedure AVG(var GSI: TGreyscaleImage; h, w: word);
procedure GeometricMean(var GSI: TGreyscaleImage; h, w: word);

implementation

uses
  Math;

function GetPixelValue(const GSI: TGreyscaleImage; i, j: integer): byte;
begin
  if i < 1 then
    i := 1;
  if i > GSI.N then
    i := GSI.N;
  if j < 1 then
    j := 1;
  if j > GSI.M then
    j := GSI.M;
  GetPixelValue := GSI.i[i, j];
end;

procedure AVG(var GSI: TGreyscaleImage; h, w: word);
var
  i, j: word;
  fi, fj: integer;
  sum: LongWord;
  GSIR: TGreyscaleImage;
begin
  UImages.InitGSImg(GSIR, GSI.N, GSI.M);
  for i := 1 to GSI.N do
    for j := 1 to GSI.M do
      GSIR.i[i, j] := GSI.i[i, j];
  for i := 1 to GSI.N do
    for j := 1 to GSI.M do
    begin
      sum := 0;
      for fi := -h to h do
        for fj := -w to w do
          sum := sum + GetPixelValue(GSI, i + fi, j + fj);
      sum := round(sum / ((2 * h + 1) * (2 * w + 1)));
      GSIR.i[i, j] := sum;
    end;
  for i := 1 to GSI.N do
    for j := 1 to GSI.M do
      GSI.i[i, j] := GSIR.i[i, j];
end;

procedure GeometricMean(var GSI: TGreyscaleImage; h, w: word);
var
  i, j: word;
  fi, fj: integer;
  p: double;
  GSIR: TGreyscaleImage;
begin
  UImages.InitGSImg(GSIR, GSI.N, GSI.M);
  for i := 1 to GSI.N do
    for j := 1 to GSI.M do
      GSIR.i[i, j] := GSI.i[i, j];
  for i := 1 to GSI.N do
    for j := 1 to GSI.M do
    begin
      p := 1;
      for fi := -h to h do
        for fj := -w to w do
          p := p * GetPixelValue(GSI, i + fi, j + fj);
      p := power(p, 1 / ((2 * h + 1) * (2 * w + 1)));
      GSIR.i[i, j] := round(p);
    end;
  for i := 1 to GSI.N do
    for j := 1 to GSI.M do
      GSI.i[i, j] := GSIR.i[i, j];
end;

end.
