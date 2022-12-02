class PayloadParser
  attr_accessor :file_name

  def initialize(file_name:)
    @file_name = file_name
    # probably need some manner of handling by type?
  end

  def run
    # confirm the file exists
    # read the file as a stream, break where it goes based on two consecutive
    # newlines
  end
end
