#include <zi/zunit/zunit.hpp>

#include "downsampling.hpp"

ZiTEST( TestDownsampling3D )
{
    int data[4*4*4] =
        { 1, 1, 1, 1,
          1, 1, 1, 1,
          1, 1, 1, 1,
          1, 1, 1, 1,

          1, 2, 1, 2,
          2, 2, 2, 2,
          1, 2, 1, 2,
          2, 2, 2, 2,

          3, 3, 3, 3,
          3, 3, 3, 3,
          3, 3, 3, 3,
          3, 3, 3, 3,

          3, 2, 3, 2,
          2, 2, 2, 2,
          3, 2, 3, 2,
          2, 2, 2, 2 };



    boost::const_multi_array_ref<int,3> m(data, boost::extents[4][4][4]);

    std::vector< downsampler<int>::matrix_type > results;

    EXPECT_EQ( downsampler<int>::downsample( m, results ), 2 );

    EXPECT_EQ( results[0][0][0][0], 1 );
    EXPECT_EQ( results[0][0][0][1], 1 );
    EXPECT_EQ( results[0][0][1][0], 1 );
    EXPECT_EQ( results[0][0][1][1], 1 );

    EXPECT_EQ( results[0][1][0][0], 3 );
    EXPECT_EQ( results[0][1][0][1], 3 );
    EXPECT_EQ( results[0][1][1][0], 3 );
    EXPECT_EQ( results[0][1][1][1], 3 );

    EXPECT_EQ( results[1][0][0][0], 2 );
}


ZiTEST( TestDownsampling2D )
{
    int data[8*8] =
        { 17, 1, 17, 2, 18, 3, 18, 4,
          1, 21, 2, 2, 3, 21, 4, 4,
          17, 5, 17, 6, 18, 7, 18, 8,
          5, 21, 6, 6, 7, 21, 8, 8,
          19, 9, 19, 10, 20, 11, 20, 12,
          9, 21, 10, 10, 11, 21, 12, 12,
          19, 13, 19, 14, 20, 15, 20, 16,
          13, 21, 14, 14, 15, 21, 16, 16
        };



    boost::const_multi_array_ref<int,2> m(data, boost::extents[8][8]);

    std::vector< downsampler<int,2>::matrix_type > results;

    EXPECT_EQ( (downsampler<int,2>::downsample( m, results )), 21 );

    int expected = 0;

    for ( std::size_t i = 0; i < results.size(); ++i )
    {
        for ( std::size_t x = 0; x < results[i].shape()[0]; ++x )
        {
            for ( std::size_t y = 0; y < results[i].shape()[1]; ++y )
            {
                ++expected;
                EXPECT_EQ( results[i][x][y], expected );
            }
        }
    }

}

ZiTEST( TestDownsampling4D )
{
    int data[16] =
        { 1, 2,
          3, 4,

          5, 6,
          7, 8,


          9, 10,
          11, 12,

          13, 14,
          15, 6 };

    boost::const_multi_array_ref<int,4> m(data, boost::extents[2][2][2][2]);

    std::vector< downsampler<int,4>::matrix_type > results;

    EXPECT_EQ( (downsampler<int,4>::downsample( m, results )), 6 );
}



ZiTEST( TestDownsampling4DLarger )
{
    int data[8*8*8*8];

    for ( std::size_t i = 0; i < 8*8*8*8; ++i )
    {
        if ( i & 1 )
        {
            data[i] = 1;
        }
        else
        {
            data[i] = 2;
        }
    }

    data[1] = 0;


    boost::const_multi_array_ref<int,4> m(data, boost::extents[8][8][8][8]);

    std::vector< downsampler<int,4>::matrix_type > results;

    EXPECT_EQ( (downsampler<int,4>::downsample( m, results )), 2 );
}

ZiTEST( TestDownsampling1D )
{
    int data[16] =
        { 1, 2, 2, 2, 3, 3, 3, 3,
          4, 5, 5, 6, 6, 6, 6, 6
        };

    boost::const_multi_array_ref<int,1> m(data, boost::extents[16]);

    std::vector< downsampler<int,1>::matrix_type > results;

    EXPECT_EQ( (downsampler<int,1>::downsample( m, results )), 6 );

    EXPECT_EQ( results[0][1], 2 );
    EXPECT_EQ( results[0][2], 3 );
    EXPECT_EQ( results[0][3], 3 );
    EXPECT_EQ( results[0][6], 6 );
    EXPECT_EQ( results[0][7], 6 );


    EXPECT_EQ( results[1][0], 2 );
    EXPECT_EQ( results[1][1], 3 );
    EXPECT_EQ( results[1][2], 5 );
    EXPECT_EQ( results[1][3], 6 );

    EXPECT_EQ( results[2][0], 3 );
    EXPECT_EQ( results[2][1], 6 );
}


ZiTEST( DownsamplingSpeedTest )
{
    int* data = new int[128*128*128];

    for ( std::size_t i = 0; i < 128*128*128; ++i )
    {
        if ( i & 1 )
        {
            data[i] = 1;
        }
        else
        {
            data[i] = 2;
        }
    }

    data[1] = 0;

    boost::const_multi_array_ref<int,3> m(data, boost::extents[128][128][128]);

    std::vector< downsampler<int>::matrix_type > results;

    EXPECT_EQ( downsampler<int>::downsample( m, results ), 2 );

    delete [] data;
}
