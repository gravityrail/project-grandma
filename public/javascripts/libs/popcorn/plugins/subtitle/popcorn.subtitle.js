// PLUGIN: Subtitle

(function (Popcorn) {
  
  /**
   */

  // just a little tool function
  // calculates the top and left position of an element
  var offset = function(obj) {
    var left, top;
    left = top = 0;
    if (obj.offsetParent) {
        do {
            left += obj.offsetLeft;
            top  += obj.offsetTop;
        } while (obj = obj.offsetParent);
    }
    return {
        left : left,
        top : top
    };
  };

  // translates whatever is in options.container into selected language
  var translate = function( options, text ) {

    options.selectedLanguage = options.languageSrc.options[ options.languageSrc.selectedIndex ].value;

    google.language.translate( text, '', options.selectedLanguage, function( result ) {

      options.container.innerHTML = result.translation;

    } );
  };


/*
      // Find element offset
      if (element.offsetParent) {
        do {
          offsetX += element.offsetLeft;
          offsetY += element.offsetTop;
        } while ((element = element.offsetParent));
      }
*/

  Popcorn.plugin( "subtitle" , {
    
      manifest: {
        about:{
          name: "Popcorn Subtitle Plugin",
          version: "0.1",
          author:  "Scott Downe",
          website: "http://scottdowne.wordpress.com/"
        },
        options:{
          start    : {elem:'input', type:'text', label:'In'},
          end      : {elem:'input', type:'text', label:'Out'},
          target  :  'Subtitle-container',
          text     : {elem:'input', type:'text', label:'Text'}
        }
      },

      _setup: function( options ) {

        // Creates a div for all subtitles to use
        if ( !this.container ) {
          this.container = document.createElement('div');

          this.container.style.position   = "absolute";
          this.container.style.color      = "white";
          this.container.style.textShadow = "black 2px 2px 6px";
          this.container.style.fontSize   = "18px";
          this.container.style.fontWeight = "bold";
          this.container.style.textAlign  = "center";

          // the video element must have height and width defined
          this.container.style.width      = this.video.offsetWidth + "px";
          this.container.style.top        = offset( this.video ).top + this.video.offsetHeight - 65 + "px";
          this.container.style.left       = offset( this.video ).left + "px";

          this.video.parentNode.appendChild( this.container );
        }

        // if a target is specified, use that
        if ( options.target && options.target !== 'Subtitle-container' ) {
          options.container = document.getElementById( options.target );
        } else { // use shared default container
          options.container = this.container;
        }

        var accessibility = document.getElementById( options.accessibilitysrc ),
            that = this;

        options.showSubtitle = function() {
          options.container.innerHTML = options.text;
        };
        options.toggleSubtitles = function() {};
        options.that = this;
        

        if ( options.languagesrc ) {
          options.showSubtitle = translate;
          options.languageSrc = document.getElementById( options.languagesrc );
          options.selectedLanguage = options.languageSrc.options[ options.languageSrc.selectedIndex ].value;

          if ( !this.languageSources ) {
            this.languageSources = {};
          }

          

          if ( !this.languageSources[ options.languagesrc ] ) {
            this.languageSources[ options.languagesrc ] = {};
            
          }

          if ( !this.languageSources[ options.languagesrc ][ options.target ] ) {
            this.languageSources[ options.languagesrc ][ options.target ] = true;

            options.languageSrc.addEventListener( "change", function() {


              options.toggleSubtitles();
              options.showSubtitle( options, options.container.innerHTML );

            }, false );

          }

        }

        if ( accessibility ) {
          options.accessibility = accessibility;

          options.toggleSubtitles = function() {
            options.selectedLanguage = options.languageSrc.options[ options.languageSrc.selectedIndex ].value;
            if ( options.accessibility.checked || options.selectedLanguage !== ( options.language || "") ) {
              options.display = "inline";
              options.container.style.display = options.display;
            } else if ( options.selectedLanguage === ( options.language || "") ) {
              options.display = "none";
              options.container.style.display = options.display;
            }

          };

          options.accessibility.addEventListener( "change", options.toggleSubtitles, false );

          // initiate it once to set starting state
          options.toggleSubtitles();
        }

      },
      /**
       * @member subtitle 
       * The start function will be executed when the currentTime 
       * of the video  reaches the start time provided by the 
       * options variable
       */
      start: function(event, options){
        options.container.style.display = options.display;
        options.showSubtitle( options, options.text );
      },
      /**
       * @member subtitle 
       * The end function will be executed when the currentTime 
       * of the video  reaches the end time provided by the 
       * options variable
       */
      end: function(event, options){
        options.container.style.display = options.display;
        options.container.innerHTML = "";
      }
   
  } );

})( Popcorn );
