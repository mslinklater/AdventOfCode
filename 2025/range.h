#include <cstdint>
#include <vector>

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