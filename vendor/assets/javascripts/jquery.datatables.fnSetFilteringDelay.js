jQuery.fn.dataTableExt.oApi.fnSetFilteringDelay = function ( oSettings, iDelay ) {

 /*
  * Type:        Plugin for DataTables (www.datatables.net) JQuery plugin.
  * Name:        dataTableExt.oApi.fnSetFilteringDelay
  * Version:     1.0.0
  * Description: Enables filtration delay for keeping the browser more
  *              responsive while searching for a longer keyword.
  * Inputs:      object:oSettings - dataTables settings object
  *              integer:iDelay - delay in miliseconds
  * Returns:     JQuery
  * Usage:       $('#example').dataTable().fnSetFilteringDelay(250);
  *
  * Author:      Zygimantas Berziunas (www.zygimantas.com)
  * Created:     7/3/2009
  * Language:    Javascript
  * License:     GPL v2 or BSD 3 point style
  * Contact:     zygimantas.berziunas@hotmail.com
  */

  iDelay  = (iDelay && (/^[0-9]+$/.test(iDelay))) ? iDelay : 250; 

  var $this = this, oTimerId;

  // Unfortunately there is no nFilter inside oSettings.
  var anControl = $( 'div.dataTables_filter input:text' );

  anControl.unbind( 'keyup' ).bind( 'keyup', function() {

    var $$this = $this;
    window.clearTimeout(oTimerId);

    oTimerId = window.setTimeout(function() {

      $$this.fnFilter( anControl.val() );
    }, iDelay);
  });

  return this;
}