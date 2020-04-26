CLASS zcl_game_of_life_gui DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    CLASS-METHODS main.

  PROTECTED SECTION.
  PRIVATE SECTION.

ENDCLASS.



CLASS zcl_game_of_life_gui IMPLEMENTATION.

  METHOD main.



    DATA(cols) = 4.
    DATA(rows) = 4.


    DATA(gol) = NEW zcl_game_of_life( ).
    gol->create_boardgame( cols = cols rows = rows ).

    gol->set_cell_status( col = 2 row = 1 status = abap_true ).
    gol->set_cell_status( col = 2 row = 2 status = abap_true ).
    gol->set_cell_status( col = 3 row = 2 status = abap_true ).

    DATA(output) = cl_demo_output=>new( ).

    DO 4 TIMES.

      output->begin_section( |ABAP Game of Life : interation { sy-index }| )->line( ).

      output->write_html( '<table border>' ).
      DATA(row) = 0.
      DO rows TIMES.
        ADD 1 TO row.
        output->write_html( '<tr>' ).
        DATA(col) = 0.
        DO cols TIMES.
          ADD 1 TO col.
          DATA(cell_value) = SWITCH #( gol->get_cell_status( col = col row = row ) WHEN abap_false THEN '&nbsp;' ELSE abap_true ).
          output->write_html( |<td>{ cell_value }</td>| ).
        ENDDO.
        output->write_html( '</tr>' ) .
      ENDDO.
      output->write_html( '</table>' ).
      output->display(  ).

      gol->iterate(  ).
    ENDDO.

  ENDMETHOD.
ENDCLASS.
