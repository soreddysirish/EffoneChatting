module GroupmessagesHelper
 def self_or_other(text)
    text.user == current_user ? "self" : "other"
  end

end
