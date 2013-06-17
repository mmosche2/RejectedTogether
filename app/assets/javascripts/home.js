
var reject_messages = ['Thanks for the free REJECTION :)', 'really, again? how old are you?', 
											 'hey, stop that!', 
											 'just signup already - I mean, COME ON!', 'is this fun for you?',
											 'I am rubber and you are glue, so ha #burn', 'now you are making me sad... :(',
											 'can we just be friends? eh? what do you say, friend?',
											 'fine. I am not listening anymore, I am going away', 
											 '...', 'ok im still here. guess what, now im like you - ewww leave me alone',
											 'leave me alone!!!!!!!!! friend?', 'if you press it again, i have a surprise for you',
											 'BOOOOOOOOOOOOOO', 'hahaha! got ya good', 'ok seriously, this has to count for so many rejections',
											 'if Rejection Therapy was a game, you are helping me win', 'im bored of you. bye','']
var rm_id=0


$(document).ready(function(){

	$('#HomeReject').mouseup(function(){
		if (rm_id == 13){
			$('body').css('background-color','black')
			$('#Tagline').addClass('largest')
		}
		if (rm_id == 14){
			$('body').css('background-color','#ffffff')
			$('#Tagline').removeClass('largest')
		}
		$('#Tagline').html(reject_messages[rm_id]);
		rm_id++;
	});

	$('.comment_body_input').blur(function(){
		var input_val = $.trim($(this).val());
		if( !input_val || input_val == "") {
			$(this).siblings('.submit_comment').addClass('hidden');
			//alert("i would have submitted here");
		}
	});
	$('.comment_body_input').focus(function(){
		$(this).siblings('.submit_comment').removeClass('hidden');
	});


})