ly = RBA::Layout::new; ly.read($input); top = ly.top_cell
hvi = RBA::Region::new(top.begin_shapes_rec(ly.layer(75, 20))).merged
poly = RBA::Region::new(top.begin_shapes_rec(ly.layer(66, 20))).merged
puts "HVI poligonos: #{hvi.size}, bbox #{hvi.bbox.to_s}, area um2 #{hvi.area * ly.dbu * ly.dbu}"
hvi.each { |p| puts "  " + p.bbox.to_s }
puts "poly que cruza el borde de HVI: #{(poly.interacting(hvi) - poly.inside(hvi)).size}"
