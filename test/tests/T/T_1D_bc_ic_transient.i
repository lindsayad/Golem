[Mesh]
  type = FileMesh
  file = T_1D_bc_ic_transient.msh
  boundary_id = '0 1 2 3 4 5 6 7'
  boundary_name = 'left1 left2 right1 right2 bottom top front back'
[]

[Variables]
  [./temperature]
    order = FIRST
    family = LAGRANGE
  [../]
[]

[Kernels]
  [./T_time]
    type = GolemKernelTimeT
    variable = temperature
  [../]
  [./TKernel]
    type = GolemKernelT
    variable = temperature
  [../]
[]

[Functions]
  [./IC_x_func]
    type = PiecewiseMultilinear
    data_file = IC_x.txt
  [../]
[]

[ICs]
  [./T_IC]
    type = FunctionIC
    variable = temperature
    function = 'IC_x_func'
  [../]
[]

[BCs]
  [./T0_left1]
    type = PresetBC
    variable = temperature
    boundary = left1
    value = 0.0
  [../]
  [./T0_right1]
    type = PresetBC
    variable = temperature
    boundary = right1
    value = 0.0
  [../]
[]

[Materials]
  [./thermal_left]
    type = GolemMaterialT
    block = 0
    fluid_thermal_conductivity_initial = 1.0
    solid_thermal_conductivity_initial = 1.1574074
    solid_heat_capacity_initial = 0.01
    solid_density_initial = 2000
    porosity_uo = porosity
    fluid_density_uo = fluid_density
  [../]
  [./thermal_right]
    type = GolemMaterialT
    block = 1
    fluid_thermal_conductivity_initial = 1.0
    solid_thermal_conductivity_initial = 1.1574074
    solid_heat_capacity_initial = 0.01
    solid_density_initial = 2000
    porosity_uo = porosity
    fluid_density_uo = fluid_density
  [../]
[]

[UserObjects]
  [./porosity]
    type = GolemPorosityConstant
  [../]
  [./fluid_density]
    type = GolemFluidDensityConstant
  [../]
[]

[Preconditioning]
  [./precond]
    type = SMP
    full = true
    petsc_options = '-snes_ksp_ew'
    petsc_options_iname = '-ksp_type -pc_type -snes_atol -snes_rtol -snes_max_it -ksp_max_it -sub_pc_type -sub_pc_factor_shift_type'
    petsc_options_value = 'gmres asm 1E-10 1E-10 200 500 lu NONZERO'
  [../]
[]

[Executioner]
  type = Transient
  solve_type = Newton
  start_time = 0.0
  end_time = 7776
  dt = 777.6
[]

[Outputs]
  #interval = 5
  print_linear_residuals = true
  perf_graph = true
  exodus = true
[]
