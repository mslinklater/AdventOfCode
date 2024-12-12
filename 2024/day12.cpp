#include <cassert>
#include <string>
#include <algorithm>
#include <list>

#include "utils.h"

uint64_t Solve(const std::string& filename, int part)
{
    uint64_t answer = 0;
    return answer;
}

int main(int argc, const char** argv)
{
    assert(Solve("../input/day12test", 1) == 0);
//    assert(Solve("../input/day11test", 1, 25) == 55312);    // 25 times

//    assert(Solve("../input/day11", 1, 25) == 216996);
//    assert(Solve("../input/day11", 1, 75) == 257335372288947);

    std::cout << "problem 1:" << Solve("../input/day11", 1) << std::endl;
//    std::cout << "problem 2:" << Solve("../input/day11", 1, 75) << std::endl;

    return 0;
}
