<!-- {{{Config -->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Fira+Code:wght@400;700&family=Fredoka:wght@400;700&family=Inspiration&family=Lobster&family=Lobster+Two&family=Poppins:ital,wght@0,400;0,700;1,400&family=Roboto:wght@400;700&display=swap" rel="stylesheet">
<!-- {{{ Styles -->
<style>
    *{
        font-family: 'Poppins'
    }
    h1{
        font-family: 'Poppins';
    }
    h2,h3,h4,h5,h6{
        font-family: 'Poppins';
    }
    h3 a{
        text-decoration: none;
        color: red;
    }
    code{
        font-family: 'Fira Code';
    }
    div.trim_1 {
        max-height: 550px;
        overflow: hidden;
    }
    div.trim_2 {
        max-height: 100px;
        overflow: hidden;
    }
    div.trim_3 {
        max-height: 600px;
        overflow: hidden;
    }
    /* li { */
    /*     list-style-type: none; */
    /* } */
    /* ol { */
    /*     counter-reset: cupcake; */
    /*     padding-left: 32px; */
    /* } */
    /* ol li { */
    /*     counter-increment: cupcake; */
    /* } */
    /* ol li:before { */
    /*     content: counters(cupcake, '.') ' '; */
    /*     /* Whatever custom styles you want here */ */
    /*     color: rebeccapurple; */
    /*     font-weight: bold; */
    /* } */
</style>
<!--}}}-->
<!--}}}-->

# TODO-List for my QTile config 

## Urgency Levels:
### More than one of these levels can be applied at once
- optional
- recommended
- urgent
- essential
- performance


## ITEMS 

- Testing (optional, performance)
    - First steps by using a script to compile (test with py_compile or qtile check) and run (e4xecute qtile shell commands)
    - Integration Testing with external dependencies like scripts and other programs

- Fallback for external scripts (urgent, performance)
    - Once Testing is complete, the scripts will hopefully tell me what dependencies the program relies upon and, which will need a fallback.
    - Fallback will be either Exception Handling if not fitting fallback is found, or a different script that will be a legacy kind of fallback for the original one. 
    - Either way, the user shall not be wondering what happend (or didn't), thus the next item.
- Feedback (optional, recommended)
    - The user of this config might want to know what script was activated or failed. 
    - It is implied that a user of Linux and let alone tiling WMs will know what he or she is doing. But a visual and most importantely satisfying feedback for actions is awesome.
    - Solutions to this could either be dunst with a custom config for central display of feedback notifications or a custom popup or other effect.
- Faster Startup via autostart.sh (urgent, performance)
    - The current autostart.sh can still be optimized by offloading and or optimizing the way of running scripts. 
    - Some scripts, like the rendering of the lockscreen for betterlockscreen might be done after qtile startet and in the background, thus stopping the further delay of the login sequence (starting of XOrg)
- Setup Script (essential (for releasing))
