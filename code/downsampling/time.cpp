#include "downsampling.hpp"

#include <iostream>
#include <zi/time/timer.hpp>

int main()
{
    int* data = new int[128*128*128];

    for ( std::size_t i = 0; i < 128*128*128; ++i )
    {
        if ( i & 1 )
        {
            data[i] = std::rand() % 12345;
        }
        else
        {
            data[i] = 2;
        }
    }

    data[1] = 0;

    boost::const_multi_array_ref<int,3> m(data, boost::extents[128][128][128]);

    std::vector< downsampler<int>::matrix_type > results;

    zi::wall_timer t;
    t.reset();

    std::cout << " Result: " << downsampler<int>::downsample( m, results ) << "\n";

    std::cout << " Time:   " << t.elapsed<double>() << "\n";

    delete [] data;
}
