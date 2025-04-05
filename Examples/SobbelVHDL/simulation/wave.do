onerror {resume}
radix define States {
    "2'b00" "Play" -color "cyan",
    "2'b01" "Pause" -color "orange",
    "2'b10" "Seek" -color "blue",
    "2'b11" "Stop" -color "green",
    -default hexadecimal
    -defaultcolor white
}
quietly WaveActivateNextPane {} 0
add wave -noupdate /dj_roomba_3000_tb/uut/dj_roomba_inst/clk
add wave -noupdate /dj_roomba_3000_tb/uut/dj_roomba_inst/reset
add wave -noupdate -expand -group Lab8 /dj_roomba_3000_tb/uut/dj_roomba_inst/execute_btn
add wave -noupdate -expand -group Lab8 /dj_roomba_3000_tb/uut/dj_roomba_inst/execute_flag
add wave -noupdate -expand -group Lab8 /dj_roomba_3000_tb/uut/dj_roomba_inst/sync
add wave -noupdate -expand -group Lab8 /dj_roomba_3000_tb/uut/dj_roomba_inst/sync_flag
add wave -noupdate -expand -group Lab8 /dj_roomba_3000_tb/uut/dj_roomba_inst/led
add wave -noupdate -expand -group Lab8 -radix decimal /dj_roomba_3000_tb/uut/dj_roomba_inst/audio_out
add wave -noupdate -expand -group Lab8 -radix unsigned /dj_roomba_3000_tb/uut/dj_roomba_inst/data_address
add wave -noupdate -expand -group Lab8 -radix States /dj_roomba_3000_tb/uut/dj_roomba_inst/op_code
add wave -noupdate -expand -group Lab8 /dj_roomba_3000_tb/uut/dj_roomba_inst/repeat
add wave -noupdate -expand -group Lab8 -radix decimal /dj_roomba_3000_tb/uut/dj_roomba_inst/instr_address
add wave -noupdate -expand -group Lab8 -radix binary /dj_roomba_3000_tb/uut/dj_roomba_inst/instr_data
add wave -noupdate -expand -group Lab8 /dj_roomba_3000_tb/uut/dj_roomba_inst/error_flag
add wave -noupdate -expand -group Lab8 /dj_roomba_3000_tb/uut/dj_roomba_inst/current_state
add wave -noupdate -expand -group Honors -radix decimal /dj_roomba_3000_tb/uut/dj_roomba_inst/echo_int
add wave -noupdate -expand -group Honors -radix decimal /dj_roomba_3000_tb/uut/dj_roomba_inst/play_int
add wave -noupdate -expand -group Honors /dj_roomba_3000_tb/uut/echo
add wave -noupdate -expand -group Honors -radix decimal /dj_roomba_3000_tb/uut/dj_roomba_audio_out
add wave -noupdate -expand -group Honors -radix decimal -childformat {{/dj_roomba_3000_tb/uut/filtered_audio(15) -radix decimal} {/dj_roomba_3000_tb/uut/filtered_audio(14) -radix decimal} {/dj_roomba_3000_tb/uut/filtered_audio(13) -radix decimal} {/dj_roomba_3000_tb/uut/filtered_audio(12) -radix decimal} {/dj_roomba_3000_tb/uut/filtered_audio(11) -radix decimal} {/dj_roomba_3000_tb/uut/filtered_audio(10) -radix decimal} {/dj_roomba_3000_tb/uut/filtered_audio(9) -radix decimal} {/dj_roomba_3000_tb/uut/filtered_audio(8) -radix decimal} {/dj_roomba_3000_tb/uut/filtered_audio(7) -radix decimal} {/dj_roomba_3000_tb/uut/filtered_audio(6) -radix decimal} {/dj_roomba_3000_tb/uut/filtered_audio(5) -radix decimal} {/dj_roomba_3000_tb/uut/filtered_audio(4) -radix decimal} {/dj_roomba_3000_tb/uut/filtered_audio(3) -radix decimal} {/dj_roomba_3000_tb/uut/filtered_audio(2) -radix decimal} {/dj_roomba_3000_tb/uut/filtered_audio(1) -radix decimal} {/dj_roomba_3000_tb/uut/filtered_audio(0) -radix decimal}} -subitemconfig {/dj_roomba_3000_tb/uut/filtered_audio(15) {-height 15 -radix decimal} /dj_roomba_3000_tb/uut/filtered_audio(14) {-height 15 -radix decimal} /dj_roomba_3000_tb/uut/filtered_audio(13) {-height 15 -radix decimal} /dj_roomba_3000_tb/uut/filtered_audio(12) {-height 15 -radix decimal} /dj_roomba_3000_tb/uut/filtered_audio(11) {-height 15 -radix decimal} /dj_roomba_3000_tb/uut/filtered_audio(10) {-height 15 -radix decimal} /dj_roomba_3000_tb/uut/filtered_audio(9) {-height 15 -radix decimal} /dj_roomba_3000_tb/uut/filtered_audio(8) {-height 15 -radix decimal} /dj_roomba_3000_tb/uut/filtered_audio(7) {-height 15 -radix decimal} /dj_roomba_3000_tb/uut/filtered_audio(6) {-height 15 -radix decimal} /dj_roomba_3000_tb/uut/filtered_audio(5) {-height 15 -radix decimal} /dj_roomba_3000_tb/uut/filtered_audio(4) {-height 15 -radix decimal} /dj_roomba_3000_tb/uut/filtered_audio(3) {-height 15 -radix decimal} /dj_roomba_3000_tb/uut/filtered_audio(2) {-height 15 -radix decimal} /dj_roomba_3000_tb/uut/filtered_audio(1) {-height 15 -radix decimal} /dj_roomba_3000_tb/uut/filtered_audio(0) {-height 15 -radix decimal}} /dj_roomba_3000_tb/uut/filtered_audio
add wave -noupdate -expand -group Honors -radix decimal /dj_roomba_3000_tb/uut/distort_filter_audio
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {7477 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 202
configure wave -valuecolwidth 48
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits us
update
WaveRestoreZoom {0 ns} {37800 ns}
