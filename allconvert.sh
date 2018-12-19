#!/usr/bin/env bash

# 4IR - SI
/bin/bash convert.sh -q xml/maquettes/maquette_4IR_SI_S1.xml outputs_html/maquette_4IR_SI_S1.html
/bin/bash convert.sh -q xml/maquettes/maquette_4IR_SI_S2.xml outputs_html/maquette_4IR_SI_S2.html

# 4IR - SC
/bin/bash convert.sh -q xml/maquettes/maquette_4IR_SC_S1.xml outputs_html/maquette_4IR_SC_S1.html
/bin/bash convert.sh -q xml/maquettes/maquette_4IR_SC_S2.xml outputs_html/maquette_4IR_SC_S2.html

# 4AE - SE
/bin/bash convert.sh -q xml/maquettes/maquette_4AE_SE_S1.xml outputs_html/maquette_4AE_SE_S1.html
/bin/bash convert.sh -q xml/maquettes/maquette_4AE_SE_S2.xml outputs_html/maquette_4AE_SE_S2.html

# 5 - SDBD
/bin/bash convert.sh -q xml/maquettes/maquetteSDBD1.xml outputs_html/maquetteSDBD1.html
