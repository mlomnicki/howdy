# Stolen from Steam project by Sven Fuchs http://github.com/svenfuchs/steam
class String
  def underscore
    self[0, 1].downcase + self[1..-1].gsub(/[A-Z]/) { |c| "_#{c.downcase}" }
  end
end unless String.method_defined?(:underscore)
