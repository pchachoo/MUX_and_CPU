onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /muxs_tb/input1s
add wave -noupdate /muxs_tb/input2s
add wave -noupdate /muxs_tb/input3s
add wave -noupdate /muxs_tb/input4s
add wave -noupdate /muxs_tb/input5s
add wave -noupdate /muxs_tb/input6s
add wave -noupdate /muxs_tb/input7s
add wave -noupdate /muxs_tb/selectors
add wave -noupdate /muxs_tb/outputs
add wave -noupdate /muxs_tb/input1bit1
add wave -noupdate /muxs_tb/input1bit2
add wave -noupdate /muxs_tb/input1bit3
add wave -noupdate /muxs_tb/input1bit4
add wave -noupdate /muxs_tb/input1bit5
add wave -noupdate /muxs_tb/input1bit6
add wave -noupdate /muxs_tb/input1bit7
add wave -noupdate /muxs_tb/input1bit8
add wave -noupdate /muxs_tb/output1bitor
add wave -noupdate /muxs_tb/output1bitand
add wave -noupdate /muxs_tb/output1bitnot
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {123 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 227
configure wave -valuecolwidth 149
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
WaveRestoreZoom {0 ns} {396 ns}
