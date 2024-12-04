#include <filesystem>
#include <cassert>
#include "utils.h"
#include <set>

int solve(Path path, int part)
{
    int answer = 0;
    StringVector lines = GetFileAsLines(path);
    std::set<Vec2> houseSet;
    if(part == 1)
    {
        int x = 0;
        int y = 0;
        Vec2 c = {0,0};

        answer = houseSet.size();
    }
    else
    {

    }
    return answer;
}

int main(int argc, const char** argv)
{
    assert(solve("../input/day2", 1) == 2081);
//    assert(solve("../input/day2", 2) == 3783758);

    std::cout << "problem 1:" << solve("../input/day3", 1) << std::endl;
//    std::cout << "problem 2:" << solve("../input/day2", 2) << std::endl;

    return 0;
}