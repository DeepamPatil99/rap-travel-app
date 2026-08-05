@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'CDS for Travel Header'
@Metadata.ignorePropagatedAnnotations: true

define root view entity ZI_TRAVEL_TAB
  as select from ztravel_header

  composition [0..*] of zi_booking_tab as _Booking

{
  key traveluuid            as TravelUUID,

      travel_id             as TravelId,
      employee_id           as EmployeeId,
      employee_name         as EmployeeName,
      start_date            as StartDate,
      end_date              as EndDate,

      currency_code         as CurrencyCode,

      @Semantics.amount.currencyCode: 'CurrencyCode'
      booking_fee           as BookingFee,

      @Semantics.amount.currencyCode: 'CurrencyCode'
      total_price           as TotalPrice,

      status                as Status,
      requestor_user        as RequestorUser,
      created_by            as CreatedBy,
      created_at            as CreatedAt,
      last_changed_by       as LastChangedBy,
      last_changed_at       as LastChangedAt,
      local_last_changed_at as LocalLastChangedAt,
      _Booking
}
