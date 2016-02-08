//
// Copyright (C) 2015-2016  Aleksandar Zlateski <zlateski@mit.edu>
//                          Kisuk Lee           <kisuklee@mit.edu>
//
// --------------------------------------------------------------------
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

#include "boost/multi_array.hpp"
#include "boost/pending/disjoint_sets.hpp"

template< typename ID, typename F >
inline void
merge_regions( ID* seg,
               std::size_t sx,
               std::size_t sy,
               std::size_t sz,
               F* dend_values,
               ID* dend_pairs,
               std::size_t nedges,
               F threshold,
               ID* new_seg )
{
    // find largest ID in segmentation
    ID max_segid  = seg[0];
    std::size_t n = sx*sy*sz;
    for ( std::size_t i = 1; i < n; ++i )
    {
        if (seg[i] > max_segid )
            max_segid = seg[i];
    }

    // intitialize disjoint set
    std::vector<ID>       p(max_segid+1);
    std::vector<uint8_t>  r(max_segid+1);
    for ( ID i = 0; i < max_segid+1; ++i )
    {
        p[i] = i;
        r[i] = 0;
    }
    boost::disjoint_sets<uint8_t*,ID*> sets(&r[0],&p[0]);

    // merging
    for ( std::size_t i = 0; i < nedges; ++i )
    {
        if ( dend_values[i] < threshold )
        {
            break;
        }

        ID s1 = sets.find_set(dend_pairs[2*i]);
        ID s2 = sets.find_set(dend_pairs[2*i+1]);

        if ( s1 != s2 && s1 && s2 )
        {
            sets.link(s1,s2);
            uint32_t s = sets.find_set(s1);
        }
    }

    // remapping
    std::vector<ID> remaps(max_segid+1);

    ID next_id = 1;

    for ( ID id = 0; id < max_segid+1; ++id )
    {
        ID s = sets.find_set(id);
        if ( s && (remaps[s] == 0) )
        {
            remaps[s] = next_id++;
        }
    }

    for ( std::ptrdiff_t idx = 0; idx < n; ++idx )
    {
        new_seg[idx] = remaps[sets.find_set(seg[idx])];
    }
}

#include "mex.h"
#include "matrix.h"

// seg = merge_regions(seg,vals,pairs,threshold)
void mexFunction( int nlhs, mxArray* plhs[],
                  int nrhs, const mxArray* prhs[] )
{
    if ( nrhs != 4 )
    {
        mexErrMsgTxt("Wrong number of arguments");
    }

    if ( nlhs == 0 )
    {
        mexErrMsgTxt("Need output variables");
    }

    std::size_t ndim = 3;

    const mwSize* dim = mxGetDimensions(prhs[0]);

    std::size_t sx = dim[0];
    std::size_t sy = dim[1];
    std::size_t sz = dim[2];

    plhs[0] = mxCreateNumericArray(ndim, dim, mxUINT32_CLASS, mxREAL);

    merge_regions<uint32_t,double>
            (reinterpret_cast<uint32_t*>(mxGetData(prhs[0])),sx,sy,sz,
             reinterpret_cast<double*>(mxGetData(prhs[1])),
             reinterpret_cast<uint32_t*>(mxGetData(prhs[2])),
             mxGetNumberOfElements(prhs[1]),
             static_cast<double>(mxGetScalar(prhs[3])),
             reinterpret_cast<uint32_t*>(mxGetData(plhs[0])));
}