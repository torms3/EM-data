//
// Copyright (C) 2013  Aleksandar Zlateski <zlateski@mit.edu>
// ----------------------------------------------------------
//
// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
//
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with this program.  If not, see <http://www.gnu.org/licenses/>.
//

#include <cstddef>
#include <cassert>
#include <cstring>
#include <cstdlib>
#include <iostream>
#include <stdint.h>
#include <vector>

namespace zi {

template< class T >
class disjoint_sets
{

private:
    T        *p_;
    uint8_t  *r_;
    T         size_ ;
    T         sets_ ;

    void init( T s )
    {
        p_ = reinterpret_cast< T* >( malloc( s * sizeof( T ) ));
        r_ = reinterpret_cast< uint8_t* >( malloc( s * sizeof( uint8_t ) ));

        for ( T i = 0; i < s; ++i )
        {
            p_[ i ] = i;
            r_[ i ] = 0;
        }
        size_ = sets_ = s;
    }

public:

    explicit disjoint_sets( const T& s = 0 ): p_( 0 ), r_( 0 ), size_( 0 ), sets_( 0 )
    {
        if ( s > 0 )
        {
            init( s );
        }
    }

    ~disjoint_sets()
    {
        if ( p_ )
        {
            free( p_ );
        }
        if ( r_ )
        {
            free( r_ );
        }
    }

    inline T find_set( const T& id ) const
    {
        T i( id ), n( id ), x;

        while ( n != p_[ n ] )
        {
            n = p_[ n ];
        }

        while ( n != i )
        {
            x = p_[ id ];
            p_[ id ] = n;
            i = x;
        }

        return n;
    }

    inline T operator[]( const T& id ) const
    {
        return find_set( id );
    }

    inline T join( const T& x, const T& y )
    {
        if ( x == y )
        {
            return x;
        }

        --sets_;

        if ( r_[ x ] >= r_[ y ] )
        {
            p_[ y ] = x;
            if ( r_[ x ] == r_[ y ] )
            {
                ++r_[ x ];
            }
            return x;
        }

        p_[ x ] = y;
        return y;
    }

    inline T operator()( const T& x, const T& y )
    {
        return join( x, y );
    }

    inline void clear()
    {
        for ( T i = 0; i < size_; ++i )
        {
            p_[ i ] = i;
            r_[ i ] = 0;
        }
        sets_ = size_;
    }

    inline void resize( const T& s )
    {
        if ( s != size_ )
        {
            if ( size_ )
            {
                free( p_ );
                free( r_ );
            }
            init( s );
        }
        else
        {
            clear();
        }
    }

    T size() const
    {
        return size_;
    }

    T set_count() const
    {
        return sets_;
    }

};

} // namespace zi


void print_usage()
{
  std::cout << "Usage: R = ZiConnectedComponents(AffinityGraph, Threshold [, MinSize = 0] )\n"
	    << "  Affinity - 4D Affinity graph of type float or double\n"
	    << "  Threshold - float or double (edges below Threshold are ignored)\n"
	    << "  MinSize - float or double or Integer (components smaller than MinSize will be ignored)\n"
	    << "\n"
	    << "*Affinity(x,y,z,1) is an edge between [x-1,y,z] and [x,y,z]\n"
	    << "*Affinity(x,y,z,2) is an edge between [x,y-1,z] and [x,y,z]\n"
	    << "*Affinity(x,y,z,3) is an edge between [x,y,z-1] and [x,y,z]\n";
}

