import $ from 'jquery';

//when close modal do something
$(document).ready(function(){
  $('#modal').on('hidden.bs.modal', function() {
    $('.errors').html('')//switch div alert with a blank content
  })
});

