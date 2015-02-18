//
// Copyright (C) 2015  Aleksandar Zlateski <zlateski@mit.edu>
//                     Kisuk Lee           <kisuklee@mit.edu>
//
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

#include <stdint.h>
#include <vector>
#include <algorithm>
#include <iostream>

#include "boost/multi_array.hpp"
#include "boost/pending/disjoint_sets.hpp"


template<typename T>
inline void
get_segmentation( const T* affinz,
                  const T* affiny,
                  const T* affinx,
                  // const B* maskz,
                  // const B* masky,
                  // const B* maskx,
                  std::size_t sz,
                  std::size_t sy,
                  std::size_t sx,
                  double threshold,
                  uint64_t* segmentation )
{
    std::size_t n = sx*sy*sz;

    std::vector<uint32_t> p(n+1);
    std::vector<uint8_t>  r(n+1);
    for ( uint32_t i = 0; i < n+1; ++i )
    {
        p[i] = i;
        r[i] = 0;
    }

    boost::disjoint_sets<uint8_t*,uint32_t*>  sets(&r[0],&p[0]);
    std::vector<uint32_t>                     sizes(n+1);

    // affinity graph
    T* vpx = std::get_temporary_buffer<T>(n).first;
    T* vpy = std::get_temporary_buffer<T>(n).first;
    T* vpz = std::get_temporary_buffer<T>(n).first;
    
    std::copy(affinx, affinx+n, vpx);
    std::copy(affiny, affiny+n, vpy);
    std::copy(affinz, affinz+n, vpz);

    boost::multi_array_ref<T,3> vtmpx(vpx, boost::extents[sx][sy][sz]);
    boost::multi_array_ref<T,3> vtmpy(vpy, boost::extents[sx][sy][sz]);
    boost::multi_array_ref<T,3> vtmpz(vpz, boost::extents[sx][sy][sz]);

    // segmentation output
    boost::multi_array_ref<uint64_t,3> ids(segmentation, boost::extents[sx][sy][sz]);

    for ( std::size_t i = 0; i < n; ++i )
    {
        ids.data()[i] = i+1;
        sizes[i+1] = 1;
    }

    typedef std::pair<uint32_t,uint32_t> edge_type;
    std::vector<edge_type> edges;

    // thresholded affinity graph
    for ( std::size_t x = 0; x < sx; ++x )
        for ( std::size_t y = 0; y < sy; ++y )
            for ( std::size_t z = 0; z < sz; ++z )
            {
                uint64_t id1 = ids[x][y][z];

                if ( x > 0 )
                {
                    if (vtmpx[x][y][z] > threshold )
                    {
                        uint64_t id2 = ids[x-1][y][z];
                        edges.push_back(edge_type(id1, id2));
                    }
                }

                if ( y > 0 )
                {
                    if ( vtmpy[x][y][z] > threshold )
                    {
                        uint64_t id2 = ids[x][y-1][z];
                        edges.push_back(edge_type(id1, id2));
                    }
                }

                if ( z > 0 )
                {
                    if ( vtmpz[x][y][z] > threshold )
                    {
                        uint64_t id2 = ids[x][y][z-1];
                        edges.push_back(edge_type(id1, id2));
                    }
                }
            }

    // connected components of the thresholded affinity graph
    for ( std::vector<edge_type>::iterator it = edges.begin();
          it != edges.end(); ++it )
    {
        uint32_t set1 = sets.find_set(it->first);
        uint32_t set2 = sets.find_set(it->second);

        if ( set1 != set2 )
        {
            sets.link(set1, set2);
            uint32_t new_set = sets.find_set(set1);

            sizes[set1] += sizes[set2];
            sizes[set2]  = 0;

            std::swap(sizes[new_set], sizes[set1]);
        }
    }

    std::vector<uint32_t> remaps(n+1);

    uint32_t next_id = 1;

    for ( std::size_t i = 0; i < n; ++i )
    {
        uint32_t id = sets.find_set(ids.data()[i]);
        if ( sizes[id] > 1 )
        {
            if ( remaps[id] == 0 )
            {
                remaps[id] = next_id;
                ids.data()[i] = next_id;
                ++next_id;
            }
            else
            {
                ids.data()[i] = remaps[id];
            }
        }
        else
        {
            remaps[id] = 0;
            ids.data()[i] = 0;
        }
    }

    std::return_temporary_buffer(vpx);
    std::return_temporary_buffer(vpy);
    std::return_temporary_buffer(vpz);
}

#include "mex.h"

void mexFunction(int nlhs, mxArray* plhs[], int nrhs, const mxArray* prhs[])
{
    double threshold = 0.5;

    if ( nrhs != 3 && nrhs != 4 )
    {
        mexErrMsgTxt("Wrong number of arguments");
    }
    else if ( nrhs == 4 )
    {
        threshold = static_cast<double>(mxGetScalar(prhs[3]));
    }

    mwSize num_dims[3] = { 1, 1, 1 };
    for ( std::size_t i = 0; i < 3; ++i )
    {
        num_dims[i] = mxGetNumberOfDimensions(prhs[i]);
        // allow 2D as well as 3D
        if ( num_dims[i] != 3 )
        {
            mexErrMsgTxt("Wrong number of dimensions of affinity graph");
        }
    }    

    const mwSize* dim = mxGetDimensions(prhs[0]);

    std::size_t sx = dim[0];
    std::size_t sy = dim[1];
    std::size_t sz = dim[2];

    // output segmentation
    if ( nlhs == 0 )
    {
        mexErrMsgTxt("Need output variable");
    }

    std::size_t ndim = 3;

    plhs[0] = mxCreateNumericArray( ndim, dim, mxUINT64_CLASS, mxREAL );

    if ( mxIsSingle(prhs[0]) )
    {
        get_segmentation<float>
            (reinterpret_cast<float*>(mxGetData(prhs[0])),
             reinterpret_cast<float*>(mxGetData(prhs[1])),
             reinterpret_cast<float*>(mxGetData(prhs[2])),
             sx,sy,sz,threshold,
             reinterpret_cast<uint64_t*>(mxGetData(plhs[0])));
    }
    else if ( mxIsDouble(prhs[0]) )
    {
        get_segmentation<double>
            (reinterpret_cast<double*>(mxGetData(prhs[0])),
             reinterpret_cast<double*>(mxGetData(prhs[1])),
             reinterpret_cast<double*>(mxGetData(prhs[2])),
             sx,sy,sz,threshold,
             reinterpret_cast<uint64_t*>(mxGetData(plhs[0])));
    }
}
