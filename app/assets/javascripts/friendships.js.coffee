$ ->
	#$(".message-link").on('click', ->user_id = $(this).attr("user-id") $("#friends_list option[value="+user_id+"]").attr("class", "selected"))

	$("#message_model").modal(show: false,)

	$("#friends_list").fcbkcomplete( ->
                    addontab: true,                   
                    maxitems: 10,
                    input_min_size: 0,
                    height: 8,
                    cache: true,
                    newel: true,
                    select_all_text: "select",
    )
	
	
    
  
  
  
 