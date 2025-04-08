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

    "Task 2
    data fn type i.
    data sn type i.
    data op type char1.
    fn = 18.
    sn = 2.
    op = '+'.
    DATA(result) = zif_abap_course_basics~calculator(
            iv_first_number = fn
            iv_second_number = sn
            iv_operator = op ).
    out->write( |{ fn } { op } { sn }: { result }| ).

    "Task 3
    out->write( zif_abap_course_basics~fizz_buzz(  ) ).

    "Task 4
    out->write( zif_abap_course_basics~date_parsing( `3 November 1979` ) ).

    "Task 5
    out->write( zif_abap_course_basics~scrabble_score( `Test` ) ).

    "Task 6
    out->write( zif_abap_course_basics~get_current_date_time(  ) ).



  ENDMETHOD.


  METHOD zif_abap_course_basics~calculator.
    "Task 2
    "IMPORTING iv_first_number  TYPE i
    "          iv_second_number TYPE i
    "          iv_operator      TYPE char1
    "RETURNING VALUE(rv_result) TYPE i
    case iv_operator.
        when '+'.
            rv_result = iv_first_number + iv_second_number.
        when '-'.
            rv_result = iv_first_number - iv_second_number.
        when '*'.
            rv_result = iv_first_number * iv_second_number.
        when '/'.
            try.
                rv_result = iv_first_number / iv_second_number.
            catch cx_sy_zerodivide.
                rv_result = cl_abap_math=>min_int4.
            endtry.
        when others.
            rv_result = cl_abap_math=>min_int4.

    ENDCASE.

  ENDMETHOD.


  METHOD zif_abap_course_basics~date_parsing.
  "IMPORTING iv_date          TYPE string
  "RETURNING VALUE(rv_result) TYPE dats.
    data month_part type string.
    data day_part type string.
    SPLIT iv_date AT space INTO: TABLE DATA(date_parts).

    if strlen( date_parts[ 1 ] ) = 1.
        day_part = `0` && date_parts[ 1 ].
    else.
        day_part = date_parts[ 1 ].
    ENDIF.

    if strlen( date_parts[ 2 ] ) > 2.
        case date_parts[ 2 ].
            when `January`.
               month_part = `01`.
            when `February`.
               month_part = `02`.
            when `March`.
               month_part = `03`.
            when `April`.
               month_part = `04`.
            when `May`.
               month_part = `05`.
            when `June`.
               month_part = `06`.
            when `July`.
               month_part = `07`.
            when `August`.
               month_part = `08`.
            when `September`.
               month_part = `09`.
            when `October`.
               month_part = `10`.
            when `November`.
               month_part = `11`.
            when `December`.
               month_part = `12`.
        ENDCASE.
    ELSEIF strlen( date_parts[ 2 ] ) = 1.
        month_part = `0` && date_parts[ 2 ].
    else.
        month_part = date_parts[ 2 ].
    ENDIF.

    rv_result = conv d( date_parts[ 3 ] && month_part && day_part ).
  ENDMETHOD.


  METHOD zif_abap_course_basics~fizz_buzz.
    "RETURNING VALUE(rv_result) TYPE string.
    data counter type i value 1.
    data is_mod_3 type string.

    do 100 times.
        if counter mod 3 <> 0 and counter mod 5 <> 0.
            rv_result = rv_result && |{ counter }|.
        else.
            if counter mod 3 = 0.
                rv_result = rv_result && `Fizz`.
            ENDIF.

            if counter mod 5 = 0.
                rv_result = rv_result && `Buzz`.
            ENDif.
        endif.
        rv_result = rv_result && ` `.
        counter = counter + 1.
    enddo.
  ENDMETHOD.


  METHOD zif_abap_course_basics~get_current_date_time.
  "RETURNING VALUE(rv_result) TYPE timestampl.
    GET TIME STAMP FIELD DATA(lv_timestamp).
    CONVERT TIME STAMP lv_timestamp TIME ZONE sy-zonlo
        INTO TIME DATA(current_time).
    data current_date type d.
    current_date = sy-datum.
    CONVERT DATE current_date TIME current_time
        INTO TIME STAMP rv_result time zone sy-zonlo.
  ENDMETHOD.


  METHOD zif_abap_course_basics~hello_world.
    rv_result = |Hello { iv_name }, your system user is { sy-uname }.|.
  ENDMETHOD.


  METHOD zif_abap_course_basics~internal_tables.
  ENDMETHOD.


  METHOD zif_abap_course_basics~open_sql.
  ENDMETHOD.


  METHOD zif_abap_course_basics~scrabble_score.
  "IMPORTING iv_word          TYPE string
  "RETURNING VALUE(rv_result) TYPE i.
  DATA(word_length) = strlen( iv_word ).
  data index type i.
  data char type c.
  data word_tmp type string.
  word_tmp = iv_word.
  translate word_tmp to UPPER CASE.
  while index < word_length.
    char = word_tmp+index(1).
        case char.
            when `A`.
                rv_result = rv_result + 1.
            when `B`.
                rv_result = rv_result + 2.
            when `C`.
                rv_result = rv_result + 3.
            when `D`.
                rv_result = rv_result + 4.
            when `E`.
                rv_result = rv_result + 5.
            when `F`.
                rv_result = rv_result + 6.
            when `G`.
                rv_result = rv_result + 7.
            when `H`.
                rv_result = rv_result + 8.
            when `I`.
                rv_result = rv_result + 9.
            when `J`.
                rv_result = rv_result + 10.
            when `K`.
                rv_result = rv_result + 11.
            when `L`.
                rv_result = rv_result + 12.
            when `M`.
                rv_result = rv_result + 13.
            when `N`.
                rv_result = rv_result + 14.
            when `O`.
                rv_result = rv_result + 15.
            when `P`.
                rv_result = rv_result + 16.
            when `Q`.
                rv_result = rv_result + 17.
            when `R`.
                rv_result = rv_result + 18.
            when `S`.
                rv_result = rv_result + 19.
            when `T`.
                rv_result = rv_result + 20.
            when `U`.
                rv_result = rv_result + 21.
            when `V`.
                rv_result = rv_result + 22.
            when `W`.
                rv_result = rv_result + 23.
            when `X`.
                rv_result = rv_result + 24.
            when `Y`.
                rv_result = rv_result + 25.
            when `Z`.
                rv_result = rv_result + 26.
        ENDCASE.
    index = index + 1.
  ENDWHILE.

  ENDMETHOD.
ENDCLASS.
