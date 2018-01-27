def curve(x,y,n)
  x = 100 if x.nil?
  y = 100 if y.nil?
  points = [[x,y]]
  n.times do |t|
    begin
      new_x = [true,false].sample ? (x+rand) : (x-rand)
    end until (x>new_x)
    y = y+rand
    points.push([new_x,y])
  end
  points
end
