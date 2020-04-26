CLASS ltcl_gol DEFINITION FINAL FOR TESTING
  DURATION SHORT
  RISK LEVEL HARMLESS.

  PRIVATE SECTION.
    METHODS:
      first_test    FOR TESTING RAISING cx_static_check,
      second_test   FOR TESTING RAISING cx_static_check,
      third_test    FOR TESTING RAISING cx_static_check,
      fourth_test   FOR TESTING RAISING cx_static_check.

ENDCLASS.


CLASS ltcl_gol IMPLEMENTATION.


  METHOD first_test.
    DATA(gol) = NEW zcl_game_of_life(  ).

    gol->create_boardgame( cols = 3 rows = 3 ).

    gol->set_cell_status( col = 2 row = 2 status = abap_true ).
    gol->set_cell_status( col = 2 row = 1 status = abap_true ).

    DATA(alive_cells) = gol->get_surrounding_alife_cells( col = 2 row = 2 ).

    cl_abap_unit_assert=>assert_equals( msg = 'Expected alive cells 1' exp = 1 act = alive_cells ).

  ENDMETHOD.


  METHOD second_test.
    DATA(gol) = NEW zcl_game_of_life(  ).

    gol->create_boardgame( cols = 3 rows = 3 ).

    gol->set_cell_status( col = 2 row = 2 status = abap_true ).
    gol->set_cell_status( col = 2 row = 1 status = abap_true ).
    gol->set_cell_status( col = 3 row = 3 status = abap_true ).

    DATA(alive_cells) = gol->get_surrounding_alife_cells( col = 2 row = 2 ).

    cl_abap_unit_assert=>assert_equals( msg = 'Expected alive cells 2' exp = 2 act = alive_cells ).

  ENDMETHOD.

  METHOD third_test.
    DATA(gol) = NEW zcl_game_of_life(  ).

    gol->create_boardgame( cols = 3 rows = 3 ).

    gol->set_cell_status( col = 1 row = 1 status = abap_true ).
    gol->set_cell_status( col = 1 row = 2 status = abap_true ).
    gol->set_cell_status( col = 1 row = 3 status = abap_true ).
    gol->set_cell_status( col = 2 row = 1 status = abap_true ).
    gol->set_cell_status( col = 2 row = 2 status = abap_true ).
    gol->set_cell_status( col = 2 row = 3 status = abap_true ).
    gol->set_cell_status( col = 3 row = 1 status = abap_true ).
    gol->set_cell_status( col = 3 row = 2 status = abap_true ).
    gol->set_cell_status( col = 3 row = 3 status = abap_true ).

    DATA(alive_cells) = gol->get_surrounding_alife_cells( col = 2 row = 2 ).

    cl_abap_unit_assert=>assert_equals( msg = 'Expected alive cells 8' exp = 8 act = alive_cells ).
  ENDMETHOD.

  METHOD fourth_test.

    DATA(gol) = NEW zcl_game_of_life(  ).

    gol->create_boardgame( cols = 3 rows = 3 ).

    gol->set_cell_status( col = 1 row = 1 status = abap_true ).
    gol->set_cell_status( col = 1 row = 2 status = abap_true ).
    gol->set_cell_status( col = 1 row = 3 status = abap_true ).
    gol->set_cell_status( col = 2 row = 1 status = abap_true ).
    gol->set_cell_status( col = 2 row = 2 status = abap_true ).
    gol->set_cell_status( col = 2 row = 3 status = abap_true ).
    gol->set_cell_status( col = 3 row = 1 status = abap_true ).
    gol->set_cell_status( col = 3 row = 2 status = abap_true ).
    gol->set_cell_status( col = 3 row = 3 status = abap_true ).

    gol->apply_rules( col = 2 row = 2  ).

    cl_abap_unit_assert=>assert_equals( msg = 'Expected new status = DEAD' exp = abap_false act = gol->get_cell_status( col = 2 row = 2 ) ).

  ENDMETHOD.

ENDCLASS.
