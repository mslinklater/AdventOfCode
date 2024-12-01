#include <filesystem>
#include <cassert>
#include "utils.h"

int solve(std::filesystem::path path, int part)
{
    int answer = 0;

    std::vector<std::string> lines = GetFileAsLines(path);

    if(part == 1)
    {
        for( auto x : lines[0])
        {
            if(x == '(') answer++;
            if(x == ')') answer--;
        }
    }
    else
    {
        int floor = 0;
        int index = 0;
        for( auto x : lines[0])
        {
            if(x == '(') floor++;
            if(x == ')') floor--;
            index++;
            if(floor == -1)
            {
                return index;
            }
        }
    }

    return answer;
}

int main(int argc, const char** argv)
{
    assert(solve("../input/day1", 1) == 74);
    assert(solve("../input/day1", 2) == 1795);

    std::cout << "problem 1:" << solve("../input/day1", 1) << std::endl;
    std::cout << "problem 2:" << solve("../input/day1", 2) << std::endl;

    return 0;
}