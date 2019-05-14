import numpy as np  
import pandas as pd  
import matplotlib.pyplot as plt  

tt="Highlighted points over expressive faces (th=5mm and 10mm)"

df = pd.read_csv("/home/latin/Documentos/MESTRADO/DATA/bosphorus-outlier-density200-crop80-icp/FER/roi/C001_roi_5mm_e_10mm.csv") 

bplot = df.boxplot()

bplot.set_xlabel("Expression",fontsize=12)
bplot.set_ylabel("Proportion of points",fontsize=12)
bplot.tick_params(labelsize=10)

plt.title(tt, fontsize=14)
plt.show()
# output file name
plot_file_name="/home/latin/Documentos/MESTRADO/DATA/bosphorus-outlier-density200-crop80-icp/FER/roi/C001_boxplot_RoI_5mm_e_10mm.png"
 
# save as png
bplot.figure.savefig(plot_file_name,
                    format='png',
                    dpi=300)