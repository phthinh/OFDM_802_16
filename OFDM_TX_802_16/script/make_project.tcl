# Function:
#   Generate a vivado project for the IEEE 802.16 based transmitting system

set orig_dir ".."
set work_dir "."
set project_name "OFDM_TX_802_16"
set part "xc7z020clg484-1"
#set project_name [lindex $argv 0]
#set orig_dir [lindex $argv 1]
#set work_dir [lindex $argv 2]
#set part	[lindex $argv 3]

# Set the directory path for the original project from where this script was exported
set orig_proj_dir [file normalize $work_dir/$project_name]

# Create project
create_project $project_name $work_dir/$project_name

# Set the directory path for the new project
set proj_dir [get_property directory [current_project]]

# Set project properties
set obj [get_projects $project_name]
set_property -name "default_lib" -value "xil_defaultlib" -objects  $obj
set_property -name "PART" -value  $part -objects  $obj 

# Create 'sources_1' fileset (if not found)
if {[string equal [get_filesets -quiet sources_1] ""]} {
  create_fileset -srcset sources_1
}

# Set 'sources_1' fileset object
set files [list \
			[file normalize $orig_dir/MY_SOURCES/IFFT_Mod.v] \
			[file normalize $orig_dir/MY_SOURCES/Pilots_Insert.v] \
			[file normalize $orig_dir/MY_SOURCES/QPSK_Mod.v] \
			[file normalize $orig_dir/MY_SOURCES/Tx_Out.v] \
			[file normalize $orig_dir/MY_SOURCES/OFDM_TX_802_16.v] \
			[file normalize $orig_dir/MY_SOURCES/Pilot_seq.txt] \
			[file normalize $orig_dir/MY_SOURCES/Pre.txt] \
              ]
add_files -norecurse -fileset [get_filesets sources_1] $files

# Set 'sources_1' fileset file properties for remote files
set file "$orig_dir/MY_SOURCES/Pilot_seq.txt"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "Data Files" -objects $file_obj

set file "$orig_dir/MY_SOURCES/Pre.txt"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "Data Files" -objects $file_obj

#set_property verilog_define [list FPGA Single_ended_clock_capable_pin] [get_filesets sources_1] 

# Set 'sources_1' fileset properties
set_property "top" "OFDM_TX_802_16" [get_filesets sources_1]

#IFFT
create_ip -name xfft -vendor xilinx.com -library ip -version 9.1 -module_name ifft
set_property -dict [list \
						CONFIG.aresetn {true} \
						CONFIG.channels {1} \
						CONFIG.output_ordering {natural_order}	\
						CONFIG.butterfly_type {use_xtremedsp_slices} \
						CONFIG.implementation_options {pipelined_streaming_io} \
						CONFIG.complex_mult_type {use_mults_resources} \
						CONFIG.rounding_modes {truncation} \
						CONFIG.transform_length {256} \
						CONFIG.cyclic_prefix_insertion {true} \
						CONFIG.data_format {fixed_point} \
						CONFIG.input_width {16} \
						CONFIG.phase_factor_width {16}] \
	[get_ips ifft]
generate_target {instantiation_template} [get_files $proj_dir/$project_name.srcs/sources_1/ip/ifft/ifft.xci]


# Create 'constrs_1' fileset (if not found)
if {[string equal [get_filesets -quiet constrs_1] ""]} {
  create_fileset -constrset constrs_1
}

# Set 'constrs_1' fileset object
set obj [get_filesets constrs_1]

# Add/Import constrs file and set constrs file properties
#set file "[file normalize "$work_dir/../board/$target/constraint/$target.xdc"]"
#set file_added [add_files -norecurse -fileset $obj $file]

# generate all IP source code
generate_target all [get_ips]

# force create the synth_1 path (need to make soft link in Makefile)
launch_runs -scripts_only synth_1

# Create 'sim_1' fileset (if not found)
if {[string equal [get_filesets -quiet sim_1] ""]} {
  create_fileset -simset sim_1
}

# Set 'sim_1' fileset object
set obj [get_filesets sim_1]
set files [list \
 [file normalize $orig_dir/MY_SOURCES/OFDM_TX_tb.v] \
]
add_files -norecurse -fileset $obj $files

# Set 'sim_1' fileset properties
set obj [get_filesets sim_1]
set_property -name "top" -value "OFDM_TX_tb" -objects $obj
set_property -name "top_lib" -value "xil_defaultlib" -objects $obj


# suppress some not very useful messages
# warning partial connection
set_msg_config -id "\[Synth 8-350\]" -suppress
# info do synthesis
set_msg_config -id "\[Synth 8-256\]" -suppress
set_msg_config -id "\[Synth 8-638\]" -suppress
# BRAM mapped to LUT due to optimization
set_msg_config -id "\[Synth 8-3969\]" -suppress
# BRAM with no output register
set_msg_config -id "\[Synth 8-4480\]" -suppress
# DSP without input pipelining
set_msg_config -id "\[Drc 23-20\]" -suppress
# Update IP version
set_msg_config -id "\[Netlist 29-345\]" -suppress


# do not flatten design
set_property STEPS.SYNTH_DESIGN.ARGS.FLATTEN_HIERARCHY none [get_runs synth_1]