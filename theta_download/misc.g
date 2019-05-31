//genesis

function distribute_cells_on_circle (cells, radius)
str cells
float radius

float PI = 3.14159
str c_name
str compi
int cellno
float fi=0
float dfi
float dx
float dy
cellno = {getarg {el {cells}} -count}
dfi = 2 * {PI} / {cellno}

    foreach c_name ({el {cells}})
        dx = {radius} * {cos {fi}}
        dy = {radius} * {sin {fi}}
        foreach compi ({el {c_name}/##[OBJECT=compartment]})
            setfield {compi} x {{getfield {compi} x} + dx}
            setfield {compi} x0 {{getfield {compi} x0} + dx}
            setfield {compi} y {{getfield {compi} y} + dy}
            setfield {compi} y0 {{getfield {compi} y0} + dy}
        end
        fi = fi + dfi
    end
end
