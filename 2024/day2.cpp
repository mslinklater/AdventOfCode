#include <cassert>
#include <string>
#include <algorithm>

#include "utils.h"

enum class EDir
{
    kUnknown,
    kInvalid,
    kUp,
    kDown
};

EDir CalcPair(int a, int b, EDir last)
{
    if(a == b) return EDir::kInvalid;
    if(std::abs(a-b) > 3) return EDir::kInvalid;

    EDir ans = (a - b <0) ? EDir::kUp : EDir::kDown;

    if(last == EDir::kUnknown) return ans;
    if(last == ans) return ans;
    return EDir::kInvalid;
}

int Solve(const std::string& filename, int part)
{
    int answer = 0;

    std::vector<std::string> file = GetFileAsLines(filename);

    for(auto line : file)
    {
        std::vector<std::string> entries = SplitStringByChar(line, ' ');
        std::vector<int> numbers = IntVecFromStringVec(entries);

        if(part == 1)
        {
            bool safe = true;
            EDir last = EDir::kUnknown;
            for(int i=0 ; i<entries.size()-1 ; ++i)
            {
                EDir next = CalcPair(numbers[i], numbers[i+1], last);
                last = next;
                safe &= last != EDir::kInvalid;
            }
            if(safe)
            {
                answer++;
            }
        }
        else
        {
            // do part 2 and clean up
        }
    }
    return answer;
}

int main(int argc, const char** argv)
{
    assert(Solve("../input/day2test", 1) == 2);
    
    assert(Solve("../input/day2", 1) == 502);
//    assert(solve("../input/day1", 2) == 26859182);

    std::cout << "problem 1:" << Solve("../input/day2", 1) << std::endl;
//    std::cout << "problem 2:" << solve("../input/day1", 2) << std::endl;

    return 0;
}