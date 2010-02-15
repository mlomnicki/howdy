class String

  # Returns true if string include digits only
  def integer?
    !!(self =~ /[0-9]+/)
  end

end unless String.method_defined?(:integer?) 
