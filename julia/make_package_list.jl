using Pkg

open("tmp", "w") do tmp
  Pkg.status(io=tmp)
end

cmds = pipeline(`tail -n +2 tmp`, `head -n -1`, `sed 's/^..//'`, `cut -d " " -f 2`, "package_list")
run(cmds)
run(`rm -f tmp`)

println("Package list is created successfully !!")
println("Please look at package_list in the same folder")

