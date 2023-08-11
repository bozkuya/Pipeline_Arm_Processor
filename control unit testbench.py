import cocotb
from cocotb.regression import TestFactory
from cocotb.triggers import RisingEdge, FallingEdge

@cocotb.test()
async def test_control_unit(dut):
    """Test control unit"""

    # Define the clock period
    clock_period = 1  # adjust this to your actual clock period

    # Reset the design
    dut.reset <= 1
    dut.opcode <= 0
    dut.func <= 0

    await FallingEdge(dut.clock)
    dut.reset <= 0
    await FallingEdge(dut.clock)

    # Test R-type instructions (assuming opcode 0 is for R-type)
    dut.opcode <= 0
    await FallingEdge(dut.clock)

    assert dut.mem_to_reg == 0, "Incorrect control signal for R-type instruction"
    assert dut.mem_write == 0, "Incorrect control signal for R-type instruction"
    assert dut.branch == 0, "Incorrect control signal for R-type instruction"
    assert dut.reg_write == 1, "Incorrect control signal for R-type instruction"
    assert dut.alu_src == 0, "Incorrect control signal for R-type instruction"
    assert dut.jump == 0, "Incorrect control signal for R-type instruction"

    # Test more cases...

tf = TestFactory(test_control_unit)
tf.generate_tests()
