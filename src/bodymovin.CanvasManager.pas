unit bodymovin.CanvasManager;

interface

uses
  System.Generics.Collections, FMX.Graphics, FMX.Layouts, FMX.Objects, System.Classes;

type

  TFrameKey = class
    procedure DoRender(ALayer: TCanvas);

  end;

  TCanvasLayer = class(TLayout)
  private
    FLayers: array of TRectangle;
    function GetLayer(AIndex: Integer): TCanvas;
    function CreateLayer: TRectangle;
  public
    constructor Create(AOwner: TComponent); override;
    procedure DrawFrame(AFrameData: TFrameKey; ALayer: Integer);
    destructor Destroy; override;
    property Layer[Index: Integer]: TCanvas read GetLayer;

  end;

implementation

uses
  FMX.Types, System.UITypes;

{ TCanvasLayer }

constructor TCanvasLayer.Create(AOwner: TComponent);
begin
  inherited;
end;

function TCanvasLayer.CreateLayer: TRectangle;
begin
  Result := TRectangle.Create(Self);
  Result.Parent := Self;
  Result.Fill.Color := TAlphaColorRec.Null;
  Result.Stroke.Kind := TBrushKind.None;
  Result.Align := TAlignLayout.Contents;
  Result.BringToFront;
end;

destructor TCanvasLayer.Destroy;
begin
  FLayers := [];
  inherited;
end;

procedure TCanvasLayer.DrawFrame(AFrameData: TFrameKey; ALayer: Integer);
begin
  AFrameData.DoRender(Layer[ALayer]);
end;

function TCanvasLayer.GetLayer(AIndex: Integer): TCanvas;
begin
  if Length(FLayers) - 1 < AIndex  then
    SetLength(FLayers, AIndex + 1);

  if not Assigned(FLayers[AIndex]) then
    FLayers[AIndex] := CreateLayer;

  Result := FLayers[AIndex].Canvas;
end;


{ TFrameKey }

procedure TFrameKey.DoRender(ALayer: TCanvas);
begin

end;

end.
