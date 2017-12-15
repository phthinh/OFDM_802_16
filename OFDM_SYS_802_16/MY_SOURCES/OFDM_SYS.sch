<?xml version="1.0" encoding="UTF-8"?>
<drawing version="7">
    <attr value="spartan6" name="DeviceFamilyName">
        <trait delete="all:0" />
        <trait editname="all:0" />
        <trait edittrait="all:0" />
    </attr>
    <netlist>
        <signal name="XLXN_1(31:0)" />
        <signal name="XLXN_2" />
        <signal name="XLXN_3" />
        <signal name="XLXN_4" />
        <signal name="XLXN_5" />
        <signal name="XLXN_6(31:0)" />
        <signal name="XLXN_7" />
        <signal name="XLXN_8" />
        <signal name="XLXN_9" />
        <signal name="XLXN_10" />
        <signal name="XLXN_11(31:0)" />
        <signal name="XLXN_12" />
        <signal name="XLXN_13" />
        <signal name="XLXN_14" />
        <signal name="XLXN_15" />
        <signal name="DAT_I(1:0)" />
        <signal name="CYC_I" />
        <signal name="WE_I" />
        <signal name="STB_I" />
        <signal name="CLK_I" />
        <signal name="RST_I" />
        <signal name="ACK_O" />
        <signal name="XLXN_79" />
        <signal name="XLXN_97(31:0)" />
        <signal name="XLXN_98" />
        <signal name="XLXN_16" />
        <signal name="XLXN_17" />
        <signal name="XLXN_18" />
        <signal name="XLXN_19" />
        <signal name="XLXN_20(31:0)" />
        <signal name="XLXN_21(31:0)" />
        <signal name="XLXN_22" />
        <signal name="XLXN_23" />
        <signal name="XLXN_24" />
        <signal name="XLXN_25" />
        <signal name="XLXN_26" />
        <signal name="XLXN_27(31:0)" />
        <signal name="XLXN_28" />
        <signal name="XLXN_29" />
        <signal name="XLXN_30" />
        <signal name="XLXN_31(31:0)" />
        <signal name="XLXN_32" />
        <signal name="XLXN_33" />
        <signal name="XLXN_34" />
        <signal name="XLXN_35" />
        <signal name="XLXN_36" />
        <signal name="XLXN_37(31:0)" />
        <signal name="XLXN_38" />
        <signal name="XLXN_39" />
        <signal name="XLXN_40" />
        <signal name="XLXN_41(31:0)" />
        <signal name="XLXN_42" />
        <signal name="XLXN_43" />
        <signal name="XLXN_44" />
        <signal name="XLXN_45" />
        <signal name="XLXN_46" />
        <signal name="XLXN_47(31:0)" />
        <signal name="XLXN_48" />
        <signal name="XLXN_49" />
        <signal name="XLXN_50" />
        <signal name="XLXN_51(31:0)" />
        <signal name="XLXN_52" />
        <signal name="DAT_O(7:0)" />
        <signal name="WE_O" />
        <signal name="STB_O" />
        <signal name="CYC_O" />
        <signal name="ACK_I" />
        <signal name="SNR_I(3:0)" />
        <signal name="XLXN_675" />
        <signal name="XLXN_676" />
        <signal name="XLXN_677" />
        <signal name="XLXN_678" />
        <signal name="XLXN_679(31:0)" />
        <signal name="XLXN_681" />
        <signal name="XLXN_683" />
        <signal name="XLXN_684" />
        <port polarity="Input" name="DAT_I(1:0)" />
        <port polarity="Input" name="CYC_I" />
        <port polarity="Input" name="WE_I" />
        <port polarity="Input" name="STB_I" />
        <port polarity="Input" name="CLK_I" />
        <port polarity="Input" name="RST_I" />
        <port polarity="Output" name="ACK_O" />
        <port polarity="Output" name="DAT_O(7:0)" />
        <port polarity="Output" name="WE_O" />
        <port polarity="Output" name="STB_O" />
        <port polarity="Output" name="CYC_O" />
        <port polarity="Input" name="ACK_I" />
        <port polarity="Input" name="SNR_I(3:0)" />
        <blockdef name="QPSK_Mod">
            <timestamp>2012-12-4T6:29:9</timestamp>
            <rect width="288" x="64" y="-448" height="512" />
            <rect width="64" x="0" y="-428" height="24" />
            <line x2="0" y1="-416" y2="-416" x1="64" />
            <line x2="0" y1="-352" y2="-352" x1="64" />
            <line x2="0" y1="-288" y2="-288" x1="64" />
            <line x2="0" y1="-224" y2="-224" x1="64" />
            <line x2="0" y1="32" y2="32" x1="64" />
            <line x2="64" y1="-160" y2="-160" x1="0" />
            <rect width="64" x="352" y="-428" height="24" />
            <line x2="416" y1="-416" y2="-416" x1="352" />
            <line x2="416" y1="-352" y2="-352" x1="352" />
            <line x2="416" y1="-288" y2="-288" x1="352" />
            <line x2="416" y1="-224" y2="-224" x1="352" />
            <line x2="352" y1="-160" y2="-160" x1="416" />
            <line x2="0" y1="-32" y2="-32" x1="64" />
        </blockdef>
        <blockdef name="Pilots_Insert">
            <timestamp>2012-12-4T6:32:3</timestamp>
            <rect width="288" x="64" y="-448" height="512" />
            <rect width="64" x="0" y="-428" height="24" />
            <line x2="0" y1="-416" y2="-416" x1="64" />
            <line x2="0" y1="-352" y2="-352" x1="64" />
            <line x2="0" y1="-288" y2="-288" x1="64" />
            <line x2="0" y1="-224" y2="-224" x1="64" />
            <line x2="0" y1="-32" y2="-32" x1="64" />
            <line x2="0" y1="32" y2="32" x1="64" />
            <line x2="416" y1="-352" y2="-352" x1="352" />
            <line x2="416" y1="-224" y2="-224" x1="352" />
            <line x2="416" y1="-288" y2="-288" x1="352" />
            <rect width="64" x="352" y="-428" height="24" />
            <line x2="416" y1="-416" y2="-416" x1="352" />
            <line x2="352" y1="-160" y2="-160" x1="416" />
            <line x2="64" y1="-160" y2="-160" x1="0" />
        </blockdef>
        <blockdef name="IFFT_Mod">
            <timestamp>2012-12-4T8:13:50</timestamp>
            <rect width="288" x="64" y="-432" height="512" />
            <rect width="64" x="0" y="-412" height="24" />
            <line x2="0" y1="-400" y2="-400" x1="64" />
            <line x2="0" y1="-336" y2="-336" x1="64" />
            <line x2="0" y1="-272" y2="-272" x1="64" />
            <line x2="0" y1="-208" y2="-208" x1="64" />
            <line x2="416" y1="-336" y2="-336" x1="352" />
            <line x2="416" y1="-208" y2="-208" x1="352" />
            <line x2="416" y1="-272" y2="-272" x1="352" />
            <line x2="352" y1="-144" y2="-144" x1="416" />
            <line x2="64" y1="-144" y2="-144" x1="0" />
            <rect width="64" x="352" y="-412" height="24" />
            <line x2="416" y1="-400" y2="-400" x1="352" />
            <line x2="0" y1="-16" y2="-16" x1="64" />
            <line x2="0" y1="48" y2="48" x1="64" />
        </blockdef>
        <blockdef name="Tx_Out">
            <timestamp>2012-12-4T6:46:44</timestamp>
            <rect width="288" x="64" y="-448" height="512" />
            <rect width="64" x="0" y="-428" height="24" />
            <line x2="0" y1="-416" y2="-416" x1="64" />
            <line x2="0" y1="-288" y2="-288" x1="64" />
            <line x2="0" y1="-224" y2="-224" x1="64" />
            <line x2="0" y1="-352" y2="-352" x1="64" />
            <line x2="0" y1="-32" y2="-32" x1="64" />
            <line x2="0" y1="32" y2="32" x1="64" />
            <line x2="416" y1="-352" y2="-352" x1="352" />
            <line x2="416" y1="-224" y2="-224" x1="352" />
            <line x2="416" y1="-288" y2="-288" x1="352" />
            <line x2="352" y1="-160" y2="-160" x1="416" />
            <line x2="64" y1="-160" y2="-160" x1="0" />
            <rect width="64" x="352" y="-428" height="24" />
            <line x2="416" y1="-416" y2="-416" x1="352" />
        </blockdef>
        <blockdef name="Synch">
            <timestamp>2012-12-29T5:51:54</timestamp>
            <rect width="64" x="368" y="-300" height="24" />
            <line x2="432" y1="-288" y2="-288" x1="368" />
            <line x2="432" y1="-224" y2="-224" x1="368" />
            <line x2="432" y1="-160" y2="-160" x1="368" />
            <line x2="368" y1="-32" y2="-32" x1="432" />
            <rect width="64" x="368" y="20" height="24" />
            <line x2="432" y1="32" y2="32" x1="368" />
            <line x2="432" y1="-96" y2="-96" x1="368" />
            <line x2="432" y1="64" y2="64" x1="368" />
            <rect width="304" x="64" y="-320" height="512" />
            <rect width="64" x="0" y="-300" height="24" />
            <line x2="0" y1="-288" y2="-288" x1="64" />
            <line x2="0" y1="96" y2="96" x1="64" />
            <line x2="0" y1="160" y2="160" x1="64" />
            <line x2="64" y1="-32" y2="-32" x1="0" />
            <line x2="0" y1="32" y2="32" x1="64" />
            <rect width="64" x="0" y="20" height="24" />
            <line x2="0" y1="-224" y2="-224" x1="64" />
            <line x2="0" y1="-160" y2="-160" x1="64" />
            <line x2="0" y1="-96" y2="-96" x1="64" />
        </blockdef>
        <blockdef name="FreComp">
            <timestamp>2012-12-27T6:8:51</timestamp>
            <line x2="0" y1="-416" y2="-416" x1="64" />
            <line x2="0" y1="-352" y2="-352" x1="64" />
            <line x2="0" y1="-288" y2="-288" x1="64" />
            <rect width="64" x="0" y="-492" height="24" />
            <line x2="0" y1="-480" y2="-480" x1="64" />
            <rect width="64" x="0" y="-172" height="24" />
            <line x2="0" y1="-160" y2="-160" x1="64" />
            <line x2="64" y1="-224" y2="-224" x1="0" />
            <rect width="64" x="368" y="-492" height="24" />
            <line x2="432" y1="-480" y2="-480" x1="368" />
            <line x2="432" y1="-416" y2="-416" x1="368" />
            <line x2="432" y1="-352" y2="-352" x1="368" />
            <line x2="432" y1="-288" y2="-288" x1="368" />
            <line x2="368" y1="-224" y2="-224" x1="432" />
            <rect width="304" x="64" y="-512" height="512" />
            <line x2="0" y1="-128" y2="-128" x1="64" />
            <line x2="0" y1="-16" y2="-16" x1="64" />
            <line x2="0" y1="-64" y2="-64" x1="64" />
        </blockdef>
        <blockdef name="RemoveCP">
            <timestamp>2012-12-27T6:9:36</timestamp>
            <rect width="304" x="64" y="-448" height="512" />
            <rect width="64" x="0" y="-428" height="24" />
            <line x2="0" y1="-416" y2="-416" x1="64" />
            <line x2="0" y1="-352" y2="-352" x1="64" />
            <line x2="0" y1="-288" y2="-288" x1="64" />
            <line x2="0" y1="-224" y2="-224" x1="64" />
            <line x2="64" y1="-160" y2="-160" x1="0" />
            <rect width="64" x="368" y="-428" height="24" />
            <line x2="432" y1="-416" y2="-416" x1="368" />
            <line x2="432" y1="-352" y2="-352" x1="368" />
            <line x2="432" y1="-288" y2="-288" x1="368" />
            <line x2="432" y1="-224" y2="-224" x1="368" />
            <line x2="368" y1="-160" y2="-160" x1="432" />
            <line x2="0" y1="-32" y2="-32" x1="64" />
            <line x2="0" y1="32" y2="32" x1="64" />
        </blockdef>
        <blockdef name="FFT">
            <timestamp>2012-12-27T6:10:14</timestamp>
            <rect width="64" x="0" y="-428" height="24" />
            <line x2="0" y1="-416" y2="-416" x1="64" />
            <rect width="64" x="368" y="-428" height="24" />
            <line x2="432" y1="-416" y2="-416" x1="368" />
            <line x2="0" y1="-352" y2="-352" x1="64" />
            <line x2="0" y1="-288" y2="-288" x1="64" />
            <line x2="0" y1="-224" y2="-224" x1="64" />
            <line x2="64" y1="-160" y2="-160" x1="0" />
            <line x2="432" y1="-352" y2="-352" x1="368" />
            <line x2="432" y1="-288" y2="-288" x1="368" />
            <line x2="368" y1="-160" y2="-160" x1="432" />
            <rect width="304" x="64" y="-448" height="512" />
            <line x2="432" y1="-224" y2="-224" x1="368" />
            <line x2="0" y1="-32" y2="-32" x1="64" />
            <line x2="0" y1="32" y2="32" x1="64" />
        </blockdef>
        <blockdef name="iCFO_EstComp">
            <timestamp>2012-12-27T6:11:45</timestamp>
            <line x2="0" y1="-416" y2="-416" x1="64" />
            <rect width="64" x="0" y="-428" height="24" />
            <line x2="0" y1="-352" y2="-352" x1="64" />
            <line x2="0" y1="-288" y2="-288" x1="64" />
            <line x2="0" y1="-224" y2="-224" x1="64" />
            <rect width="304" x="64" y="-448" height="508" />
            <line x2="64" y1="-160" y2="-160" x1="0" />
            <line x2="0" y1="-32" y2="-32" x1="64" />
            <line x2="0" y1="32" y2="32" x1="64" />
            <rect width="64" x="368" y="-428" height="24" />
            <line x2="432" y1="-416" y2="-416" x1="368" />
            <line x2="432" y1="-352" y2="-352" x1="368" />
            <line x2="432" y1="-288" y2="-288" x1="368" />
            <line x2="432" y1="-224" y2="-224" x1="368" />
            <line x2="368" y1="-160" y2="-160" x1="432" />
        </blockdef>
        <blockdef name="Ch_EstEqu">
            <timestamp>2012-12-27T6:13:39</timestamp>
            <rect width="304" x="64" y="-448" height="512" />
            <rect width="64" x="0" y="-428" height="24" />
            <line x2="0" y1="-416" y2="-416" x1="64" />
            <line x2="0" y1="-352" y2="-352" x1="64" />
            <line x2="0" y1="-288" y2="-288" x1="64" />
            <line x2="0" y1="-224" y2="-224" x1="64" />
            <line x2="64" y1="-160" y2="-160" x1="0" />
            <rect width="64" x="368" y="-428" height="24" />
            <line x2="432" y1="-416" y2="-416" x1="368" />
            <line x2="432" y1="-352" y2="-352" x1="368" />
            <line x2="432" y1="-288" y2="-288" x1="368" />
            <line x2="432" y1="-224" y2="-224" x1="368" />
            <line x2="368" y1="-160" y2="-160" x1="432" />
            <line x2="0" y1="-32" y2="-32" x1="64" />
            <line x2="0" y1="32" y2="32" x1="64" />
        </blockdef>
        <blockdef name="PhaseTrack">
            <timestamp>2012-12-27T6:14:13</timestamp>
            <rect width="304" x="64" y="-448" height="512" />
            <line x2="0" y1="-32" y2="-32" x1="64" />
            <line x2="0" y1="32" y2="32" x1="64" />
            <rect width="64" x="0" y="-428" height="24" />
            <line x2="0" y1="-416" y2="-416" x1="64" />
            <line x2="0" y1="-352" y2="-352" x1="64" />
            <line x2="0" y1="-288" y2="-288" x1="64" />
            <line x2="0" y1="-224" y2="-224" x1="64" />
            <line x2="64" y1="-160" y2="-160" x1="0" />
            <rect width="64" x="368" y="-428" height="24" />
            <line x2="432" y1="-416" y2="-416" x1="368" />
            <line x2="432" y1="-352" y2="-352" x1="368" />
            <line x2="432" y1="-288" y2="-288" x1="368" />
            <line x2="432" y1="-224" y2="-224" x1="368" />
            <line x2="368" y1="-160" y2="-160" x1="432" />
        </blockdef>
        <blockdef name="DataSymDem">
            <timestamp>2012-12-27T6:14:48</timestamp>
            <rect width="304" x="64" y="-448" height="512" />
            <rect width="64" x="0" y="-428" height="24" />
            <line x2="0" y1="-416" y2="-416" x1="64" />
            <rect width="64" x="368" y="-428" height="24" />
            <line x2="432" y1="-416" y2="-416" x1="368" />
            <line x2="0" y1="-352" y2="-352" x1="64" />
            <line x2="0" y1="-288" y2="-288" x1="64" />
            <line x2="0" y1="-224" y2="-224" x1="64" />
            <line x2="432" y1="-352" y2="-352" x1="368" />
            <line x2="432" y1="-288" y2="-288" x1="368" />
            <line x2="64" y1="-160" y2="-160" x1="0" />
            <line x2="368" y1="-160" y2="-160" x1="432" />
            <line x2="432" y1="-224" y2="-224" x1="368" />
            <line x2="0" y1="-32" y2="-32" x1="64" />
            <line x2="0" y1="32" y2="32" x1="64" />
        </blockdef>
        <blockdef name="Ch_Sim1">
            <timestamp>2012-12-29T5:45:46</timestamp>
            <line x2="0" y1="-288" y2="-288" x1="64" />
            <line x2="0" y1="-224" y2="-224" x1="64" />
            <rect width="64" x="0" y="-428" height="24" />
            <line x2="0" y1="-416" y2="-416" x1="64" />
            <line x2="0" y1="-352" y2="-352" x1="64" />
            <rect width="688" x="64" y="-448" height="512" />
            <line x2="64" y1="-160" y2="-160" x1="0" />
            <rect width="64" x="752" y="-428" height="24" />
            <line x2="816" y1="-416" y2="-416" x1="752" />
            <line x2="752" y1="-160" y2="-160" x1="816" />
            <line x2="0" y1="-32" y2="-32" x1="64" />
            <line x2="0" y1="32" y2="32" x1="64" />
            <line x2="816" y1="-288" y2="-288" x1="752" />
            <line x2="816" y1="-352" y2="-352" x1="752" />
            <line x2="816" y1="-224" y2="-224" x1="752" />
        </blockdef>
        <block symbolname="QPSK_Mod" name="QPSK_Mod_ins">
            <blockpin signalname="DAT_I(1:0)" name="DAT_I(1:0)" />
            <blockpin signalname="CYC_I" name="CYC_I" />
            <blockpin signalname="WE_I" name="WE_I" />
            <blockpin signalname="STB_I" name="STB_I" />
            <blockpin signalname="RST_I" name="RST_I" />
            <blockpin signalname="ACK_O" name="ACK_O" />
            <blockpin signalname="XLXN_1(31:0)" name="DAT_O(31:0)" />
            <blockpin signalname="XLXN_2" name="CYC_O" />
            <blockpin signalname="XLXN_3" name="WE_O" />
            <blockpin signalname="XLXN_4" name="STB_O" />
            <blockpin signalname="XLXN_5" name="ACK_I" />
            <blockpin signalname="CLK_I" name="CLK_I" />
        </block>
        <block symbolname="Pilots_Insert" name="Pilots_Insert_ins">
            <blockpin signalname="XLXN_1(31:0)" name="DAT_I(31:0)" />
            <blockpin signalname="XLXN_2" name="CYC_I" />
            <blockpin signalname="XLXN_3" name="WE_I" />
            <blockpin signalname="XLXN_4" name="STB_I" />
            <blockpin signalname="CLK_I" name="CLK_I" />
            <blockpin signalname="RST_I" name="RST_I" />
            <blockpin signalname="XLXN_7" name="CYC_O" />
            <blockpin signalname="XLXN_9" name="STB_O" />
            <blockpin signalname="XLXN_8" name="WE_O" />
            <blockpin signalname="XLXN_6(31:0)" name="DAT_O(31:0)" />
            <blockpin signalname="XLXN_10" name="ACK_I" />
            <blockpin signalname="XLXN_5" name="ACK_O" />
        </block>
        <block symbolname="IFFT_Mod" name="IFFT_Mod_ins">
            <blockpin signalname="XLXN_6(31:0)" name="DAT_I(31:0)" />
            <blockpin signalname="XLXN_7" name="CYC_I" />
            <blockpin signalname="XLXN_8" name="WE_I" />
            <blockpin signalname="XLXN_9" name="STB_I" />
            <blockpin signalname="XLXN_14" name="CYC_O" />
            <blockpin signalname="XLXN_13" name="STB_O" />
            <blockpin signalname="XLXN_12" name="WE_O" />
            <blockpin signalname="XLXN_15" name="ACK_I" />
            <blockpin signalname="XLXN_10" name="ACK_O" />
            <blockpin signalname="XLXN_11(31:0)" name="DAT_O(31:0)" />
            <blockpin signalname="CLK_I" name="CLK_I" />
            <blockpin signalname="RST_I" name="RST_I" />
        </block>
        <block symbolname="Synch" name="Synch_ins">
            <blockpin signalname="XLXN_22" name="ACK_I" />
            <blockpin signalname="XLXN_16" name="WE_O" />
            <blockpin signalname="XLXN_17" name="STB_O" />
            <blockpin signalname="XLXN_18" name="CYC_O" />
            <blockpin signalname="XLXN_19" name="FRE_O_val" />
            <blockpin signalname="XLXN_20(31:0)" name="DAT_O(31:0)" />
            <blockpin signalname="XLXN_21(31:0)" name="FRE_O(31:0)" />
            <blockpin signalname="XLXN_97(31:0)" name="DAT_I(31:0)" />
            <blockpin signalname="CLK_I" name="CLK_I" />
            <blockpin signalname="RST_I" name="RST_I" />
            <blockpin signalname="SNR_I(3:0)" name="SNR(3:0)" />
            <blockpin signalname="XLXN_79" name="ACK_O" />
            <blockpin signalname="XLXN_98" name="WE_I" />
            <blockpin signalname="XLXN_683" name="STB_I" />
            <blockpin signalname="XLXN_684" name="CYC_I" />
        </block>
        <block symbolname="RemoveCP" name="RemoveCP_ins">
            <blockpin signalname="CLK_I" name="CLK_I" />
            <blockpin signalname="RST_I" name="RST_I" />
            <blockpin signalname="XLXN_26" name="WE_I" />
            <blockpin signalname="XLXN_25" name="STB_I" />
            <blockpin signalname="XLXN_24" name="CYC_I" />
            <blockpin signalname="XLXN_32" name="ACK_I" />
            <blockpin signalname="XLXN_27(31:0)" name="DAT_I(31:0)" />
            <blockpin signalname="XLXN_23" name="ACK_O" />
            <blockpin signalname="XLXN_30" name="CYC_O" />
            <blockpin signalname="XLXN_29" name="STB_O" />
            <blockpin signalname="XLXN_28" name="WE_O" />
            <blockpin signalname="XLXN_31(31:0)" name="DAT_O(31:0)" />
        </block>
        <block symbolname="iCFO_EstComp" name="iCFO_EstComp_ins">
            <blockpin signalname="CLK_I" name="CLK_I" />
            <blockpin signalname="RST_I" name="RST_I" />
            <blockpin signalname="XLXN_36" name="WE_I" />
            <blockpin signalname="XLXN_35" name="STB_I" />
            <blockpin signalname="XLXN_34" name="CYC_I" />
            <blockpin signalname="XLXN_42" name="ACK_I" />
            <blockpin signalname="XLXN_37(31:0)" name="DAT_I(31:0)" />
            <blockpin signalname="XLXN_33" name="ACK_O" />
            <blockpin signalname="XLXN_40" name="CYC_O" />
            <blockpin signalname="XLXN_39" name="STB_O" />
            <blockpin signalname="XLXN_38" name="WE_O" />
            <blockpin signalname="XLXN_41(31:0)" name="DAT_O(31:0)" />
        </block>
        <block symbolname="PhaseTrack" name="PhaseTrack_ins">
            <blockpin signalname="CLK_I" name="CLK_I" />
            <blockpin signalname="RST_I" name="RST_I" />
            <blockpin signalname="XLXN_46" name="WE_I" />
            <blockpin signalname="XLXN_45" name="STB_I" />
            <blockpin signalname="XLXN_44" name="CYC_I" />
            <blockpin signalname="XLXN_52" name="ACK_I" />
            <blockpin signalname="XLXN_47(31:0)" name="DAT_I(31:0)" />
            <blockpin signalname="XLXN_43" name="ACK_O" />
            <blockpin signalname="XLXN_50" name="CYC_O" />
            <blockpin signalname="XLXN_49" name="STB_O" />
            <blockpin signalname="XLXN_48" name="WE_O" />
            <blockpin signalname="XLXN_51(31:0)" name="DAT_O(31:0)" />
        </block>
        <block symbolname="FreComp" name="FreComp_ins">
            <blockpin signalname="CLK_I" name="CLK_I" />
            <blockpin signalname="RST_I" name="RST_I" />
            <blockpin signalname="XLXN_16" name="WE_I" />
            <blockpin signalname="XLXN_17" name="STB_I" />
            <blockpin signalname="XLXN_18" name="CYC_I" />
            <blockpin signalname="XLXN_19" name="FRE_I_nd" />
            <blockpin signalname="XLXN_23" name="ACK_I" />
            <blockpin signalname="XLXN_20(31:0)" name="DAT_I(31:0)" />
            <blockpin signalname="XLXN_21(31:0)" name="FRE_I(31:0)" />
            <blockpin signalname="XLXN_22" name="ACK_O" />
            <blockpin signalname="XLXN_24" name="CYC_O" />
            <blockpin signalname="XLXN_25" name="STB_O" />
            <blockpin signalname="XLXN_26" name="WE_O" />
            <blockpin signalname="XLXN_27(31:0)" name="DAT_O(31:0)" />
        </block>
        <block symbolname="FFT" name="FFT_ins">
            <blockpin signalname="CLK_I" name="CLK_I" />
            <blockpin signalname="RST_I" name="RST_I" />
            <blockpin signalname="XLXN_28" name="WE_I" />
            <blockpin signalname="XLXN_29" name="STB_I" />
            <blockpin signalname="XLXN_30" name="CYC_I" />
            <blockpin signalname="XLXN_33" name="ACK_I" />
            <blockpin signalname="XLXN_31(31:0)" name="DAT_I(31:0)" />
            <blockpin signalname="XLXN_32" name="ACK_O" />
            <blockpin signalname="XLXN_34" name="CYC_O" />
            <blockpin signalname="XLXN_35" name="STB_O" />
            <blockpin signalname="XLXN_36" name="WE_O" />
            <blockpin signalname="XLXN_37(31:0)" name="DAT_O(31:0)" />
        </block>
        <block symbolname="Ch_EstEqu" name="Ch_EstEqu_ins">
            <blockpin signalname="CLK_I" name="CLK_I" />
            <blockpin signalname="RST_I" name="RST_I" />
            <blockpin signalname="XLXN_38" name="WE_I" />
            <blockpin signalname="XLXN_39" name="STB_I" />
            <blockpin signalname="XLXN_40" name="CYC_I" />
            <blockpin signalname="XLXN_43" name="ACK_I" />
            <blockpin signalname="XLXN_41(31:0)" name="DAT_I(31:0)" />
            <blockpin signalname="XLXN_42" name="ACK_O" />
            <blockpin signalname="XLXN_44" name="CYC_O" />
            <blockpin signalname="XLXN_45" name="STB_O" />
            <blockpin signalname="XLXN_46" name="WE_O" />
            <blockpin signalname="XLXN_47(31:0)" name="DAT_O(31:0)" />
        </block>
        <block symbolname="DataSymDem" name="DataSymDem_ins">
            <blockpin signalname="CLK_I" name="CLK_I" />
            <blockpin signalname="RST_I" name="RST_I" />
            <blockpin signalname="XLXN_48" name="WE_I" />
            <blockpin signalname="XLXN_49" name="STB_I" />
            <blockpin signalname="XLXN_50" name="CYC_I" />
            <blockpin signalname="ACK_I" name="ACK_I" />
            <blockpin signalname="XLXN_51(31:0)" name="DAT_I(31:0)" />
            <blockpin signalname="XLXN_52" name="ACK_O" />
            <blockpin signalname="CYC_O" name="CYC_O" />
            <blockpin signalname="STB_O" name="STB_O" />
            <blockpin signalname="WE_O" name="WE_O" />
            <blockpin signalname="DAT_O(7:0)" name="DAT_O(7:0)" />
        </block>
        <block symbolname="Ch_Sim1" name="Ch_Sim_ins">
            <blockpin signalname="XLXN_677" name="WE_I" />
            <blockpin signalname="XLXN_676" name="STB_I" />
            <blockpin signalname="XLXN_679(31:0)" name="DAT_I(31:0)" />
            <blockpin signalname="XLXN_675" name="CYC_I" />
            <blockpin signalname="XLXN_678" name="ACK_O" />
            <blockpin signalname="XLXN_97(31:0)" name="DAT_O(31:0)" />
            <blockpin signalname="XLXN_79" name="ACK_I" />
            <blockpin signalname="CLK_I" name="CLK_I" />
            <blockpin signalname="RST_I" name="RST_I" />
            <blockpin signalname="XLXN_683" name="STB_O" />
            <blockpin signalname="XLXN_98" name="WE_O" />
            <blockpin signalname="XLXN_684" name="CYC_O" />
        </block>
        <block symbolname="Tx_Out" name="Tx_Out_ins">
            <blockpin signalname="XLXN_11(31:0)" name="DAT_I(31:0)" />
            <blockpin signalname="XLXN_12" name="WE_I" />
            <blockpin signalname="XLXN_13" name="STB_I" />
            <blockpin signalname="XLXN_14" name="CYC_I" />
            <blockpin signalname="CLK_I" name="CLK_I" />
            <blockpin signalname="RST_I" name="RST_I" />
            <blockpin signalname="XLXN_675" name="CYC_O" />
            <blockpin signalname="XLXN_676" name="STB_O" />
            <blockpin signalname="XLXN_677" name="WE_O" />
            <blockpin signalname="XLXN_678" name="ACK_I" />
            <blockpin signalname="XLXN_15" name="ACK_O" />
            <blockpin signalname="XLXN_679(31:0)" name="DAT_O(31:0)" />
        </block>
    </netlist>
    <sheet sheetnum="1" width="5440" height="3520">
        <instance x="656" y="928" name="QPSK_Mod_ins" orien="R0">
        </instance>
        <instance x="1184" y="928" name="Pilots_Insert_ins" orien="R0">
        </instance>
        <branch name="XLXN_1(31:0)">
            <wire x2="1184" y1="512" y2="512" x1="1072" />
        </branch>
        <branch name="XLXN_2">
            <wire x2="1184" y1="576" y2="576" x1="1072" />
        </branch>
        <branch name="XLXN_3">
            <wire x2="1184" y1="640" y2="640" x1="1072" />
        </branch>
        <branch name="XLXN_4">
            <wire x2="1184" y1="704" y2="704" x1="1072" />
        </branch>
        <branch name="XLXN_5">
            <wire x2="1184" y1="768" y2="768" x1="1072" />
        </branch>
        <branch name="XLXN_6(31:0)">
            <wire x2="1744" y1="512" y2="512" x1="1600" />
        </branch>
        <branch name="XLXN_7">
            <wire x2="1744" y1="576" y2="576" x1="1600" />
        </branch>
        <branch name="XLXN_8">
            <wire x2="1744" y1="640" y2="640" x1="1600" />
        </branch>
        <branch name="XLXN_9">
            <wire x2="1744" y1="704" y2="704" x1="1600" />
        </branch>
        <branch name="XLXN_10">
            <wire x2="1744" y1="768" y2="768" x1="1600" />
        </branch>
        <branch name="DAT_I(1:0)">
            <wire x2="656" y1="512" y2="512" x1="304" />
        </branch>
        <branch name="CYC_I">
            <wire x2="656" y1="576" y2="576" x1="304" />
        </branch>
        <branch name="WE_I">
            <wire x2="656" y1="640" y2="640" x1="304" />
        </branch>
        <branch name="STB_I">
            <wire x2="656" y1="704" y2="704" x1="304" />
        </branch>
        <branch name="CLK_I">
            <wire x2="416" y1="896" y2="896" x1="304" />
            <wire x2="592" y1="896" y2="896" x1="416" />
            <wire x2="656" y1="896" y2="896" x1="592" />
            <wire x2="592" y1="896" y2="1040" x1="592" />
            <wire x2="1120" y1="1040" y2="1040" x1="592" />
            <wire x2="1680" y1="1040" y2="1040" x1="1120" />
            <wire x2="2176" y1="1040" y2="1040" x1="1680" />
            <wire x2="2960" y1="1040" y2="1040" x1="2176" />
            <wire x2="416" y1="896" y2="2000" x1="416" />
            <wire x2="576" y1="2000" y2="2000" x1="416" />
            <wire x2="640" y1="2000" y2="2000" x1="576" />
            <wire x2="576" y1="2000" y2="2176" x1="576" />
            <wire x2="1088" y1="2176" y2="2176" x1="576" />
            <wire x2="1600" y1="2176" y2="2176" x1="1088" />
            <wire x2="2112" y1="2176" y2="2176" x1="1600" />
            <wire x2="2624" y1="2176" y2="2176" x1="2112" />
            <wire x2="3136" y1="2176" y2="2176" x1="2624" />
            <wire x2="3648" y1="2176" y2="2176" x1="3136" />
            <wire x2="4160" y1="2176" y2="2176" x1="3648" />
            <wire x2="1152" y1="2032" y2="2032" x1="1088" />
            <wire x2="1088" y1="2032" y2="2176" x1="1088" />
            <wire x2="1184" y1="896" y2="896" x1="1120" />
            <wire x2="1120" y1="896" y2="1040" x1="1120" />
            <wire x2="1664" y1="2000" y2="2000" x1="1600" />
            <wire x2="1600" y1="2000" y2="2176" x1="1600" />
            <wire x2="1744" y1="896" y2="896" x1="1680" />
            <wire x2="1680" y1="896" y2="1040" x1="1680" />
            <wire x2="2176" y1="2000" y2="2000" x1="2112" />
            <wire x2="2112" y1="2000" y2="2176" x1="2112" />
            <wire x2="2176" y1="896" y2="1040" x1="2176" />
            <wire x2="2240" y1="896" y2="896" x1="2176" />
            <wire x2="2688" y1="2000" y2="2000" x1="2624" />
            <wire x2="2624" y1="2000" y2="2176" x1="2624" />
            <wire x2="3024" y1="896" y2="896" x1="2960" />
            <wire x2="2960" y1="896" y2="1040" x1="2960" />
            <wire x2="3200" y1="2000" y2="2000" x1="3136" />
            <wire x2="3136" y1="2000" y2="2176" x1="3136" />
            <wire x2="3712" y1="2000" y2="2000" x1="3648" />
            <wire x2="3648" y1="2000" y2="2176" x1="3648" />
            <wire x2="4224" y1="2000" y2="2000" x1="4160" />
            <wire x2="4160" y1="2000" y2="2176" x1="4160" />
        </branch>
        <branch name="RST_I">
            <wire x2="448" y1="960" y2="960" x1="304" />
            <wire x2="624" y1="960" y2="960" x1="448" />
            <wire x2="624" y1="960" y2="1072" x1="624" />
            <wire x2="1152" y1="1072" y2="1072" x1="624" />
            <wire x2="1712" y1="1072" y2="1072" x1="1152" />
            <wire x2="2208" y1="1072" y2="1072" x1="1712" />
            <wire x2="2992" y1="1072" y2="1072" x1="2208" />
            <wire x2="656" y1="960" y2="960" x1="624" />
            <wire x2="448" y1="960" y2="2064" x1="448" />
            <wire x2="608" y1="2064" y2="2064" x1="448" />
            <wire x2="640" y1="2064" y2="2064" x1="608" />
            <wire x2="608" y1="2064" y2="2208" x1="608" />
            <wire x2="1120" y1="2208" y2="2208" x1="608" />
            <wire x2="1632" y1="2208" y2="2208" x1="1120" />
            <wire x2="2144" y1="2208" y2="2208" x1="1632" />
            <wire x2="2656" y1="2208" y2="2208" x1="2144" />
            <wire x2="3168" y1="2208" y2="2208" x1="2656" />
            <wire x2="3680" y1="2208" y2="2208" x1="3168" />
            <wire x2="4192" y1="2208" y2="2208" x1="3680" />
            <wire x2="1152" y1="2080" y2="2080" x1="1120" />
            <wire x2="1120" y1="2080" y2="2208" x1="1120" />
            <wire x2="1184" y1="960" y2="960" x1="1152" />
            <wire x2="1152" y1="960" y2="1072" x1="1152" />
            <wire x2="1632" y1="2064" y2="2208" x1="1632" />
            <wire x2="1664" y1="2064" y2="2064" x1="1632" />
            <wire x2="1744" y1="960" y2="960" x1="1712" />
            <wire x2="1712" y1="960" y2="1072" x1="1712" />
            <wire x2="2176" y1="2064" y2="2064" x1="2144" />
            <wire x2="2144" y1="2064" y2="2208" x1="2144" />
            <wire x2="2208" y1="960" y2="1072" x1="2208" />
            <wire x2="2240" y1="960" y2="960" x1="2208" />
            <wire x2="2688" y1="2064" y2="2064" x1="2656" />
            <wire x2="2656" y1="2064" y2="2208" x1="2656" />
            <wire x2="3024" y1="960" y2="960" x1="2992" />
            <wire x2="2992" y1="960" y2="1072" x1="2992" />
            <wire x2="3200" y1="2064" y2="2064" x1="3168" />
            <wire x2="3168" y1="2064" y2="2208" x1="3168" />
            <wire x2="3712" y1="2064" y2="2064" x1="3680" />
            <wire x2="3680" y1="2064" y2="2208" x1="3680" />
            <wire x2="4224" y1="2064" y2="2064" x1="4192" />
            <wire x2="4192" y1="2064" y2="2208" x1="4192" />
        </branch>
        <branch name="ACK_O">
            <wire x2="656" y1="768" y2="768" x1="304" />
        </branch>
        <branch name="XLXN_98">
            <wire x2="576" y1="1360" y2="1680" x1="576" />
            <wire x2="640" y1="1680" y2="1680" x1="576" />
            <wire x2="3968" y1="1360" y2="1360" x1="576" />
            <wire x2="3968" y1="576" y2="576" x1="3840" />
            <wire x2="3968" y1="576" y2="1360" x1="3968" />
        </branch>
        <branch name="XLXN_97(31:0)">
            <wire x2="608" y1="1424" y2="1616" x1="608" />
            <wire x2="640" y1="1616" y2="1616" x1="608" />
            <wire x2="4000" y1="1424" y2="1424" x1="608" />
            <wire x2="4000" y1="512" y2="512" x1="3840" />
            <wire x2="4000" y1="512" y2="1424" x1="4000" />
        </branch>
        <instance x="640" y="1904" name="Synch_ins" orien="R0">
        </instance>
        <instance x="1664" y="2032" name="RemoveCP_ins" orien="R0">
        </instance>
        <instance x="2688" y="2032" name="iCFO_EstComp_ins" orien="R0">
        </instance>
        <instance x="3712" y="2032" name="PhaseTrack_ins" orien="R0">
        </instance>
        <instance x="1152" y="2096" name="FreComp_ins" orien="R0">
        </instance>
        <instance x="2176" y="2032" name="FFT_ins" orien="R0">
        </instance>
        <instance x="3200" y="2032" name="Ch_EstEqu_ins" orien="R0">
        </instance>
        <instance x="4224" y="2032" name="DataSymDem_ins" orien="R0">
        </instance>
        <branch name="XLXN_16">
            <wire x2="1152" y1="1680" y2="1680" x1="1072" />
        </branch>
        <branch name="XLXN_17">
            <wire x2="1152" y1="1744" y2="1744" x1="1072" />
        </branch>
        <branch name="XLXN_18">
            <wire x2="1152" y1="1808" y2="1808" x1="1072" />
        </branch>
        <branch name="XLXN_19">
            <wire x2="1152" y1="1968" y2="1968" x1="1072" />
        </branch>
        <branch name="XLXN_20(31:0)">
            <wire x2="1152" y1="1616" y2="1616" x1="1072" />
        </branch>
        <branch name="XLXN_21(31:0)">
            <wire x2="1152" y1="1936" y2="1936" x1="1072" />
        </branch>
        <branch name="XLXN_22">
            <wire x2="1152" y1="1872" y2="1872" x1="1072" />
        </branch>
        <branch name="XLXN_23">
            <wire x2="1664" y1="1872" y2="1872" x1="1584" />
        </branch>
        <branch name="XLXN_24">
            <wire x2="1664" y1="1808" y2="1808" x1="1584" />
        </branch>
        <branch name="XLXN_25">
            <wire x2="1664" y1="1744" y2="1744" x1="1584" />
        </branch>
        <branch name="XLXN_26">
            <wire x2="1664" y1="1680" y2="1680" x1="1584" />
        </branch>
        <branch name="XLXN_27(31:0)">
            <wire x2="1664" y1="1616" y2="1616" x1="1584" />
        </branch>
        <branch name="XLXN_28">
            <wire x2="2176" y1="1680" y2="1680" x1="2096" />
        </branch>
        <branch name="XLXN_29">
            <wire x2="2176" y1="1744" y2="1744" x1="2096" />
        </branch>
        <branch name="XLXN_30">
            <wire x2="2176" y1="1808" y2="1808" x1="2096" />
        </branch>
        <branch name="XLXN_31(31:0)">
            <wire x2="2176" y1="1616" y2="1616" x1="2096" />
        </branch>
        <branch name="XLXN_32">
            <wire x2="2176" y1="1872" y2="1872" x1="2096" />
        </branch>
        <branch name="XLXN_33">
            <wire x2="2688" y1="1872" y2="1872" x1="2608" />
        </branch>
        <branch name="XLXN_34">
            <wire x2="2688" y1="1808" y2="1808" x1="2608" />
        </branch>
        <branch name="XLXN_35">
            <wire x2="2688" y1="1744" y2="1744" x1="2608" />
        </branch>
        <branch name="XLXN_36">
            <wire x2="2688" y1="1680" y2="1680" x1="2608" />
        </branch>
        <branch name="XLXN_37(31:0)">
            <wire x2="2688" y1="1616" y2="1616" x1="2608" />
        </branch>
        <branch name="XLXN_38">
            <wire x2="3200" y1="1680" y2="1680" x1="3120" />
        </branch>
        <branch name="XLXN_39">
            <wire x2="3200" y1="1744" y2="1744" x1="3120" />
        </branch>
        <branch name="XLXN_40">
            <wire x2="3200" y1="1808" y2="1808" x1="3120" />
        </branch>
        <branch name="XLXN_41(31:0)">
            <wire x2="3200" y1="1616" y2="1616" x1="3120" />
        </branch>
        <branch name="XLXN_42">
            <wire x2="3200" y1="1872" y2="1872" x1="3120" />
        </branch>
        <branch name="XLXN_43">
            <wire x2="3712" y1="1872" y2="1872" x1="3632" />
        </branch>
        <branch name="XLXN_44">
            <wire x2="3712" y1="1808" y2="1808" x1="3632" />
        </branch>
        <branch name="XLXN_45">
            <wire x2="3712" y1="1744" y2="1744" x1="3632" />
        </branch>
        <branch name="XLXN_46">
            <wire x2="3712" y1="1680" y2="1680" x1="3632" />
        </branch>
        <branch name="XLXN_47(31:0)">
            <wire x2="3712" y1="1616" y2="1616" x1="3632" />
        </branch>
        <branch name="XLXN_48">
            <wire x2="4224" y1="1680" y2="1680" x1="4144" />
        </branch>
        <branch name="XLXN_49">
            <wire x2="4224" y1="1744" y2="1744" x1="4144" />
        </branch>
        <branch name="XLXN_50">
            <wire x2="4224" y1="1808" y2="1808" x1="4144" />
        </branch>
        <branch name="XLXN_51(31:0)">
            <wire x2="4224" y1="1616" y2="1616" x1="4144" />
        </branch>
        <branch name="XLXN_52">
            <wire x2="4224" y1="1872" y2="1872" x1="4144" />
        </branch>
        <branch name="DAT_O(7:0)">
            <wire x2="4880" y1="1616" y2="1616" x1="4656" />
        </branch>
        <branch name="WE_O">
            <wire x2="4880" y1="1680" y2="1680" x1="4656" />
        </branch>
        <branch name="STB_O">
            <wire x2="4880" y1="1744" y2="1744" x1="4656" />
        </branch>
        <branch name="CYC_O">
            <wire x2="4880" y1="1808" y2="1808" x1="4656" />
        </branch>
        <branch name="ACK_I">
            <wire x2="4880" y1="1872" y2="1872" x1="4656" />
        </branch>
        <iomarker fontsize="28" x="4880" y="1616" name="DAT_O(7:0)" orien="R0" />
        <iomarker fontsize="28" x="4880" y="1680" name="WE_O" orien="R0" />
        <iomarker fontsize="28" x="4880" y="1744" name="STB_O" orien="R0" />
        <iomarker fontsize="28" x="4880" y="1808" name="CYC_O" orien="R0" />
        <iomarker fontsize="28" x="4880" y="1872" name="ACK_I" orien="R0" />
        <branch name="XLXN_79">
            <wire x2="3872" y1="1168" y2="1168" x1="480" />
            <wire x2="480" y1="1168" y2="1872" x1="480" />
            <wire x2="640" y1="1872" y2="1872" x1="480" />
            <wire x2="3872" y1="768" y2="768" x1="3840" />
            <wire x2="3872" y1="768" y2="1168" x1="3872" />
        </branch>
        <instance x="1744" y="912" name="IFFT_Mod_ins" orien="R0">
        </instance>
        <iomarker fontsize="28" x="304" y="512" name="DAT_I(1:0)" orien="R180" />
        <iomarker fontsize="28" x="304" y="576" name="CYC_I" orien="R180" />
        <iomarker fontsize="28" x="304" y="960" name="RST_I" orien="R180" />
        <iomarker fontsize="28" x="304" y="640" name="WE_I" orien="R180" />
        <iomarker fontsize="28" x="304" y="704" name="STB_I" orien="R180" />
        <iomarker fontsize="28" x="304" y="896" name="CLK_I" orien="R180" />
        <iomarker fontsize="28" x="304" y="768" name="ACK_O" orien="R180" />
        <branch name="XLXN_11(31:0)">
            <wire x2="2240" y1="512" y2="512" x1="2160" />
        </branch>
        <branch name="XLXN_14">
            <wire x2="2240" y1="576" y2="576" x1="2160" />
        </branch>
        <branch name="XLXN_12">
            <wire x2="2240" y1="640" y2="640" x1="2160" />
        </branch>
        <branch name="XLXN_13">
            <wire x2="2240" y1="704" y2="704" x1="2160" />
        </branch>
        <branch name="XLXN_15">
            <wire x2="2240" y1="768" y2="768" x1="2160" />
        </branch>
        <instance x="3024" y="928" name="Ch_Sim_ins" orien="R0">
        </instance>
        <branch name="XLXN_675">
            <wire x2="3024" y1="576" y2="576" x1="2656" />
        </branch>
        <branch name="XLXN_676">
            <wire x2="3024" y1="704" y2="704" x1="2656" />
        </branch>
        <branch name="XLXN_677">
            <wire x2="3024" y1="640" y2="640" x1="2656" />
        </branch>
        <branch name="XLXN_678">
            <wire x2="3024" y1="768" y2="768" x1="2656" />
        </branch>
        <branch name="XLXN_679(31:0)">
            <wire x2="3024" y1="512" y2="512" x1="2656" />
        </branch>
        <instance x="2240" y="928" name="Tx_Out_ins" orien="R0">
        </instance>
        <iomarker fontsize="28" x="304" y="1936" name="SNR_I(3:0)" orien="R180" />
        <branch name="SNR_I(3:0)">
            <wire x2="640" y1="1936" y2="1936" x1="304" />
        </branch>
        <branch name="XLXN_683">
            <wire x2="544" y1="1296" y2="1744" x1="544" />
            <wire x2="640" y1="1744" y2="1744" x1="544" />
            <wire x2="3936" y1="1296" y2="1296" x1="544" />
            <wire x2="3936" y1="640" y2="640" x1="3840" />
            <wire x2="3936" y1="640" y2="1296" x1="3936" />
        </branch>
        <branch name="XLXN_684">
            <wire x2="3904" y1="1232" y2="1232" x1="512" />
            <wire x2="512" y1="1232" y2="1808" x1="512" />
            <wire x2="640" y1="1808" y2="1808" x1="512" />
            <wire x2="3904" y1="704" y2="704" x1="3840" />
            <wire x2="3904" y1="704" y2="1232" x1="3904" />
        </branch>
    </sheet>
</drawing>