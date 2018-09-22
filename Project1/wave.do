onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /mux_tb/input1s
add wave -noupdate /mux_tb/input2s
add wave -noupdate /mux_tb/input3s
add wave -noupdate /mux_tb/input4s
add wave -noupdate /mux_tb/input5s
add wave -noupdate /mux_tb/input6s
add wave -noupdate /mux_tb/input7s
add wave -noupdate /mux_tb/selectors
add wave -noupdate /mux_tb/outputs
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ns} 0}
quietly wave cursor active 0
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {0 ns} {1 us}
