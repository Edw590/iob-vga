SHELL:=/bin/bash

TOP_MODULE=iob_vga

#PATHS
REMOTE_ROOT_DIR ?=sandbox/iob-vga
SIM_DIR ?=$(VGA_HW_DIR)/simulation/$(SIMULATOR)
FPGA_DIR ?=$(VGA_DIR)/hardware/fpga/$(FPGA_COMP)
DOC_DIR ?=

LIB_DIR ?=$(VGA_DIR)/submodules/LIB
VGA_HW_DIR:=$(VGA_DIR)/hardware

#MAKE SW ACCESSIBLE REGISTER
MKREGS:=$(shell find $(LIB_DIR) -name mkregs.py)

#DEFAULT FPGA FAMILY AND FAMILY LIST
FPGA_FAMILY ?=XCKU
FPGA_FAMILY_LIST ?=CYCLONEV-GT XCKU

#DEFAULT DOC AND DOC LIST
DOC ?=pb
DOC_LIST ?=pb ug

# default target
default: sim

# VERSION
VERSION ?=V0.1
$(TOP_MODULE)_version.txt:
	echo $(VERSION) > version.txt

#cpu accessible registers
iob_vga_swreg_def.vh iob_vga_swreg_gen.vh: $(VGA_DIR)/mkregs.conf
	$(MKREGS) iob_vga $(VGA_DIR) HW

vga-gen-clean:
	@rm -rf *# *~ version.txt

.PHONY: default vga-gen-clean
