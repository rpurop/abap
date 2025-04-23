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
    DATA fn TYPE i.
    DATA sn TYPE i.
    DATA op TYPE char1.
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

    "Task 7
    zif_abap_course_basics~internal_tables(  ).




  ENDMETHOD.


  METHOD zif_abap_course_basics~calculator.
    "Task 2
    "IMPORTING iv_first_number  TYPE i
    "          iv_second_number TYPE i
    "          iv_operator      TYPE char1
    "RETURNING VALUE(rv_result) TYPE i
    CASE iv_operator.
      WHEN '+'.
        rv_result = iv_first_number + iv_second_number.
      WHEN '-'.
        rv_result = iv_first_number - iv_second_number.
      WHEN '*'.
        rv_result = iv_first_number * iv_second_number.
      WHEN '/'.
        TRY.
            rv_result = iv_first_number / iv_second_number.
          CATCH cx_sy_zerodivide.
            rv_result = cl_abap_math=>min_int4.
        ENDTRY.
      WHEN OTHERS.
        rv_result = cl_abap_math=>min_int4.

    ENDCASE.

  ENDMETHOD.


  METHOD zif_abap_course_basics~date_parsing.
    "IMPORTING iv_date          TYPE string
    "RETURNING VALUE(rv_result) TYPE dats.
    DATA month_part TYPE string.
    DATA day_part TYPE string.
    SPLIT iv_date AT space INTO: TABLE DATA(date_parts).

    IF strlen( date_parts[ 1 ] ) = 1.
      day_part = `0` && date_parts[ 1 ].
    ELSE.
      day_part = date_parts[ 1 ].
    ENDIF.

    IF strlen( date_parts[ 2 ] ) > 2.
      CASE date_parts[ 2 ].
        WHEN `January`.
          month_part = `01`.
        WHEN `February`.
          month_part = `02`.
        WHEN `March`.
          month_part = `03`.
        WHEN `April`.
          month_part = `04`.
        WHEN `May`.
          month_part = `05`.
        WHEN `June`.
          month_part = `06`.
        WHEN `July`.
          month_part = `07`.
        WHEN `August`.
          month_part = `08`.
        WHEN `September`.
          month_part = `09`.
        WHEN `October`.
          month_part = `10`.
        WHEN `November`.
          month_part = `11`.
        WHEN `December`.
          month_part = `12`.
      ENDCASE.
    ELSEIF strlen( date_parts[ 2 ] ) = 1.
      month_part = `0` && date_parts[ 2 ].
    ELSE.
      month_part = date_parts[ 2 ].
    ENDIF.

    rv_result = CONV d( date_parts[ 3 ] && month_part && day_part ).
  ENDMETHOD.


  METHOD zif_abap_course_basics~fizz_buzz.
    "RETURNING VALUE(rv_result) TYPE string.
    DATA counter TYPE i VALUE 1.
    DATA is_mod_3 TYPE string.

    DO 100 TIMES.
      IF counter MOD 3 <> 0 AND counter MOD 5 <> 0.
        rv_result = rv_result && |{ counter }|.
      ELSE.
        IF counter MOD 3 = 0.
          rv_result = rv_result && `Fizz`.
        ENDIF.

        IF counter MOD 5 = 0.
          rv_result = rv_result && `Buzz`.
        ENDIF.
      ENDIF.
      rv_result = rv_result && ` `.
      counter = counter + 1.
    ENDDO.
  ENDMETHOD.


  METHOD zif_abap_course_basics~get_current_date_time.
    "RETURNING VALUE(rv_result) TYPE timestampl.
    GET TIME STAMP FIELD DATA(lv_timestamp).
    CONVERT TIME STAMP lv_timestamp TIME ZONE sy-zonlo
        INTO TIME DATA(current_time).
    DATA current_date TYPE d.
    current_date = sy-datum.
    CONVERT DATE current_date TIME current_time
        INTO TIME STAMP rv_result TIME ZONE sy-zonlo.
  ENDMETHOD.


  METHOD zif_abap_course_basics~hello_world.
    rv_result = |Hello { iv_name }, your system user is { sy-uname }.|.
  ENDMETHOD.


  METHOD zif_abap_course_basics~internal_tables.
  "EXPORTING et_travel_ids_task7_1 TYPE ltty_travel_id
  "            et_travel_ids_task7_2 TYPE ltty_travel_id
  "            et_travel_ids_task7_3 TYPE ltty_travel_id.
    DATA tmp_uuid TYPE uuid.
    SELECT SINGLE
        FROM ZTRAVEL_GVV
        FIELDS travel_uuid
        into @tmp_uuid.
    if sy-subrc = 4.
        SELECT * FROM ZTRAVEL_GVV INTO TABLE @DATA(lt_ztravel).
        DELETE ZTRAVEL_GVV FROM TABLE @lt_ztravel.
        COMMIT WORK AND WAIT.

        INSERT ZTRAVEL_GVV FROM
        ( SELECT FROM /dmo/travel

            FIELDS  uuid( )          AS travel_uuid,
                    travel_id        AS travel_id,
                    agency_id        AS agency_id,
                    customer_id      AS customer_id,
                    begin_date       AS begin_date,
                    end_date         AS end_date,
                    booking_fee      AS booking_fee,
                    total_price      AS total_price,
                    currency_code    AS currency_code,
                    description      AS description,
                    CASE status
                        WHEN 'B' THEN  'A'  " ACCEPTED
                        WHEN 'X'  THEN 'X' " CANCELLED
                        ELSE 'O'         " open
                    END              AS overall_status,
                    createdby        AS createdby,
                    createdat        AS createdat,
                    lastchangedby    AS last_changed_by,
                    lastchangedat    AS last_changed_at
        ORDER BY travel_id ).
        COMMIT WORK AND WAIT.
    else.
        SELECT * FROM ZTRAVEL_GVV INTO TABLE @DATA(lt_ztravel1).
        data lt_ztravel1_line like LINE OF lt_ztravel1.


        LOOP AT lt_ztravel1 into lt_ztravel1_line
                            where agency_id = `070001`
                                and booking_fee = 20
                                and currency_code = `JPY`.
            APPEND VALUE #( travel_id = lt_ztravel1_line-travel_id  ) to et_travel_ids_task7_1.

        endloop.

        "7.2 commented because there is no exch rate and currency_conversion throws an error
