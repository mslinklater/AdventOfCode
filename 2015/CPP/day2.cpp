#include <filesystem>
#include <cassert>
#include "utils.h"

int solve(Path path, int part)
{
    int answer = 0;
    StringVector lines = GetFileAsLines(path);

    for(auto line : lines)
    {
        int firstX = line.find("x");
        int secondX = line.find("x", firstX + 1);
        int x = std::stoi(line.substr(0, firstX));
        int y = std::stoi(line.substr(firstX + 1, secondX - firstX - 1));
        int z = std::stoi(line.substr(secondX + 1));
        int paperZ = x * y;
        int paperY = x * z;
        int paperX = y * z;
        
        if(part == 1)
        {
            answer += std::min(paperX, std::min(paperY, paperZ)) + paperX * 2 + paperY * 2 + paperZ * 2;
        }
        else
        {
            answer += x * y * z;
            if(paperX < std::min(paperY, paperZ))
            {
                answer += (y + z) * 2;
            }
            else if(paperY < paperZ)
            {
                answer += (x + z) * 2;
            }
            else
            {
                answer += (x + y) * 2;
            }
        }
    }

    return answer;
}

int main(int argc, const char** argv)
{
    assert(solve("../input/day2", 1) == 1588178);
    assert(solve("../input/day2", 2) == 3783758);

    std::cout << "problem 1:" << solve("../input/day2", 1) << std::endl;
    std::cout << "problem 2:" << solve("../input/day2", 2) << std::endl;

    return 0;
}