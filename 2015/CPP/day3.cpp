#include <filesystem>
#include <cassert>
#include "utils.h"
#include <set>

struct Coord
{
    int x;
    int y;
};

int solve(std::filesystem::path path, int part)
{
    int answer = 0;
    std::vector<std::string> lines = GetFileAsLines(path);
    std::set<Coord> houseSet;
    if(part == 1)
    {
        int x = 0;
        int y = 0;
        Coord c = {0,0};
#if 0
        houseSet.insert(c);
        for(auto dir : lines[0])
        {
            switch(dir)
            {
                case '>':
                    c.x++;
                    break;
                case '<':
                    c.x--;
                    break;
                case '^':
                    c.y++;
                    break;
                case 'v':
                    c.y--;
                    break;
                default:
                    break;
            }
            houseSet.insert(c);
        }
#endif
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