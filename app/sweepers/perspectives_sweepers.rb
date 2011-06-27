class PerspectivesSweeper < ActionController::Caching::Sweeper

  observe Perspectives

  def before_show(perspectives)
   clear_perspectives_cache(perspectives)
  end


  def after_save(perspectives)
   clear_perspectives_cache(perspectives)
  end

  def after_destroy(perspectives)
   clear_perspectives_cache(perspectives)
  end

  def clear_perspectives_cache(perspectives)
   expire_page :controller => perspectives, :action=>show
  end



end