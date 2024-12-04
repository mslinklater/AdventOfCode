#include <cassert>
#include <string>
#include <algorithm>

#include "utils.h"

int Solve(const std::string& filename, int part)
{
    int answer = 0;

    StringVector patterns[8];
    patterns[0] = {"XMAS"};
    patterns[1] = {"SAMX"};
    patterns[2] = {"X", "M", "A", "S"};
    patterns[3] = {"S", "A", "M", "X"};
    patterns[4] = {"X...", ".M..", "..A.", "...S"};
    patterns[5] = {"S...", ".A..", "..M.", "...X"};
    patterns[6] = {"...X", "..M.", ".A..", "S..."};
    patterns[7] = {"...S", "..A.", ".M..", "X..."};

    StringVector patterns2[4];
    patterns2[0] = {"M.S", ".A.", "M.S"};
    patterns2[1] = {"S.S", ".A.", "M.M"};
    patterns2[2] = {"M.M", ".A.", "S.S"};
    patterns2[3] = {"S.M", ".A.", "S.M"};

    StringVector data = GetFileAsLines(filename);

    int width = data[0].size();
    int height = data.size();

    for(int x = 0; x < width ; ++x)
    {
        for(int y = 0; y < height ; ++y)
        {
            if(part == 1)
            {
                for(int p = 0; p < 8 ; ++p)
                {
                    if(DoesMatch2D(patterns[p], data, Vec2(x,y), '.'))
                    {
                        answer++;
                    }
                }
            }
            else
            {
                for(int p = 0; p < 4 ; ++p)
                {
                    if(DoesMatch2D(patterns2[p], data, Vec2(x,y), '.'))
                    {
                        answer++;
                    }
                }
            }
        }
    }

    return answer;
}

int main(int argc, const char** argv)
{
    assert(Solve("../input/day4test", 1) == 18);
    assert(Solve("../input/day4test", 2) == 9);
    
    assert(Solve("../input/day4", 1) == 2406);
    assert(Solve("../input/day4", 2) == 1807);

    std::cout << "problem 1:" << Solve("../input/day4", 1) << std::endl;
    std::cout << "problem 2:" << Solve("../input/day4", 2) << std::endl;

    return 0;
}