CLASS lhc_ZI_TRAVEL_TAB DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    CONSTANTS gc_test_role TYPE string VALUE 'ADMIN'.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR zi_travel_tab RESULT result.

    METHODS get_global_authorizations FOR GLOBAL AUTHORIZATION
      IMPORTING REQUEST requested_authorizations FOR zi_travel_tab RESULT result.

    METHODS validateDates FOR VALIDATE ON SAVE
      IMPORTING keys FOR zi_travel_tab~validateDates.

    METHODS ApproveTravel FOR MODIFY
      IMPORTING keys   FOR ACTION zi_travel_tab~ApproveTravel
      RESULT    result.

    METHODS RejectTravel FOR MODIFY
      IMPORTING keys   FOR ACTION zi_travel_tab~RejectTravel
      RESULT    result.

    METHODS SubmitTravel FOR MODIFY
      IMPORTING keys   FOR ACTION zi_travel_tab~SubmitTravel
      RESULT    result.
    METHODS SetRequestorUser FOR DETERMINE ON MODIFY
      IMPORTING keys FOR zi_travel_tab~SetRequestorUser.

    METHODS SetInitialStatus FOR DETERMINE ON MODIFY
      IMPORTING keys FOR zi_travel_tab~SetInitialStatus.

    METHODS get_instance_features FOR INSTANCE FEATURES
      IMPORTING keys REQUEST requested_features FOR zi_travel_tab RESULT result.

ENDCLASS.