*        SELECT travel_id,
*                begin_date,
*                currency_conversion( amount = total_price,
*                                     source_currency = currency_code,
*                                     round = 'X',
*                                     target_currency = 'USD',
*                                     exchange_rate_date = begin_date ) as amount
*                 "no exch rate in the db and do not accept error_handling parameter although documented
*            from ztravel_gvv
*            INTO TABLE @DATA(lt_ztravel2).
*
*         data lt_ztravel2_line like LINE OF lt_ztravel2.
*
*         LOOP AT lt_ztravel2 into lt_ztravel2_line
*                            where amount > 2000.
*            APPEND VALUE #( travel_id = lt_ztravel2_line-travel_id  ) to et_travel_ids_task7_2.
*
*        endloop.

        "7.3
        DELETE lt_ztravel1 WHERE currency_code <> 'EUR'.
        sort lt_ztravel1 ASCENDING by total_price begin_date.


        LOOP AT lt_ztravel1 into lt_ztravel1_line.
            if sy-tabix > 10.
                exit.
            endif.
            append value #(  travel_id = lt_ztravel1_line-travel_id  ) to et_travel_ids_task7_3.

        endloop.


    ENDIF.
  ENDMETHOD.


  METHOD zif_abap_course_basics~open_sql.
  ENDMETHOD.


  METHOD zif_abap_course_basics~scrabble_score.
    "IMPORTING iv_word          TYPE string
    "RETURNING VALUE(rv_result) TYPE i.

    "Version 1
