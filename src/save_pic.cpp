//
// Created by ljn on 19-12-31.
//
#include <Eigen/Dense>
#include "save_pic.hpp"
SAVEPIC::SAVEPIC() {
    pic_ = cv::Mat1b::zeros(10, 10);
    cv::imshow("pic", pic_);
    Eigen::Vector3d vec{0, 1, 2};
    std::cout << vec << std::endl;
}
