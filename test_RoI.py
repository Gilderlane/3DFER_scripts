''' Aims to highlight regions of interest based on the comparison
between expressive face point clouds'''

from open3d import *
import numpy as np
from scipy.spatial.distance import euclidean
from sklearn.neighbors import NearestNeighbors

expressions= {"ANGER", "DISGUST", "FEAR", "HAPPY", "SADNESS", "SURPRISE"}
subjects={"bs000","bs001","bs002","bs003","bs004","bs005","bs006","bs008","bs009","bs011","bs012","bs014","bs015","bs016","bs017","bs018","bs019","bs021","bs022","bs023","bs024","bs025","bs026","bs027","bs028","bs029","bs030","bs031","bs032","bs033","bs034","bs035","bs036","bs037","bs038","bs039","bs040","bs041","bs042","bs043","bs044","bs045","bs046","bs082","bs083","bs084","bs085","bs086","bs087","bs088","bs089","bs090","bs091","bs093","bs094","bs095","bs096","bs097","bs098","bs099","bs100","bs101","bs102","bs103","bs104"}

for SUB in subjects:
	print("----------------")
	print(SUB)
	cloudN = "../../DATA/bosphorus-outlier-density200-crop80-icp/FER/faces/neutrals/"+SUB+"_N_N_0.pcd"
	cloudE = "../../DATA/bosphorus-outlier-density200-crop80-icp/FER/faces/emotions/"+SUB+"_E_SURPRISE_0.pcd"
	# threshold em milimetros
	threshold=3
	pcdN = read_point_cloud(cloudN)
	pcdE = read_point_cloud(cloudE)

	xyzN = np.asarray(pcdN.points)
	xyzE = np.asarray(pcdE.points)

	nbrs = NearestNeighbors(n_neighbors=1, algorithm='ball_tree').fit(xyzE)
	distances, indices = nbrs.kneighbors(xyzN)

	print("Quantos pontos possuem distancia superior ao threshold?")
	print(sum(distances>threshold))
	print("Quais sao os indices desses pontos na nuvem?")
	print(indices)
	xyzDiff = xyzE[indices[distances>threshold]]

	# ===Visualization	
	pcdDiff = PointCloud()
	pcdDiff.points = Vector3dVector(xyzDiff)
	pcdDiff.paint_uniform_color(np.asarray([255,0,0]))

	pcdE.paint_uniform_color(np.asarray([0,0,255]))

	pcdN.paint_uniform_color(np.asarray([0,0,0]))
	draw_geometries([pcdDiff, pcdE, pcdN])
	# ===

	#draw_geometries([pcdDiff])
	# vis = Visualizer()
	# vis.create_window()
	# vis.add_geometry(pcdDiff)
	# opt = vis.get_render_option()
	# opt.background_color = np.asarray([0, 0, 0])
	# vis.run()
	# vis.capture_screen_image("../../DATA/bosphorus-outlier-density200-crop80-icp/FER/diff/"+SUB+"_E_ANGER_0.png")
	# vis.close()
	# print(opt)