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

#include <iostream>
#include <map>

template< typename ID >
inline std::pair<double,double>
compute_Rand_score( ID* segA, // ground truth segmentation
                    ID* segB, // proposal segmentation
                    std::size_t n )
{
    typedef std::map<ID, std::size_t> vector_type;
    typedef std::map<ID, vector_type> matrix_type;

    typedef typename vector_type::iterator vit;
    typedef typename matrix_type::iterator mit;

    matrix_type p_ij;
    vector_type a_i, b_j;
    double p_i0 = 0;

    // construct overlap matrix
    for ( std::ptrdiff_t idx = 0; idx < n; ++idx )
    {
        ID gtv = segA[idx]; // watershed voxel
        ID wsv = segB[idx]; // ground truth voxel

        if ( gtv ) // foreground restriction
        {
            ++a_i[gtv];

            if ( wsv )
            {
                ++p_ij[gtv][wsv];
                ++b_j[wsv];
            }
            else
            {
                ++p_i0;
            }
        }
    }

    // compute stats
    double sumAB = 0;
    for ( mit a = p_ij.begin(); a != p_ij.end(); ++a )
    {
        vector_type& row = a->second;
        for ( vit b = row.begin(); b != row.end(); ++b )
        {
            sumAB += b->second * b->second;
        }
    }
    // sumAB += p_i0/static_cast<double>(n);
    sumAB += p_i0;

    double sumA = 0;
    for ( vit a = a_i.begin(); a != a_i.end(); ++a )
    {
        sumA += a->second * a->second;
    }

    double sumB = 0;
    for ( vit b = b_j.begin(); b != b_j.end(); ++b )
    {
        sumB += b->second * b->second;
    }
    // sumB += p_i0/static_cast<double>(n);
    sumB += p_i0;

    double merge = sumAB/sumB;
    double split = sumAB/sumA;
    // double score = merge*split*2/(merge+split);
    // std::cout << "Merge  score: " << merge << "\n";
    // std::cout << "Split  score: " << split  << "\n";
    // std::cout << "Rand F-score: " << score << "\n";

    return std::make_pair(merge,split);
}

#include "mex.h"

// result = compute_Rand_score(segA,segB)
void mexFunction( int nlhs, mxArray* plhs[],
                  int nrhs, const mxArray* prhs[] )
{
    if ( nrhs != 2 )
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

    std::pair<double,double> score =
        compute_Rand_score<uint32_t>
            (reinterpret_cast<uint32_t*>(mxGetData(prhs[0])),
             reinterpret_cast<uint32_t*>(mxGetData(prhs[1])),
             sx*sy*sz);

    // Create a 2-by-1 real float
    plhs[0] = mxCreateNumericMatrix(2, 1, mxDOUBLE_CLASS, mxREAL);
    double* ret = reinterpret_cast<double*>(mxGetData(plhs[0]));
    ret[0] = score.first;
    ret[1] = score.second;
}