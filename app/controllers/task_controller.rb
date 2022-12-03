require 'json'

class TaskController < ApplicationController
  before_action :raise_error, only: [:show]
  def input
  end

  def show
    str = params[:array]
    if res = Calculation.find_by_array(str)
      @segments = ActiveSupport::JSON::decode( res.segments )
      @max_seg = ActiveSupport::JSON::decode( res.max_seg )
      @count = res.seg_count
      @start = res.array
      @was_created = false
    else
      str
      @max_seg = 0
      arr = str.split(' ').map(&:to_i)
      @segments = get_segments(arr)
      @max_seg = (@segments.max_by { |elem| elem[:length] })[:segment] unless @segments.nil? || @segments.empty?
      @count = @segments.length
      @start = str
      res = Calculation.create(
        array: str, 
        seg_count: @count, 
        max_seg: ActiveSupport::JSON::encode( @max_seg ), 
        segments: ActiveSupport::JSON::encode( @segments ),
      )
      @was_created = true
      res.save
    end
  end

  def calculations
    @calcs = Calculation.all
    render xml: @calcs
  end

  private

  def perfect?(num)
    summ = 0
    ans = false
    (1...num).each do |i|
      summ += i if (num % i).zero?
    end
    ans = true if (summ == num) && num.positive?
    ans
  end

  def get_segments(array)
    result = []
    len = 0
    seg = []
    array.each do |elem|
      if perfect?(elem)
        len += 1
        seg.append(elem)
      else
        result.append({ length: len, segment: seg.join(' ') }) if len.positive?
        len = 0
        seg = []
      end
    end
    result.append({ length: len, segment: seg.join(' ') }) if len.positive?
    result
  end

  def raise_error
    if params[:array].nil? || params[:array].empty?
      flash[:error] = 'Ошибка: параметры не должны быть пустыми.'
      redirect_to root_path
    elsif !params[:array].match(/^( ?-?\d)+$/)
      flash[:error] = 'Ошибка: параметры введены некорректно.'
      redirect_to root_path
    end
  end
end
