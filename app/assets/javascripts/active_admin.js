//= require active_admin/base
//= require chosen.jquery.min
//= require_self

var mobile = /Android|webOS|iPhone|iPad|iPod|BlackBerry/i.test(navigator.userAgent);
var states;

$( document ).ready(function(){


  setDatePickers();

  // Filter states when country select changes
  $( 'form' ).on( {
    change: function(){ filterStateSelect( $( this ).parents( 'fieldset' ).first() ); }
  }, '[data-type="country_select"]')

  // Get states list
  states = $( '[data-type="state_select"]').html();

  // Initi address form on load
  $( 'fieldset' ).each( function(){
    filterStateSelect( this );
  });

  setChosen();
  $( 'div.has_many > a.button' ).on( 'click', function(){ setChosen(); });

  $( '.has_many.addresses a.button').on( 'click', function(){
    console.log("HI");
    states = $( '[data-type="state_select"]').html();
    filterStateSelect( $( '.has_many.addresses fieldset').last() );
  });

  $( '.has_many.memberships a.button' ).on( 'click', function(){ setDatePickers(); });
});

function setDatePickers()
{
  if( mobile )
  {
    return;
  }

  $( 'input[type="date"]' ).addClass( 'datepicker' );
  $( 'input[type="date"]' ).attr( 'type', 'text' );

  var options = { dateFormat: 'yy-mm-dd' }
  $( '.datepicker' ).each( function(){

    if( $( this ).attr( 'data-years' ) )
    {
      options.changeYear = true;
      options.yearRange = $( this ).attr( 'data-years' )
    }

    $( this ).datepicker( options )
  });
}

function filterStateSelect(fieldset)
{
  country = $( fieldset ).find( '[data-type="country_select"] :selected' ).text();
  console.log( "Filtering selection for optgroup[label='" + country + "']" );
  options = $(states).filter("optgroup[label='" + country + "']").html()
  console.log( options );
  if( options )
  {
    $( fieldset ).find( '[data-type="state_select"]' ).html( options );
    $( fieldset ).find( '[data-type="state_select"]' ).parent().show();
  } else {
    $( fieldset ).find( '[data-type="state_select"]' ).empty();
    $( fieldset ).find( '[data-type="state_select"]' ).parent().hide();
  }
}

function setChosen()
{
  $('[data-hook="choose"]').chosen({
    allow_single_deselect: true,
    no_results_text: 'Record not found',
    width:"76%"
  });
}
