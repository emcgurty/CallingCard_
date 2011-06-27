def action_with_many_tabs
    # id is a label name
    @current_id = params[:id] || @Model.find(:first).label
    return false unless request.post?
    #your action code here
end