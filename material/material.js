/* Copyright 2014+, Federico Zivolo, LICENSE at https://github.com/FezVrasta/bootstrap-material-design/blob/master/LICENSE.md */

$(function (){

    ripples.init(".btn:not(.btn-link), .navbar a, .nav-tabs a, .withripple");

    // Add fake-checkbox to material checkboxes
    $(".checkbox label input").after("<span class=ripple></span><span class=check></span>");

    // Add fake-radio to material radios
    $(".radio label input").after("<span class=ripple></span><span class=circle></span><span class=check></span>");

    // Add elements for material inputs
    $("input.form-control, textarea.form-control, select.form-control").each( function() {
        $(this).wrap("<div class=form-control-wrapper></div>");
        $(this).after("<span class=material-input></span>");
        if ($(this).hasClass("floating-label")) {
            var placeholder = $(this).attr("placeholder");
            $(this).attr("placeholder", null).removeClass("floating-label");
            $(this).after("<div class=floating-label>" + placeholder + "</div>");
        }
        if ($(this).val() === "") {
            $(this).addClass("empty");
        }
    });

    $(document).on("keyup", ".form-control", function() {
        if ($(this).val() !== "") {
            $(this).removeClass("empty");
        } else {
            $(this).addClass("empty");
        }
    });
});
