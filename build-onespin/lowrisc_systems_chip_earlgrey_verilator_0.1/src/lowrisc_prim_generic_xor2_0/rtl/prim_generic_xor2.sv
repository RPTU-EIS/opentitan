// Copyright lowRISC contributors.
// Licensed under the Apache License, Version 2.0, see LICENSE for details.
// SPDX-License-Identifier: Apache-2.0

`include "../../lowrisc_prim_assert_0.1/rtl/prim_assert.sv"

module prim_generic_xor2 #(
  parameter int Width = 1
) (
  input        [Width-1:0] in0_i,
  input        [Width-1:0] in1_i,
  output logic [Width-1:0] out_o
);

  assign out_o = in0_i ^ in1_i;

endmodule
