jQuery.fn.dataTableExt.oApi.fnSetFilteringDelay = function ( oSettings, iDelay ) {
        var _that = this;
        this.each( function ( i ) {
                $.fn.dataTableExt.iApiIndex = i;
                iDelay  = (iDelay && (/^[0-9]+$/.test(iDelay))) ? iDelay : 250;
                
                var $this = this, oTimerId;
                var anControl = $( 'input', _that.fnSettings().aanFeatures.f );
                
                anControl.unbind( 'keyup' ).bind( 'keyup', function(event) {
                        window.clearTimeout(oTimerId);
                        
                        if (event.keyCode == '13') {
                                // cr, we filter immedately
                                $.fn.dataTableExt.iApiIndex = i;
                                _that.fnFilter( $(this).val() );
                        } else {
                                // not cr, set new timer
                                oTimerId = window.setTimeout(function() {
                                        $.fn.dataTableExt.iApiIndex = i;
                                        _that.fnFilter( $(this).val() );
                                }, iDelay);
                        }
                        
                });
                
                return this;
        } );
        return this;
};