#include <cassert>
#include <string>
#include <algorithm>
#include <list>

#include "utils.h"

struct Range
{
    int value;
    int count;
};

void PrintRange(const std::list<Range>& ranges)
{
    int size = 0;
    int occupiedSize = 0;
    for(auto el : ranges)
    {
        std::cout << el.value << ":" << el.count << "  ";
        size += el.count;

        if(el.value != -1)
            occupiedSize += el.count;
    }
    std::cout << "size:" << size;
    std::cout << "  occupied:" << occupiedSize;
    std::cout << std::endl;
}

uint64_t Solve(const std::string& filename, int part)
{
    uint64_t answer = 0;
    String input = GetFileAsSingleLine(filename);

    std::vector<int> blocks;    // used for pt 1
    std::list<Range> ranges;    // used for pt 2

    bool isFree = false;
    int blockNum = 0;

    for(auto c : input)
    {
        int val = c - '0';
        Range range;

        if(isFree)
        {
            for(int i=0 ; i<val ; i++)
            {
                blocks.push_back(-1);
            }
            range.count = val;
            range.value = -1;
            ranges.push_back(range);
        }
        else
        {
            for(int i=0 ; i<val ; i++)
            {
                blocks.push_back(blockNum);
            }
            range.count = val;
            range.value = blockNum;
            ranges.push_back(range);
            blockNum++;
        }
        isFree = !isFree;
    }


    if(part == 1)
    {
        // simple char by char move
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
        // clean up back end        
        while(blocks[blocks.size() - 1] == -1)
        {
            blocks.pop_back();
        }
        // work out answer
        for(int i=0 ; i<blocks.size() ; i++)
        {
            answer += blocks[i] * i;
        }
    }
    else
    {
        PrintRange(ranges);

        std::list<Range>::iterator tail = ranges.end();
        tail--;
        std::list<Range>::iterator head = ranges.begin();
        while(tail != ranges.begin())
        {
            if(tail->value != -1)
            {
                Range& tailRange = *tail;
                // begin forward scan for a gap
                head = ranges.begin();
                bool found = false;
                while((head != tail) && !found)
                {
                    if((head->value == -1) && (head->count >= tail->count))
                    {
                        found = true;
                    }
                    else
                    {
                        head++;
                    }
                }
                if(found)
                {
                    if(head->count == tail->count)
                    {
                        // simple move
                        head->value = tail->value;
                        tail->value = -1;
                    }
                    else
                    {
                        Range newRange; // new empty range
                        newRange.value = -1;
                        newRange.count = head->count - tail->count;
                        std::list<Range>::iterator ins = head;
                        ins++;
                        ranges.insert(ins, newRange);
                        head->count = tail->count;
                        head->value = tail->value;
                        tail->value = -1;
                    }
                }
                tail--;
                PrintRange(ranges);
            }

            tail--;
        }
    }


    return answer;
}

int main(int argc, const char** argv)
{
//    assert(Solve("../input/day9test", 1) == 1928);
//    assert(Solve("../input/day9test", 2) == 2858);
    Solve("../input/day9test", 2);

    assert(Solve("../input/day9", 1) == 6463499258318);
//    assert(Solve("../input/day8", 2) == 1280);

    std::cout << "problem 1:" << Solve("../input/day9", 1) << std::endl;
//    std::cout << "problem 2:" << Solve("../input/day9", 2) << std::endl;

    return 0;
}

//--- TODELETE

#if 0
        int frontHead = 0;
        int frontTail = 0;
        int backHead = blocks.size() - 1;
        int backTail = blocks.size() - 1;

        while(backHead > 0)
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

            bool foundSlot = false;
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
                if(gapAvailable >= gapRequired)
                {
//                    frontTail = frontHead+1;
                    foundSlot = true;
                }
                else
                {
                    frontTail = frontHead+1;
                }
            } while ((gapAvailable < gapRequired) && !foundSlot && (frontTail < backHead));

            if(foundSlot)
            {
                for(int i=0; i<gapRequired ; i++)
                {
                    blocks[frontTail+i] = blocks[backTail-i];
                    blocks[backTail-i] = -1;
                }
//                frontHead = frontTail + gapRequired;
            }
                backHead--;
                backTail = backHead;
//            }
            frontHead = frontTail = 0;
        }
#endif
