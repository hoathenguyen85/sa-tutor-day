# load gemfile_like file to load gems that might be needs to be installed for
# this program to work.
require_relative 'gemfile_like'
# Special object to help visually show how sorting works
require_relative 'visual_data'

require 'colorize'

class Sorter
  attr_reader :array_to_sort

  def initialize(array)
    # This will stay unchanged to show all sorting
    # on this array
    @original_array = []

    # convert the data in array into a VisualData
    # to help visually see the sorting in irb
    array.each do |data|
      @original_array << VisualData.new(data)
    end
  end

  # Best case: O(n^2)
  # Average case: O(n^2)
  # Wosrt Case: O(n^2)
  # Space: O(1)
  def selection_sort
    minimum_index = 0
    index_to_sort = 0

    reset_array_to_sort

    # loop through each index of the array to get the correct
    # minimum to go in this index
    begin
      minimum_index = index_to_sort

      array_to_sort[minimum_index].type = :minimum
      print_array_to_sort

      # start searching for the minimum index after the
      # current index of the first loop
      searching_index = index_to_sort + 1
      begin
        # time to compare the searching index
        array_to_sort[searching_index].type = :comparing
        print_array_to_sort

        # change the index if a new minimum is found
        if array_to_sort[searching_index] < array_to_sort[minimum_index]
          # the old minimum inde is now in the unsorted state
          array_to_sort[minimum_index].type = :unsorted
          print_array_to_sort

          minimum_index = searching_index

          # got the new minimum
          array_to_sort[minimum_index].type = :minimum
          print_array_to_sort
        else
          array_to_sort[searching_index].type = :unsorted
        end

        # increment to next searching index
        searching_index = searching_index + 1
      # end inner loop at the end of array
      end until searching_index == array_to_sort.length

      # swapping
      swap!(array_to_sort, index_to_sort, minimum_index) if index_to_sort != minimum_index

      # done with the index of the outer loop, it is now sorted
      array_to_sort[index_to_sort].type = :sorted

      print_array_to_sort

      # increment to the next index to order next
      index_to_sort = index_to_sort + 1
    # end outer loop at second to last, since last index
    # should be sorted 
    end until index_to_sort == array_to_sort.length - 1

    array_to_sort
  end

  # TODO: fix colouring
  # Best case: O(n)
  # Average case: O(n^2)
  # Worst case: O(n^2)
  # Space: O(1)
  def insertion_sort
    reset_array_to_sort

    index_to_sort = 1

    begin
      compare_index = index_to_sort

      array_to_sort[index_to_sort].type = :comparing
      print_array_to_sort

      until compare_index < 1 || array_to_sort[compare_index - 1] <= array_to_sort[compare_index]
        # swapping
        swap!(array_to_sort, compare_index, compare_index - 1)
        print_array_to_sort
        compare_index = compare_index - 1
      end

      array_to_sort[compare_index].type = :unsorted if(compare_index != index_to_sort)

      array_to_sort[index_to_sort].type = :sorted
      print_array_to_sort

      index_to_sort = index_to_sort + 1
    end until index_to_sort == array_to_sort.length

    array_to_sort
  end

  # Best case: O(n)
  # Average case: O(n^2)
  # Worst case: O(n^2)
  # Space O(1)
  def bubble_sort
    reset_array_to_sort
    swap = true

    until(!swap)
      swap = false

      current_index = 1
      # inner sort compares the current index and the previous index
      until current_index == array_to_sort.length
        array_to_sort[current_index].type = :comparing
        array_to_sort[current_index - 1].type = :comparing
        print_array_to_sort

        if array_to_sort[current_index - 1] > array_to_sort[current_index]
          swap!(array_to_sort, current_index, current_index - 1)
          swap = true

          array_to_sort[current_index].type = :unsorted
          array_to_sort[current_index - 1].type = :unsorted
        else
          array_to_sort[current_index].type = :sorted
          array_to_sort[current_index - 1].type = :sorted
        end
        print_array_to_sort

        current_index = current_index + 1
      end
    end


  end

  private
    def print_array_to_sort
      print "\e[H\e[2J"

      puts ("|%p|" * array_to_sort.length) % array_to_sort

      sleep(0.25)
      print "\e[H\e[2J"
    end

    # hard copy original array in array_to_sort
    # hard copy? 
    # Why not do array_to_sort = original_array?
    #
    # Hard copy means to create a new array object and
    # duplicate from the old array object.
    def reset_array_to_sort
      @original_array.each do |visual_data|
        visual_data.type = :unsorted
      end

      @array_to_sort = @original_array.dup
    end

    def swap!(array, first_index, second_index)
      array[first_index], array[second_index] = array[second_index], array[first_index]
    end
end