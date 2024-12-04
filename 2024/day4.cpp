#include <cassert>
#include <string>
#include <algorithm>

#include "utils.h"

bool WillFit(int x, int y, int sizeX, int sizeY, int length, EDirection dir)
{
    bool ret = false;
    switch(dir)
    {
        case EDirection::Up:
            ret = (x >= 0) && (x < sizeX) && (y < sizeY) && (y >= length); 
            break;
        case EDirection::Down:
            ret = (x >= 0) && (x < sizeX) && (y <= sizeY - length) && (y > 0); 
            break;
        case EDirection::Left:
            ret = (x >= length) && (x < sizeX) && (y < sizeY) && (y >= 0); 
            break;
        case EDirection::Right:
            ret = (x >= 0) && (x <= sizeX - length) && (y < sizeY) && (y >= 0); 
            break;
        default:       
            break;
    }
    return ret;
}

int Solve(const std::string& filename, int part)
{
    int answer = 0;
    StringVector data = GetFileAsLines(filename);

    String pattern = "XMAS";

    int width = data[0].size();
    int height = data.size();

    for(int x = 0; x < width ; ++x)
    {
        for(int y = 0; y < height ; ++y)
        {
            Vec2 start(x, y);
        }
    }

    return answer;
}

int main(int argc, const char** argv)
{
    assert(Solve("../input/day4test", 1) == 14);
//    assert(Solve("../input/day3test", 2) == 48);
    
//    assert(Solve("../input/day3", 1) == 167090022);
//    assert(Solve("../input/day3", 2) == 89823704);

    std::cout << "problem 1:" << Solve("../input/day3", 1) << std::endl;
//    std::cout << "problem 2:" << Solve("../input/day3", 2) << std::endl;

    return 0;
}