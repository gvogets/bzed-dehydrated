# Returns the contents of a file - or nil
# if the file does not exist. based on file.rb from puppet.

Puppet::Parser::Functions.newfunction(
  :dehydrated_file,
  type: :rvalue,
  doc: <<-EOS
  Return the contents of a file.  Multiple files
  can be passed, and the first file that exists will be read in.
  EOS
) do |vals|
  vals.each do |file|
    unless Puppet::Util.absolute_path?(file)
      raise(Puppet::ParseError, 'Files must be fully qualified')
    end
    if FileTest.exists?(file)
      File.read(file)
      break
    end
  end
  nil
end
