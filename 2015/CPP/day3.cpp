#include <filesystem>
#include <cassert>
#include "utils.h"
#include <set>
#include <map>

int solve(Path path, int part)
{
    int answer = 0;
    String line = GetFileAsSingleLine(path);
    if(part == 1)
    {
        std::set<Vec2> houseSet;
        Vec2 santaPos {0, 0};
        houseSet.insert(santaPos);
        for( auto c : line )
        {
            switch(c)
            {
                case '>':
                    santaPos.x++;
                    break;
                case '<':
                    santaPos.x--;
                    break;
                case '^':
                    santaPos.y--;
                    break;
                case 'v':
                    santaPos.y++;
                    break;
                default:
                    break;
            }
            if(!houseSet.contains(santaPos))
            {
                houseSet.insert(santaPos);
            }
        }

        answer = houseSet.size();
    }
    else
    {
        std::map<Vec2, int> houseMap;
        Vec2 santaPos {0,0};
        Vec2 roboPos {0,0};
        houseMap[santaPos] = 2;
        for(int i=0 ; i<line.size() ; i+=2)
        {
            switch(line[i])
            {
                case '>':
                    santaPos.x++;
                    break;
                case '<':
                    santaPos.x--;
                    break;
                case '^':
                    santaPos.y--;
                    break;
                case 'v':
                    santaPos.y++;
                    break;
                default:
                    break;
            }

            switch(line[i+1])
            {
                case '>':
                    roboPos.x++;
                    break;
                case '<':
                    roboPos.x--;
                    break;
                case '^':
                    roboPos.y--;
                    break;
                case 'v':
                    roboPos.y++;
                    break;
                default:
                    break;
            }
            if(!houseMap.contains(santaPos))
                houseMap.insert({santaPos, 1});
            else
                houseMap[santaPos]++;

            if(!houseMap.contains(roboPos))
                houseMap.insert({roboPos, 1});
            else
                houseMap[roboPos]++;
        }
        answer = houseMap.size();
    }
    return answer;
}

int main(int argc, const char** argv)
{
    assert(solve("../input/day3", 1) == 2081);
    assert(solve("../input/day3", 2) == 2341);

    std::cout << "problem 1:" << solve("../input/day3", 1) << std::endl;
    std::cout << "problem 2:" << solve("../input/day3", 2) << std::endl;

    return 0;
}