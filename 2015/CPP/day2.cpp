#include <filesystem>
#include <cassert>
#include "utils.h"

int solve(std::filesystem::path path, int part)
{
    int answer = 0;
    std::vector<std::string> lines = GetFileAsLines(path);

    return answer;
}

int main(int argc, const char** argv)
{
    assert(solve("../input/day2", 1) == 1588178);
//    assert(solve("../input/day2", 2) == 3783758);

    std::cout << "problem 1:" << solve("../input/day2", 1) << std::endl;
    std::cout << "problem 2:" << solve("../input/day2", 2) << std::endl;

    return 0;
}