template <typename Float, typename Id>
std::size_t get_components( std::size_t xs,
                            std::size_t ys,
                            std::size_t zs,
                            const Float* affinities,
                            Id*    ids,
                            Float  threshold,
			    Float  min_size = static_cast<Float>(0) )
{
    std::size_t total = xs * ys * zs;
    zi::disjoint_sets<Id> sets(total+1);
    std::vector<std::size_t> sizes(total+1);

    for ( std::size_t i = 0; i < total; ++i )
    {
	    sizes[i+1] = 1;
    }

    const std::size_t dx = 1;
    const std::size_t dy = xs;
    const std::size_t dz = xs*ys;

    std::size_t iidx = 0;
    for ( std::size_t oidx = 0, k = 0; k < zs; ++k )
        for ( std::size_t j = 0; j < ys; ++j )
            for ( std::size_t i = 0; i < xs; ++i, ++oidx, ++iidx )
                if ( i > 0 && affinities[iidx] >= threshold )
                {
                    if ( sets.find_set(oidx+1) != sets.find_set(oidx-dx+1) ) 
                    {
                        std::size_t size = sizes[sets.find_set(oidx+1)] + sizes[sets.find_set(oidx-dx+1)];
                        sizes[sets.join(sets.find_set(oidx+1), sets.find_set(oidx-dx+1))] = size;
                    }
                }

    for ( std::size_t oidx = 0, k = 0; k < zs; ++k )
        for ( std::size_t j = 0; j < ys; ++j )
            for ( std::size_t i = 0; i < xs; ++i, ++oidx, ++iidx )
                if ( j > 0 && affinities[iidx] >= threshold )
                {
                    if ( sets.find_set(oidx+1) != sets.find_set(oidx-dy+1) ) 
                    {
               		    std::size_t size = sizes[sets.find_set(oidx+1)] + sizes[sets.find_set(oidx-dy+1)];
                        sizes[sets.join(sets.find_set(oidx+1), sets.find_set(oidx-dy+1))] = size;
                    }
                }

    for ( std::size_t oidx = 0, k = 0; k < zs; ++k )
        for ( std::size_t j = 0; j < ys; ++j )
            for ( std::size_t i = 0; i < xs; ++i, ++oidx, ++iidx )
                if ( k > 0 && affinities[iidx] >= threshold )
                {
                    if ( sets.find_set(oidx+1) != sets.find_set(oidx-dz+1) ) 
                    {
               		    std::size_t size = sizes[sets.find_set(oidx+1)] + sizes[sets.find_set(oidx-dz+1)];
                        sizes[sets.join(sets.find_set(oidx+1), sets.find_set(oidx-dz+1))] = size;
                    }
                }

    //std::cout << "Total Sets: " << sets.set_count();

    std::vector<Id> remaps(total);
    Id last = 0;

    for ( std::size_t i = 0; i < total; ++i )
    {
        Id s = sets.find_set(i+1);
        if ( remaps[s] == 0 )
        {
	        if ( sizes[s] > min_size )
	        {
	            remaps[s] = ++last;
	        }
        }
        ids[i] = remaps[s];
    }

    //std::cout << "Min Size is: " << min_size << "\n";    

    return last;
}

#include "mex.h"

void mexFunction(int nlhs, mxArray* plhs[], int nrhs, const mxArray* prhs[])
{
    if ( nrhs != 2 && nrhs != 3 )
    {
        print_usage();
        mexErrMsgTxt("Not enough arguments");
    }

    const mwSize num_dim = mxGetNumberOfDimensions(prhs[0]);

    if ( num_dim != 4 )
    {
        print_usage();
        mexErrMsgTxt("Wrong number of dimensions of the first argument");
    }

    const mwSize* dims = mxGetDimensions(prhs[0]);

    double threshold = mxGetScalar(prhs[1]);
    double min_size = static_cast<double>(0);


    if ( nrhs == 3 )
      {
	min_size = mxGetScalar(prhs[2]);
      }

    mwSize out_dim[] = { dims[0], dims[1], dims[2] };
    mwSize out_dims  = 3;

    if ( nlhs == 0 )
    {
        mexErrMsgTxt("Need output variable");
    }

    std::size_t total = dims[0]*dims[1]*dims[2];
    bool needs64 = total > 2000000000;

    plhs[0] = mxCreateNumericArray( out_dims, out_dim,
                                    needs64 ? mxUINT64_CLASS : mxUINT32_CLASS,
                                    mxREAL );

    std::size_t res = 0;

    if ( mxIsSingle(prhs[0]) )
    {
        if ( needs64 )
        {
            res = get_components<float, uint64_t>( static_cast<std::size_t>(dims[0]),
                                                   static_cast<std::size_t>(dims[1]),
                                                   static_cast<std::size_t>(dims[2]),
                                                   reinterpret_cast<float*>(mxGetData(prhs[0])),
                                                   reinterpret_cast<uint64_t*>(mxGetData(plhs[0])),
                                                   static_cast<float>(threshold),
						   static_cast<float>(min_size));
        }
        else
        {
            res = get_components<float, uint32_t>( static_cast<std::size_t>(dims[0]),
                                                   static_cast<std::size_t>(dims[1]),
                                                   static_cast<std::size_t>(dims[2]),
                                                   reinterpret_cast<float*>(mxGetData(prhs[0])),
                                                   reinterpret_cast<uint32_t*>(mxGetData(plhs[0])),
                                                   static_cast<float>(threshold),
						   static_cast<float>(min_size) );
        }
    }
    else if ( mxIsDouble(prhs[0]) )
    {
        if ( needs64 )
        {
            res = get_components<double, uint64_t>( static_cast<std::size_t>(dims[0]),
                                                    static_cast<std::size_t>(dims[1]),
                                                    static_cast<std::size_t>(dims[2]),
                                                    reinterpret_cast<double*>(mxGetData(prhs[0])),
                                                    reinterpret_cast<uint64_t*>(mxGetData(plhs[0])),
                                                    threshold,
						    min_size );
        }
        else
        {
            res = get_components<double, uint32_t>( static_cast<std::size_t>(dims[0]),
                                                    static_cast<std::size_t>(dims[1]),
                                                    static_cast<std::size_t>(dims[2]),
                                                    reinterpret_cast<double*>(mxGetData(prhs[0])),
                                                    reinterpret_cast<uint32_t*>(mxGetData(plhs[0])),
                                                    threshold,
						    min_size );
        }
    }

    std::cout << "Found total of: " << res << " components\n";
}