*  DATA(word_length) = strlen( iv_word ).
*  data index type i.
*  data char type c.
*  data word_tmp type string.
*  word_tmp = iv_word.
*  translate word_tmp to UPPER CASE.
*  while index < word_length.
*    char = word_tmp+index(1).
*        case char.
*            when `A`.
*                rv_result = rv_result + 1.
*            when `B`.
*                rv_result = rv_result + 2.
*            when `C`.
*                rv_result = rv_result + 3.
*            when `D`.
*                rv_result = rv_result + 4.
*            when `E`.
*                rv_result = rv_result + 5.
*            when `F`.
*                rv_result = rv_result + 6.
*            when `G`.
*                rv_result = rv_result + 7.
*            when `H`.
*                rv_result = rv_result + 8.
*            when `I`.
*                rv_result = rv_result + 9.
*            when `J`.
*                rv_result = rv_result + 10.
*            when `K`.
*                rv_result = rv_result + 11.
*            when `L`.
*                rv_result = rv_result + 12.
*            when `M`.
*                rv_result = rv_result + 13.
*            when `N`.
*                rv_result = rv_result + 14.
*            when `O`.
*                rv_result = rv_result + 15.
*            when `P`.
*                rv_result = rv_result + 16.
*            when `Q`.
*                rv_result = rv_result + 17.
*            when `R`.
*                rv_result = rv_result + 18.
*            when `S`.
*                rv_result = rv_result + 19.
*            when `T`.
*                rv_result = rv_result + 20.
*            when `U`.
*                rv_result = rv_result + 21.
*            when `V`.
*                rv_result = rv_result + 22.
*            when `W`.
*                rv_result = rv_result + 23.
*            when `X`.
*                rv_result = rv_result + 24.
*            when `Y`.
*                rv_result = rv_result + 25.
*            when `Z`.
*                rv_result = rv_result + 26.
*        ENDCASE.
*    index = index + 1.
*  ENDWHILE.

    "Version 2
    TYPES: BEGIN OF letter_points,
             letter TYPE char1,
             points TYPE i,
           END OF letter_points.

    TYPES tt_alphabet TYPE SORTED TABLE OF letter_points WITH UNIQUE KEY letter.

    DATA alphabet TYPE tt_alphabet.

    APPEND VALUE #( letter = `A` points = 1 ) TO alphabet.
    APPEND VALUE #( letter = `B` points = 2 ) TO alphabet.
    APPEND VALUE #( letter = `C` points = 3 ) TO alphabet.
    APPEND VALUE #( letter = `D` points = 4 ) TO alphabet.
    APPEND VALUE #( letter = `E` points = 5 ) TO alphabet.
    APPEND VALUE #( letter = `F` points = 6 ) TO alphabet.
    APPEND VALUE #( letter = `G` points = 7 ) TO alphabet.
    APPEND VALUE #( letter = `H` points = 8 ) TO alphabet.
    APPEND VALUE #( letter = `I` points = 9 ) TO alphabet.
    APPEND VALUE #( letter = `J` points = 10 ) TO alphabet.
    APPEND VALUE #( letter = `K` points = 11 ) TO alphabet.
    APPEND VALUE #( letter = `L` points = 12 ) TO alphabet.
    APPEND VALUE #( letter = `M` points = 13 ) TO alphabet.
    APPEND VALUE #( letter = `N` points = 14 ) TO alphabet.
    APPEND VALUE #( letter = `O` points = 15 ) TO alphabet.
    APPEND VALUE #( letter = `P` points = 16 ) TO alphabet.
    APPEND VALUE #( letter = `Q` points = 17 ) TO alphabet.
    APPEND VALUE #( letter = `R` points = 18 ) TO alphabet.
    APPEND VALUE #( letter = `S` points = 19 ) TO alphabet.
    APPEND VALUE #( letter = `T` points = 20 ) TO alphabet.
    APPEND VALUE #( letter = `U` points = 21 ) TO alphabet.
    APPEND VALUE #( letter = `V` points = 22 ) TO alphabet.
    APPEND VALUE #( letter = `W` points = 23 ) TO alphabet.
    APPEND VALUE #( letter = `X` points = 24 ) TO alphabet.
    APPEND VALUE #( letter = `Y` points = 25 ) TO alphabet.
    APPEND VALUE #( letter = `Z` points = 26 ) TO alphabet.

    DATA(word_length) = strlen( iv_word ).
    DATA index TYPE i.
    DATA char TYPE c.
    DATA word_tmp TYPE string.
    word_tmp = iv_word.
    TRANSLATE word_tmp TO UPPER CASE.
    WHILE index < word_length.
      char = word_tmp+index(1).
      rv_result = rv_result + alphabet[ letter = char ]-points.
      index = index + 1.
    ENDWHILE.




  ENDMETHOD.
ENDCLASS.
