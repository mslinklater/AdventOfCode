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

bool CaclSeries(const std::vector<int>& series)
{
    bool safe = true;
    EDir last = EDir::kUnknown;
    for(int i=0 ; i<series.size()-1 ; ++i)
    {
        EDir next = CalcPair(series[i], series[i+1], last);
        last = next;
        safe &= last != EDir::kInvalid;
    }
    return safe;
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
            bool safe = CaclSeries(numbers);
            if(safe)
            {
                answer++;
            }
        }
        else
        {
            bool worked = false;
            for(int iDel=0 ; iDel < numbers.size() ; ++iDel)
            {
                std::vector<int> testNumbers = numbers;
                testNumbers.erase(testNumbers.begin() + iDel);
                worked |= CaclSeries(testNumbers);
            }
            if(worked)
            {
                answer++;
            }
        }
    }
    return answer;
}

int main(int argc, const char** argv)
{
    assert(Solve("../2024/input/day2test", 1) == 2);
    
    assert(Solve("../2024/input/day2", 1) == 502);
    assert(Solve("../2024/input/day2", 2) == 544);

    std::cout << "problem 1:" << Solve("../2024/input/day2", 1) << std::endl;
    std::cout << "problem 2:" << Solve("../2024/input/day2", 2) << std::endl;

    return 0;
}