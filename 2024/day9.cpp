#include <cassert>
#include <string>
#include <algorithm>

#include "utils.h"

uint64_t Solve(const std::string& filename, int part)
{
    uint64_t answer = 0;
    return answer;
}

int main(int argc, const char** argv)
{
    assert(Solve("../input/day8test", 1) == 14);
//    assert(Solve("../input/day8test", 2) == 34);
    
//    assert(Solve("../input/day8", 1) == 400);
//    assert(Solve("../input/day8", 2) == 1280);

    std::cout << "problem 1:" << Solve("../input/day8", 1) << std::endl;
//    std::cout << "problem 2:" << Solve("../input/day8", 2) << std::endl;

    return 0;
}