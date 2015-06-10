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

  # Best case: O(n log(n))
  # Average Case: O(n log(n))
  # Worst Case: O(n^2)
  # Space: O(log(n))
  def quick_sort(pivot_type = :lo)
    reset_array_to_sort

    quick_sort_recursion(array_to_sort, 0, array_to_sort.length - 1, pivot_type)
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

    def partition(array, low_index, high_index)
      pivot_index = (low_index + high_index) / 2
      pivotValue = array[]
      #put the chosen pivot at A[hi]

      swap!(array, pivot_index, high_index)
    end

    def done_sorting?(low_index, high_index, pivot)
      pivot == :lo ? low_index >= high_index : low_index <= high_index
    end

    def pivot_index(low_index, high_index, pivot)
      pivot == :lo ? low_index : high_index
    end

    def quick_sort_recursion(array, low_index, high_index, pivot_type)
      if done_sorting?(low_index, high_index, pivot_type)
          # Done sorting
          return array
      end

      # Take a pivot value, at the far left
      pivot = array[pivot_index(low_index, high_index, pivot_type)]

      # Min and Max pointers
      min = low_index
      max = high_index

      # Current free slot
      free = min

      while min < max
        if free == min # Evaluate array[max]
          if array[max] <= pivot # Smaller than pivot, must move
            array[free] = array[max]
            min += 1
            free = max
            print_array_to_sort
          else
            max -= 1
          end
        elsif free == max # Evaluate array[min]
          if array[min] >= pivot # Bigger than pivot, must move
            array[free] = array[min]
            max -= 1
            free = min
            print_array_to_sort
          else
            min += 1
          end
        else
          raise "Inconsistent state"
        end
      end

      array[free] = pivot
      print_array_to_sort

      quick_sort_recursion(array, low_index, free - 1, pivot_type)
      quick_sort_recursion(array, free + 1, high_index, pivot_type)
    end
end