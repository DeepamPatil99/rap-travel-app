CLASS zload_emp DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zload_emp IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

    DATA lt_employee TYPE TABLE OF zemployee_master.

    lt_employee = VALUE #(

      (
        employeeid   = 'EMP001'
        employeename = 'Deepam Patil'
        userid       = 'DEEPAM'
        role         = 'EMPLOYEE'
      )

      (
        employeeid   = 'EMP002'
        employeename = 'Travel Manager'
        userid       = 'ADMIN1'
        role         = 'ADMIN'
      )

    ).

    INSERT zemployee_master FROM TABLE @lt_employee.

    out->write( 'Employees inserted successfully' ).

  ENDMETHOD.
ENDCLASS.
