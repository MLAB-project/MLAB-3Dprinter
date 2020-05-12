AMF_DIR := ../amf
STL_DIR := ../../doc/src/stl
ASSEMBLY_STL_DIR := ../../doc/src/stl
IMG_DIR := ../../doc/src/img
SRC_DIR := ./src/4printing
ASSEMBLY_DIR := ./src/assembly
DEP_DIR := ./dep
GCODE_DIR := ../amf/gcode
PLATE_DIMMENSIONS=120
SIMARRANGE=/usr/local/bin/simarrange
STLSORT := stlsort
OPENSCAD_APP := $(shell which openscad || which openscad-nightly)
MERGE_APP := ./merge_modifiers.sh
SLICER_APP := Slic3r
VPATH := $(SRC_DIR):$(DEP_DIR):$(AMF_DIR):$(IMG_DIR)

SOURCES := $(wildcard $(SRC_DIR)/*.scad)
ASSEMBLIES := $(wildcard $(ASSEMBLY_DIR)/*.scad)
AMF := $(wildcard $(AMF_DIR)/*.amf)
STL := $(patsubst $(SRC_DIR)/%.scad, $(STL_DIR)/%.stl, $(SOURCES))
ASSEMBLY := $(patsubst $(ASSEMBLY_DIR)/%.scad, $(ASSEMBLY_STL_DIR)/%.stl, $(ASSEMBLIES))
TARGETS := $(patsubst $(SRC_DIR)/%.scad, $(AMF_DIR)/%.amf, $(SOURCES))
IMAGES := $(patsubst $(SRC_DIR)/%.scad, $(IMG_DIR)/%.png, $(SOURCES))
GCODE := $(patsubst $(AMF_DIR)/%.amf, $(GCODE_DIR)/%.gcode, $(AMF))

all : amf images stl gcode

print : amf gcode

calibration:
	openscad -m make -o calibration.stl calibration.scad

amf : $(TARGETS)

$(AMF_DIR)/%.amf : $(SRC_DIR)/%.scad
	####################################################################################
	# MAKING AMF FOR $<
	####################################################################################
	#
	# Update dependencies and make no-draft version of model in AMF.
	$(OPENSCAD_APP) -D "draft = false" -m make -o $@ -d $(patsubst $(AMF_DIR)/%.amf, $(DEP_DIR)/%.deps, $@) $<
	# Remove absolute paths in dependencies.
	sed -i "s|$(shell pwd)/||" $(patsubst $(AMF_DIR)/%.amf, $(DEP_DIR)/%.deps, $@)
	# Sort deps file to keep git changes to minimum.
	sort -rf $(patsubst $(AMF_DIR)/%.amf, $(DEP_DIR)/%.deps, $@) -o $(patsubst $(AMF_DIR)/%.amf, $(DEP_DIR)/%.deps, $@)
	sed -i 's|[^\]$$|& \\|' $(patsubst $(AMF_DIR)/%.amf, $(DEP_DIR)/%.deps, $@)
	# Add modifiers to AMF files.
	$(MERGE_APP) -a $@ -s $<

include $(wildcard $(DEP_DIR)/*.deps)

stl : $(STL)

$(STL_DIR)/%.stl : $(AMF_DIR)/%.amf
	####################################################################################
	# MAKING STL FOR $<
	####################################################################################
	#
	# Make no-draft version of model in STL.
	$(OPENSCAD_APP) -D "draft = false" -m make -o $@ $(patsubst $(STL_DIR)/%.stl, $(SRC_DIR)/%.scad, $@)
	# Sort stl file to keep git changes to minimum.
	$(STLSORT) $@ || :

images : $(IMAGES)

$(IMG_DIR)/%.png : $(STL_DIR)/%.stl
	####################################################################################
	# MAKING PNG FOR $<
	####################################################################################
	#
	# Create temporary file for fast image rendering.
	echo "import(\"$<\");" > tmp.scad
	# Render PNG image from temporary file.
	$(OPENSCAD_APP) -o $@ tmp.scad
	# Remove temporary file
	rm -f tmp.scad

assembly : $(ASSEMBLY)

$(ASSEMBLY_STL_DIR)/%.stl : $(ASSEMBLY_DIR)/%.scad
	####################################################################################
	# MAKING STL FOR $<
	####################################################################################
	# $(ASSEMBLY_STL_DIR)
	# Update dependencies and make no-draft version of model in STL.
	$(OPENSCAD_APP) -D 'stl_dir = "../../../stl/"' -D "draft = false" -m make -o $@ -d $(patsubst $(ASSEMBLY_STL_DIR)/%.stl, $(DEP_DIR)/%.deps, $@) $<
	# Remove absolute paths in dependencies.
	sed -i "s|$(shell pwd)/||" $(patsubst $(ASSEMBLY_STL_DIR)/%.stl, $(DEP_DIR)/%.deps, $@)
	# Sort deps file to keep git changes to minimum.
	sort -rf $(patsubst $(ASSEMBLY_STL_DIR)/%.stl, $(DEP_DIR)/%.deps, $@) -o $(patsubst $(ASSEMBLY_STL_DIR)/%.stl, $(DEP_DIR)/%.deps, $@)
	sed -i 's|[^\]$$|& \\|' $(patsubst $(ASSEMBLY_STL_DIR)/%.stl, $(DEP_DIR)/%.deps, $@)

gcode : $(GCODE)

$(GCODE_DIR)/%.gcode : $(AMF_DIR)/%.amf
	####################################################################################
	# MAKING GCODE FOR $<
	####################################################################################
	#
	# Generate gcode files.
	$(SLICER_APP) --load $(SRC_DIR)/config.ini -o $@ --no-gui -j 3 $<

arrange : amf
	$(SIMARRANGE) -x $(PLATE_DIMMENSIONS) -y $(PLATE_DIMMENSIONS) $(ARRANGE_TARGETS)

clean:
	rm -f calibration.stl
	rm -f $(AMF_DIR)/*.amf
	rm -f $(STL_DIR)/*.stl
	rm -f $(IMG_DIR)/*.png
