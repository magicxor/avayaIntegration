unit uRoutingServicesCtConector;

interface

uses uEscapeServicesCtConector, uCtTypes, uACS_h, uCSTADefs_h;

type
  TRoutingServicesCtConector = class(TEscapeServicesCtConector)

  public
    function RouteRegisterReq( const routingDevice : TDeviceID;
      const InvokeID : TInvokeID = 0 ) : TSAPI;
    function RouteRegisterCancel( const routeRegisterReqID : RouteRegisterReqID_t;
      const InvokeID : TInvokeID = 0 ) : TSAPI;
  end;

implementation

uses SysUtils, uStreamerCtConector, uCSTA_h, uMonitorServicesCtConector;

{ TRoutingServicesCtConector }

function TRoutingServicesCtConector.RouteRegisterCancel(
  const routeRegisterReqID: RouteRegisterReqID_t;
  const InvokeID: TInvokeID): TSAPI;
begin
Result := DEFAULT_ERROR_CODE;
if not CheckParams( routeRegisterReqID > 0,
  Format( '%s.RouteRegisterCancel', [ ClassName ] ) ) then
  exit;

Result := cstaRouteRegisterCancel(FAcsHandle, InvokeID, routeRegisterReqID, nil);
CheckForGoodCtResult(Result, 'cstaRouteRegisterCancel');
end;

function TRoutingServicesCtConector.RouteRegisterReq(
  const routingDevice: TDeviceID; const InvokeID: TInvokeID): TSAPI;
var
  _routingDevice : DeviceId_t;
begin
Result := DEFAULT_ERROR_CODE;
if not CheckParams( Length(routingDevice) > 0,
  Format( '%s.RouteRegisterReq', [ ClassName ] ) ) then
  exit;

PrepareDeviceID_t( _routingDevice, routingDevice );
Result := cstaRouteRegisterReq(FAcsHandle, InvokeID, @_routingDevice, nil);
CheckForGoodCtResult(Result, 'cstaRouteRegisterReq');
end;

end.
 