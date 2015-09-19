vlog -work work /home/piero/Repositorios/Propios/Vhdl/MaquinaDeEstados/detecsec/Mealy/2Procesos/simulation/modelsim/detecsec.vwf.vt
vsim -novopt -c -t 1ps -L max7000s_ver -L altera_ver -L altera_mf_ver -L 220model_ver -L sgate work.detecsec_vlg_vec_tst
onerror {resume}
add wave {detecsec_vlg_vec_tst/i1/CLK}
add wave {detecsec_vlg_vec_tst/i1/RST}
add wave {detecsec_vlg_vec_tst/i1/Xin}
add wave {detecsec_vlg_vec_tst/i1/Zout}
run -all
