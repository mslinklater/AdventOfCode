#include <string>

// Base class for all day solutions
class IDayBase
{
    public:
    virtual uint64_t Solve(const std::string& input, int part) = 0;
};
