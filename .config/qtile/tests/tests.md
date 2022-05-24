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


# QTile Config Tests

> This Document is for the development progress of these tests only.

## Goal
> The goal of these tests is to run through the config files and test their action to make qtile run into fewer errors, which will not be immeadiately noticable after reloading.

## Scope
> The scope of this will be limited to running external processes (which will be tested seperately) and qtile's own functions. All the config files will be parsed by python py_compile and qtiles check function. 


## Process 
### Testing Testing 
> The first script to test my config(s) will be running py_compile or qtile check on one or more config files. It will run a few of qtiles function through the shell and test some dependencies.
