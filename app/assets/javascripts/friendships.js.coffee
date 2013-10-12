$ ->
	 ($ "#message_model").modal(show: false,)

	 ($ "#friends_list").fcbkcomplete( ->
                    addontab: true,                   
                    maxitems: 10,
                    height: 10,
                    cache: true,
                    newel: true,
                    select_all_text: "select"
    )

    ($ "body").delegate ".message-link", "click", -> 
        $("#friends_list").trigger "addItem",[{"title": $(this).attr("user_name"), "value": $(this).attr("user_id")}]


    
     
    


    
	
	
    
  
  
  
 