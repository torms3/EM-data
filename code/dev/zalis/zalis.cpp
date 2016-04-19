//
// Copyright (C) 2012-2015  Aleksandar Zlateski <zlateski@mit.edu>
//                    2015  Kisuk Lee           <kisuklee@mit.edu>
// ---------------------------------------------------------------
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

#include "flow_graph/computation/zalis.hpp"

namespace znn { namespace v4 {

// Convert 4D array to vector of 3D array
template<typename T>
inline std::vector<cube_p<T>> raw2vec( const T* raw, const vec3i& s, size_t n )
{
    std::vector<cube_p<T>> ret;

    for ( size_t i = 0; i < n; ++i )
    {
        auto c = get_cube<T>(s);
        std::ptrdiff_t m = c->num_elements();
        std::copy(raw + i*m, raw + (i+1)*m, c->data());
        ret.push_back(c);
    }

    return ret;
}

// Convert vector of 3D array to 4D array
template<typename T>
inline void vec2raw( std::vector<cube_p<T>> vec, T* raw )
{
    size_t n = vec.size();
    std::ptrdiff_t m = vec[0]->num_elements();

    for ( size_t i = 0; i < n; ++i )
        std::copy(vec[i]->data(), vec[i]->data() + m, raw + i*m);
}

template<typename T>
inline void mex_zalis( const T* true_affs_data,
                       const T* affs_data,
                       T high,
                       T low,
                       bool frac_norm,
                       size_t sx,
                       size_t sy,
                       size_t sz,
                       T* merger,
                       T* splitter )
{
    vec3i dim(sz,sy,sx);
    size_t n = sx*sy*sz;

    // create affinity graphs
    auto true_affs = raw2vec(true_affs_data, dim, 3);
    auto affs      = raw2vec(affs_data, dim, 3);

    // run zalis
    auto w = zalis(true_affs, affs, frac_norm, high, low);

    // return merger & splitter weights
    vec2raw(w.merger, merger);
    vec2raw(w.splitter, splitter);
}

}} // namespace znn::v4

#include "mex.h"

// [merger,splitter] = zalis(true_affs, affs, high, low, frac_norm)
void mexFunction(int nlhs, mxArray* plhs[], int nrhs, const mxArray* prhs[])
{
    if ( nrhs != 5 )
    {
        mexErrMsgTxt("Wrong number of arguments");
    }

    if ( nlhs == 0 )
    {
        mexErrMsgTxt("Need output variables");
    }

    const mwSize* dim = mxGetDimensions(prhs[0]);
    std::size_t sx = dim[0];
    std::size_t sy = dim[1];
    std::size_t sz = dim[2];

    std::size_t ndim = 4;
    plhs[0] = mxCreateNumericArray( ndim, dim, mxDOUBLE_CLASS, mxREAL );
    plhs[1] = mxCreateNumericArray( ndim, dim, mxDOUBLE_CLASS, mxREAL );

    znn::v4::mex_zalis<double>
        ( reinterpret_cast<double*>(mxGetData(prhs[0])),
          reinterpret_cast<double*>(mxGetData(prhs[1])),
          static_cast<double>(mxGetScalar(prhs[2])),
          static_cast<double>(mxGetScalar(prhs[3])),
          static_cast<bool>(mxGetScalar(prhs[4])),
          sx, sy, sz,
          reinterpret_cast<double*>(mxGetData(plhs[0])),
          reinterpret_cast<double*>(mxGetData(plhs[1]))
        );
}