CLASS lhc_ZI_TRAVEL_TAB IMPLEMENTATION.

  METHOD get_instance_authorizations.
  ENDMETHOD.

  METHOD get_global_authorizations.
  ENDMETHOD.

  METHOD validateDates.

    READ ENTITIES OF zi_travel_tab
      ENTITY zi_travel_tab
      ALL FIELDS
      WITH CORRESPONDING #( keys )
      RESULT DATA(lt_travel).

    LOOP AT lt_travel INTO DATA(ls_travel).

      IF ls_travel-EndDate < ls_travel-StartDate.

        APPEND VALUE #(
          %tky = ls_travel-%tky
        ) TO failed-zi_travel_tab.

        APPEND VALUE #(
          %tky = ls_travel-%tky
          %msg = new_message_with_text(
                   severity = if_abap_behv_message=>severity-error
                   text     = 'End Date cannot be before Start Date'
                 )
        ) TO reported-zi_travel_tab.

      ENDIF.

    ENDLOOP.

  ENDMETHOD.

  METHOD ApproveTravel.

    DATA(lv_role) = gc_test_role.

    IF lv_role <> 'ADMIN'.

      APPEND VALUE #(
        %msg = new_message_with_text(
          severity = if_abap_behv_message=>severity-error
          text     = 'Only administrators can approve travel requests'
        )
      ) TO reported-zi_travel_tab.

      RETURN.

    ENDIF.

    READ ENTITIES OF zi_travel_tab
      ENTITY zi_travel_tab
      ALL FIELDS
      WITH CORRESPONDING #( keys )
      RESULT DATA(lt_travel).

    LOOP AT lt_travel INTO DATA(ls_travel).

      IF ls_travel-Status <> 'S'.

        APPEND VALUE #(
          %tky = ls_travel-%tky
          %msg = new_message_with_text(
            severity = if_abap_behv_message=>severity-error
            text     = 'Only submitted requests can be approved'
          )
        ) TO reported-zi_travel_tab.

        RETURN.

      ENDIF.

    ENDLOOP.

    MODIFY ENTITIES OF zi_travel_tab
      ENTITY zi_travel_tab
      UPDATE FIELDS ( Status )
      WITH VALUE #(
        FOR key IN keys (
          %tky   = key-%tky
          Status = 'A'
        )
      ).

    READ ENTITIES OF zi_travel_tab
      ENTITY zi_travel_tab
      ALL FIELDS
      WITH CORRESPONDING #( keys )
      RESULT DATA(lt_result).

    result = VALUE #(
      FOR row IN lt_result (
        %tky   = row-%tky
        %param = row
      )
    ).

  ENDMETHOD.


  METHOD RejectTravel.

    DATA(lv_role) = gc_test_role.

    IF lv_role <> 'ADMIN'.

      APPEND VALUE #(
        %msg = new_message_with_text(
          severity = if_abap_behv_message=>severity-error
          text     = 'Only administrators can reject travel requests'
        )
      ) TO reported-zi_travel_tab.

      RETURN.

    ENDIF.

    READ ENTITIES OF zi_travel_tab
      ENTITY zi_travel_tab
      ALL FIELDS
      WITH CORRESPONDING #( keys )
      RESULT DATA(lt_travel).

    LOOP AT lt_travel INTO DATA(ls_travel).

      IF ls_travel-Status <> 'S'.

        APPEND VALUE #(
          %tky = ls_travel-%tky
          %msg = new_message_with_text(
            severity = if_abap_behv_message=>severity-error
            text     = 'Only submitted requests can be rejected'
          )
        ) TO reported-zi_travel_tab.

        RETURN.

      ENDIF.

    ENDLOOP.

    MODIFY ENTITIES OF zi_travel_tab
      ENTITY zi_travel_tab
      UPDATE FIELDS ( Status )
      WITH VALUE #(
        FOR key IN keys (
          %tky   = key-%tky
          Status = 'R'
        )
      ).

    READ ENTITIES OF zi_travel_tab
      ENTITY zi_travel_tab
      ALL FIELDS
      WITH CORRESPONDING #( keys )
      RESULT DATA(lt_result).

    result = VALUE #(
      FOR row IN lt_result (
        %tky   = row-%tky
        %param = row
      )
    ).

  ENDMETHOD.


  METHOD SubmitTravel.

    MODIFY ENTITIES OF zi_travel_tab
      ENTITY zi_travel_tab
      UPDATE FIELDS ( Status )
      WITH VALUE #(
        FOR key IN keys (
          %tky   = key-%tky
          Status = 'S'
        )
      ).

    READ ENTITIES OF zi_travel_tab
      ENTITY zi_travel_tab
      ALL FIELDS
      WITH CORRESPONDING #( keys )
      RESULT DATA(lt_result).

    result = VALUE #(
      FOR row IN lt_result (
        %tky   = row-%tky
        %param = row
      )
    ).

  ENDMETHOD.

  METHOD SetRequestorUser.

    DATA(lv_user) =
      cl_abap_context_info=>get_user_technical_name( ).

    MODIFY ENTITIES OF zi_travel_tab
      ENTITY zi_travel_tab
      UPDATE FIELDS ( RequestorUser )
      WITH VALUE #(
        FOR key IN keys (
          %tky = key-%tky
          RequestorUser = lv_user
        )
      ).

  ENDMETHOD.

  METHOD SetInitialStatus.

    MODIFY ENTITIES OF zi_travel_tab
      ENTITY zi_travel_tab
      UPDATE FIELDS ( Status )
      WITH VALUE #(
        FOR key IN keys (
          %tky   = key-%tky
          Status = 'O'
        )
      ).

  ENDMETHOD.

  METHOD get_instance_features.

    DATA(lv_role) = gc_test_role.

    READ ENTITIES OF zi_travel_tab
      ENTITY zi_travel_tab
      FIELDS ( Status )
      WITH CORRESPONDING #( keys )
      RESULT DATA(lt_travel).

    result =
      VALUE #(

        FOR ls_travel IN lt_travel (

          %tky = ls_travel-%tky

          %action-SubmitTravel =
            COND #(
              WHEN ls_travel-Status = 'O'
              THEN if_abap_behv=>fc-o-enabled
              ELSE if_abap_behv=>fc-o-disabled
            )

          %action-ApproveTravel =
            COND #(
              WHEN ls_travel-Status = 'S'
               AND lv_role = 'ADMIN'
              THEN if_abap_behv=>fc-o-enabled
              ELSE if_abap_behv=>fc-o-disabled
            )

          %action-RejectTravel =
            COND #(
              WHEN ls_travel-Status = 'S'
               AND lv_role = 'ADMIN'
              THEN if_abap_behv=>fc-o-enabled
              ELSE if_abap_behv=>fc-o-disabled
            )

        )
      ).

  ENDMETHOD.

ENDCLASS.
