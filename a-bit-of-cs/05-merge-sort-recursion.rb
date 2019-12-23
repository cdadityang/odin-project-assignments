def merge_sort(arr)
  return arr if arr.length < 2
  
  left_arr = arr[0..arr.length/2 - 1]
  right_arr = arr[arr.length/2..arr.length - 1]
  
  left_sort = merge_sort(left_arr)
  right_sort = merge_sort(right_arr)
  
  merge(left_sort, right_sort)
end

def merge(left_arr, right_arr)
  new_arr = []
  
  while(left_arr.length != 0 && right_arr.length != 0) do
    n = left_arr.first <= right_arr.first ? left_arr.shift : right_arr.shift
    new_arr << n
  end
  
  new_arr + left_arr + right_arr
end

p merge_sort([4,3,2,1])

p merge_sort([108,15,50,4,8,42,23,16])