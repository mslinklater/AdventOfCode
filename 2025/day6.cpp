#include <cassert>
#include <string>
#include <algorithm>

#include "utils.h"

struct Range
{
    uint64_t start;
    uint64_t end;
    bool Contains(uint64_t val) const
    {
        return val >= start && val <= end;
    }
};

// Merge overlapping ranges in the vector
std::vector<Range> MergeRanges(std::vector<Range> ranges)
{
    if (ranges.empty())
        return ranges;
    
    // Sort ranges by start position
    std::sort(ranges.begin(), ranges.end(), 
        [](const Range& a, const Range& b) { return a.start < b.start; });
    
    std::vector<Range> merged;
    merged.push_back(ranges[0]);
    
    for (size_t i = 1; i < ranges.size(); ++i)
    {
        Range& last = merged.back();
        const Range& current = ranges[i];
        
        // Check if current range overlaps or is adjacent to the last merged range
        if (current.start <= last.end + 1)
        {
            // Merge by extending the end if necessary
            last.end = std::max(last.end, current.end);
        }
        else
        {
            // No overlap, add as new range
            merged.push_back(current);
        }
    }
    
    return merged;
}

std::vector<Range> ranges;
std::vector<uint64_t> ingredients;

uint64_t Solve(const std::string& filename, int part)
{
    uint64_t answer = 0;
    ranges.clear();
    ingredients.clear();

    StringVector lines = GetFileAsLines(filename);
    assert(!lines.empty());
    int lineIndex = 0;
    while(lines[lineIndex].size() != 0)
    {
        StringVector parts = SplitStringByChar(lines[lineIndex], '-');
        Range r;
        r.start = std::stoll(parts[0]);
        r.end = std::stoll(parts[1]);
        ranges.push_back(r);
        lineIndex++;
    }
    while(lineIndex < lines.size())
    {
        if(lines[lineIndex].size() > 0)
        {
            ingredients.push_back(std::stoll(lines[lineIndex]));
        }
        lineIndex++;
    }

    if(part == 1)
    {
        for(uint64_t ingredient : ingredients)
        {
            bool valid = false;
            for(const Range& r : ranges)
            {
                if(r.Contains(ingredient))
                {
                    valid = true;
                    break;
                }
            }
            if(valid)
            {
                answer++;
            }
        }
    }
    else
    {
        // no part 2
        ranges = MergeRanges(ranges);
        for(const Range& r : ranges)
        {
            answer += (r.end - r.start + 1);
        }
    }
    return answer;
}

int main(int argc, const char** argv)
{
    assert(Solve("../input/day5test", 1) == 3);
    //assert(Solve("../input/day4", 1) == 1537);

    assert(Solve("../input/day5test", 2) == 14);
//    assert(Solve("../input/day4", 2) == 8707);

    std::cout << "problem 1:" << Solve("../input/day5", 1) << std::endl;
    std::cout << "problem 2:" << Solve("../input/day5", 2) << std::endl;

    return 0;
}
