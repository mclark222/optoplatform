$(document).ready(function () {

    //Nav mobile
    $('.jsNavMobile').click(function () {
        $(".left-menu").toggleClass("left-menu-show");
        $(".content").toggleClass("content-blur");
        $("body").toggleClass("no-scroll");
        $(this).toggleClass("nav-mobile-close");
    });

    //Custom JS fr accordion component 
    // When any accordion title is clicked
    $(".accordion-title").click(function () {
        const $accordion_wrapper = $(this).parent();
        const $accordion_content = $(this).parent().find(".accordion-content").first();
        const $accordion_open = "accordion-open";

        // If this accordion is already open
        if ($accordion_wrapper.hasClass($accordion_open)) {
            $accordion_content.slideUp(); // Close the content
            $accordion_wrapper.removeClass($accordion_open); // Remove the accordionm--open class
        }
        // If this accordion is not already open
        else {
            $accordion_content.slideDown(); // Show this accordion's content
            $accordion_wrapper.addClass($accordion_open); // Add the accordion--open class
        }
    });

    //Modal
    $('.modal-open').click(function () {
        $('.modal').fadeOut(200);
        var targetModal = '#' + $(this).data('modal');
        $(targetModal).fadeIn(200);
        $("body").addClass("no-scroll");
    });

    $(document).click(function (e) {
        if ($(e.target).closest('.modal-open,.modal-content').length === 0) {
            $('.modal').fadeOut();
            $("body").removeClass("no-scroll");
        }
    });

    $(document).on('keydown', function (e) {
        if (e.keyCode === 27) { // ESC
            $('.modal').fadeOut();
            $("body").removeClass("no-scroll");
        }
    });

    //Accordion table buttons
    $(".jsAccordionEdit").click(function () {
        $(this).parent().parent().addClass("accordion-table-edit-mote");
    });
    $(".jsAccordionSave").click(function () {
        $(this).parent().parent().removeClass("accordion-table-edit-mote");
    });
    $(".jsAccordionDelete").click(function () {
        $(this).parent().parent().remove();
    });

});
