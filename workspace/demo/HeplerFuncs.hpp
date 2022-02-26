#include <jupyter/opencv>
#include <opencv2/core.hpp>
#include <opencv2/imgproc.hpp>

inline bool isPowerOf2(const size_t _Value) {
    return (_Value != 0 && (_Value & (_Value - 1)) == 0);
}

inline void shiftFromCornerToCenter(cv::Mat& src) {
    CV_Assert_2((src.cols & 1) == 0, (src.rows & 1) == 0);
    int halfWidth = src.cols / 2;
    int halfHeight = src.rows / 2;
    cv::Mat leftTop = src(cv::Rect(0, 0, halfWidth, halfHeight));
    cv::Mat rightTop = src(cv::Rect(halfWidth, 0, halfWidth, halfHeight));
    cv::Mat leftBottom = src(cv::Rect(0, halfHeight, halfWidth, halfHeight));
    cv::Mat rightBottom = src(cv::Rect(halfWidth, halfHeight, halfWidth, halfHeight));
    cv::Mat temp;
    // Swap leftTop with rightBottom
    rightBottom.copyTo(temp);
    leftTop.copyTo(rightBottom);
    temp.copyTo(leftTop);
    // Swap rightTop with leftBottom
    rightTop.copyTo(temp);
    leftBottom.copyTo(rightTop);
    temp.copyTo(leftBottom);
}

inline cv::Mat makeRGB(const cv::Mat& image) {
    if (image.type() == CV_8UC3) {
        return image;
    }

    cv::Mat rgbImage;
    if (image.type() == CV_8UC1) {
        cvtColor(image, rgbImage, cv::COLOR_GRAY2RGB);
    }
    else if (image.type() == CV_32FC1) {
        image.convertTo(rgbImage, CV_8U, 255.0);
        cvtColor(rgbImage, rgbImage, cv::COLOR_GRAY2RGB);
    }
    return rgbImage;
}
