class CalorieParser
  attr_accessor :contents, :data, :input_file

  def initialize(input_file:)
    @input_file = input_file
    @data = []

    # TODO: Probably need some manner of handling by type?
  end

  def run
    # confirm the file exists
    # read the file as a stream, break where it goes based on two consecutive
    # newlines
    i = 0
    File.foreach(input_file) do |line|
      i += 1 if line.match(/^\n/)
      next if line.match(/^\n/)

      data[i] = [] if data[i].nil?
      data[i] << line.chomp
    end
  end

  def results
    data
  end
end
