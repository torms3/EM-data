//
// Aleksandar Zlateski <zlateski@mit.edu>
//

#include <zi/concurrency.hpp>
#include <zi/parallel/algorithm.hpp>
#include <zi/bits/bind.hpp>
#include <zi/bits/mem_fn.hpp>
#include <zi/utility/assert.hpp>
#include <zi/utility/singleton.hpp>
#include <zi/meta/enable_if.hpp>

#include <boost/multi_array.hpp>
#include <boost/array.hpp>

#include <vector>
#include <iostream>
#include <algorithm>

template< typename T, std::size_t N >
struct downsample_impl
{
private:
    typedef typename boost::const_multi_array_ref<T,N> const_matrix_type;
    typedef typename boost::multi_array<T,N>           matrix_type;
    typedef typename boost::array<std::size_t,N>       indices;
    typedef downsample_impl<T,N>                       this_type;

    struct args
    {
        std::size_t level;
        std::size_t numel;
        indices dims;
        indices src;
        indices dst;

        args()
            : level(0), numel(0)
        { }
    };


    T most_common_element( typename std::vector< T >::iterator begin,
                           std::size_t len ) const
    {
        if ( len == 1 )
        {
            return *begin;
        }

        std::size_t maxn = 1;
        std::size_t curn = 1;
        T ret            = *begin;

        while ( --len )
        {
            if ( *begin != *(begin+1) )
            {
                if ( curn > maxn )
                {
                    maxn = curn;
                    ret  = *begin;
                }
                curn = 1;
            }
            else
            {
                ++curn;
            }
            ++begin;
        }

        if ( curn > maxn )
        {
            return (*begin);
        }
        else
        {
            return ret;
        }
    }

    //
    // recurse on the dimension
    //
    template< std::size_t D >
    typename zi::meta::enable_if_c<(D<N)>::type
    partial_downsample( const const_matrix_type& m,
                        args a,
                        typename std::vector<T>::iterator buffer,
                        std::vector<matrix_type>& results,
                        int num_threads ) const
    {
        a.numel >>= 1;

        a.dims[D] >>= 1;
        a.dst[D]  <<= 1;

        partial_downsample<D+1>( m, a, buffer, results, num_threads*2 );

        ++a.dst[D];
        a.src[D] += a.dims[D];

        partial_downsample<D+1>( m, a, buffer+a.numel, results, num_threads*2 );

        std::inplace_merge( buffer, buffer+a.numel, buffer+2*a.numel);
    }

    //
    // base case2 ( recurse on the size, or stop )
    //
    template< std::size_t D >
    typename zi::meta::disable_if_c<(D<N)>::type
    partial_downsample( const const_matrix_type& m,
                        args a,
                        typename std::vector<T>::iterator buffer,
                        std::vector<matrix_type>& results,
                        int num_threads ) const
    {
        if ( a.numel == 1 )
        {
            buffer[0] = m(a.src);
            return;
        }
        else
        {
            --a.level;
            partial_downsample<0>( m, a, buffer, results, num_threads );
            results[a.level](a.dst) = most_common_element( buffer, a.numel );
        }

    }

    std::size_t intlog2( std::size_t s ) const
    {
        std::size_t n = 0;
        while ( s != 1 )
        {
            ZI_ASSERT(s%2==0);
            s /= 2;
            ++n;
        }
        return n;
    }

public:

    T operator()( const const_matrix_type& m,
                  std::vector< matrix_type >& result ) const
    {
        args a; a.numel = 1;
        std::size_t s = m.shape()[0];
        std::size_t n = 0;

        indices size;

        for ( std::size_t i = 0; i < N; ++i )
        {
            a.src[i]  = a.dst[i] = 0;
            a.dims[i] = s;
            a.numel  *= s;
            ZI_ASSERT(s == m.shape()[i]);
        }

        size = a.dims;

        std::vector<T> buffer(a.numel);

        result.resize(intlog2(s));

        while ( s != 1 )
        {
            s /= 2;
            for ( std::size_t i = 0; i < N; ++i )
            {
                size[i] /= 2;
            }

            result[n].resize(size);
            ++n;
        }

        a.level = n;
        partial_downsample<N>( m, a, buffer.begin(), result, 1 );

        return result.back()(a.src);
    }

};

template< typename T, std::size_t N = 3 >
struct downsampler
{
    typedef typename boost::const_multi_array_ref<T,N> const_matrix_type;
    typedef typename boost::multi_array<T,N>           matrix_type;

    static downsample_impl<T,N>& downsample;
};

template< typename T, std::size_t N >
downsample_impl<T,N>& downsampler<T,N>::downsample =
    zi::singleton<downsample_impl<T,N> >::instance();

