unit Bodymovin;

interface

uses
  FMX.Graphics, bodymovin.CanvasManager, System.Classes, FMX.Ani, bodymovin.Struct, FMX.Layouts;

const
  MAX_PRE_FRAME = 10;

type
  TRGB = record
    R, G, B, A: Byte;
    function Make(R, G, B, A: Byte): TRGB; overload;
    function Make(AHex: Integer): TRGB; overload;
  end;


  TLayer = class
    FStartAt,
    FStopAt: Integer;
    FFrames: array of TFrameKey;


    procedure DoDrawFrame(Akey: Integer);
    constructor Create(AFrameCount: Integer);
  end;

  TBodymovinPlayer = class
  private
    FFrameTimer: TFloatAnimation;
    FView: TLayout;
    FData: TAnimationData;
    FCanvas: TCanvasLayer;
    FFrameKey: Integer;
    FLayers: array of TLayer;


    procedure OnRenderNew(Sender: TObject);
  public
    constructor Create(AContainer: TLayout; AData: string);
    destructor Destroy; override;

  end;

implementation

uses
  System.UITypes, REST.Json, FMX.Dialogs;

{ TRGB }

function TRGB.Make(AHex: Integer): TRGB;
begin
  Result.R := Byte(AHex);
  Result.G := Byte(AHex shr 8);
  Result.B := Byte(AHex shr 16);
  Result.A := Byte(AHex shr 24);
end;

function TRGB.Make(R, G, B, A: Byte): TRGB;
begin
  Result.R := R;
  Result.G := G;
  Result.B := B;
  Result.A := A;
end;

{ TBodymovinPlayer }

constructor TBodymovinPlayer.Create(AContainer: TLayout; AData: string);
begin
  FView := AContainer;
  FCanvas := TCanvasLayer.Create(AContainer);
  FFrameKey := 0;
  FFrameTimer := TFloatAnimation.Create(AContainer);
  FFrameTimer.Enabled := False;
  FFrameTimer.OnProcess := OnRenderNew;
  FData :=  TAnimationData.Create(AData);
  ShowMessage(FData.ToString);

end;

destructor TBodymovinPlayer.Destroy;
begin
  FFrameTimer.DisposeOf;
  inherited;
end;

procedure TBodymovinPlayer.OnRenderNew(Sender: TObject);
var
  LLayer: TLayer;
begin
  for LLayer in FLayers do
    LLayer.DoDrawFrame(FFrameKey);
  Inc(FFrameKey);
end;

{ TLayer }

constructor TLayer.Create(AFrameCount: Integer);
begin
  SetLength(FFrames, AFrameCount);
end;

procedure TLayer.DoDrawFrame(Akey: Integer);
begin

end;

end.
