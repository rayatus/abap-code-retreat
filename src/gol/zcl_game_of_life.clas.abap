CLASS zcl_game_of_life DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC.


  PUBLIC SECTION.

    TYPES: BEGIN OF ltyp_boardgame,
             alife TYPE abap_bool,
             col   TYPE i,
             row   TYPE i,
           END   OF ltyp_boardgame,
           ltyp_t_boardgame TYPE HASHED TABLE OF ltyp_boardgame WITH UNIQUE KEY col row.

    DATA: boardgame TYPE ltyp_t_boardgame READ-ONLY.

    METHODS create_boardgame
      IMPORTING
        cols             TYPE i
        rows             TYPE i
      RETURNING
        VALUE(et_result) TYPE ltyp_t_boardgame.

    METHODS set_cell_status
      IMPORTING
        col    TYPE i
        row    TYPE i
        status TYPE abap_bool.

    METHODS get_surrounding_alife_cells
      IMPORTING
                col                 TYPE i
                row                 TYPE i
      RETURNING VALUE(alived_cells) TYPE i.

    METHODS apply_rules
      IMPORTING
        col TYPE i
        row TYPE i.

    METHODS get_cell_status
      IMPORTING
                col           TYPE i
                row           TYPE i
      RETURNING VALUE(status) TYPE abap_bool.

    METHODS iterate.

  PROTECTED SECTION.
  PRIVATE SECTION.



ENDCLASS.



CLASS zcl_game_of_life IMPLEMENTATION.



  METHOD create_boardgame.
    DATA col TYPE i.
    DATA row TYPE i.
    DATA ls_entry TYPE LINE OF ltyp_t_boardgame.

    DO rows TIMES.
      ADD 1 TO col.
      CLEAR row.

      DO cols TIMES.

        ADD 1 TO row.
        ls_entry-col = col.
        ls_entry-row = row.

        INSERT ls_entry INTO TABLE et_result.

      ENDDO.

    ENDDO.

    boardgame = et_result.

  ENDMETHOD.



  METHOD apply_rules.

    DATA(will_be_alive) = abap_false.

    DATA(surrounding_alive_cells) = get_surrounding_alife_cells( col = col row = row ).

    CASE boardgame[ col = col row = row ]-alife.

      WHEN abap_true.
        IF ( surrounding_alive_cells < 2 OR  surrounding_alive_cells > 3 ).
          will_be_alive = abap_false.
        ELSE.
          will_be_alive = abap_true.
        ENDIF.

      WHEN abap_false.
        IF ( surrounding_alive_cells = 3 ).
          will_be_alive = abap_true.
        ELSE.
          will_be_alive = abap_false.
        ENDIF.

    ENDCASE.

    boardgame[ col = col row = row ]-alife = will_be_alive.

  ENDMETHOD.

  METHOD get_surrounding_alife_cells.

    DATA l_col TYPE i.
    DATA l_row TYPE i.

    l_col  = col - 1.
    l_row  = row.

    IF get_cell_status( col = l_col row = l_row ) = abap_true.
      ADD 1 TO alived_cells.
    ENDIF.


    l_col  = col + 1.
    l_row  = row.

    IF get_cell_status( col = l_col row = l_row ) = abap_true.
      ADD 1 TO alived_cells.
    ENDIF.


    l_col  = col.
    l_row  = row - 1.

    IF get_cell_status( col = l_col row = l_row ) = abap_true.
      ADD 1 TO alived_cells.
    ENDIF.


    l_col  = col.
    l_row  = row + 1.

    IF get_cell_status( col = l_col row = l_row ) = abap_true.
      ADD 1 TO alived_cells.
    ENDIF.


    l_col  = col - 1.
    l_row  = row - 1.

    IF get_cell_status( col = l_col row = l_row ) = abap_true.
      ADD 1 TO alived_cells.
    ENDIF.


    l_col  = col + 1.
    l_row  = row - 1.

    IF get_cell_status( col = l_col row = l_row ) = abap_true.
      ADD 1 TO alived_cells.
    ENDIF.


    l_col  = col - 1.
    l_row  = row + 1.

    IF get_cell_status( col = l_col row = l_row ) = abap_true.
      ADD 1 TO alived_cells.
    ENDIF.

    l_col  = col + 1.
    l_row  = row + 1.

    IF get_cell_status( col = l_col row = l_row ) = abap_true.
      ADD 1 TO alived_cells.
    ENDIF.

  ENDMETHOD.


  METHOD get_cell_status.
    IF line_exists( boardgame[ col = col row = row ] ).
      status = boardgame[ col = col row = row ]-alife.
    ENDIF.
  ENDMETHOD.

  METHOD set_cell_status.
    boardgame[ col = col row = row ]-alife = status.
  ENDMETHOD.

  METHOD iterate.
    LOOP AT boardgame ASSIGNING FIELD-SYMBOL(<cell>).
      apply_rules( col = <cell>-col row = <cell>-row ).
    ENDLOOP.
  ENDMETHOD.

ENDCLASS.
