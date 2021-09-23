// Copyright lowRISC contributors.
// Licensed under the Apache License, Version 2.0, see LICENSE for details.
// SPDX-License-Identifier: Apache-2.0
#ifndef OPENTITAN_HW_IP_OTBN_DV_MEMUTIL_OTBN_MEMUTIL_H_
#define OPENTITAN_HW_IP_OTBN_DV_MEMUTIL_OTBN_MEMUTIL_H_

#include <svdpi.h>

#include "dpi_memutil.h"
#include "ecc32_mem_area.h"

class OtbnMemUtil : public DpiMemUtil {
 public:
  // Constructor. top_scope is the SV scope that contains IMEM and
  // DMEM memories as u_imem and u_dmem, respectively.
  OtbnMemUtil(const std::string &top_scope);

  // Load an ELF file at the given path and backdoor load it into the
  // attached memories.
  //
  // If something goes wrong, throws a std::exception.
  void LoadElf(const std::string &elf_path);

  // Get access to the segments currently staged for imem/dmem
  const StagedMem::SegMap &GetSegs(bool is_imem) const;

  // Get access to a memory area
  const MemArea &GetMemArea(bool is_imem) const {
    return is_imem ? imem_ : dmem_;
  }

  // Get the expected end address, if set. Otherwise returns -1.
  int GetExpEndAddr() const { return expected_end_addr_; }

 private:
  void OnElfLoaded(Elf *elf_file) override;

  Ecc32MemArea imem_, dmem_;
  int expected_end_addr_;
};

// DPI-accessible wrappers
extern "C" {
OtbnMemUtil *OtbnMemUtilMake(const char *top_scope);
void OtbnMemUtilFree(OtbnMemUtil *mem_util);

// Loads an ELF file into memory via the backdoor. Returns 1'b1 on success.
// Prints a message to stderr and returns 1'b0 on failure.
svBit OtbnMemUtilLoadElf(OtbnMemUtil *mem_util, const char *elf_path);

// Loads an ELF file into the OtbnMemUtil object, but doesn't touch the
// simulated memory. Returns 1'b1 on success. Prints a message to stderr and
// returns 1'b0 on failure.
svBit OtbnMemUtilStageElf(OtbnMemUtil *mem_util, const char *elf_path);

// Returns the number of segments currently staged in imem/dmem.
int OtbnMemUtilGetSegCount(OtbnMemUtil *mem_util, svBit is_imem);

// Gets offset and size (both in 32-bit words) for a segment currently staged
// in imem/dmem. Both are returned with output arguments. Returns 1'b1 on
// success. Prints a message to stderr and returns 1'b0 on failure.
svBit OtbnMemUtilGetSegInfo(OtbnMemUtil *mem_util, svBit is_imem, int seg_idx,
                            /* output bit[31:0] */ svBitVecVal *seg_off,
                            /* output bit[31:0] */ svBitVecVal *seg_size);

// Gets a word of data from segments currently staged in imem/dmem. If there
// is a word at that address, the function writes its value to the output
// argument and then returns 1'b1. If there is no word at that address, the
// output argument is untouched and the function returns 1'b0.
//
// If word_off is invalid (negative or enormous), the function writes a
// message to stderr and returns 1'b0.
svBit OtbnMemUtilGetSegData(OtbnMemUtil *mem_util, svBit is_imem, int word_off,
                            /* output bit[31:0] */ svBitVecVal *data_value);

// Get an "expected end address". This is a belt-and-braces check, where the
// producer of the ELF file knows what address they expect to finish at (either
// an ECALL or a known-bad faulting instruction). They can put this as a magic
// symbol in the ELF file and then we check at simulation time that we really
// did stop there.
//
// Note: This functionality doesn't provide any extra check of OTBN itself.
// Rather, it's helpful for debugging the random instruction generator, which
// is supposed to be able to predict (roughly) what its instruction streams
// will do.
//
// Returns the output address as an integer. A negative result means that no
// such address is present in the ELF file.
int OtbnMemUtilGetExpEndAddr(OtbnMemUtil *mem_util);
}

#endif  // OPENTITAN_HW_IP_OTBN_DV_MEMUTIL_OTBN_MEMUTIL_H_