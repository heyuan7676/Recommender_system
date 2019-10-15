function RMSE=RMSE(prediction,groundtruth)
omega_test=double(groundtruth>0);
RMSE=sqrt(sum(sum((prediction.*omega_test-groundtruth).^2))/sum(sum(omega_test)));