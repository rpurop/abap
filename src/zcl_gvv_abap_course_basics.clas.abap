CLASS zcl_gvv_abap_course_basics DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
    INTERFACES zif_abap_course_basics .


  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_gvv_abap_course_basics IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.
    "Task 1
    out->write( zif_abap_course_basics~hello_world( 'Grigor' ) ).
  ENDMETHOD.


  METHOD zif_abap_course_basics~calculator.
  ENDMETHOD.


  METHOD zif_abap_course_basics~date_parsing.
  ENDMETHOD.


  METHOD zif_abap_course_basics~fizz_buzz.
  ENDMETHOD.


  METHOD zif_abap_course_basics~get_current_date_time.
  ENDMETHOD.


  METHOD zif_abap_course_basics~hello_world.
    rv_result = |Hello { iv_name }, your system user is { sy-uname }.|.
  ENDMETHOD.


  METHOD zif_abap_course_basics~internal_tables.
  ENDMETHOD.


  METHOD zif_abap_course_basics~open_sql.
  ENDMETHOD.


  METHOD zif_abap_course_basics~scrabble_score.
  ENDMETHOD.
ENDCLASS.
