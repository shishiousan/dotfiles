using Pkg

open("./package_list", "r") do df
  list = readlines(df)
  Pkg.add(list)
  Pkg.update()
end


