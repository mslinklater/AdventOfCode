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
    assert(Solve("../input/day10test", 1) == 36);
//    assert(Solve("../input/day9test", 2) == 2858);

//    assert(Solve("../input/day9", 1) == 6463499258318);
//    assert(Solve("../input/day9", 2) == 6493634986625);

    std::cout << "problem 1:" << Solve("../input/day9", 1) << std::endl;
//    std::cout << "problem 2:" << Solve("../input/day9", 2) << std::endl;

    return 0;
}
