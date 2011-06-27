class SignaturesSweeper < ActionController::Caching::Sweeper

  observe Signatures

  def before_show_refresh(signatures)
   clear_signatures_cache(signatures)
  end


  def after_save(signatures)
   clear_signatures_cache(signatures)
  end

  def after_destroy(signatures)
   clear_signatures_cache(signatures)
  end

  def clear_signatures_cache(signatures)
   expire_page :controller => :signatures, :action=> :show_refresh
   expire_page :controller => :home, :action=> :index

  end



end