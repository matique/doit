My = Object.new
class << My

  def verbose(what, txt)
    marker = '*'*4
    arr = txt
    arr = txt ? txt.split("\n") : ''  unless Array === txt
    if arr.length > 1
      puts "#{marker} #{what} #{marker}"
      puts txt
      puts marker
    else
      puts "#{marker} #{what}: #{txt}"
    end
  end

end
