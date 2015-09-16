onerror {quit -f}
vlib work
vlog -work work detecsec.vo
vlog -work work detecsec.vt
vsim -novopt -c -t 1ps -L cycloneiv_ver -L altera_ver -L altera_mf_ver -L 220model_ver -L sgate work.detecsec_vlg_vec_tst
vcd file -direction detecsec.msim.vcd
vcd add -internal detecsec_vlg_vec_tst/*
vcd add -internal detecsec_vlg_vec_tst/i1/*
add wave /*
run -all
