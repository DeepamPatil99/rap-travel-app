@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'interface of the booking table'
@Metadata.ignorePropagatedAnnotations: true
define view entity zi_booking_tab
  as select from ztravel_book
  
 association to parent ZI_TRAVEL_TAB as _Travel
    on $projection.TravelUuid = _Travel.TravelUUID
{
  key booking_uuid          as BookingUuid,
      travel_uuid           as TravelUuid,
      carrier_id            as CarrierId,
      flight_no             as FlightNo,
      flight_date           as FlightDate,
      currency_code         as CurrencyCode,
      @Semantics.amount.currencyCode: 'CurrencyCode'
      booking_price         as BookingPrice,
      created_by            as CreatedBy,
      created_at            as CreatedAt,
      last_changed_by       as LastChangedBy,
      last_changed_at       as LastChangedAt,
      local_last_changed_at as LocalLastChangedAt,
      _Travel
}
