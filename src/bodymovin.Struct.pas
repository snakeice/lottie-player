unit bodymovin.Struct;

interface

uses
  System.Generics.Collections, System.JSON;

type
  ILayer = Interface
  end;

  IAsset = Interface
  end;

  IShape = interface

  end;

  TCharacterShape = class
    FShape: IShape;
  end;

  TChars = class
  private
    // Character
    FCharacter: Char;
    // Font family
    FFontFamily: string;
    // Font size
    FSize: Extended;
    // Font Style
    FStyle: string;
    // Width
    FWidth: Extended;
    // Character Properties
    FData: TArray<TCharacterShape>;
  public
    function ToString: string; override;
    property Ch: Char read FCharacter write FCharacter;
    property fFamily: string read FFontFamily write FFontFamily;
    property size: Extended read FSize write FSize;
    property style: string read FStyle write FStyle;
    property w: Extended read FWidth write FWidth;
    property &property: TArray<TCharacterShape> read FData write FData;


    constructor Create(AData: TJSONObject);
  end;

  TAnimationData = class
    // In Point of the Time Ruler. Sets the initial Frame of the animation.
    FInPoint,
    // Out Point of the Time Ruler. Sets the final Frame of the animation
    FOutPoint,
    // Frame rate
    FFrameRate,
    // Composition Width
    FWidth,
    // Composition Height
    FHeight: Extended;
    // Bodymovin Version
    FVersion: string;

    Flayers: array of ILayer;
    FAssets: array of IAsset;
    FChars: TArray<TChars>;
  private
    procedure ParseChars(AChars: TJSONArray);

  published
    function ToString: string; override;
    property ip: Extended read FInPoint write FInPoint;
    property op: Extended read FOutPoint write FOutPoint;
    property fr: Extended read FFrameRate write FFrameRate;
    property w: Extended read FWidth write FWidth;
    property h: Extended read FHeight write FHeight;
    property v: string read FVersion write FVersion;
    property chars: TArray<TChars> read FChars write FChars;

    constructor Create(AData: string);
  end;

implementation

uses
  System.Sysutils;

{ TAnimationData }

constructor TAnimationData.Create(AData: string);
var
  LDataJson: TJSONObject;
  LTmpArray: TJSONArray;
begin
  LDataJson := TJSONObject.ParseJSONValue(AData) as TJSONObject;
  try
    LDataJson.TryGetValue<Extended>('ip', FInPoint);
    LDataJson.TryGetValue<Extended>('op', FOutPoint);
    LDataJson.TryGetValue<Extended>('fr', FFrameRate);
    LDataJson.TryGetValue<Extended>('w', FWidth);
    LDataJson.TryGetValue<Extended>('h', FHeight);
    LDataJson.TryGetValue<string>('v', FVersion);

    if LDataJson.TryGetValue<TJSONArray>('chars', LTmpArray) then
      ParseChars(LTmpArray);
  finally
    LDataJson.DisposeOf;
  end;
end;

procedure TAnimationData.ParseChars(AChars: TJSONArray);
var
  LIndex: Integer;
begin
  SetLength(FChars, AChars.Count);
  for LIndex := 0 to AChars.Count - 1 do
    chars[LIndex] := TChars.Create(AChars.Items[LIndex] as TJSONObject);

end;

function TAnimationData.ToString: string;
var
  LChar: TChars;
begin
  Result :=
    'In Point: ' + FInPoint.ToString + sLineBreak +
    'Out Point: ' + FOutPoint.ToString + sLineBreak +
    'Frame rate: ' + FFrameRate.ToString + sLineBreak +
    'Composition Width: ' + FWidth.ToString + sLineBreak +
    'Composition Height: ' + FHeight.ToString + sLineBreak +
    'Bodymovin Version: ' + FVersion + sLineBreak +
    'Chars: [';

    for LChar in FChars do
    begin
      Result := Result + sLineBreak + '{ ' + sLineBreak + LChar.ToString + sLineBreak + '},';
    end;

    Result := Result + ']';
end;

{ TChars }

constructor TChars.Create(AData: TJSONObject);
begin
  AData.TryGetValue<Char>('ch', FCharacter);
  AData.TryGetValue<string>('fFamily', FFontFamily);
  AData.TryGetValue<Extended>('size', FSize);
  AData.TryGetValue<string>('style', FStyle);
  AData.TryGetValue<Extended>('w', FWidth);
end;

function TChars.ToString: string;
begin
  Result :=
    '  Character: "' + FCharacter + '"' + sLineBreak +
    '  Font family: ' + FFontFamily + sLineBreak +
    '  Font size: ' + FSize.ToString + sLineBreak +
    '  Font Style: ' + FStyle +
    '  Width: ' + FWidth.ToString;
end;

end.
