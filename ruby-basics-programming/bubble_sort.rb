def bubble_sort(arr)
  for i in (1..(arr.size - 1))
    counter = 0
    for j in (0..(arr.size - (i+1)))
      if arr[j] > arr[j+1]
        swap = arr[j]
        arr[j] = arr[j+1]
        arr[j+1] = swap
        counter += 1
      end
    end
    return arr if counter == 0
  end
  arr
end

p bubble_sort([4,3,78,2,0,2])

def bubble_sort_by(arr)
  for i in (1..(arr.size - 1))
    for j in (0..(arr.size - (i+1)))
      diff = yield(arr[j], arr[j+1])
      if diff > 0
        arr[j], arr[j+1] = arr[j+1], arr[j]
      end
    end
  end
  p arr
end

bubble_sort_by(["hi","hello","hey"]) do |left,right|
  left.length - right.length
end