// # Place all the behaviors and hooks related to the matching controller here.
// # All this logic will automatically be available in application.js.
// # You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$(document).ready(function () {

$('.delete_dx').bind('ajax:success', function() {  
    $(this).closest('tr').fadeOut();  
});
// $('.edit-treatment-search').live('keydown',function (e) {
//         var keyCode = e.keyCode || e.which;

//         if (keyCode == 9 || keyCode == 13) {
//             $(this).parent().removeClass('open');
//             $(this).data('cui', "");
//             // call custom function here
//         }
// });

//$('.edit-button').click(function){
//live("click", function () {
        //make the disorder edit form show
        //$(this).('.disorder-edit').removeClass('hidden');
//$('.disorder-edit').removeClass('hidden');
};
//};
//         $(this).parent().addClass('info');
//         $('#edit-prescription').empty();
//         $('#prescriptions').empty();


// function 

// call something after the page is finished loading

// $function


// function edit_listener onClick 

// know which row you're editting

//     <div class="disorder edit hidden">
//       <%= form_tag(dx_path(dx), :remote => true, :method => "Put") do %>
//         <%= text_area_tag("message", nil, :class => 'message') %>
//         <%= submit_tag("Submit changes", :class => 'btn btn-primary') %>
//       <% end %>

//       <%= form_tag(dx_path(dx), :remote => true, :method => "Put", :class => 'cancel') do %>
//         <%= submit_tag("Cancel", :class => 'btn btn-danger action') %>
//       <% end %>
//     </div>


// when the page finishes loading

// create new item for class

// .live use that class, new item with that class, link to that function to call

