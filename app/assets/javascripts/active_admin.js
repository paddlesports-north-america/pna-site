//= require active_admin/base
//= require select2
//= require_self

var mobile = /Android|webOS|iPhone|iPad|iPod|BlackBerry/i.test(navigator.userAgent);
var states;
var costs;

$( document ).ready(function(){


  setDatePickers();

  // Filter states when country select changes
  $( 'form' ).on( {
    change: function(){ filterStateSelect( $( this ).parents( 'fieldset' ).first() ); }
  }, '[data-type="country_select"]');

  // Get states list
  states = $( '[data-type="state_select"]').html();

  // Initi address form on load
  $( 'fieldset' ).each( function(){
    filterStateSelect( this );
  });

  setChosen();

  $( 'form' ).on({
    input: function(){
      console.log( $( this ).val() );
      var src = $( this ).parents( 'li' ).children( 'select' );
      console.log( $( src ).attr( "data-source" ) );
      $.ajax({
        url: $( src ).attr( "data-source" ) + ".json",
        dataType: 'json',
        data: { q: $( this ).val() },
        success: function( data ){
          $( src ).html('')
          for( var i in data )
          {
            $( src ).append( "<option value=\"" + data[i].id + "\">" + data[i].description + "</option>" );
          }
          $( src ).trigger("liszt:updated");
        }
      });
    }
  }, '.chzn-search input' );

  $( 'div.has_many > a.button' ).on( 'click', function(){
    setChosen();
    $( this ).parents( 'div.has_many' ).find( 'input' ).first().focus();
  });

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
    $( fieldset ).find( '[data-type="state_select"]' ).html('<option></option>'); //.empty();
    $( fieldset ).find( '[data-type="state_select"]' ).parent().hide();
  }
}

function setCostField( element, data )
{
  var cost = $( element ).attr( 'name' ).replace( /(\[)product_id(\])/g, '\$1cost\$2' );
  console.log( "Setting " + cost + " to " + data.amount );
  $( '[name="' + cost + '"]' ).val( data.amount );
}

function memberAutocompleteFormat( item )
{
  console.log( 'autocomplete format')
  if( typeof item.member != 'undefined' )
  {
    item = item.member;
  }

  return item.id + " : " + item.first_name + ' ' + item.last_name;
}

function productAutocompleteFormat( item )
{
  return item.description;
}

function setChosen()
{

  $('[data-hook="choose"]').not('.select2-offscreen' ).each( function(){

    var opts = {
      width: "76%",
      allowClear: true,
      placeholder: "Select an option"
    }

    if( typeof $( this ).attr( 'data-autocomplete' ) != 'undefined' )
    {
      console.log( $( this ).attr( 'id' ) );

      $( this ).attr( 'type', 'hidden' );

      opts.minimumInputLength = 2;
      opts.ajax = {
        url: $( this ).attr( 'data-source' ) + "/autocomplete.json",
        dataType: 'json',
        data: function( term, page )
        {
          return { q: term }
        },
        results: function( data, page )
        {
          return { results: data };
        }
      }

      if( typeof $( this ).attr( 'multiple') != 'undefined' )
      {
        opts.multiple = $( this ).attr( 'multiple' );
      }

      if( $( this ).attr( 'data-format' ) != "" )
      {
        opts.formatResult = window[ $( this ).attr( 'data-format' ) ];
        opts.formatSelection = window[ $( this ).attr( 'data-format' ) ];
      }

      opts.initSelection = function( element, callback )
      {
        console.log( element );
        var id = $( element ).val().split(",");
        console.log( id );
        var redata = [];
        if( id != "" )
        {
          for( var i = 0; i < id.length; i++ ){
            m = id[i];
            if( m.length == 0 )
            {
              continue;
            }
            
            $.ajax({
              url: $( element ).attr( 'data-source' ) + '/' + m + ".json",
              dataType: 'json'
            }).done(function( data ){ callback( data ) }); //redata.push(data) }); 
          }
        }
        // callback( redata );
      }

    }

    if( $( this ).attr( 'data-callback') )
    {
      $( this ).on({
        change: function(){
          window[ $( this ).attr( 'data-callback' ) ]( this, $( this ).select2( 'data' ) );
        }
      });
    }

    $( this ).select2( opts );

    // if( $( this ).attr( 'data-autocomplete' ) && $( this ).val() )
    // {
    //   console.log( "Attempting to load value " + $( this ).val() + " from resource " + $( this ).attr( 'data-source' ) );

    //   var src = $( this ).attr( 'data-source' );
    //   var val = $( this ).val();
    //   var ele = this
    //   $.ajax({
    //     url: src + "/" + val + ".json",
    //     dataType: 'json',
    //     success: function( data )
    //     {
    //       $( ele ).select2( 'data', { id: data.id, text: data.description } );
    //     }
    //   });
    // }

  });
}
