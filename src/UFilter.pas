unit UFilter;

interface

uses
  UImages;
procedure AVGFilter(var GSI: TGreyscaleImage; h, w: word);
procedure WeightedAVGFilter(var GSI: TGreyscaleImage; h, w: word);
procedure GeometricMeanFilter(var GSI: TGreyscaleImage; h, w: word);
procedure MedianFilter(var GSI: TGreyscaleImage; h, w: word);
procedure MaxFilter(var GSI: TGreyscaleImage; h, w: word);
procedure MinFilter(var GSI: TGreyscaleImage; h, w: word);
procedure MiddlePointFilter(var GSI: TGreyscaleImage; h, w: word);

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

procedure AVGFilter(var GSI: TGreyscaleImage; h, w: word);
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

procedure WeightedAVGFilter(var GSI: TGreyscaleImage; h, w: word);
var
  i, j: integer;
  fi, fj: integer;
  sum: double;
  GSIR: TGreyscaleImage;
  Mask: array of array of double;
  maxDist, maskWeigth: double;
begin
  UImages.InitGSImg(GSIR, GSI.N, GSI.M);
  for i := 1 to GSI.N do
    for j := 1 to GSI.M do
      GSIR.i[i, j] := GSI.i[i, j];

  SetLength(Mask, 2 * h + 2);
  for i := 1 to 2 * h + 2 do
    SetLength(Mask[i], 2 * w + 2);
  for i := -h to h do
    for j := -w to w do
      Mask[i + h + 1, j + w + 1] := sqrt(sqr(i) + sqr(j));
  maxDist := Mask[1, 1];
  maskWeigth := 0;
  for i := 1 to 2 * h + 1 do
    for j := 1 to 2 * w + 1 do
    begin
      Mask[i, j] := (maxDist - Mask[i, j]) / maxDist;
      maskWeigth := maskWeigth + Mask[i, j];
    end;

  for i := 1 to GSI.N do
    for j := 1 to GSI.M do
    begin
      sum := 0;
      for fi := -h to h do
        for fj := -w to w do
          sum := sum + Mask[fi + h + 1, fj + w + 1] * GetPixelValue(GSI, i + fi, j + fj);
      GSIR.i[i, j] := round(sum / maskWeigth);
    end;
  for i := 1 to GSI.N do
    for j := 1 to GSI.M do
      GSI.i[i, j] := GSIR.i[i, j];
end;

procedure GeometricMeanFilter(var GSI: TGreyscaleImage; h, w: word);
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

procedure MedianFilter(var GSI: TGreyscaleImage; h, w: word);
var
  i, j: word;
  fi, fj: integer;
  GSIR: TGreyscaleImage;
  k, l: word;
  val: byte;
  tmp: array of byte;
begin
  UImages.InitGSImg(GSIR, GSI.N, GSI.M);
  for i := 1 to GSI.N do
    for j := 1 to GSI.M do
      GSIR.i[i, j] := GSI.i[i, j];

  SetLength(tmp, (2 * h + 1) * (2 * w + 1) + 1);
  for i := 1 to GSI.N do
    for j := 1 to GSI.M do
    begin
      k := 0;
      for fi := -h to h do
        for fj := -w to w do
        begin
          k := k + 1;
          tmp[k] := GetPixelValue(GSI, i + fi, j + fj);
        end;
      for k := 1 to (2 * h + 1) * (2 * w + 1) - 1 do
        for l := k + 1 to (2 * h + 1) * (2 * w + 1) do
          if tmp[k] > tmp[l] then
          begin
            val := tmp[k];
            tmp[k] := tmp[l];
            tmp[l] := val;
          end;
      GSIR.i[i, j] := tmp[((2 * h + 1) * (2 * w + 1) div 2) + 1];
    end;
  tmp := nil;
  for i := 1 to GSI.N do
    for j := 1 to GSI.M do
      GSI.i[i, j] := GSIR.i[i, j];
end;

procedure MaxFilter(var GSI: TGreyscaleImage; h, w: word);
var
  i, j: word;
  fi, fj: integer;
  GSIR: TGreyscaleImage;
  k: word;
  Max: byte;
  tmp: array of byte;
begin
  UImages.InitGSImg(GSIR, GSI.N, GSI.M);
  for i := 1 to GSI.N do
    for j := 1 to GSI.M do
      GSIR.i[i, j] := GSI.i[i, j];

  SetLength(tmp, (2 * h + 1) * (2 * w + 1) + 1);
  for i := 1 to GSI.N do
    for j := 1 to GSI.M do
    begin
      k := 0;
      for fi := -h to h do
        for fj := -w to w do
        begin
          k := k + 1;
          tmp[k] := GetPixelValue(GSI, i + fi, j + fj);
        end;
      Max := tmp[1];
      for k := 1 to (2 * h + 1) * (2 * w + 1) - 1 do
        if tmp[k] > Max then
          Max := tmp[k];
      GSIR.i[i, j] := Max;
    end;
  tmp := nil;
  for i := 1 to GSI.N do
    for j := 1 to GSI.M do
      GSI.i[i, j] := GSIR.i[i, j];
end;

procedure MinFilter(var GSI: TGreyscaleImage; h, w: word);
var
  i, j: word;
  fi, fj: integer;
  GSIR: TGreyscaleImage;
  k: word;
  Min: byte;
  tmp: array of byte;
begin
  UImages.InitGSImg(GSIR, GSI.N, GSI.M);
  for i := 1 to GSI.N do
    for j := 1 to GSI.M do
      GSIR.i[i, j] := GSI.i[i, j];

  SetLength(tmp, (2 * h + 1) * (2 * w + 1) + 1);
  for i := 1 to GSI.N do
    for j := 1 to GSI.M do
    begin
      k := 0;
      for fi := -h to h do
        for fj := -w to w do
        begin
          k := k + 1;
          tmp[k] := GetPixelValue(GSI, i + fi, j + fj);
        end;
      Min := tmp[1];
      for k := 1 to (2 * h + 1) * (2 * w + 1) - 1 do
        if tmp[k] < Min then
          Min := tmp[k];
      GSIR.i[i, j] := Min;
    end;
  tmp := nil;
  for i := 1 to GSI.N do
    for j := 1 to GSI.M do
      GSI.i[i, j] := GSIR.i[i, j];
end;

procedure MiddlePointFilter(var GSI: TGreyscaleImage; h, w: word);
var
  i, j: word;
  fi, fj: integer;
  GSIR: TGreyscaleImage;
  k: word;
  Min, Max: byte;
  tmp: array of byte;
begin
  UImages.InitGSImg(GSIR, GSI.N, GSI.M);
  for i := 1 to GSI.N do
    for j := 1 to GSI.M do
      GSIR.i[i, j] := GSI.i[i, j];

  SetLength(tmp, (2 * h + 1) * (2 * w + 1) + 1);
  for i := 1 to GSI.N do
    for j := 1 to GSI.M do
    begin
      k := 0;
      for fi := -h to h do
        for fj := -w to w do
        begin
          k := k + 1;
          tmp[k] := GetPixelValue(GSI, i + fi, j + fj);
        end;
      Min := tmp[1];
      Max := tmp[1];
      for k := 1 to (2 * h + 1) * (2 * w + 1) - 1 do
      begin
        if tmp[k] < Min then
          Min := tmp[k];
        if tmp[k] > Max then
          Max := tmp[k];
      end;
      GSIR.i[i, j] := round((Max + Min) / 2);
    end;
  tmp := nil;
  for i := 1 to GSI.N do
    for j := 1 to GSI.M do
      GSI.i[i, j] := GSIR.i[i, j];
end;

end.
