// Copyright lowRISC contributors.
// Licensed under the Apache License, Version 2.0, see LICENSE for details.
// SPDX-License-Identifier: Apache-2.0

// Author: Dino Mehmedagić

// This is a top-level wrapper that instantiates two OpenTitan Earlgrey chips for the purposes of 
// formal verification using UPEC

module top_level_upec (
  // Reset and clock signals
  input                                                             rst_ni,
  input  logic                                                      clk_i,

  // I/O for instance 1
  input        [46:0]                                               mio_in_i_1,
  output logic [46:0]                                               mio_out_o_1,
  output logic [46:0]                                               mio_oe_o_1,
  input        [23:0]                                               dio_in_i_1,
  output logic [23:0]                                               dio_out_o_1,
  output logic [23:0]                                               dio_oe_o_1,
  output prim_pad_wrapper_pkg::pad_attr_t [pinmux_reg_pkg::NMioPads-1:0]    mio_attr_o_1,
  output prim_pad_wrapper_pkg::pad_attr_t [pinmux_reg_pkg::NDioPads-1:0]    dio_attr_o_1,
  output ast_pkg::adc_ast_req_t                                     adc_req_o_1,
  input  ast_pkg::adc_ast_rsp_t                                     adc_rsp_i_1,
  input  edn_pkg::edn_req_t                                         ast_edn_req_i_1,
  output edn_pkg::edn_rsp_t                                         ast_edn_rsp_o_1,
  output lc_ctrl_pkg::lc_tx_t                                       ast_lc_dft_en_o_1,
  input  prim_ram_1p_pkg::ram_1p_cfg_t                              ram_1p_cfg_i_1,
  input  prim_ram_2p_pkg::ram_2p_cfg_t                              ram_2p_cfg_i_1,
  input  prim_rom_pkg::rom_cfg_t                                    rom_cfg_i_1,
  output logic                                                      clk_main_jitter_en_o_1,
  output lc_ctrl_pkg::lc_tx_t                                       ast_clk_byp_req_o_1,
  input  lc_ctrl_pkg::lc_tx_t                                       ast_clk_byp_ack_i_1,
  output ast_pkg::ast_dif_t                                         flash_alert_o_1,
  input  lc_ctrl_pkg::lc_tx_t                                       flash_bist_enable_i_1,
  input  logic                                                      flash_power_down_h_i_1,
  input  logic                                                      flash_power_ready_h_i_1,
  output entropy_src_pkg::entropy_src_rng_req_t                     es_rng_req_o_1,
  input  entropy_src_pkg::entropy_src_rng_rsp_t                     es_rng_rsp_i_1,
  output logic                                                      es_rng_fips_o_1,
  output tlul_pkg::tl_h2d_t                                         ast_tl_req_o_1,
  input  tlul_pkg::tl_d2h_t                                         ast_tl_rsp_i_1,
  output pinmux_pkg::dft_strap_test_req_t                           dft_strap_test_o_1,
  input  logic                                                      dft_hold_tap_sel_i_1,
  output pwrmgr_pkg::pwr_ast_req_t                                  pwrmgr_ast_req_o_1,
  input  pwrmgr_pkg::pwr_ast_rsp_t                                  pwrmgr_ast_rsp_i_1,
  output otp_ctrl_pkg::otp_ast_req_t                                otp_ctrl_otp_ast_pwr_seq_o_1,
  input  otp_ctrl_pkg::otp_ast_rsp_t                                otp_ctrl_otp_ast_pwr_seq_h_i_1,
  output ast_pkg::ast_dif_t                                         otp_alert_o_1,
  input  ast_pkg::ast_alert_req_t                                   sensor_ctrl_ast_alert_req_i_1,
  output ast_pkg::ast_alert_rsp_t                                   sensor_ctrl_ast_alert_rsp_o_1,
  input  ast_pkg::ast_status_t                                      sensor_ctrl_ast_status_i_1,
  input  logic [8:0]                                                ast2pinmux_i_1,
  input  logic                                                      ast_init_done_i_1,
  output logic                                                      usbdev_usb_ref_val_o_1,
  output logic                                                      usbdev_usb_ref_pulse_o_1,
  output clkmgr_pkg::clkmgr_ast_out_t                               clks_ast_o_1,
  output rstmgr_pkg::rstmgr_ast_out_t                               rsts_ast_o_1,
  inout [1:0]                                                       flash_test_mode_a_io_1,
  inout                                                             flash_test_voltage_h_io_1,
  inout                                                             otp_ext_voltage_h_io_1,
  input                                                             scan_rst_ni_1,
  input                                                             scan_en_i_1,
  input lc_ctrl_pkg::lc_tx_t                                        scanmode_i_1,

  // I/O for instance 2
  input        [46:0]                                               mio_in_i_2,
  output logic [46:0]                                               mio_out_o_2,
  output logic [46:0]                                               mio_oe_o_2,
  input        [23:0]                                               dio_in_i_2,
  output logic [23:0]                                               dio_out_o_2,
  output logic [23:0]                                               dio_oe_o_2,
  output prim_pad_wrapper_pkg::pad_attr_t [pinmux_reg_pkg::NMioPads-1:0]    mio_attr_o_2,
  output prim_pad_wrapper_pkg::pad_attr_t [pinmux_reg_pkg::NDioPads-1:0]    dio_attr_o_2,
  output ast_pkg::adc_ast_req_t                                     adc_req_o_2,
  input  ast_pkg::adc_ast_rsp_t                                     adc_rsp_i_2,
  input  edn_pkg::edn_req_t                                         ast_edn_req_i_2,
  output edn_pkg::edn_rsp_t                                         ast_edn_rsp_o_2,
  output lc_ctrl_pkg::lc_tx_t                                       ast_lc_dft_en_o_2,
  input  prim_ram_1p_pkg::ram_1p_cfg_t                              ram_1p_cfg_i_2,
  input  prim_ram_2p_pkg::ram_2p_cfg_t                              ram_2p_cfg_i_2,
  input  prim_rom_pkg::rom_cfg_t                                    rom_cfg_i_2,
  output logic                                                      clk_main_jitter_en_o_2,
  output lc_ctrl_pkg::lc_tx_t                                       ast_clk_byp_req_o_2,
  input  lc_ctrl_pkg::lc_tx_t                                       ast_clk_byp_ack_i_2,
  output ast_pkg::ast_dif_t                                         flash_alert_o_2,
  input  lc_ctrl_pkg::lc_tx_t                                       flash_bist_enable_i_2,
  input  logic                                                      flash_power_down_h_i_2,
  input  logic                                                      flash_power_ready_h_i_2,
  output entropy_src_pkg::entropy_src_rng_req_t                     es_rng_req_o_2,
  input  entropy_src_pkg::entropy_src_rng_rsp_t                     es_rng_rsp_i_2,
  output logic                                                      es_rng_fips_o_2,
  output tlul_pkg::tl_h2d_t                                         ast_tl_req_o_2,
  input  tlul_pkg::tl_d2h_t                                         ast_tl_rsp_i_2,
  output pinmux_pkg::dft_strap_test_req_t                           dft_strap_test_o_2,
  input  logic                                                      dft_hold_tap_sel_i_2,
  output pwrmgr_pkg::pwr_ast_req_t                                  pwrmgr_ast_req_o_2,
  input  pwrmgr_pkg::pwr_ast_rsp_t                                  pwrmgr_ast_rsp_i_2,
  output otp_ctrl_pkg::otp_ast_req_t                                otp_ctrl_otp_ast_pwr_seq_o_2,
  input  otp_ctrl_pkg::otp_ast_rsp_t                                otp_ctrl_otp_ast_pwr_seq_h_i_2,
  output ast_pkg::ast_dif_t                                         otp_alert_o_2,
  input  ast_pkg::ast_alert_req_t                                   sensor_ctrl_ast_alert_req_i_2,
  output ast_pkg::ast_alert_rsp_t                                   sensor_ctrl_ast_alert_rsp_o_2,
  input  ast_pkg::ast_status_t                                      sensor_ctrl_ast_status_i_2,
  input  logic [8:0]                                                ast2pinmux_i_2,
  input  logic                                                      ast_init_done_i_2,
  output logic                                                      usbdev_usb_ref_val_o_2,
  output logic                                                      usbdev_usb_ref_pulse_o_2,
  output clkmgr_pkg::clkmgr_ast_out_t                               clks_ast_o_2,
  output rstmgr_pkg::rstmgr_ast_out_t                               rsts_ast_o_2,
  inout [1:0]                                                       flash_test_mode_a_io_2,
  inout                                                             flash_test_voltage_h_io_2,
  inout                                                             otp_ext_voltage_h_io_2,
  input                                                             scan_rst_ni_2,
  input                                                             scan_en_i_2,
  input lc_ctrl_pkg::lc_tx_t                                        scanmode_i_2
);

  top_earlgrey #(
    .SramCtrlRetAonInstrExec(0),
    .SramCtrlMainInstrExec(1)
  ) top_earlgrey_1 (
    .rst_ni                       (rst_ni),
    .mio_in_i                     (mio_in_i_1),
    .mio_out_o                    (mio_out_o_1),
    .mio_oe_o                     (mio_oe_o_1),
    .dio_in_i                     (dio_in_i_1),
    .dio_out_o                    (dio_out_o_1),
    .dio_oe_o                     (dio_oe_o_1),
    .mio_attr_o                   (mio_attr_o_1),
    .dio_attr_o                   (dio_attr_o_1),
    .adc_req_o                    (adc_req_o_1),
    .adc_rsp_i                    (adc_rsp_i_1),
    .ast_edn_req_i                (ast_edn_req_i_1),
    .ast_edn_rsp_o                (ast_edn_rsp_o_1),
    .ast_lc_dft_en_o              (ast_lc_dft_en_o_1),
    .ram_1p_cfg_i                 (ram_1p_cfg_i_1),
    .ram_2p_cfg_i                 (ram_2p_cfg_i_1),
    .rom_cfg_i                    (rom_cfg_i_1),
    .clk_main_i                   (clk_i),
    .clk_io_i                     (clk_i),
    .clk_usb_i                    (clk_i),
    .clk_aon_i                    (clk_i),
    .clk_main_jitter_en_o         (clk_main_jitter_en_o_1),
    .ast_clk_byp_req_o            (ast_clk_byp_req_o_1),
    .ast_clk_byp_ack_i            (ast_clk_byp_ack_i_1),
    .flash_alert_o                (flash_alert_o_1),
    .flash_bist_enable_i          (flash_bist_enable_i_1),
    .flash_power_down_h_i         (flash_power_down_h_i_1),
    .flash_power_ready_h_i        (flash_power_ready_h_i_1),
    .es_rng_req_o                 (es_rng_req_o_1),
    .es_rng_rsp_i                 (es_rng_rsp_i_1),
    .es_rng_fips_o                (es_rng_fips_o_1),
    .ast_tl_req_o                 (ast_tl_req_o_1),
    .ast_tl_rsp_i                 (ast_tl_rsp_i_1),
    .dft_strap_test_o             (dft_strap_test_o_1),
    .dft_hold_tap_sel_i           (dft_hold_tap_sel_i_1),
    .pwrmgr_ast_req_o             (pwrmgr_ast_req_o_1),
    .pwrmgr_ast_rsp_i             (pwrmgr_ast_rsp_i_1),
    .otp_ctrl_otp_ast_pwr_seq_o   (otp_ctrl_otp_ast_pwr_seq_o_1),
    .otp_ctrl_otp_ast_pwr_seq_h_i (otp_ctrl_otp_ast_pwr_seq_h_i_1),
    .otp_alert_o                  (otp_alert_o_1),
    .sensor_ctrl_ast_alert_req_i  (sensor_ctrl_ast_alert_req_i_1),
    .sensor_ctrl_ast_alert_rsp_o  (sensor_ctrl_ast_alert_rsp_o_1),
    .sensor_ctrl_ast_status_i     (sensor_ctrl_ast_status_i_1),
    .ast2pinmux_i                 (ast2pinmux_i_1),
    .ast_init_done_i              (ast_init_done_i_1),
    .usbdev_usb_ref_val_o         (usbdev_usb_ref_val_o_1),
    .usbdev_usb_ref_pulse_o       (usbdev_usb_ref_pulse_o_1),
    .clks_ast_o                   (clks_ast_o_1),
    .rsts_ast_o                   (rsts_ast_o_1),
    .flash_test_mode_a_io         (flash_test_mode_a_io_1),
    .flash_test_voltage_h_io      (flash_test_voltage_h_io_1),
    .otp_ext_voltage_h_io         (otp_ext_voltage_h_io_1),
    .scan_rst_ni                  (scan_rst_ni_1),
    .scan_en_i                    (scan_en_i_1),
    .scanmode_i                   (scanmode_i_1)
  );

  top_earlgrey #(
    .SramCtrlRetAonInstrExec(0),
    .SramCtrlMainInstrExec(1)
  ) top_earlgrey_2 (
    .rst_ni                       (rst_ni),
    .mio_in_i                     (mio_in_i_2),
    .mio_out_o                    (mio_out_o_2),
    .mio_oe_o                     (mio_oe_o_2),
    .dio_in_i                     (dio_in_i_2),
    .dio_out_o                    (dio_out_o_2),
    .dio_oe_o                     (dio_oe_o_2),
    .mio_attr_o                   (mio_attr_o_2),
    .dio_attr_o                   (dio_attr_o_2),
    .adc_req_o                    (adc_req_o_2),
    .adc_rsp_i                    (adc_rsp_i_2),
    .ast_edn_req_i                (ast_edn_req_i_2),
    .ast_edn_rsp_o                (ast_edn_rsp_o_2),
    .ast_lc_dft_en_o              (ast_lc_dft_en_o_2),
    .ram_1p_cfg_i                 (ram_1p_cfg_i_2),
    .ram_2p_cfg_i                 (ram_2p_cfg_i_2),
    .rom_cfg_i                    (rom_cfg_i_2),
    .clk_main_i                   (clk_i),
    .clk_io_i                     (clk_i),
    .clk_usb_i                    (clk_i),
    .clk_aon_i                    (clk_i),
    .clk_main_jitter_en_o         (clk_main_jitter_en_o_2),
    .ast_clk_byp_req_o            (ast_clk_byp_req_o_2),
    .ast_clk_byp_ack_i            (ast_clk_byp_ack_i_2),
    .flash_alert_o                (flash_alert_o_2),
    .flash_bist_enable_i          (flash_bist_enable_i_2),
    .flash_power_down_h_i         (flash_power_down_h_i_2),
    .flash_power_ready_h_i        (flash_power_ready_h_i_2),
    .es_rng_req_o                 (es_rng_req_o_2),
    .es_rng_rsp_i                 (es_rng_rsp_i_2),
    .es_rng_fips_o                (es_rng_fips_o_2),
    .ast_tl_req_o                 (ast_tl_req_o_2),
    .ast_tl_rsp_i                 (ast_tl_rsp_i_2),
    .dft_strap_test_o             (dft_strap_test_o_2),
    .dft_hold_tap_sel_i           (dft_hold_tap_sel_i_2),
    .pwrmgr_ast_req_o             (pwrmgr_ast_req_o_2),
    .pwrmgr_ast_rsp_i             (pwrmgr_ast_rsp_i_2),
    .otp_ctrl_otp_ast_pwr_seq_o   (otp_ctrl_otp_ast_pwr_seq_o_2),
    .otp_ctrl_otp_ast_pwr_seq_h_i (otp_ctrl_otp_ast_pwr_seq_h_i_2),
    .otp_alert_o                  (otp_alert_o_2),
    .sensor_ctrl_ast_alert_req_i  (sensor_ctrl_ast_alert_req_i_2),
    .sensor_ctrl_ast_alert_rsp_o  (sensor_ctrl_ast_alert_rsp_o_2),
    .sensor_ctrl_ast_status_i     (sensor_ctrl_ast_status_i_2),
    .ast2pinmux_i                 (ast2pinmux_i_2),
    .ast_init_done_i              (ast_init_done_i_2),
    .usbdev_usb_ref_val_o         (usbdev_usb_ref_val_o_2),
    .usbdev_usb_ref_pulse_o       (usbdev_usb_ref_pulse_o_2),
    .clks_ast_o                   (clks_ast_o_2),
    .rsts_ast_o                   (rsts_ast_o_2),
    .flash_test_mode_a_io         (flash_test_mode_a_io_2),
    .flash_test_voltage_h_io      (flash_test_voltage_h_io_2),
    .otp_ext_voltage_h_io         (otp_ext_voltage_h_io_2),
    .scan_rst_ni                  (scan_rst_ni_2),
    .scan_en_i                    (scan_en_i_2),
    .scanmode_i                   (scanmode_i_2)
  );
    
endmodule