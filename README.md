# IEEE 802.16 OFDM-based transceiver system
This repos contains the implementation of IEEE 802.16 (i.e. WiMax) OFDM-based transceiver system. This is stored in 3 separate parts, i.e. transmitter (TX), receiver (RX) and transceiver (SYS).

Each part includes implementation files stored in **MY_SOURCES** and **IPCORE**, and simulation golden model stored in **MATLAB**.

**MY_SOURCES** contains hdl files using verilog to implement the sub-modules (*.v) of systems and to make a testbench files (*_tb.v). There are some pre-computed cofficient sets defined by the standard (e.g. preamble) are stored in '*.txt' files. OFDM_TX_802_16.v, OFDM_RX_802_16.v and OFDM_SYS.sch are the top modules of transmitter, receiver and transceiver systems, respectively.

**IPCORE** contains the configured files of IPCores instantiated by impelemented systems. The IPCores are generated using ISE Design Tool.

**MATLAB** contains matlab files that simulate 802.11 OFDM signals as a golden model for implementation. The matlab files are also used to generate test vector for testbench and verify the output files from testbench.

#### Publications

This implementation is presented in the papers below:

[1] T. H. Pham, S. A. Fahmy and I. V. McLoughlin, "Low-Power Correlation for IEEE 802.16 OFDM Synchronization on FPGA," in IEEE Transactions on Very Large Scale Integration (VLSI) Systems, vol. 21, no. 8, pp. 1549-1553, Aug. 2013. 
[doi: 10.1109/TVLSI.2012.2210917](https://www.researchgate.net/publication/260655626)	

[2] T. H. Pham, I. V. Mcloughlin and S. A. Fahmy, "Robust and Efficient OFDM Synchronization for FPGA-Based Radios," Circuits, Systems, and Signal Processing, vol. 33, (8), pp. 2475-2493, 2014. 
[doi: 10.1007/s00034-014-9747-z](https://www.researchgate.net/publication/260267629)

[3] T. H. Pham, S. A. Fahmy and I. V. McLoughlin, "Efficient Integer Frequency Offset Estimation Architecture for Enhanced OFDM Synchronization," in IEEE Transactions on Very Large Scale Integration (VLSI) Systems, vol. 24, no. 4, pp. 1412-1420, April 2016.
[doi: 10.1109/TVLSI.2015.2453207](https://www.researchgate.net/publication/280932614)

[4] T. H. Pham, S. A. Fahmy and I. V. McLoughlin, "An End-to-End Multi-Standard OFDM Transceiver Architecture Using FPGA Partial Reconfiguration," in IEEE Access, vol. 5, pp. 21002-21015, 2017.
[doi: 10.1109/ACCESS.2017.2756914](http://ieeexplore.ieee.org/stamp/stamp.jsp?tp=&arnumber=8051045&isnumber=7859429)

If you use this for research, please cite the paper:
```
@ARTICLE{Pham2017, 
author={T. H. Pham and S. A. Fahmy and I. V. McLoughlin}, 
journal={IEEE Access}, 
title={An End-to-End Multi-Standard OFDM Transceiver Architecture Using FPGA Partial Reconfiguration}, 
year={2017}, 
volume={5}, 
number={}, 
pages={21002-21015}, 
keywords={Baseband;Field programmable gate arrays;Hardware;OFDM;Program processors;Standards;OFDM;cognitive radio;open wireless architecture;radio transceivers;reconfigurable architectures}, 
doi={10.1109/ACCESS.2017.2756914}, 
ISSN={}, 
month={},}
```
