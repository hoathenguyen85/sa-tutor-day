class VisualData
  # if the Data has been sorted, current one,
  # or comparing with the current.
  attr_accessor :type
  attr_reader :data

  def initialize(data)
    @data = data
    @type = :unsorted
  end

  # how puts will show this object
  def inspect
    case(@type)
    when :unsorted
      @data.to_s.colorize(:red)
    when :minimum
      @data.to_s.colorize(:yellow)
    when :comparing
      @data.to_s.colorize(:blue)
    when :sorted
      @data.to_s.colorize(:green)
    end
  end

  # override some basic comparison operator's to work
  # with the data attribute
  def <(other_visual_data)
    @data < other_visual_data.data
  end

  def >(other_visual_data)
    @data > other_visual_data.data
  end

  def <=(other_visual_data)
    @data <= other_visual_data.data
  end

  def >=(other_visual_data)
    @data >= other_visual_data.data
  end
end