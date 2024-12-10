#include <cassert>
#include <string>
#include <algorithm>

#include "utils.h"

uint64_t Solve(const std::string& filename, int part)
{
    uint64_t answer = 0;
    String input = GetFileAsSingleLine(filename);

    std::vector<int> blocks;

    bool isFree = false;
    int blockNum = 0;
    for(auto c : input)
    {
        int val = c - '0';
        if(isFree)
        {
            for(int i=0 ; i<val ; i++)
            {
                blocks.push_back(-1);
            }
        }
        else
        {
            for(int i=0 ; i<val ; i++)
            {
                blocks.push_back(blockNum);
            }
            blockNum++;
        }
        isFree = !isFree;
    }


    if(part == 1)
    {
        int head = 0;
        int tail = blocks.size() - 1;
        while(head < tail)
        {
            while((blocks[head] != -1) && (head < tail))
                head++;
            while((blocks[tail] == -1) && (head < tail))
                tail--;
            blocks[head] = blocks[tail];
            blocks[tail] = -1;
        }
    }
    else
    {
        int frontHead = 0;
        int frontTail = 0;
        int backHead = blocks.size() - 1;
        int backTail = blocks.size() - 1;

        while(frontHead < backHead)
        {
            // find tail range
            while(blocks[backTail] == -1)
                backTail--;
            backHead = backTail;
            while(blocks[backHead] == blocks[backTail])
                backHead--;
            backHead++;
            int gapRequired = backTail - backHead + 1;

            int gapAvailable = 0;

            do
            {
                // find a gap big enough
                while(blocks[frontTail] != -1)
                    frontTail++;
                frontHead = frontTail;
                while(blocks[frontHead] == -1)
                    frontHead++;
                frontHead--;
                gapAvailable = frontHead - frontTail + 1;
            } while (gapAvailable < gapRequired);


        }

    }

    while(blocks[blocks.size() - 1] == -1)
    {
        blocks.pop_back();
    }

    for(int i=0 ; i<blocks.size() ; i++)
    {
        answer += blocks[i] * i;
    }

    return answer;
}

int main(int argc, const char** argv)
{
    assert(Solve("../input/day9test", 1) == 1928);
    assert(Solve("../input/day9test", 2) == 2858);
    
    assert(Solve("../input/day9", 1) == 6463499258318);
//    assert(Solve("../input/day8", 2) == 1280);

    std::cout << "problem 1:" << Solve("../input/day9", 1) << std::endl;
    std::cout << "problem 2:" << Solve("../input/day9", 2) << std::endl;

    return 0;
}