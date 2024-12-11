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
        std::list<Range>::iterator tail;
        std::list<Range>::iterator head;

        int valueToMove = 0;
        for(auto i : ranges)
        {
            valueToMove = std::max(valueToMove, i.value);
        }

        while(valueToMove >= 0)
        {
            head = ranges.begin();
            tail = ranges.end();

            // set tail

            while(tail->value != valueToMove)
                tail--;

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
                    head->count = tail->count;
                    head->value = tail->value;
                    tail->value = -1;
                    ranges.insert(ins, newRange);
                }
            }

            valueToMove--;
        }

        // sum up answer
        int position = 0;
        for(auto i : ranges)
        {
            if(i.value != -1)
            {
                for(int count = 0; count < i.count ; count++)
                {
                    answer += position * i.value;
                    position++;
                }
            }
            else
            {
                position += i.count;
            }
        }
    }


    return answer;
}

int main(int argc, const char** argv)
{
    assert(Solve("../input/day9test", 1) == 1928);
    assert(Solve("../input/day9test", 2) == 2858);

    assert(Solve("../input/day9", 1) == 6463499258318);
    assert(Solve("../input/day9", 2) == 6493634986625);

    std::cout << "problem 1:" << Solve("../input/day9", 1) << std::endl;
    std::cout << "problem 2:" << Solve("../input/day9", 2) << std::endl;

    return 0;
}
