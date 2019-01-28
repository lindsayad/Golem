/******************************************************************************/
/*           GOLEM - Multiphysics of faulted geothermal reservoirs            */
/*                                                                            */
/*          Copyright (C) 2017 by Antoine B. Jacquey and Mauro Cacace         */
/*             GFZ Potsdam, German Research Centre for Geosciences            */
/*                                                                            */
/*    This program is free software: you can redistribute it and/or modify    */
/*    it under the terms of the GNU General Public License as published by    */
/*      the Free Software Foundation, either version 3 of the License, or     */
/*                     (at your option) any later version.                    */
/*                                                                            */
/*       This program is distributed in the hope that it will be useful,      */
/*       but WITHOUT ANY WARRANTY; without even the implied warranty of       */
/*        MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the       */
/*                GNU General Public License for more details.                */
/*                                                                            */
/*      You should have received a copy of the GNU General Public License     */
/*    along with this program.  If not, see <http://www.gnu.org/licenses/>    */
/******************************************************************************/

#ifndef GOLEMFUNCTIONBCFROMFILE_H
#define GOLEMFUNCTIONBCFROMFILE_H

#include "Function.h"
#include "GolemSetBCFromFile.h"
#include "GolemInterpolateBCFromFile.h"

class GolemFunctionBCFromFile;

template <>
InputParameters validParams<GolemFunctionBCFromFile>();

class GolemFunctionBCFromFile : public Function
{
public:
  GolemFunctionBCFromFile(const InputParameters & parameters);
  virtual Real value(Real t, const Point & pt) override;

protected:
  std::unique_ptr<GolemSetBCFromFile> _set_bc;
  std::unique_ptr<GolemInterpolateBCFromFile> _interpolate_bc;
  int _n_points;
  bool _has_interpol_in_time;
  bool _has_interpol_in_space;
  const std::string _data_file_name;
  std::vector<Real> _time_frames;
  std::vector<std::string> _file_names;

private:
  void parseFile();
  bool parseNextLineReals(std::ifstream & ifs, std::vector<Real> & myvec);
  bool parseNextLineStrings(std::ifstream & ifs, std::vector<std::string> & myvec);
  void fillMatrixBC(ColumnMajorMatrix & px, ColumnMajorMatrix & py, ColumnMajorMatrix & pz);
  Real constant_value(Real t, const Point & pt);
  Real interpolated_value(Real t, const Point & pt);
};

#endif // GOLEMFUNCTIONBCFROMFILE_H
