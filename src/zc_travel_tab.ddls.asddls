@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'consumption of travel'
@Metadata.allowExtensions: true
define root view entity zc_travel_tab provider contract transactional_query
as projection on ZI_TRAVEL_TAB
{
    key TravelUUID,
    TravelId,
    EmployeeId,
    EmployeeName,
    StartDate,
    EndDate,
    CurrencyCode,
    @Semantics.amount.currencyCode: 'CurrencyCode'
    BookingFee,
    @Semantics.amount.currencyCode: 'CurrencyCode'
    TotalPrice,
    Status,
    RequestorUser,
    CreatedBy,
    CreatedAt,
    LastChangedBy,
    LastChangedAt,
    LocalLastChangedAt,
    /* Associations */
    _Booking : redirected to composition child zc_booking_tab
}
