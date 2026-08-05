@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'consumption of booking'
@Metadata.allowExtensions: true
define view entity zc_booking_tab as projection on zi_booking_tab
{
    key BookingUuid,
    TravelUuid,
    CarrierId,
    FlightNo,
    FlightDate,
    CurrencyCode,
    @Semantics.amount.currencyCode: 'CurrencyCode'
    BookingPrice,
    CreatedBy,
    CreatedAt,
    LastChangedBy,
    LastChangedAt,
    LocalLastChangedAt,
    /* Associations */
    _Travel : redirected to parent zc_travel_tab
}
