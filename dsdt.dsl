/*
 * Intel ACPI Component Architecture
 * AML Disassembler version 20091214
 *
 * Disassembly of ./dsdt.aml, Wed Jan 13 01:51:43 2010
 *
 *
 * Original Table Header:
 *     Signature        "DSDT"
 *     Length           0x00007AD7 (31447)
 *     Revision         0x01 **** ACPI 1.0, no 64-bit math support
 *     Checksum         0xFF
 *     OEM ID           "A1192"
 *     OEM Table ID     "A1192000"
 *     OEM Revision     0x00000000 (0)
 *     Compiler ID      "INTL"
 *     Compiler Version 0x20091214 (537465364)
 */
DefinitionBlock ("./dsdt.aml", "DSDT", 1, "A1192", "A1192000", 0x00000000)
{
    External (\_PR_.CPU2)
    External (\_PR_.CPU1)

    Scope (_PR)
    {
        Processor (P001, 0x01, 0x00000000, 0x06) {}
    }

    Scope (_PR)
    {
        Processor (P002, 0x02, 0x00000000, 0x06) {}
    }

    Name (DP80, 0x80)
    Name (DP90, 0x90)
    Name (AMWV, 0x08)
    Name (APIC, One)
    Name (PMBS, 0x0800)
    Name (PMLN, 0x80)
    Name (GPBS, 0x0480)
    Name (GPLN, 0x40)
    Name (SMBL, Zero)
    Name (PM28, 0x0828)
    Name (PM30, 0x0830)
    Name (SUSW, 0xFF)
    Name (PCIB, 0xE0000000)
    Name (PCIL, 0x04000000)
    Name (SMBS, 0x0400)
    OperationRegion (BIOS, SystemMemory, 0x7F7AE064, 0xFF)
    Field (BIOS, ByteAcc, NoLock, Preserve)
    {
        SS1,    1, 
        SS2,    1, 
        SS3,    1, 
        SS4,    1, 
                Offset (0x01), 
        IOST,   16, 
        TOPM,   32, 
        ROMS,   32, 
        MG1B,   32, 
        MG1L,   32, 
        MG2B,   32, 
        MG2L,   32, 
                Offset (0x1C), 
        DMAX,   8, 
        HPTA,   32, 
        CPB0,   32, 
        CPB1,   32, 
        CPB2,   32, 
        CPB3,   32, 
        ASSB,   8, 
        AOTB,   8, 
        AAXB,   32, 
        SMIF,   8, 
        DTSE,   8, 
        DTS1,   8, 
        DTS2,   8, 
        MPEN,   8, 
        TPMF,   8
    }

    Method (RRIO, 4, NotSerialized)
    {
        Store ("RRIO", Debug)
    }

    Method (RDMA, 3, NotSerialized)
    {
        Store ("rDMA", Debug)
    }

    Name (PICM, Zero)
    Method (_PIC, 1, NotSerialized)
    {
        If (Arg0)
        {
            Store (0xAA, DBG8)
        }
        Else
        {
            Store (0xAC, DBG8)
        }

        Store (Arg0, PICM)
    }

    Name (OSVR, Ones)
    Method (OSFL, 0, NotSerialized)
    {
        If (LNotEqual (OSVR, Ones))
        {
            Return (OSVR)
        }

        If (LEqual (PICM, Zero))
        {
            Store (0xAC, DBG8)
        }

        Store (One, OSVR)
        If (CondRefOf (_OSI, Local1))
        {
            If (_OSI ("Windows 2000"))
            {
                Store (0x04, OSVR)
            }

            If (_OSI ("Windows 2001"))
            {
                Store (Zero, OSVR)
            }

            If (_OSI ("Windows 2001 SP1"))
            {
                Store (Zero, OSVR)
            }

            If (_OSI ("Windows 2001 SP2"))
            {
                Store (Zero, OSVR)
            }

            If (_OSI ("Windows 2001.1"))
            {
                Store (Zero, OSVR)
            }

            If (_OSI ("Windows 2001.1 SP1"))
            {
                Store (Zero, OSVR)
            }

            If (_OSI ("Windows 2006"))
            {
                Store (Zero, OSVR)
            }
        }
        Else
        {
            If (MCTH (_OS, "Microsoft Windows NT"))
            {
                Store (0x04, OSVR)
            }
            Else
            {
                If (MCTH (_OS, "Microsoft WindowsME: Millennium Edition"))
                {
                    Store (0x02, OSVR)
                }

                If (MCTH (_OS, "Linux"))
                {
                    Store (0x03, OSVR)
                }
            }
        }

        Return (OSVR)
    }

    Method (MCTH, 2, NotSerialized)
    {
        If (LLess (SizeOf (Arg0), SizeOf (Arg1)))
        {
            Return (Zero)
        }

        Add (SizeOf (Arg0), One, Local0)
        Name (BUF0, Buffer (Local0) {})
        Name (BUF1, Buffer (Local0) {})
        Store (Arg0, BUF0)
        Store (Arg1, BUF1)
        While (Local0)
        {
            Decrement (Local0)
            If (LNotEqual (DerefOf (Index (BUF0, Local0)), DerefOf (Index (
                BUF1, Local0))))
            {
                Return (Zero)
            }
        }

        Return (One)
    }

    Name (PRWP, Package (0x02)
    {
        Zero, 
        Zero
    })
    Method (GPRW, 2, NotSerialized)
    {
        Store (Arg0, Index (PRWP, Zero))
        Store (ShiftLeft (SS1, One), Local0)
        Or (Local0, ShiftLeft (SS2, 0x02), Local0)
        Or (Local0, ShiftLeft (SS3, 0x03), Local0)
        Or (Local0, ShiftLeft (SS4, 0x04), Local0)
        If (And (ShiftLeft (One, Arg1), Local0))
        {
            Store (Arg1, Index (PRWP, One))
        }
        Else
        {
            ShiftRight (Local0, One, Local0)
            If (LOr (LEqual (OSFL (), One), LEqual (OSFL (), 0x02)))
            {
                FindSetLeftBit (Local0, Index (PRWP, One))
            }
            Else
            {
                FindSetRightBit (Local0, Index (PRWP, One))
            }
        }

        Return (PRWP)
    }

    Name (WAKP, Package (0x02)
    {
        Zero, 
        Zero
    })
    OperationRegion (DEB0, SystemIO, DP80, One)
    Field (DEB0, ByteAcc, NoLock, Preserve)
    {
        DBG8,   8
    }

    OperationRegion (DEB1, SystemIO, DP90, 0x02)
    Field (DEB1, WordAcc, NoLock, Preserve)
    {
        DBG9,   16
    }

    Scope (_SB)
    {
        Name (PR00, Package (0x12)
        {
            Package (0x04)
            {
                0x0001FFFF, 
                Zero, 
                LNKA, 
                Zero
            }, 

            Package (0x04)
            {
                0x0001FFFF, 
                One, 
                LNKB, 
                Zero
            }, 

            Package (0x04)
            {
                0x0001FFFF, 
                0x02, 
                LNKC, 
                Zero
            }, 

            Package (0x04)
            {
                0x0001FFFF, 
                0x03, 
                LNKD, 
                Zero
            }, 

            Package (0x04)
            {
                0x001FFFFF, 
                Zero, 
                LNKC, 
                Zero
            }, 

            Package (0x04)
            {
                0x001FFFFF, 
                One, 
                LNKD, 
                Zero
            }, 

            Package (0x04)
            {
                0x001EFFFF, 
                Zero, 
                LNKB, 
                Zero
            }, 

            Package (0x04)
            {
                0x001BFFFF, 
                Zero, 
                LNKA, 
                Zero
            }, 

            Package (0x04)
            {
                0x001CFFFF, 
                Zero, 
                LNKA, 
                Zero
            }, 

            Package (0x04)
            {
                0x001CFFFF, 
                One, 
                LNKB, 
                Zero
            }, 

            Package (0x04)
            {
                0x001CFFFF, 
                0x02, 
                LNKC, 
                Zero
            }, 

            Package (0x04)
            {
                0x001CFFFF, 
                0x03, 
                LNKD, 
                Zero
            }, 

            Package (0x04)
            {
                0x001EFFFF, 
                One, 
                LNKE, 
                Zero
            }, 

            Package (0x04)
            {
                0x001DFFFF, 
                Zero, 
                LNKH, 
                Zero
            }, 

            Package (0x04)
            {
                0x001DFFFF, 
                One, 
                LNKD, 
                Zero
            }, 

            Package (0x04)
            {
                0x001DFFFF, 
                0x02, 
                LNKC, 
                Zero
            }, 

            Package (0x04)
            {
                0x001DFFFF, 
                0x03, 
                LNKA, 
                Zero
            }, 

            Package (0x04)
            {
                0x0002FFFF, 
                Zero, 
                LNKA, 
                Zero
            }
        })
        Name (AR00, Package (0x12)
        {
            Package (0x04)
            {
                0x0001FFFF, 
                Zero, 
                Zero, 
                0x10
            }, 

            Package (0x04)
            {
                0x0001FFFF, 
                One, 
                Zero, 
                0x11
            }, 

            Package (0x04)
            {
                0x0001FFFF, 
                0x02, 
                Zero, 
                0x12
            }, 

            Package (0x04)
            {
                0x0001FFFF, 
                0x03, 
                Zero, 
                0x13
            }, 

            Package (0x04)
            {
                0x001FFFFF, 
                Zero, 
                Zero, 
                0x12
            }, 

            Package (0x04)
            {
                0x001FFFFF, 
                One, 
                Zero, 
                0x13
            }, 

            Package (0x04)
            {
                0x001EFFFF, 
                Zero, 
                Zero, 
                0x11
            }, 

            Package (0x04)
            {
                0x001BFFFF, 
                Zero, 
                Zero, 
                0x10
            }, 

            Package (0x04)
            {
                0x001CFFFF, 
                Zero, 
                Zero, 
                0x10
            }, 

            Package (0x04)
            {
                0x001CFFFF, 
                One, 
                Zero, 
                0x11
            }, 

            Package (0x04)
            {
                0x001CFFFF, 
                0x02, 
                Zero, 
                0x12
            }, 

            Package (0x04)
            {
                0x001CFFFF, 
                0x03, 
                Zero, 
                0x13
            }, 

            Package (0x04)
            {
                0x001EFFFF, 
                One, 
                Zero, 
                0x14
            }, 

            Package (0x04)
            {
                0x001DFFFF, 
                Zero, 
                Zero, 
                0x17
            }, 

            Package (0x04)
            {
                0x001DFFFF, 
                One, 
                Zero, 
                0x13
            }, 

            Package (0x04)
            {
                0x001DFFFF, 
                0x02, 
                Zero, 
                0x12
            }, 

            Package (0x04)
            {
                0x001DFFFF, 
                0x03, 
                Zero, 
                0x10
            }, 

            Package (0x04)
            {
                0x0002FFFF, 
                Zero, 
                Zero, 
                0x10
            }
        })
        Name (PR05, Package (0x01)
        {
            Package (0x04)
            {
                0xFFFF, 
                Zero, 
                LNKB, 
                Zero
            }
        })
        Name (AR05, Package (0x01)
        {
            Package (0x04)
            {
                0xFFFF, 
                Zero, 
                Zero, 
                0x11
            }
        })
        Name (PR06, Package (0x01)
        {
            Package (0x04)
            {
                0xFFFF, 
                Zero, 
                LNKC, 
                Zero
            }
        })
        Name (AR06, Package (0x01)
        {
            Package (0x04)
            {
                0xFFFF, 
                Zero, 
                Zero, 
                0x12
            }
        })
        Name (PR07, Package (0x01)
        {
            Package (0x04)
            {
                0xFFFF, 
                Zero, 
                LNKD, 
                Zero
            }
        })
        Name (AR07, Package (0x01)
        {
            Package (0x04)
            {
                0xFFFF, 
                Zero, 
                Zero, 
                0x13
            }
        })
        Name (PRSA, ResourceTemplate ()
        {
            IRQ (Level, ActiveLow, Shared, )
                {3,4,5,6,7,10,11,12,14,15}
        })
        Alias (PRSA, PRSB)
        Alias (PRSA, PRSC)
        Alias (PRSA, PRSD)
        Alias (PRSA, PRSE)
        Alias (PRSA, PRSF)
        Alias (PRSA, PRSG)
        Alias (PRSA, PRSH)
        Device (PCI0)
        {
            Name (_HID, EisaId ("PNP0A08"))
            Name (_ADR, Zero)
            Method (^BN00, 0, NotSerialized)
            {
                Return (Zero)
            }

            Method (_BBN, 0, NotSerialized)
            {
                Return (BN00 ())
            }

            Name (_UID, Zero)
            Method (_PRT, 0, NotSerialized)
            {
                If (PICM)
                {
                    Return (AR00)
                }

                Return (PR00)
            }

            Method (_S3D, 0, NotSerialized)
            {
                If (LOr (LEqual (OSFL (), One), LEqual (OSFL (), 0x02)))
                {
                    Return (0x02)
                }
                Else
                {
                    Return (0x03)
                }
            }

            Name (_CID, EisaId ("PNP0A03"))
            Device (MCH)
            {
                Name (_HID, EisaId ("PNP0C01"))
                Name (_UID, 0x0A)
                Name (_CRS, ResourceTemplate ()
                {
                    Memory32Fixed (ReadWrite,
                        0xFED13000,         // Address Base
                        0x00007000,         // Address Length
                        )
                })
            }

            Method (NPTS, 1, NotSerialized)
            {
            }

            Method (NWAK, 1, NotSerialized)
            {
            }

            Device (P0P2)
            {
                Name (_ADR, 0x00010000)
                Method (_PRW, 0, NotSerialized)
                {
                    Return (GPRW (0x09, 0x04))
                }
            }

            Device (P0P1)
            {
                Name (_ADR, 0x001E0000)
                Method (_PRW, 0, NotSerialized)
                {
                    Return (GPRW (0x0B, 0x04))
                }
            }

            Device (SBRG)
            {
                Name (_ADR, 0x001F0000)
                Method (SPTS, 1, NotSerialized)
                {
                    Store (One, PS1S)
                    Store (One, PS1E)
                }

                Method (SWAK, 1, NotSerialized)
                {
                    Store (Zero, PS1E)
                    If (LNot (GNVS (0x15C5)))
                    {
                        Notify (PWRB, 0x02)
                    }
                }

                OperationRegion (PMS0, SystemIO, PMBS, PMLN)
                Field (PMS0, ByteAcc, NoLock, Preserve)
                {
                        ,   10, 
                    RTCS,   1, 
                        ,   4, 
                    WAKS,   1, 
                            Offset (0x03), 
                    PWBT,   1, 
                            Offset (0x04)
                }

                OperationRegion (SMIE, SystemIO, PM30, 0x08)
                Field (SMIE, ByteAcc, NoLock, Preserve)
                {
                        ,   4, 
                    PS1E,   1, 
                        ,   31, 
                    PS1S,   1, 
                            Offset (0x08)
                }

                OperationRegion (GPBX, SystemIO, GPBS, GPLN)
                Field (GPBX, ByteAcc, NoLock, Preserve)
                {
                    GPUS,   32, 
                    GPSL,   32, 
                            Offset (0x0C), 
                    GPLV,   32, 
                            Offset (0x18), 
                    GPBL,   32, 
                            Offset (0x2C), 
                    GPIV,   32
                }

                Device (PIC)
                {
                    Name (_HID, EisaId ("PNP0000"))
                    Name (_CRS, ResourceTemplate ()
                    {
                        IO (Decode16,
                            0x0020,             // Range Minimum
                            0x0020,             // Range Maximum
                            0x00,               // Alignment
                            0x02,               // Length
                            )
                        IO (Decode16,
                            0x00A0,             // Range Minimum
                            0x00A0,             // Range Maximum
                            0x00,               // Alignment
                            0x02,               // Length
                            )
                        IRQNoFlags ()
                            {2}
                    })
                }

                Device (DMAD)
                {
                    Name (_HID, EisaId ("PNP0200"))
                    Name (_CRS, ResourceTemplate ()
                    {
                        DMA (Compatibility, BusMaster, Transfer8, )
                            {4}
                        IO (Decode16,
                            0x0000,             // Range Minimum
                            0x0000,             // Range Maximum
                            0x00,               // Alignment
                            0x10,               // Length
                            )
                        IO (Decode16,
                            0x0081,             // Range Minimum
                            0x0081,             // Range Maximum
                            0x00,               // Alignment
                            0x03,               // Length
                            )
                        IO (Decode16,
                            0x0087,             // Range Minimum
                            0x0087,             // Range Maximum
                            0x00,               // Alignment
                            0x01,               // Length
                            )
                        IO (Decode16,
                            0x0089,             // Range Minimum
                            0x0089,             // Range Maximum
                            0x00,               // Alignment
                            0x03,               // Length
                            )
                        IO (Decode16,
                            0x008F,             // Range Minimum
                            0x008F,             // Range Maximum
                            0x00,               // Alignment
                            0x01,               // Length
                            )
                        IO (Decode16,
                            0x00C0,             // Range Minimum
                            0x00C0,             // Range Maximum
                            0x00,               // Alignment
                            0x20,               // Length
                            )
                    })
                }

                Device (TMR)
                {
                    Name (_HID, EisaId ("PNP0100"))
                    Name (_CRS, ResourceTemplate ()
                    {
                        IO (Decode16,
                            0x0040,             // Range Minimum
                            0x0040,             // Range Maximum
                            0x00,               // Alignment
                            0x04,               // Length
                            )
                        IRQNoFlags ()
                            {0}
                    })
                }

                Device (RTC0)
                {
                    Name (_HID, EisaId ("PNP0B00"))
                    Name (_CRS, ResourceTemplate ()
                    {
                        IO (Decode16,
                            0x0070,             // Range Minimum
                            0x0070,             // Range Maximum
                            0x00,               // Alignment
                            0x02,               // Length
                            )
                    })
                }

                Device (PS2K)
                {
                    Name (_HID, EisaId ("PNP0303"))
                    Name (_CID, EisaId ("PNP030B"))
                    Method (_STA, 0, NotSerialized)
                    {
                        ShiftLeft (One, 0x0A, Local0)
                        If (And (IOST, Local0))
                        {
                            Return (0x0F)
                        }

                        Return (Zero)
                    }

                    Name (_CRS, ResourceTemplate ()
                    {
                        IO (Decode16,
                            0x0060,             // Range Minimum
                            0x0060,             // Range Maximum
                            0x00,               // Alignment
                            0x01,               // Length
                            )
                        IO (Decode16,
                            0x0064,             // Range Minimum
                            0x0064,             // Range Maximum
                            0x00,               // Alignment
                            0x01,               // Length
                            )
                        IRQNoFlags ()
                            {1}
                    })
                }

                Device (PS2M)
                {
                    Name (_HID, EisaId ("SYN0A04"))
                    Name (_CID, Package (0x03)
                    {
                        EisaId ("SYN0A00"), 
                        EisaId ("SYN0002"), 
                        EisaId ("PNP0F13")
                    })
                    Method (_STA, 0, NotSerialized)
                    {
                        ShiftLeft (One, 0x0C, Local0)
                        If (And (IOST, Local0))
                        {
                            Return (0x0F)
                        }

                        Return (Zero)
                    }

                    Name (_CRS, ResourceTemplate ()
                    {
                        IRQNoFlags ()
                            {12}
                    })
                }

                Device (SPKR)
                {
                    Name (_HID, EisaId ("PNP0800"))
                    Name (_CRS, ResourceTemplate ()
                    {
                        IO (Decode16,
                            0x0061,             // Range Minimum
                            0x0061,             // Range Maximum
                            0x00,               // Alignment
                            0x01,               // Length
                            )
                    })
                }

                Device (COPR)
                {
                    Name (_HID, EisaId ("PNP0C04"))
                    Name (_CRS, ResourceTemplate ()
                    {
                        IO (Decode16,
                            0x00F0,             // Range Minimum
                            0x00F0,             // Range Maximum
                            0x00,               // Alignment
                            0x10,               // Length
                            )
                        IRQNoFlags ()
                            {13}
                    })
                }

                Device (EC0)
                {
                    Name (_HID, EisaId ("PNP0C09"))
                    Name (_CRS, ResourceTemplate ()
                    {
                        IO (Decode16,
                            0x0062,             // Range Minimum
                            0x0062,             // Range Maximum
                            0x00,               // Alignment
                            0x01,               // Length
                            )
                        IO (Decode16,
                            0x0066,             // Range Minimum
                            0x0066,             // Range Maximum
                            0x00,               // Alignment
                            0x01,               // Length
                            )
                    })
                    Name (_GPE, 0x1C)
                    Name (REGC, Zero)
                    Method (_REG, 2, NotSerialized)
                    {
                        If (LEqual (Arg0, 0x03))
                        {
                            Store (Arg1, REGC)
                        }
                    }

                    Method (ECAV, 0, NotSerialized)
                    {
                        If (LEqual (REGC, Ones))
                        {
                            If (LGreaterEqual (_REV, 0x02))
                            {
                                Return (One)
                            }
                            Else
                            {
                                Return (Zero)
                            }
                        }

                        Return (REGC)
                    }

                    OperationRegion (ECOR, EmbeddedControl, Zero, 0x0100)
                    Field (ECOR, ByteAcc, Lock, Preserve)
                    {
                                Offset (0x29), 
                        BT00,   8, 
                        BT01,   8, 
                        BT02,   8, 
                        BT03,   8, 
                        BT04,   8, 
                        BT05,   8, 
                        BT06,   8, 
                        BT07,   8, 
                        BT08,   8, 
                        BT09,   8, 
                        BT10,   8, 
                        BT11,   8, 
                        BT12,   8, 
                        BT13,   8, 
                        BT14,   8, 
                        BT15,   8, 
                        BT16,   8, 
                        BT17,   8, 
                        BT18,   8, 
                        BT19,   8, 
                        BT20,   8, 
                        BT21,   8, 
                        BT22,   8, 
                        BT23,   8, 
                        BT24,   8, 
                        BT25,   8, 
                        BT26,   8
                    }

                    Field (ECOR, ByteAcc, Lock, Preserve)
                    {
                                Offset (0x3F), 
                        BTS0,   1, 
                        BTS1,   1, 
                        BTS2,   1, 
                        BTS3,   1, 
                        BTS4,   1, 
                        BTS5,   1, 
                        BTS6,   1, 
                        BTS7,   1
                    }

                    Field (ECOR, ByteAcc, Lock, Preserve)
                    {
                                Offset (0x51), 
                        ST00,   8, 
                        ST01,   8, 
                        ST02,   8, 
                        ST03,   8, 
                        ST04,   8, 
                        ST05,   8, 
                        ST06,   8, 
                        ST07,   8, 
                        ST08,   8, 
                        ST09,   8, 
                        ST10,   8
                    }

                    Field (ECOR, ByteAcc, Lock, Preserve)
                    {
                                Offset (0x61), 
                        SC00,   8, 
                        SC01,   8, 
                        SC02,   8, 
                        SC03,   8, 
                        SC04,   8, 
                        SC05,   8, 
                        SC06,   8
                    }

                    Field (ECOR, ByteAcc, Lock, Preserve)
                    {
                                Offset (0x71), 
                        TM00,   8, 
                        TM01,   8, 
                        TM02,   8, 
                        TM03,   8, 
                        TM04,   8, 
                        TM05,   8, 
                        TM06,   8, 
                        TM07,   8, 
                        TM08,   8
                    }

                    Field (ECOR, ByteAcc, Lock, Preserve)
                    {
                                Offset (0x81), 
                        SM00,   8, 
                        SM01,   8, 
                        SM02,   8, 
                        SM03,   8, 
                        SM04,   8, 
                        SM05,   8, 
                        SM06,   8, 
                        SM07,   8, 
                        SM08,   8, 
                        SM09,   8, 
                        SM10,   8, 
                        SM11,   8, 
                        SM12,   8, 
                        SM13,   8, 
                        SM14,   8
                    }

                    Field (ECOR, ByteAcc, Lock, Preserve)
                    {
                                Offset (0xD0), 
                        SFB0,   8, 
                        SFB1,   8, 
                        SFB2,   8, 
                        SFB3,   8, 
                                Offset (0xEE), 
                                Offset (0xEF), 
                        SFBE,   8
                    }

                    Field (ECOR, ByteAcc, Lock, Preserve)
                    {
                                Offset (0xD0), 
                        SF00,   1, 
                        SF01,   1, 
                        SF02,   1, 
                        SF03,   1, 
                        SF04,   1, 
                        SF05,   1, 
                        SF06,   1, 
                        SF07,   1, 
                        SF08,   1, 
                        SF09,   1, 
                        SF10,   1, 
                        SF11,   1, 
                        SF12,   1, 
                        SF13,   1, 
                        SF14,   1, 
                        SF15,   1, 
                        SF16,   1, 
                        SF17,   1, 
                        SF18,   1, 
                        SF19,   1, 
                        SF20,   1, 
                        SF21,   1, 
                        SF22,   1, 
                        SF23,   1, 
                        SF24,   1, 
                        SF25,   1, 
                        SF26,   1, 
                        SF27,   1, 
                        SF28,   1, 
                        SF29,   1, 
                        SF30,   1, 
                        SF31,   1, 
                                Offset (0xEE), 
                        S240,   1, 
                        S241,   1, 
                        S242,   1, 
                        S243,   1, 
                        S244,   1, 
                        S245,   1, 
                        S246,   1, 
                        S247,   1, 
                        S248,   1, 
                        S249,   1, 
                        S250,   1, 
                        S251,   1, 
                        S252,   1, 
                        S253,   1, 
                        S254,   1, 
                        S255,   1
                    }

                    Field (ECOR, ByteAcc, Lock, Preserve)
                    {
                                Offset (0xFF), 
                        BNKD,   8
                    }

                    Field (ECOR, ByteAcc, Lock, Preserve)
                    {
                                Offset (0x42), 
                        FT00,   8, 
                        FT01,   8, 
                        FT02,   8, 
                        FT03,   8, 
                        FT04,   8, 
                        FT05,   8, 
                        FT06,   8, 
                        FT07,   8, 
                        FT08,   8, 
                        FT09,   8, 
                        FT10,   8, 
                        FT11,   8, 
                        FT12,   8, 
                        FT13,   8, 
                        FT14,   8, 
                        FT15,   8, 
                        FT16,   8, 
                        FT17,   8, 
                        FT18,   8, 
                        FT19,   8, 
                        FT20,   8, 
                        FT21,   8, 
                        FT22,   8, 
                        FT23,   8, 
                        FT24,   8, 
                        FT25,   8, 
                        FT26,   8, 
                        FT27,   8, 
                        FT28,   8, 
                        FT29,   8
                    }

                    Method (EC0S, 1, NotSerialized)
                    {
                        If (LEqual (Arg0, 0x03))
                        {
                            If (ECAV ())
                            {
                                If (LNot (Acquire (MUEC, 0xFFFF)))
                                {
                                    Store (One, SF28)
                                    Release (MUEC)
                                }
                            }
                        }

                        If (Arg0)
                        {
                            If (LLess (Arg0, 0x04)) {}
                        }
                    }

                    Method (EC0W, 1, NotSerialized)
                    {
                        If (Arg0)
                        {
                            If (LLess (Arg0, 0x04)) {}
                            If (LEqual (Arg0, 0x03))
                            {
                                If (ECAV ())
                                {
                                    If (LNot (Acquire (MUEC, 0xFFFF)))
                                    {
                                        Store (One, SF17)
                                        Release (MUEC)
                                    }
                                }
                            }
                        }
                    }
                }

                Scope (EC0)
                {
                    Mutex (MUEC, 0x00)
                    OperationRegion (DLYP, SystemIO, 0xE1, One)
                    Field (DLYP, ByteAcc, NoLock, Preserve)
                    {
                        DELY,   8
                    }

                    OperationRegion (KBCP, SystemIO, Zero, 0xFF)
                    Field (KBCP, ByteAcc, Lock, Preserve)
                    {
                                Offset (0x60), 
                        KBCD,   8, 
                                Offset (0x62), 
                        EC62,   8, 
                                Offset (0x64), 
                        KBCC,   8, 
                                Offset (0x66), 
                        EC66,   8
                    }

                    Field (KBCP, ByteAcc, Lock, Preserve)
                    {
                                Offset (0x64), 
                        KBOF,   1, 
                        KBIE,   1, 
                                Offset (0x65), 
                                Offset (0x66), 
                        ECOF,   1, 
                        ECIE,   1, 
                                Offset (0x67)
                    }

                    Method (IBFR, 0, Serialized)
                    {
                        Store (0x1000, Local0)
                        While (LAnd (Decrement (Local0), KBIE))
                        {
                            Store (Zero, DELY)
                        }
                    }

                    Method (OBFL, 0, Serialized)
                    {
                        Store (0x1000, Local0)
                        While (LAnd (Decrement (Local0), LNot (KBOF)))
                        {
                            Store (Zero, DELY)
                        }
                    }

                    Method (IBFX, 0, Serialized)
                    {
                        Store (0x1000, Local0)
                        While (LAnd (Decrement (Local0), ECIE))
                        {
                            Store (Zero, DELY)
                        }
                    }

                    Method (OBFX, 0, Serialized)
                    {
                        Store (0x1000, Local0)
                        While (LAnd (Decrement (Local0), LNot (ECOF)))
                        {
                            Store (Zero, DELY)
                        }
                    }

                    Method (ECXW, 2, Serialized)
                    {
                        If (ECAV ())
                        {
                            If (LNot (Acquire (MUEC, 0xFFFF)))
                            {
                                IBFX ()
                                Store (Arg0, EC66)
                                IBFX ()
                                Store (Arg1, EC62)
                                IBFX ()
                                Release (MUEC)
                            }
                        }
                    }

                    Method (ECXR, 1, Serialized)
                    {
                        Store (Ones, Local0)
                        If (ECAV ())
                        {
                            If (LNot (Acquire (MUEC, 0xFFFF)))
                            {
                                IBFX ()
                                Store (Arg0, EC66)
                                OBFX ()
                                Store (EC62, Local0)
                                Release (MUEC)
                            }
                        }

                        Return (Local0)
                    }

                    Method (BWRN, 1, Serialized)
                    {
                        Store (Ones, Local2)
                        If (ECAV ())
                        {
                            If (LNot (Acquire (MUEC, 0xFFFF)))
                            {
                                And (Arg0, 0xFF, Local0)
                                ShiftRight (And (Arg0, 0xFF00), 0x08, Local1)
                                Store (Local1, BT12)
                                Store (Local0, BT13)
                                Release (MUEC)
                                Store (Zero, Local2)
                            }
                        }

                        Return (Local2)
                    }

                    Method (BLOW, 1, Serialized)
                    {
                        Store (Ones, Local2)
                        If (ECAV ())
                        {
                            If (LNot (Acquire (MUEC, 0xFFFF)))
                            {
                                And (Arg0, 0xFF, Local0)
                                ShiftRight (And (Arg0, 0xFF00), 0x08, Local1)
                                Store (Local1, BT14)
                                Store (Local0, BT15)
                                Release (MUEC)
                                Store (Zero, Local2)
                            }
                        }

                        Return (Local2)
                    }

                    Method (BCRT, 1, Serialized)
                    {
                        Store (Ones, Local2)
                        If (ECAV ())
                        {
                            If (LNot (Acquire (MUEC, 0xFFFF)))
                            {
                                And (Arg0, 0xFF, Local0)
                                ShiftRight (And (Arg0, 0xFF00), 0x08, Local1)
                                Store (Local1, BT16)
                                Store (Local0, BT17)
                                Release (MUEC)
                                Store (Zero, Local2)
                            }
                        }

                        Return (Local2)
                    }

                    Method (BIF1, 0, Serialized)
                    {
                        Store (Ones, Local0)
                        If (ECAV ())
                        {
                            If (LNot (Acquire (MUEC, 0xFFFF)))
                            {
                                Store (BT00, Local0)
                                Store (BT01, Local1)
                                Or (ShiftLeft (Local0, 0x08), Local1, Local0)
                                Release (MUEC)
                            }
                        }

                        Return (Local0)
                    }

                    Method (BIF2, 0, Serialized)
                    {
                        Store (Ones, Local0)
                        If (ECAV ())
                        {
                            If (LNot (Acquire (MUEC, 0xFFFF)))
                            {
                                Store (BT23, Local0)
                                Store (BT24, Local1)
                                Or (ShiftLeft (Local0, 0x08), Local1, Local0)
                                Release (MUEC)
                            }
                        }

                        Return (Local0)
                    }

                    Method (BIF4, 0, Serialized)
                    {
                        Store (Ones, Local0)
                        If (ECAV ())
                        {
                            If (LNot (Acquire (MUEC, 0xFFFF)))
                            {
                                Store (BT02, Local0)
                                Store (BT03, Local1)
                                Or (ShiftLeft (Local0, 0x08), Local1, Local0)
                                Release (MUEC)
                            }
                        }

                        Return (Local0)
                    }

                    Method (BIF5, 0, Serialized)
                    {
                        Store (Ones, Local0)
                        If (ECAV ())
                        {
                            If (LNot (Acquire (MUEC, 0xFFFF)))
                            {
                                Store (BT12, Local0)
                                Store (BT13, Local1)
                                Or (ShiftLeft (Local0, 0x08), Local1, Local0)
                                Release (MUEC)
                            }
                        }

                        Return (Local0)
                    }

                    Method (BIF6, 0, Serialized)
                    {
                        Store (Ones, Local0)
                        If (ECAV ())
                        {
                            If (LNot (Acquire (MUEC, 0xFFFF)))
                            {
                                Store (BT14, Local0)
                                Store (BT15, Local1)
                                Or (ShiftLeft (Local0, 0x08), Local1, Local0)
                                Release (MUEC)
                            }
                        }

                        Return (Local0)
                    }

                    Method (BST1, 0, Serialized)
                    {
                        Store (Ones, Local0)
                        If (ECAV ())
                        {
                            If (LNot (Acquire (MUEC, 0xFFFF)))
                            {
                                Store (BT25, Local0)
                                Store (BT26, Local1)
                                Or (ShiftLeft (Local0, 0x08), Local1, Local0)
                                Release (MUEC)
                            }
                        }

                        If (And (Local0, 0x8000))
                        {
                            Not (Local0, Local0)
                            And (Local0, 0xFFFF, Local0)
                            Add (Local0, One, Local0)
                        }

                        Return (Local0)
                    }

                    Method (BST2, 0, Serialized)
                    {
                        Store (Ones, Local0)
                        If (ECAV ())
                        {
                            If (LNot (Acquire (MUEC, 0xFFFF)))
                            {
                                Store (BT10, Local0)
                                Store (BT11, Local1)
                                Or (ShiftLeft (Local0, 0x08), Local1, Local0)
                                Release (MUEC)
                            }
                        }

                        Multiply (Local0, 0x64, Local1)
                        Divide (Local1, 0x63, Local2, Local1)
                        If (LGreater (Local1, DerefOf (Index (PBIF, 0x02))))
                        {
                            Store (DerefOf (Index (PBIF, 0x02)), Local0)
                        }

                        Return (Local0)
                    }

                    Method (BST3, 0, Serialized)
                    {
                        Store (Ones, Local0)
                        If (ECAV ())
                        {
                            If (LNot (Acquire (MUEC, 0xFFFF)))
                            {
                                Store (BT04, Local0)
                                Store (BT05, Local1)
                                Or (ShiftLeft (Local0, 0x08), Local1, Local0)
                                Release (MUEC)
                            }
                        }

                        Return (Local0)
                    }

                    Method (EBTS, 0, Serialized)
                    {
                        Store (Ones, Local0)
                        If (ECAV ())
                        {
                            If (LNot (Acquire (MUEC, 0xFFFF)))
                            {
                                Store (BT22, Local0)
                                Release (MUEC)
                            }
                        }

                        Return (Local0)
                    }

                    Method (RCTP, 0, Serialized)
                    {
                        Store (Ones, Local0)
                        If (ECAV ())
                        {
                            If (LNot (Acquire (MUEC, 0xFFFF)))
                            {
                                Store (ST00, Local0)
                                Release (MUEC)
                            }
                        }

                        Return (Local0)
                    }

                    Method (ETPS, 1, Serialized)
                    {
                        Store (Zero, Local0)
                        If (ECAV ())
                        {
                            If (LNot (Acquire (MUEC, 0xFFFF)))
                            {
                                XOr (Arg0, One, Local1)
                                Store (Local1, SF19)
                                Release (MUEC)
                                Store (One, Local0)
                            }
                        }

                        Return (Local0)
                    }

                    Method (ETPG, 0, Serialized)
                    {
                        Store (Ones, Local0)
                        If (ECAV ())
                        {
                            If (LNot (Acquire (MUEC, 0xFFFF)))
                            {
                                Store (SF19, Local0)
                                XOr (Local0, One, Local0)
                                Release (MUEC)
                            }
                        }

                        Return (Local0)
                    }

                    Method (ELBS, 1, Serialized)
                    {
                        Store (Zero, Local0)
                        If (ECAV ())
                        {
                            If (LNot (Acquire (MUEC, 0xFFFF)))
                            {
                                XOr (Arg0, One, Local1)
                                Store (Local1, SF18)
                                Release (MUEC)
                                Store (One, Local0)
                            }
                        }

                        Return (Local0)
                    }

                    Method (ELBG, 0, Serialized)
                    {
                        Store (Ones, Local0)
                        If (ECAV ())
                        {
                            If (LNot (Acquire (MUEC, 0xFFFF)))
                            {
                                Store (SF18, Local0)
                                XOr (Local0, One, Local0)
                                Release (MUEC)
                            }
                        }

                        Return (Local0)
                    }
                }

                Device (RMSC)
                {
                    Name (_HID, EisaId ("PNP0C02"))
                    Name (_UID, 0x10)
                    Name (CRS, ResourceTemplate ()
                    {
                        IO (Decode16,
                            0x0010,             // Range Minimum
                            0x0010,             // Range Maximum
                            0x00,               // Alignment
                            0x10,               // Length
                            )
                        IO (Decode16,
                            0x0022,             // Range Minimum
                            0x0022,             // Range Maximum
                            0x00,               // Alignment
                            0x1E,               // Length
                            )
                        IO (Decode16,
                            0x0044,             // Range Minimum
                            0x0044,             // Range Maximum
                            0x00,               // Alignment
                            0x0A,               // Length
                            )
                        IO (Decode16,
                            0x0050,             // Range Minimum
                            0x0050,             // Range Maximum
                            0x00,               // Alignment
                            0x0F,               // Length
                            )
                        IO (Decode16,
                            0x0063,             // Range Minimum
                            0x0063,             // Range Maximum
                            0x00,               // Alignment
                            0x01,               // Length
                            )
                        IO (Decode16,
                            0x0065,             // Range Minimum
                            0x0065,             // Range Maximum
                            0x00,               // Alignment
                            0x01,               // Length
                            )
                        IO (Decode16,
                            0x0067,             // Range Minimum
                            0x0067,             // Range Maximum
                            0x00,               // Alignment
                            0x09,               // Length
                            )
                        IO (Decode16,
                            0x0072,             // Range Minimum
                            0x0072,             // Range Maximum
                            0x00,               // Alignment
                            0x0E,               // Length
                            )
                        IO (Decode16,
                            0x0080,             // Range Minimum
                            0x0080,             // Range Maximum
                            0x00,               // Alignment
                            0x01,               // Length
                            )
                        IO (Decode16,
                            0x0084,             // Range Minimum
                            0x0084,             // Range Maximum
                            0x00,               // Alignment
                            0x03,               // Length
                            )
                        IO (Decode16,
                            0x0088,             // Range Minimum
                            0x0088,             // Range Maximum
                            0x00,               // Alignment
                            0x01,               // Length
                            )
                        IO (Decode16,
                            0x008C,             // Range Minimum
                            0x008C,             // Range Maximum
                            0x00,               // Alignment
                            0x03,               // Length
                            )
                        IO (Decode16,
                            0x0090,             // Range Minimum
                            0x0090,             // Range Maximum
                            0x00,               // Alignment
                            0x10,               // Length
                            )
                        IO (Decode16,
                            0x00A2,             // Range Minimum
                            0x00A2,             // Range Maximum
                            0x00,               // Alignment
                            0x1E,               // Length
                            )
                        IO (Decode16,
                            0x00E0,             // Range Minimum
                            0x00E0,             // Range Maximum
                            0x00,               // Alignment
                            0x10,               // Length
                            )
                        IO (Decode16,
                            0x025C,             // Range Minimum
                            0x025C,             // Range Maximum
                            0x00,               // Alignment
                            0x04,               // Length
                            )
                        IO (Decode16,
                            0x0380,             // Range Minimum
                            0x0380,             // Range Maximum
                            0x00,               // Alignment
                            0x04,               // Length
                            )
                        IO (Decode16,
                            0x0400,             // Range Minimum
                            0x0400,             // Range Maximum
                            0x00,               // Alignment
                            0x20,               // Length
                            )
                        IO (Decode16,
                            0x04D0,             // Range Minimum
                            0x04D0,             // Range Maximum
                            0x00,               // Alignment
                            0x02,               // Length
                            )
                        IO (Decode16,
                            0x0000,             // Range Minimum
                            0x0000,             // Range Maximum
                            0x00,               // Alignment
                            0x00,               // Length
                            _Y00)
                        IO (Decode16,
                            0x0000,             // Range Minimum
                            0x0000,             // Range Maximum
                            0x00,               // Alignment
                            0x00,               // Length
                            _Y01)
                        IO (Decode16,
                            0x0000,             // Range Minimum
                            0x0000,             // Range Maximum
                            0x00,               // Alignment
                            0x00,               // Length
                            _Y02)
                        Memory32Fixed (ReadWrite,
                            0x8C000000,         // Address Base
                            0x00020000,         // Address Length
                            )
                        Memory32Fixed (ReadWrite,
                            0xFED1C000,         // Address Base
                            0x00004000,         // Address Length
                            )
                        Memory32Fixed (ReadWrite,
                            0xFED20000,         // Address Base
                            0x00020000,         // Address Length
                            )
                        Memory32Fixed (ReadWrite,
                            0xFED50000,         // Address Base
                            0x00040000,         // Address Length
                            )
                        Memory32Fixed (ReadWrite,
                            0xFFB00000,         // Address Base
                            0x00100000,         // Address Length
                            )
                        Memory32Fixed (ReadWrite,
                            0xFFF00000,         // Address Base
                            0x00100000,         // Address Length
                            )
                    })
                    Method (_CRS, 0, NotSerialized)
                    {
                        CreateWordField (CRS, \_SB.PCI0.SBRG.RMSC._Y00._MIN, GP00)
                        CreateWordField (CRS, \_SB.PCI0.SBRG.RMSC._Y00._MAX, GP01)
                        CreateByteField (CRS, \_SB.PCI0.SBRG.RMSC._Y00._LEN, GP0L)
                        Store (PMBS, GP00)
                        Store (PMBS, GP01)
                        Store (PMLN, GP0L)
                        If (SMBS)
                        {
                            CreateWordField (CRS, \_SB.PCI0.SBRG.RMSC._Y01._MIN, GP10)
                            CreateWordField (CRS, \_SB.PCI0.SBRG.RMSC._Y01._MAX, GP11)
                            CreateByteField (CRS, \_SB.PCI0.SBRG.RMSC._Y01._LEN, GP1L)
                            Store (SMBS, GP10)
                            Store (SMBS, GP11)
                            Store (SMBL, GP1L)
                        }

                        If (GPBS)
                        {
                            CreateWordField (CRS, \_SB.PCI0.SBRG.RMSC._Y02._MIN, GP20)
                            CreateWordField (CRS, \_SB.PCI0.SBRG.RMSC._Y02._MAX, GP21)
                            CreateByteField (CRS, \_SB.PCI0.SBRG.RMSC._Y02._LEN, GP2L)
                            Store (GPBS, GP20)
                            Store (GPBS, GP21)
                            Store (GPLN, GP2L)
                        }

                        Return (CRS)
                    }
                }

                Device (HPET)
                {
                    Name (_HID, EisaId ("PNP0103"))
                    Name (CRS, ResourceTemplate ()
                    {
                        IRQNoFlags ()
                            {0}
                        IRQNoFlags ()
                            {8}
                        Memory32Fixed (ReadOnly,
                            0xFED00000,         // Address Base
                            0x00000400,         // Address Length
                            _Y03)
                    })
                    OperationRegion (^LPCR, SystemMemory, 0xFED1F404, 0x04)
                    Field (LPCR, AnyAcc, NoLock, Preserve)
                    {
                        HPTS,   2, 
                            ,   5, 
                        HPTE,   1, 
                                Offset (0x04)
                    }

                    Method (_STA, 0, NotSerialized)
                    {
                        If (LEqual (OSFL (), Zero))
                        {
                            If (HPTE)
                            {
                                Return (0x0F)
                            }
                        }
                        Else
                        {
                            If (HPTE)
                            {
                                Return (0x0B)
                            }
                        }

                        Return (Zero)
                    }

                    Method (_CRS, 0, NotSerialized)
                    {
                        CreateDWordField (CRS, \_SB.PCI0.SBRG.HPET._Y03._BAS, HPT)
                        Multiply (HPTS, 0x1000, Local0)
                        Add (Local0, 0xFED00000, HPT)
                        Return (CRS)
                    }
                }

                OperationRegion (RX80, PCI_Config, Zero, 0xFF)
                Field (RX80, ByteAcc, NoLock, Preserve)
                {
                            Offset (0x80), 
                    LPCD,   16, 
                    LPCE,   16
                }

                Name (DBPT, Package (0x04)
                {
                    Package (0x08)
                    {
                        0x03F8, 
                        0x02F8, 
                        0x0220, 
                        0x0228, 
                        0x0238, 
                        0x02E8, 
                        0x0338, 
                        0x03E8
                    }, 

                    Package (0x08)
                    {
                        0x03F8, 
                        0x02F8, 
                        0x0220, 
                        0x0228, 
                        0x0238, 
                        0x02E8, 
                        0x0338, 
                        0x03E8
                    }, 

                    Package (0x03)
                    {
                        0x0378, 
                        0x0278, 
                        0x03BC
                    }, 

                    Package (0x02)
                    {
                        0x03F0, 
                        0x0370
                    }
                })
                Name (DDLT, Package (0x04)
                {
                    Package (0x02)
                    {
                        Zero, 
                        0xFFF8
                    }, 

                    Package (0x02)
                    {
                        0x04, 
                        0xFF8F
                    }, 

                    Package (0x02)
                    {
                        0x08, 
                        0xFCFF
                    }, 

                    Package (0x02)
                    {
                        0x0C, 
                        0xEFFF
                    }
                })
                Method (RRIO, 4, NotSerialized)
                {
                    If (LAnd (LLessEqual (Arg0, 0x03), LGreaterEqual (Arg0, Zero)))
                    {
                        Store (Match (DerefOf (Index (DBPT, Arg0)), MEQ, Arg2, MTR, 
                            Zero, Zero), Local0)
                        If (LNotEqual (Local0, Ones))
                        {
                            Store (DerefOf (Index (DerefOf (Index (DDLT, Arg0)), Zero)), 
                                Local1)
                            Store (DerefOf (Index (DerefOf (Index (DDLT, Arg0)), One)), 
                                Local2)
                            ShiftLeft (Local0, Local1, Local0)
                            And (LPCD, Local2, LPCD)
                            Or (LPCD, Local0, LPCD)
                            WX82 (Arg0, Arg1)
                        }
                    }

                    If (LEqual (Arg0, 0x08))
                    {
                        If (LEqual (Arg2, 0x0200))
                        {
                            WX82 (0x08, Arg0)
                        }
                        Else
                        {
                            If (LEqual (Arg2, 0x0208))
                            {
                                WX82 (0x09, Arg0)
                            }
                        }
                    }

                    If (LAnd (LLessEqual (Arg0, 0x0D), LGreaterEqual (Arg0, 0x0A)))
                    {
                        WX82 (Arg0, Arg1)
                    }
                }

                Method (WX82, 2, NotSerialized)
                {
                    ShiftLeft (One, Arg0, Local0)
                    If (Arg1)
                    {
                        Or (LPCE, Local0, LPCE)
                    }
                    Else
                    {
                        Not (Local0, Local0)
                        And (LPCE, Local0, LPCE)
                    }
                }

                Method (RDMA, 3, NotSerialized)
                {
                }

                OperationRegion (SMRG, SystemIO, SMBS, 0x10)
                Field (SMRG, ByteAcc, NoLock, Preserve)
                {
                    HSTS,   8, 
                    SSTS,   8, 
                    HSTC,   8, 
                    HCMD,   8, 
                    HADR,   8, 
                    HDT0,   8, 
                    HDT1,   8, 
                    BLKD,   8
                }

                Field (SMRG, ByteAcc, NoLock, Preserve)
                {
                            Offset (0x05), 
                    HDTW,   16
                }

                Method (SCMD, 4, NotSerialized)
                {
                    Store (0x05, Local0)
                    While (Local0)
                    {
                        Store (Arg0, HADR)
                        Store (Arg1, HCMD)
                        Store (Arg2, HDTW)
                        Store (0xFF, HSTS)
                        Store (Arg3, HSTC)
                        Store (0xFF, Local7)
                        While (Local7)
                        {
                            Decrement (Local7)
                            If (And (HSTS, 0x02))
                            {
                                Store (Zero, Local7)
                                Store (One, Local0)
                            }
                        }

                        Decrement (Local0)
                    }

                    If (And (HSTS, 0x02))
                    {
                        Return (HDTW)
                    }
                    Else
                    {
                        Return (Ones)
                    }
                }

                Method (SBYT, 2, NotSerialized)
                {
                    SCMD (Arg0, Arg1, Zero, 0x44)
                }

                Method (WBYT, 3, NotSerialized)
                {
                    SCMD (Arg0, Arg1, Arg2, 0x48)
                }

                Method (WWRD, 3, NotSerialized)
                {
                    SCMD (Arg0, Arg1, Arg2, 0x4C)
                }

                Method (RSBT, 2, NotSerialized)
                {
                    Or (Arg0, One, Arg0)
                    Return (SCMD (Arg0, Arg1, Zero, 0x44))
                }

                Method (RBYT, 2, NotSerialized)
                {
                    Or (Arg0, One, Arg0)
                    Return (SCMD (Arg0, Arg1, Zero, 0x48))
                }

                Method (RWRD, 2, NotSerialized)
                {
                    Or (Arg0, One, Arg0)
                    Return (SCMD (Arg0, Arg1, Zero, 0x4C))
                }

                Scope (\)
                {
                    OperationRegion (RAMW, SystemMemory, Subtract (TOPM, 0x00010000), 0x00010000)
                    Field (RAMW, ByteAcc, NoLock, Preserve)
                    {
                        PAR0,   32, 
                        PAR1,   32
                    }

                    OperationRegion (IOB2, SystemIO, 0xB2, 0x02)
                    Field (IOB2, ByteAcc, NoLock, Preserve)
                    {
                        SMIC,   8, 
                        SMIS,   8
                    }

                    Method (ISMI, 1, Serialized)
                    {
                        Store (Arg0, SMIC)
                    }

                    Method (GNVS, 1, Serialized)
                    {
                        Store (Arg0, PAR0)
                        ISMI (0x70)
                        Return (PAR1)
                    }

                    Method (SNVS, 2, Serialized)
                    {
                        Store (Arg0, PAR0)
                        Store (Arg1, PAR1)
                        ISMI (0x71)
                    }
                }

                Device (^PCIE)
                {
                    Name (_HID, EisaId ("PNP0C02"))
                    Name (_UID, 0x11)
                    Name (CRS, ResourceTemplate ()
                    {
                        Memory32Fixed (ReadOnly,
                            0xE0000000,         // Address Base
                            0x10000000,         // Address Length
                            _Y04)
                    })
                    Method (_CRS, 0, NotSerialized)
                    {
                        CreateDWordField (CRS, \_SB.PCI0.PCIE._Y04._BAS, BAS1)
                        CreateDWordField (CRS, \_SB.PCI0.PCIE._Y04._LEN, LEN1)
                        Store (PCIB, BAS1)
                        Store (PCIL, LEN1)
                        Return (CRS)
                    }
                }

                Scope (\)
                {
                }

                Device (OMSC)
                {
                    Name (_HID, EisaId ("PNP0C02"))
                    Name (_UID, Zero)
                    Name (CRS, ResourceTemplate ()
                    {
                        Memory32Fixed (ReadOnly,
                            0x00000000,         // Address Base
                            0x00000000,         // Address Length
                            _Y05)
                        Memory32Fixed (ReadOnly,
                            0x00000000,         // Address Base
                            0x00000000,         // Address Length
                            _Y06)
                    })
                    Method (_CRS, 0, NotSerialized)
                    {
                        If (APIC)
                        {
                            CreateDWordField (CRS, \_SB.PCI0.SBRG.OMSC._Y05._LEN, ML01)
                            CreateDWordField (CRS, \_SB.PCI0.SBRG.OMSC._Y05._BAS, MB01)
                            CreateDWordField (CRS, \_SB.PCI0.SBRG.OMSC._Y06._LEN, ML02)
                            CreateDWordField (CRS, \_SB.PCI0.SBRG.OMSC._Y06._BAS, MB02)
                            Store (0xFEC00000, MB01)
                            Store (0x1000, ML01)
                            Store (0xFEE00000, MB02)
                            Store (0x1000, ML02)
                        }

                        Return (CRS)
                    }
                }

                Device (^^RMEM)
                {
                    Name (_HID, EisaId ("PNP0C01"))
                    Name (_UID, One)
                    Name (CRS, ResourceTemplate ()
                    {
                        Memory32Fixed (ReadWrite,
                            0x00000000,         // Address Base
                            0x000A0000,         // Address Length
                            )
                        Memory32Fixed (ReadOnly,
                            0x00000000,         // Address Base
                            0x00000000,         // Address Length
                            _Y07)
                        Memory32Fixed (ReadOnly,
                            0x000E0000,         // Address Base
                            0x00020000,         // Address Length
                            _Y08)
                        Memory32Fixed (ReadWrite,
                            0x00100000,         // Address Base
                            0x00000000,         // Address Length
                            _Y09)
                        Memory32Fixed (ReadOnly,
                            0x00000000,         // Address Base
                            0x00000000,         // Address Length
                            _Y0A)
                    })
                    Method (_CRS, 0, NotSerialized)
                    {
                        CreateDWordField (CRS, \_SB.RMEM._Y07._BAS, BAS1)
                        CreateDWordField (CRS, \_SB.RMEM._Y07._LEN, LEN1)
                        CreateDWordField (CRS, \_SB.RMEM._Y08._BAS, BAS2)
                        CreateDWordField (CRS, \_SB.RMEM._Y08._LEN, LEN2)
                        CreateDWordField (CRS, \_SB.RMEM._Y09._LEN, LEN3)
                        CreateDWordField (CRS, \_SB.RMEM._Y0A._BAS, BAS4)
                        CreateDWordField (CRS, \_SB.RMEM._Y0A._LEN, LEN4)
                        If (OSFL ()) {}
                        Else
                        {
                            If (MG1B)
                            {
                                If (LGreater (MG1B, 0x000C0000))
                                {
                                    Store (0x000C0000, BAS1)
                                    Subtract (MG1B, BAS1, LEN1)
                                }
                            }
                            Else
                            {
                                Store (0x000C0000, BAS1)
                                Store (0x00020000, LEN1)
                            }

                            If (Add (MG1B, MG1L, Local0))
                            {
                                Store (Local0, BAS2)
                                Subtract (0x00100000, BAS2, LEN2)
                            }
                        }

                        Subtract (MG2B, 0x00100000, LEN3)
                        Add (MG2B, MG2L, BAS4)
                        Subtract (Zero, BAS4, LEN4)
                        Return (CRS)
                    }
                }

                Scope (\)
                {
                    Field (\_SB.PCI0.SBRG.GPBX, ByteAcc, NoLock, Preserve)
                    {
                                Offset (0x0C), 
                            ,   7, 
                        SB07,   1, 
                            ,   2, 
                        SB10,   1, 
                        SB11,   1, 
                        SB12,   1, 
                        SB13,   1, 
                        SB14,   1, 
                                Offset (0x0F), 
                        SB24,   1, 
                        SB25,   1, 
                        SB26,   1, 
                        SB27,   1, 
                        SB28,   1, 
                                Offset (0x18), 
                            ,   25, 
                        BLNK,   1, 
                                Offset (0x2C), 
                            ,   11, 
                        IV0B,   1, 
                                Offset (0x38), 
                        SB32,   1, 
                        SB33,   1, 
                        SB34,   1, 
                        SB35,   1, 
                        SB36,   1
                    }

                    OperationRegion (RCBA, SystemMemory, 0xFED1C000, 0x4000)
                    Field (RCBA, ByteAcc, NoLock, Preserve)
                    {
                                Offset (0x3418), 
                        FDRT,   32
                    }

                    Method (DFTL, 0, NotSerialized)
                    {
                        Store (Zero, TTEN)
                    }

                    Method (EFTL, 0, NotSerialized)
                    {
                        Store (One, TTEN)
                    }
                }

                Scope (\_SB.PCI0.SBRG)
                {
                    Method (OEMI, 0, NotSerialized)
                    {
                    }

                    Method (OEMS, 1, NotSerialized)
                    {
                        If (LEqual (Arg0, 0x03)) {}
                    }

                    Name (CLKB, Buffer (0x20) {})
                    Method (RCLK, 0, NotSerialized)
                    {
                        RBLK (0xD2, 0x1F, CLKB, 0x1F)
                    }

                    Method (WCLK, 0, NotSerialized)
                    {
                        WBLK (0xD2, 0x1F, 0x1F, CLKB)
                    }

                    Method (RCKB, 1, NotSerialized)
                    {
                        RCLK ()
                        Store (DerefOf (Index (CLKB, Arg0)), Local0)
                        Return (Local0)
                    }

                    Method (WCKB, 2, NotSerialized)
                    {
                        Store (Arg1, Index (CLKB, Arg0))
                    }

                    Name (DATA, Package (0x02)
                    {
                        Zero, 
                        Zero
                    })
                    Mutex (SMBA, 0x00)
                    Method (SMBC, 4, NotSerialized)
                    {
                        Acquire (SMBA, 0xFFFF)
                        Store (0xFF, HSTS)
                        Sleep (0x0A)
                        Store (HSTS, Local0)
                        And (Local0, 0x1F, Local0)
                        Store (0xFF, Local1)
                        While (LAnd (LGreater (Local1, Zero), LNotEqual (Local0, Zero)))
                        {
                            Decrement (Local1)
                            Store (0xFF, HSTS)
                            Sleep (0x0A)
                            Store (HSTS, Local0)
                            And (Local0, 0x1F, Local0)
                        }

                        If (Local0)
                        {
                            Store (0x02, HSTC)
                            Sleep (0x0A)
                            Store (Zero, HSTC)
                            Store (0xFF, HSTS)
                            Sleep (0x0A)
                            Store (HSTS, Local0)
                            And (Local0, 0x1F, Local0)
                            Store (0xFF, Local1)
                            While (LAnd (LGreater (Local1, Zero), LNotEqual (Local0, Zero)))
                            {
                                Decrement (Local1)
                                Store (0xFF, HSTS)
                                Sleep (0x0A)
                                Store (HSTS, Local0)
                                And (Local0, 0x1F, Local0)
                            }

                            If (Local0)
                            {
                                Store (One, Index (DATA, Zero))
                                Return (DATA)
                            }
                        }

                        Store (Arg1, HCMD)
                        Store (Arg0, HADR)
                        And (Arg0, One, Local0)
                        If (LNot (Local0))
                        {
                            And (Arg2, 0x04, Local0)
                            If (Local0)
                            {
                                Store (Arg3, HDTW)
                            }
                            Else
                            {
                                Store (Arg3, HDT0)
                            }
                        }

                        Store (Arg2, HSTC)
                        Sleep (0x0A)
                        Store (HSTS, Local0)
                        Store (0xFF, Local1)
                        While (LGreater (Local1, Zero))
                        {
                            And (Local0, 0x1C, Local2)
                            If (Local2)
                            {
                                Store (One, Index (DATA, Zero))
                                Return (DATA)
                            }

                            And (Local0, 0x02, Local2)
                            If (Local2)
                            {
                                Store (Zero, Index (DATA, Zero))
                                And (Arg2, 0x04, Local2)
                                If (Local0)
                                {
                                    Store (HDTW, Index (DATA, One))
                                }
                                Else
                                {
                                    Store (HDT0, Index (DATA, One))
                                }

                                Return (DATA)
                            }

                            Sleep (0x0A)
                            Store (HSTS, Local0)
                            Decrement (Local1)
                        }

                        Store (One, Index (DATA, Zero))
                        Release (SMBA)
                        Return (DATA)
                    }

                    Method (SMBB, 2, NotSerialized)
                    {
                        Store (Zero, HCMD)
                        Sleep (0x02)
                        Store (Arg0, HADR)
                        Sleep (0x02)
                        Store (0xFF, HSTS)
                        Sleep (0x02)
                        Store (0x54, HSTC)
                        Store (0xFF, Local0)
                        While (Local0)
                        {
                            Decrement (Local0)
                            Sleep (0x02)
                            If (And (HSTS, 0x02))
                            {
                                Store (Zero, Local0)
                                Store (One, Local1)
                            }
                        }

                        Store (HDT0, Local2)
                        Return (Local2)
                    }

                    Method (WBLK, 4, NotSerialized)
                    {
                        Acquire (SMBA, 0xFFFF)
                        Store (HSTC, Local0)
                        Store (Arg2, Local0)
                        Store (Zero, Local1)
                        While (Local0)
                        {
                            Store (DerefOf (Index (Arg3, Local1)), BLKD)
                            Decrement (Local0)
                            Increment (Local1)
                        }

                        Store (HSTC, Local0)
                        Store (Arg2, HDT0)
                        SMBB (Arg0, Arg1)
                        Release (SMBA)
                    }

                    Method (RBLK, 4, NotSerialized)
                    {
                        Acquire (SMBA, 0xFFFF)
                        Or (Arg0, One, Local0)
                        Store (SMBB (Local0, Arg1), Local1)
                        Store (HSTC, Local0)
                        Store (Arg3, Local0)
                        Add (Local1, One, Local2)
                        Store (Zero, Local1)
                        While (Local0)
                        {
                            Store (BLKD, Index (Arg2, Local1))
                            Decrement (Local0)
                            Increment (Local1)
                        }

                        Release (SMBA)
                    }

                    Name (CKFG, Package (0x03)
                    {
                        Package (0x0A)
                        {
                            0xEF, 
                            0x2F, 
                            0x0F, 
                            0x6E, 
                            0x76, 
                            0x32, 
                            0x1E, 
                            One, 
                            Zero, 
                            0x8F
                        }, 

                        Package (0x0A)
                        {
                            0xEF, 
                            0x2F, 
                            0x8F, 
                            0x68, 
                            0xEF, 
                            0x2F, 
                            0x1E, 
                            One, 
                            One, 
                            0x0F
                        }, 

                        Package (0x0A)
                        {
                            0xEF, 
                            0x2F, 
                            0x8F, 
                            0x68, 
                            0xEF, 
                            0x2F, 
                            0x17, 
                            Zero, 
                            One, 
                            0x8F
                        }
                    })
                    Method (FSBA, 1, NotSerialized)
                    {
                        Store (DerefOf (Index (DerefOf (Index (CKFG, Arg0)), 0x07)), 
                            Local0)
                        If (LLess (Arg0, ^^^ATKD.CFVG ()))
                        {
                            VOLS (Local0)
                        }

                        RCLK ()
                        If (LEqual (Arg0, Zero))
                        {
                            And (RCKB (Zero), 0x9F, Local1)
                            WCKB (Zero, Local1)
                        }
                        Else
                        {
                            Or (RCKB (Zero), 0x60, Local1)
                            WCKB (Zero, Local1)
                        }

                        WCLK ()
                        RCLK ()
                        WCKB (0x11, DerefOf (Index (DerefOf (Index (CKFG, Arg0)), 0x04
                            )))
                        WCKB (0x12, DerefOf (Index (DerefOf (Index (CKFG, Arg0)), 0x05
                            )))
                        WCKB (0x0F, DerefOf (Index (DerefOf (Index (CKFG, Arg0)), 0x02
                            )))
                        WCKB (0x10, DerefOf (Index (DerefOf (Index (CKFG, Arg0)), 0x03
                            )))
                        WCLK ()
                        Sleep (0x0A)
                        RCLK ()
                        WCKB (0x0B, DerefOf (Index (DerefOf (Index (CKFG, Arg0)), 0x09
                            )))
                        WCKB (0x0C, DerefOf (Index (DerefOf (Index (CKFG, Arg0)), 0x06
                            )))
                        WCLK ()
                        Sleep (0x0A)
                        Store (DerefOf (Index (DerefOf (Index (CKFG, Arg0)), 0x07)), 
                            Local0)
                        If (LGreater (Arg0, ^^^ATKD.CFVG ()))
                        {
                            VOLS (Local0)
                        }

                        Store (Arg0, FS70)
                        SNVS (0x2622, Arg0)
                    }

                    Name (CKFB, Package (0x03)
                    {
                        Package (0x0A)
                        {
                            0xEF, 
                            0x2F, 
                            0x8F, 
                            0x6A, 
                            0xEF, 
                            0x2F, 
                            0x25, 
                            One, 
                            Zero, 
                            0x8F
                        }, 

                        Package (0x0A)
                        {
                            0xEF, 
                            0x2F, 
                            0x8F, 
                            0x68, 
                            0xEF, 
                            0x2F, 
                            0x25, 
                            One, 
                            One, 
                            0x8F
                        }, 

                        Package (0x0A)
                        {
                            0xEF, 
                            0x2F, 
                            0x8F, 
                            0x68, 
                            0xEF, 
                            0x2F, 
                            0x20, 
                            Zero, 
                            One, 
                            0x8F
                        }
                    })
                    Method (FSBB, 1, NotSerialized)
                    {
                        Store (DerefOf (Index (DerefOf (Index (CKFB, Arg0)), 0x07)), 
                            Local0)
                        If (LLess (Arg0, ^^^ATKD.CFVG ()))
                        {
                            VOLS (Local0)
                        }

                        RCLK ()
                        And (RCKB (Zero), 0x9F, Local1)
                        WCKB (Zero, Local1)
                        WCLK ()
                        RCLK ()
                        WCKB (0x11, DerefOf (Index (DerefOf (Index (CKFB, Arg0)), 0x04
                            )))
                        WCKB (0x12, DerefOf (Index (DerefOf (Index (CKFB, Arg0)), 0x05
                            )))
                        WCKB (0x0F, DerefOf (Index (DerefOf (Index (CKFB, Arg0)), 0x02
                            )))
                        WCKB (0x10, DerefOf (Index (DerefOf (Index (CKFB, Arg0)), 0x03
                            )))
                        WCLK ()
                        Sleep (0x0A)
                        RCLK ()
                        WCKB (0x0B, DerefOf (Index (DerefOf (Index (CKFB, Arg0)), 0x09
                            )))
                        WCKB (0x0C, DerefOf (Index (DerefOf (Index (CKFB, Arg0)), 0x06
                            )))
                        WCKB (0x0D, DerefOf (Index (DerefOf (Index (CKFB, Arg0)), Zero
                            )))
                        WCKB (0x0E, DerefOf (Index (DerefOf (Index (CKFB, Arg0)), One
                            )))
                        WCLK ()
                        Sleep (0x0A)
                        RCLK ()
                        If (LEqual (Arg0, One))
                        {
                            Or (RCKB (Zero), 0x40, Local1)
                            WCKB (Zero, Local1)
                        }

                        WCLK ()
                        Sleep (0x0A)
                        Store (DerefOf (Index (DerefOf (Index (CKFB, Arg0)), 0x07)), 
                            Local0)
                        If (LGreater (Arg0, ^^^ATKD.CFVG ()))
                        {
                            VOLS (Local0)
                        }

                        Store (Arg0, FS70)
                        SNVS (0x2622, Arg0)
                    }

                    Method (VOLS, 1, Serialized)
                    {
                        And (Arg0, One, Local0)
                        ^EC0.ECXW (0xE1, Local0)
                    }

                    Method (KCRD, 1, Serialized)
                    {
                        If (Arg0)
                        {
                            RCLK ()
                            Or (RCKB (0x02), 0x08, Local0)
                            WCKB (0x02, Local0)
                            WCLK ()
                            Sleep (0x0A)
                        }
                        Else
                        {
                            RCLK ()
                            And (RCKB (0x02), 0xF7, Local0)
                            WCKB (0x02, Local0)
                            WCLK ()
                            Sleep (0x0A)
                        }
                    }

                    Method (FSBG, 0, Serialized)
                    {
                        Store (SizeOf (CKFG), Local0)
                        Store (SizeOf (Index (CKFG, Zero)), Local1)
                        Divide (Local0, Local1, Local0)
                        Store (GNVS (0x2622), Local1)
                        ShiftLeft (Local0, 0x08, Local0)
                        Return (Add (Local0, Local1))
                    }

                    Method (FSG2, 0, Serialized)
                    {
                        Store (SizeOf (CKFB), Local0)
                        Store (SizeOf (Index (CKFB, Zero)), Local1)
                        Divide (Local0, Local1, Local0)
                        Store (GNVS (0x2622), Local1)
                        ShiftLeft (Local0, 0x08, Local0)
                        Return (Add (Local0, Local1))
                    }
                }

                Scope (\)
                {
                    Method (OCMS, 1, Serialized)
                    {
                        Store (Arg0, Local0)
                        XOr (Local0, One, Local0)
                        SNVS (0x15FA, Local0)
                        If (Arg0)
                        {
                            Store (One, SB35)
                        }
                        Else
                        {
                            Store (Zero, SB35)
                        }

                        Sleep (0x01F4)
                        Notify (\_SB.PCI0.USB3, Zero)
                        Return (One)
                    }

                    Method (OCMG, 0, Serialized)
                    {
                        Store (GNVS (0x15FA), Local0)
                        XOr (Local0, One, Local0)
                        Return (Local0)
                    }

                    Method (OCRS, 1, Serialized)
                    {
                        Store (Arg0, Local0)
                        XOr (Local0, One, Local0)
                        SNVS (0x15F9, Local0)
                        If (Arg0)
                        {
                            \_SB.PCI0.SBRG.KCRD (Arg0)
                            Store (Zero, SB27)
                        }
                        Else
                        {
                            Store (One, SB27)
                            \_SB.PCI0.SBRG.KCRD (Arg0)
                        }

                        Sleep (0x64)
                        Notify (\_SB.PCI0.USB2, Zero)
                        Return (One)
                    }

                    Method (OCRG, 0, Serialized)
                    {
                        Store (GNVS (0x15F9), Local0)
                        XOr (Local0, One, Local0)
                        Return (Local0)
                    }

                    Method (OWLS, 1, Serialized)
                    {
                        Store (Arg0, Local0)
                        XOr (Local0, One, Local0)
                        SNVS (0x15FB, Local0)
                        If (Arg0)
                        {
                            Store (One, SB07)
                            Store (Zero, SB24)
                            Sleep (0x03E8)
                            Notify (\_SB.PCI0.P0P7, Zero)
                            Sleep (0x64)
                            Notify (\_SB.PCI0.P0P7, Zero)
                        }
                        Else
                        {
                            Store (GNVS (0x1628), Local2)
                            Store (GNVS (0x15F5), Local3)
                            XOr (Local2, One, Local2)
                            If (Local2)
                            {
                                Store (Zero, SB07)
                            }
                            Else
                            {
                                If (Local3)
                                {
                                    Store (Zero, SB07)
                                }
                            }

                            Store (One, SB24)
                            Sleep (0x64)
                            Notify (\_SB.PCI0.P0P7, Zero)
                            Sleep (0x64)
                            Notify (\_SB.PCI0.P0P7, Zero)
                        }

                        Return (One)
                    }

                    Method (OWLG, 0, Serialized)
                    {
                        Store (GNVS (0x15FB), Local0)
                        XOr (Local0, One, Local0)
                        Return (Local0)
                    }

                    Method (OBTS, 1, Serialized)
                    {
                        Store (Arg0, Local0)
                        XOr (Local0, One, Local0)
                        SNVS (0x15F5, Local0)
                        If (Arg0)
                        {
                            Store (One, SB36)
                            Store (GNVS (0x1628), Local2)
                            If (Local2)
                            {
                                Store (One, SB07)
                            }

                            Sleep (0x03E8)
                            Notify (\_SB.PCI0.USB3, Zero)
                            Sleep (0x64)
                            Notify (\_SB.PCI0.USB3, Zero)
                        }
                        Else
                        {
                            Store (Zero, SB36)
                            Store (GNVS (0x15FB), Local2)
                            If (Local2)
                            {
                                Store (Zero, SB07)
                            }

                            Sleep (0x64)
                            Notify (\_SB.PCI0.USB3, Zero)
                            Sleep (0x64)
                            Notify (\_SB.PCI0.USB3, Zero)
                        }

                        Return (One)
                    }

                    Method (OBTG, 0, Serialized)
                    {
                        Store (GNVS (0x15F5), Local0)
                        XOr (Local0, One, Local0)
                        Return (Local0)
                    }
                }

                Scope (\)
                {
                    Name (MNAM, "1000HE")
                    Field (RAMW, ByteAcc, NoLock, Preserve)
                    {
                                Offset (0x10), 
                        ACPS,   1, 
                        DCPS,   1, 
                        LCDC,   1, 
                        CPUC,   1, 
                        TPLK,   1, 
                        FANC,   1, 
                        BLTS,   1, 
                        DC2S,   1, 
                        FS70,   8, 
                        BCAT,   16, 
                        BLTC,   8, 
                        BCGS,   8, 
                        DSAF,   32, 
                        MDLC,   32, 
                        HWIF,   32, 
                        MDL1,   32, 
                                Offset (0xB0), 
                        TRTY,   8, 
                        FSFN,   8, 
                        FSTA,   16, 
                        FADR,   32, 
                        FSIZ,   16, 
                                Offset (0xC0), 
                        USBI,   32, 
                        WAKT,   8, 
                        SHE0,   8
                    }

                    Field (RAMW, ByteAcc, NoLock, Preserve)
                    {
                                Offset (0x16), 
                        DAWL,   1, 
                        DABT,   1, 
                        DAIR,   1, 
                        DACM,   1, 
                        DATV,   1, 
                        DAGP,   1, 
                        DADS,   1, 
                        DAMD,   1, 
                        DACR,   1, 
                        DA3G,   1, 
                        DAWX,   1, 
                                Offset (0x1A)
                    }

                    Field (RAMW, ByteAcc, NoLock, Preserve)
                    {
                                Offset (0x100), 
                        FN00,   8, 
                        FN01,   8, 
                        FN02,   8, 
                        FN03,   8, 
                        FN04,   8, 
                        FN05,   8, 
                        FN06,   8, 
                        FN07,   8, 
                        FN08,   8, 
                        FN09,   8, 
                        FN10,   8, 
                        FN11,   8, 
                        FN12,   8, 
                        FN13,   8, 
                        FN14,   8, 
                        FN15,   8, 
                        FN16,   8, 
                        FN17,   8, 
                        FN18,   8, 
                        FN19,   8, 
                        FN20,   8, 
                        FN21,   8, 
                        FN22,   8, 
                        FN23,   8, 
                        FN24,   8, 
                        FN25,   8, 
                        FN26,   8, 
                        FN27,   8, 
                        FN28,   8, 
                        FN29,   8, 
                        FA00,   8, 
                        FA01,   8, 
                        FA02,   8, 
                        FA03,   8, 
                        FA04,   8, 
                        FA05,   8, 
                        FA06,   8, 
                        FA07,   8, 
                        FA08,   8, 
                        FA09,   8, 
                        FA10,   8, 
                        FA11,   8, 
                        FA12,   8, 
                        FA13,   8, 
                        FA14,   8, 
                        FA15,   8, 
                        FA16,   8, 
                        FA17,   8, 
                        FA18,   8, 
                        FA19,   8, 
                        FA20,   8, 
                        FA21,   8, 
                        FA22,   8, 
                        FA23,   8, 
                        FA24,   8, 
                        FA25,   8, 
                        FA26,   8, 
                        FA27,   8, 
                        FA28,   8, 
                        FA29,   8, 
                        FC00,   8, 
                        FC01,   8, 
                        FC02,   8, 
                        FC03,   8, 
                        FC04,   8, 
                        FC05,   8, 
                        FC06,   8, 
                        FC07,   8, 
                        FC08,   8, 
                        FC09,   8, 
                        FC10,   8, 
                        FC11,   8, 
                        FC12,   8, 
                        FC13,   8, 
                        FC14,   8, 
                        FC15,   8, 
                        FC16,   8, 
                        FC17,   8, 
                        FC18,   8, 
                        FC19,   8, 
                        FC20,   8, 
                        FC21,   8, 
                        FC22,   8, 
                        FC23,   8, 
                        FC24,   8, 
                        FC25,   8, 
                        FC26,   8, 
                        FC27,   8, 
                        FC28,   8, 
                        FC29,   8
                    }

                    Method (ATKN, 1, NotSerialized)
                    {
                        Store (Zero, Local1)
                        If (\_SB.LID._LID ())
                        {
                            Store (ATKR (Arg0), Local1)
                        }

                        Return (Local1)
                    }

                    Method (ATKR, 1, NotSerialized)
                    {
                        Store (Zero, Local1)
                        If (\_SB.ATKP)
                        {
                            Notify (\_SB.ATKD, Arg0)
                            Store (One, Local1)
                        }

                        Return (Local1)
                    }
                }

                Scope (\_SB)
                {
                    Name (ATKP, Zero)
                    Device (ATKD)
                    {
                        Name (_HID, "ASUS010")
                        Name (_UID, 0x01010100)
                        Method (_STA, 0, NotSerialized)
                        {
                            If (LEqual (MSOS (), MSW7))
                            {
                                Return (Zero)
                            }
                            Else
                            {
                                Return (0x0F)
                            }
                        }

                        Method (TYPE, 0, Serialized)
                        {
                            Return (MDLC)
                        }

                        Method (TYP1, 0, Serialized)
                        {
                            Return (MDL1)
                        }

                        Method (BIOS, 0, Serialized)
                        {
                            ShiftLeft (0x11, 0x08, Local0)
                            Store (0x04, Local1)
                            Return (Add (Local0, Local1))
                        }

                        Method (VERG, 0, Serialized)
                        {
                            ShiftLeft (One, 0x08, Local0)
                            Store (0x60, Local1)
                            Return (Add (Local0, Local1))
                        }

                        Method (QURY, 1, Serialized)
                        {
                            Name (T_0, Zero)
                            Store (Arg0, T_0)
                            If (LEqual (T_0, 0x534C4250))
                            {
                                Store (One, Local1)
                            }
                            Else
                            {
                                If (LEqual (T_0, 0x474C4250))
                                {
                                    Store (One, Local1)
                                }
                                Else
                                {
                                    If (LEqual (T_0, 0x50534453))
                                    {
                                        Store (One, Local1)
                                    }
                                    Else
                                    {
                                        If (LEqual (T_0, 0x53564643))
                                        {
                                            Store (One, Local1)
                                        }
                                        Else
                                        {
                                            If (LEqual (T_0, 0x47564643))
                                            {
                                                Store (One, Local1)
                                            }
                                            Else
                                            {
                                                If (LEqual (T_0, 0x53444C57))
                                                {
                                                    Store (One, Local1)
                                                }
                                                Else
                                                {
                                                    If (LEqual (T_0, 0x47444C57))
                                                    {
                                                        Store (One, Local1)
                                                    }
                                                    Else
                                                    {
                                                        If (LEqual (T_0, 0x534D4143))
                                                        {
                                                            Store (One, Local1)
                                                        }
                                                        Else
                                                        {
                                                            If (LEqual (T_0, 0x474D4143))
                                                            {
                                                                Store (One, Local1)
                                                            }
                                                            Else
                                                            {
                                                                If (LEqual (T_0, 0x53445243))
                                                                {
                                                                    Store (One, Local1)
                                                                }
                                                                Else
                                                                {
                                                                    If (LEqual (T_0, 0x47445243))
                                                                    {
                                                                        Store (One, Local1)
                                                                    }
                                                                    Else
                                                                    {
                                                                        If (LEqual (T_0, 0x53504448))
                                                                        {
                                                                            Store (One, Local1)
                                                                        }
                                                                        Else
                                                                        {
                                                                            If (LEqual (T_0, 0x45505954))
                                                                            {
                                                                                Store (One, Local1)
                                                                            }
                                                                            Else
                                                                            {
                                                                                If (LEqual (T_0, 0x31505954))
                                                                                {
                                                                                    Store (One, Local1)
                                                                                }
                                                                                Else
                                                                                {
                                                                                    If (LEqual (T_0, 0x53485442))
                                                                                    {
                                                                                        Store (One, Local1)
                                                                                    }
                                                                                    Else
                                                                                    {
                                                                                        If (LEqual (T_0, 0x47485442))
                                                                                        {
                                                                                            Store (One, Local1)
                                                                                        }
                                                                                        Else
                                                                                        {
                                                                                            If (LEqual (T_0, 0x534F4942))
                                                                                            {
                                                                                                Store (One, Local1)
                                                                                            }
                                                                                            Else
                                                                                            {
                                                                                                If (LEqual (T_0, 0x47504250))
                                                                                                {
                                                                                                    Store (One, Local1)
                                                                                                }
                                                                                                Else
                                                                                                {
                                                                                                    If (LEqual (T_0, 0x53504250))
                                                                                                    {
                                                                                                        Store (One, Local1)
                                                                                                    }
                                                                                                    Else
                                                                                                    {
                                                                                                        If (LEqual (T_0, 0x46435748))
                                                                                                        {
                                                                                                            Store (One, Local1)
                                                                                                        }
                                                                                                        Else
                                                                                                        {
                                                                                                            Store (Zero, Local1)
                                                                                                        }
                                                                                                    }
                                                                                                }
                                                                                            }
                                                                                        }
                                                                                    }
                                                                                }
                                                                            }
                                                                        }
                                                                    }
                                                                }
                                                            }
                                                        }
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }
                            }

                            Return (Local1)
                        }

                        Method (INIT, 1, Serialized)
                        {
                            Store (One, ATKP)
                            Store (Arg0, DSAF)
                            And (CFVG (), 0xFF, SHE0)
                            Return (One)
                        }

                        Method (CMSG, 0, Serialized)
                        {
                            Store (0x1300, Local0)
                            Or (Local0, One, Local0)
                            Or (Local0, 0x02, Local0)
                            Or (Local0, 0x10, Local0)
                            Or (Local0, 0x0400, Local0)
                            Or (Local0, 0x00100000, Local0)
                            And (Local0, USBI, Local0)
                            Return (Local0)
                        }

                        Method (WLDS, 1, Serialized)
                        {
                            Return (OWLS (Arg0))
                        }

                        Method (WLDG, 0, Serialized)
                        {
                            Return (OWLG ())
                        }

                        Method (PBLS, 1, Serialized)
                        {
                            SNVS (0x43E8, Arg0)
                            ^^PCI0.SBRG.EC0.STBR ()
                            Return (One)
                        }

                        Method (PBLG, 0, Serialized)
                        {
                            Return (GNVS (0x43E8))
                        }

                        Method (CFVS, 1, Serialized)
                        {
                            And (CFVG (), 0xFF, Local0)
                            Store (GNVS (0x1626), Local1)
                            If (LNotEqual (Local0, Arg0))
                            {
                                If (LEqual (Local1, One))
                                {
                                    ^^PCI0.SBRG.FSBB (Arg0)
                                }
                                Else
                                {
                                    ^^PCI0.SBRG.FSBA (Arg0)
                                }
                            }

                            Return (One)
                        }

                        Method (CFVG, 0, Serialized)
                        {
                            Store (GNVS (0x1626), Local0)
                            If (LEqual (Local0, One))
                            {
                                Return (^^PCI0.SBRG.FSG2 ())
                            }
                            Else
                            {
                                Return (^^PCI0.SBRG.FSBG ())
                            }
                        }

                        Method (CAMS, 1, Serialized)
                        {
                            Return (OCMS (Arg0))
                        }

                        Method (CAMG, 0, Serialized)
                        {
                            Return (OCMG ())
                        }

                        Method (BTHS, 1, Serialized)
                        {
                            Return (OBTS (Arg0))
                        }

                        Method (BTHG, 0, Serialized)
                        {
                            Return (OBTG ())
                        }

                        Method (SDSP, 1, Serialized)
                        {
                            ^^PCI0.VGA.SWHD (Arg0)
                            Return (One)
                        }

                        Method (CRDS, 1, Serialized)
                        {
                            Return (OCRS (Arg0))
                        }

                        Method (CRDG, 0, Serialized)
                        {
                            Return (OCRG ())
                        }

                        Method (HDPS, 1, Serialized)
                        {
                            Store (Arg0, Local0)
                            Store (Arg0, Local1)
                            ShiftRight (Local0, 0x08, Local0)
                            And (Local1, 0xFF, Local1)
                            Name (T_0, Zero)
                            Store (Local1, T_0)
                            If (LEqual (T_0, 0x04)) {}
                            Else
                            {
                                If (LEqual (T_0, 0x06)) {}
                                Else
                                {
                                    If (LEqual (T_0, 0x07)) {}
                                    Else
                                    {
                                        If (LEqual (T_0, 0x0B)) {}
                                        Else
                                        {
                                            If (LEqual (T_0, 0x0C)) {}
                                            Else
                                            {
                                                If (LEqual (T_0, 0x0E)) {}
                                                Else
                                                {
                                                    Return (Zero)
                                                }
                                            }
                                        }
                                    }
                                }
                            }

                            If (And (LLess (Local0, 0x05), LGreater (Local0, Zero)))
                            {
                                SNVS (0x81C0, Local1)
                                SNVS (0x81C8, Local0)
                                SNVS (0x8180, 0x46)
                                SNVS (0x8188, 0x57)
                                SNVS (0x8198, Or (GNVS (0x8198), 0x40))
                                Return (One)
                            }

                            Return (Zero)
                        }

                        Method (PBPS, 1, Serialized)
                        {
                            Store (Arg0, Local0)
                            XOr (Local0, One, Local0)
                            Store (Local0, ^^PCI0.SBRG.EC0.SF18)
                            Return (One)
                        }

                        Method (PBPG, 0, Serialized)
                        {
                            Store (^^PCI0.SBRG.EC0.SF18, Local0)
                            XOr (Local0, One, Local0)
                            Return (Local0)
                        }

                        Method (HWCF, 0, Serialized)
                        {
                            Return (HWIF)
                        }

                        Method (KBFT, 1, Serialized)
                        {
                            If (^^PCI0.SBRG.EC0.ECAV ())
                            {
                                If (LNot (Acquire (^^PCI0.SBRG.EC0.MUEC, 0xFFFF)))
                                {
                                    Store (Arg0, ^^PCI0.SBRG.EC0.S251)
                                    Release (^^PCI0.SBRG.EC0.MUEC)
                                    Return (One)
                                }
                            }

                            Return (Zero)
                        }

                        Method (HKEY, 0, Serialized)
                        {
                            If (^^PCI0.SBRG.EC0.ECAV ())
                            {
                                If (LNot (Acquire (^^PCI0.SBRG.EC0.MUEC, 0xFFFF)))
                                {
                                    Store (^^PCI0.SBRG.EC0.SM08, Local0)
                                    Release (^^PCI0.SBRG.EC0.MUEC)
                                    Return (One)
                                }
                            }

                            Return (Zero)
                        }
                    }

                    Scope (\)
                    {
                        Name (OSLX, 0x10)
                        Name (OSMS, 0x20)
                        Name (MS98, 0x21)
                        Name (MSME, 0x22)
                        Name (MS2K, 0x23)
                        Name (MSXP, 0x24)
                        Name (MSVT, 0x25)
                        Name (MSW7, 0x26)
                        Name (OSFG, Ones)
                        Method (MSOS, 0, NotSerialized)
                        {
                            If (LNotEqual (OSFG, Ones))
                            {
                                Return (OSFG)
                            }

                            Store (Zero, OSFG)
                            If (CondRefOf (_OSI, Local0))
                            {
                                If (_OSI ("Windows 2001"))
                                {
                                    Store (MSXP, OSFG)
                                }

                                If (_OSI ("Windows 2001 SP1"))
                                {
                                    Store (MSXP, OSFG)
                                }

                                If (_OSI ("Windows 2001 SP2"))
                                {
                                    Store (MSXP, OSFG)
                                }

                                If (_OSI ("Windows 2006"))
                                {
                                    Store (MSVT, OSFG)
                                }

                                If (_OSI ("Windows 2009"))
                                {
                                    Store (MSW7, OSFG)
                                }

                                If (_OSI ("Linux"))
                                {
                                    Store (OSLX, OSFG)
                                }

                                Return (OSFG)
                            }
                            Else
                            {
                                If (MCTH (_OS, "Microsoft Windows"))
                                {
                                    Store (MS98, OSFG)
                                }
                                Else
                                {
                                    If (MCTH (_OS, "Microsoft WindowsME: Millennium Edition"))
                                    {
                                        Store (MSME, OSFG)
                                    }
                                    Else
                                    {
                                        If (MCTH (_OS, "Microsoft Windows NT"))
                                        {
                                            Store (MS2K, OSFG)
                                        }
                                        Else
                                        {
                                            Store (MSXP, OSFG)
                                        }
                                    }
                                }
                            }

                            Return (OSFG)
                        }

                        OperationRegion (PMIO, SystemIO, 0x0800, 0x80)
                        Field (PMIO, ByteAcc, NoLock, Preserve)
                        {
                                    Offset (0x10), 
                                ,   1, 
                            TDTY,   3, 
                            TENA,   1, 
                            TTDT,   3, 
                            TTEN,   1, 
                                ,   8, 
                            THLS,   1
                        }

                        Method (LPFS, 1, NotSerialized)
                        {
                            If (LEqual (Arg0, 0x05))
                            {
                                SNVS (0x8260, GNVS (0x8078))
                            }

                            If (\_SB.ATKP)
                            {
                                And (\_SB.ATKD.CFVG (), 0xFF, Local0)
                                SNVS (0x2624, Local0)
                                \_SB.ATKD.CFVS (One)
                            }
                        }

                        Method (LPWK, 1, NotSerialized)
                        {
                            If (LEqual (Arg0, 0x03))
                            {
                                \_SB.PCI0.SBRG.EC0.UAPF ()
                                \_SB.PCI0.SBRG.EC0.UBPF ()
                                \_SB.PCI0.SBRG.EC0.STBR ()
                            }

                            Store (Arg0, WAKT)
                            Notify (\_SB.PCI0.BAT0, 0x81)
                            Notify (\_SB.PCI0.AC0, 0x81)
                            If (LNot (GNVS (0x15C5)))
                            {
                                Notify (\_SB.PWRB, 0x02)
                            }

                            Notify (\_PR.CPU1, 0x80)
                            Notify (\_PR.CPU1, 0x81)
                            Sleep (0x0A)
                            If (Ones)
                            {
                                Notify (\_PR.CPU2, 0x80)
                                Notify (\_PR.CPU2, 0x81)
                            }
                        }
                    }

                    Scope (\_SB)
                    {
                        Device (LID)
                        {
                            Name (_HID, EisaId ("PNP0C0D"))
                            Name (LIDS, One)
                            Method (_LID, 0, NotSerialized)
                            {
                                Store (^^PCI0.SBRG.EC0.SF13, LIDS)
                                XOr (LIDS, One, Local0)
                                If (Local0)
                                {
                                    Notify (SLPB, 0x80)
                                }

                                Return (LIDS)
                            }
                        }

                        Device (SLPB)
                        {
                            Name (_HID, EisaId ("PNP0C0E"))
                        }
                    }

                    Scope (PCI0.SBRG.EC0)
                    {
                        Method (_Q04, 0, NotSerialized)
                        {
                            Notify (SLPB, 0x80)
                        }

                        Method (_Q06, 0, NotSerialized)
                        {
                            If (LEqual (DAWL, One))
                            {
                                Store (0x10, Local0)
                            }
                            Else
                            {
                                Store (^^^^ATKD.WLDG (), Local0)
                                XOr (Local0, One, Local0)
                                ^^^^ATKD.WLDS (Local0)
                                If (Local0)
                                {
                                    Store (0x10, Local0)
                                }
                                Else
                                {
                                    Store (0x11, Local0)
                                }
                            }

                            ATKN (Local0)
                            \AMW0.AMWN (0x88)
                        }

                        Method (_Q0B, 0, NotSerialized)
                        {
                            Store (^^^^ATKD.PBLG (), Local0)
                            If (LGreater (Local0, Zero))
                            {
                                Decrement (Local0)
                            }

                            If (LGreater (Local0, 0x0E))
                            {
                                Store (0x0E, Local0)
                            }

                            If (LEqual (MSOS (), MSW7))
                            {
                                Notify (^^^VGA.LCDD, 0x87)
                            }
                            Else
                            {
                                ^^^^ATKD.PBLS (Local0)
                            }

                            ATKN (Add (Local0, 0x20))
                            \AMW0.AMWN (Add (Local0, 0x20))
                        }

                        Method (_Q0D, 0, NotSerialized)
                        {
                            Store (^^^^ATKD.PBLG (), Local0)
                            If (LLess (Local0, 0x0F))
                            {
                                Increment (Local0)
                            }
                            Else
                            {
                                Store (0x0F, Local0)
                            }

                            If (LEqual (MSOS (), MSW7))
                            {
                                Notify (^^^VGA.LCDD, 0x86)
                            }
                            Else
                            {
                                ^^^^ATKD.PBLS (Local0)
                            }

                            ATKN (Add (Local0, 0x20))
                            \AMW0.AMWN (Add (Local0, 0x10))
                        }

                        Method (_Q12, 0, NotSerialized)
                        {
                            Store (^^^VGA.GETN (), Local0)
                            ATKN (Add (Local0, 0x2F))
                            \AMW0.AMWN (0xCC)
                        }

                        Method (_Q14, 0, NotSerialized)
                        {
                            ATKN (0x12)
                            \AMW0.AMWN (0xE0)
                        }

                        Method (_Q16, 0, NotSerialized)
                        {
                            ATKN (0x13)
                            \AMW0.AMWN (0x32)
                        }

                        Method (_Q17, 0, NotSerialized)
                        {
                            ATKN (0x14)
                            \AMW0.AMWN (0x31)
                        }

                        Method (_Q19, 0, NotSerialized)
                        {
                            ATKN (0x15)
                            \AMW0.AMWN (0x30)
                        }

                        Method (_Q10, 0, NotSerialized)
                        {
                            \AMW0.AMWN (0xE9)
                            ATKN (0x16)
                        }

                        Method (_Q08, 0, NotSerialized)
                        {
                            ATKN (0x37)
                            \AMW0.AMWN (0x6B)
                        }

                        Method (_Q0A, 0, NotSerialized)
                        {
                            ATKN (0x38)
                            \AMW0.AMWN (0xE1)
                        }

                        Method (_Q1B, 0, NotSerialized)
                        {
                            ATKN (0x39)
                            \AMW0.AMWN (0x5C)
                        }

                        Method (_Q27, 0, NotSerialized)
                        {
                            ATKN (0x1A)
                            \AMW0.AMWN (0xE9)
                        }

                        Method (_Q28, 0, NotSerialized)
                        {
                            ATKN (0x1B)
                            \AMW0.AMWN (0xE1)
                        }

                        Method (_Q29, 0, NotSerialized)
                        {
                            ATKN (0x1C)
                            \AMW0.AMWN (0x54)
                        }

                        Method (_Q2A, 0, NotSerialized)
                        {
                            ATKN (0x1D)
                            \AMW0.AMWN (0x55)
                        }

                        Method (_Q2B, 0, NotSerialized)
                        {
                            Notify (LID, 0x80)
                        }

                        Method (_Q2C, 0, NotSerialized)
                        {
                            Notify (LID, 0x80)
                        }

                        Method (_Q31, 0, NotSerialized)
                        {
                            UAPF ()
                            If (LEqual (MSOS (), MSW7)) {}
                            Else
                            {
                                STBR ()
                            }

                            Notify (AC0, 0x80)
                            Notify (BAT0, 0x80)
                            Sleep (0x0A)
                            If (ACPS)
                            {
                                ATKN (0x50)
                                \AMW0.AMWN (0x58)
                            }
                            Else
                            {
                                ATKN (0x51)
                                \AMW0.AMWN (0x57)
                            }

                            Notify (\_PR.CPU1, 0x80)
                            Notify (\_PR.CPU1, 0x81)
                            Sleep (0x0A)
                            If (Ones)
                            {
                                Notify (\_PR.CPU2, 0x80)
                                Notify (\_PR.CPU2, 0x81)
                            }
                        }

                        Method (_Q32, 0, NotSerialized)
                        {
                            UBPF ()
                            If (DCPS)
                            {
                                Sleep (0x01F4)
                            }

                            STBR ()
                            Notify (BAT0, One)
                            Notify (BAT0, 0x81)
                            Notify (AC0, 0x80)
                        }

                        Method (_Q33, 0, NotSerialized)
                        {
                            Notify (BAT0, 0x80)
                            Notify (AC0, 0x80)
                        }

                        Method (_Q35, 0, NotSerialized)
                        {
                            Notify (BAT0, 0x80)
                            Notify (AC0, 0x80)
                        }

                        Method (_Q36, 0, NotSerialized)
                        {
                            Notify (BAT0, 0x80)
                            Notify (AC0, 0x80)
                        }

                        Method (_Q37, 0, NotSerialized)
                        {
                            If (Or (ATKN (0x52), \AMW0.AMWN (0x6E)))
                            {
                                Notify (BAT0, 0x80)
                            }
                        }

                        Method (_Q44, 0, NotSerialized)
                        {
                            Notify (\_TZ.TZ00, 0x80)
                        }

                        Method (_Q3A, 0, NotSerialized)
                        {
                            Notify (\_TZ.TZ00, 0x80)
                        }

                        Method (_Q3B, 0, NotSerialized)
                        {
                            Notify (\_TZ.TZ00, 0x80)
                        }

                        Method (_Q38, 0, NotSerialized)
                        {
                        }

                        Method (STBR, 0, Serialized)
                        {
                            ISMI (0x78)
                        }

                        Method (UBPF, 0, Serialized)
                        {
                            If (ECAV ())
                            {
                                If (LNot (Acquire (MUEC, 0xFFFF)))
                                {
                                    Store (SF01, Local0)
                                    Release (MUEC)
                                    Store (Local0, DCPS)
                                }
                            }
                        }

                        Method (UAPF, 0, Serialized)
                        {
                            If (ECAV ())
                            {
                                If (LNot (Acquire (MUEC, 0xFFFF)))
                                {
                                    Store (SF00, Local0)
                                    Release (MUEC)
                                    Store (Local0, ACPS)
                                }
                            }
                        }

                        Method (UBCF, 0, Serialized)
                        {
                            Store (BIF1 (), BCAT)
                        }

                        Method (UBCS, 0, Serialized)
                        {
                            If (ACPS)
                            {
                                Store (0x02, BCGS)
                                Store (EBTS (), Local1)
                                If (LNotEqual (Local1, Ones))
                                {
                                    If (And (Local1, 0x40))
                                    {
                                        Store (Zero, BCGS)
                                    }
                                }
                            }
                            Else
                            {
                                Store (One, BCGS)
                            }
                        }

                        Method (UBEC, 0, Serialized)
                        {
                            If (DCPS)
                            {
                                Store (BIF2 (), Local0)
                                If (LNotEqual (Local0, Ones))
                                {
                                    Multiply (Local0, 0x0A, Local1)
                                    Divide (Local1, 0x64, Local2, Local1)
                                    If (Local2)
                                    {
                                        Add (Local1, One, Local1)
                                    }

                                    BWRN (Local1)
                                    Multiply (Local0, 0x05, Local1)
                                    Divide (Local1, 0x64, Local2, Local1)
                                    If (Local2)
                                    {
                                        Add (Local1, One, Local1)
                                    }

                                    BLOW (Local1)
                                    Multiply (Local0, 0x03, Local1)
                                    Divide (Local1, 0x64, Local2, Local1)
                                    If (Local2)
                                    {
                                        Add (Local1, One, Local1)
                                    }

                                    BCRT (Local1)
                                }
                            }
                        }
                    }
                }

                Scope (^^PCI0)
                {
                    Device (BAT0)
                    {
                        Name (_HID, EisaId ("PNP0C0A"))
                        Name (_UID, Zero)
                        Name (_PCL, Package (0x01)
                        {
                            PCI0
                        })
                        Method (_STA, 0, NotSerialized)
                        {
                            Return (CSTA ())
                        }

                        Method (_BIF, 0, NotSerialized)
                        {
                            If (LEqual (DCPS, Zero))
                            {
                                Return (NBIF)
                            }

                            CBIF ()
                            Return (PBIF)
                        }

                        Method (_BST, 0, NotSerialized)
                        {
                            If (And (0x10, _STA ()))
                            {
                                CBST ()
                            }

                            Return (PBST)
                        }
                    }

                    Name (NBIF, Package (0x0D)
                    {
                        One, 
                        Ones, 
                        Ones, 
                        One, 
                        Ones, 
                        Ones, 
                        Ones, 
                        Ones, 
                        Ones, 
                        " ", 
                        " ", 
                        " ", 
                        " "
                    })
                    Name (PBIF, Package (0x0D)
                    {
                        One, 
                        0x10CC, 
                        0x1068, 
                        One, 
                        0x36D0, 
                        0x01A4, 
                        0xD2, 
                        0x1C, 
                        0x050A, 
                        "1000HE", 
                        " ", 
                        "LION", 
                        "ASUS"
                    })
                    Name (BATF, Buffer (0x02) {})
                    CreateWordField (BATF, Zero, DATW)
                    Name (BAF1, Buffer (0x02) {})
                    CreateWordField (BAF1, Zero, DAT2)
                    Method (CSTA, 0, Serialized)
                    {
                        Store (DCPS, Local0)
                        If (Local0)
                        {
                            Return (0x1F)
                        }
                        Else
                        {
                            Return (0x0F)
                        }
                    }

                    Method (CBIF, 0, Serialized)
                    {
                        ^SBRG.EC0.UBCS ()
                        ^SBRG.EC0.UBEC ()
                        Store (^SBRG.EC0.BIF1 (), Local0)
                        If (LNotEqual (Local0, Ones))
                        {
                            Store (Local0, Index (PBIF, One))
                        }

                        Store (^SBRG.EC0.BIF2 (), Local0)
                        If (LNotEqual (Local0, Ones))
                        {
                            Store (Local0, Index (PBIF, 0x02))
                        }

                        Store (^SBRG.EC0.BIF4 (), Local0)
                        If (LNotEqual (Local0, Ones))
                        {
                            Store (Local0, Index (PBIF, 0x04))
                        }

                        Store (^SBRG.EC0.BIF5 (), Local0)
                        If (LNotEqual (Local0, Ones))
                        {
                            Store (Local0, Index (PBIF, 0x05))
                        }

                        Store (^SBRG.EC0.BIF6 (), Local0)
                        If (LNotEqual (Local0, Ones))
                        {
                            Store (Local0, Index (PBIF, 0x06))
                        }

                        Store (^SBRG.EC0.BIF1 (), Local0)
                        If (LNotEqual (Local0, Ones))
                        {
                            Divide (Local0, 0x64, Local1, Local0)
                            Store (Local0, Index (PBIF, 0x07))
                            Store (Local0, Index (PBIF, 0x08))
                        }
                    }

                    Name (PBST, Package (0x04)
                    {
                        Zero, 
                        0x8000, 
                        0x8000, 
                        0x36B0
                    })
                    Method (CBST, 0, Serialized)
                    {
                        ^SBRG.EC0.UBCS ()
                        Store (BCGS, Index (PBST, Zero))
                        Store (^SBRG.EC0.BST1 (), Local0)
                        If (LNotEqual (Local0, Ones))
                        {
                            Store (Local0, Index (PBST, One))
                        }

                        Store (^SBRG.EC0.BST2 (), Local0)
                        If (LNotEqual (Local0, Ones))
                        {
                            Store (Local0, Index (PBST, 0x02))
                        }

                        Store (^SBRG.EC0.BST3 (), DATW)
                        If (LNotEqual (DATW, Ones))
                        {
                            Store (DATW, Index (PBST, 0x03))
                        }
                    }

                    Method (UBLP, 0, Serialized)
                    {
                        If (LEqual (BCGS, One))
                        {
                            Store (0x64, BLTC)
                        }

                        If (LOr (LEqual (BCGS, Zero), LEqual (BCGS, 0x02)))
                        {
                            Store (Zero, BLTC)
                        }
                    }
                }

                Scope (\_SB)
                {
                    Scope (PCI0)
                    {
                        Device (AC0)
                        {
                            Name (_HID, "ACPI0003")
                            Method (_PSR, 0, NotSerialized)
                            {
                                Return (ACPS)
                            }

                            Name (_PCL, Package (0x01)
                            {
                                PCI0
                            })
                        }
                    }
                }
            }

            Device (IDE0)
            {
                Name (_ADR, 0x001F0001)
                Name (^NATA, Package (0x01)
                {
                    0x001F0001
                })
                Name (REGF, One)
                Method (_REG, 2, NotSerialized)
                {
                    If (LEqual (Arg0, 0x02))
                    {
                        Store (Arg1, REGF)
                    }
                }

                Name (TIM0, Package (0x08)
                {
                    Package (0x04)
                    {
                        0x78, 
                        0xB4, 
                        0xF0, 
                        0x0384
                    }, 

                    Package (0x04)
                    {
                        0x23, 
                        0x21, 
                        0x10, 
                        Zero
                    }, 

                    Package (0x04)
                    {
                        0x0B, 
                        0x09, 
                        0x04, 
                        Zero
                    }, 

                    Package (0x06)
                    {
                        0x70, 
                        0x49, 
                        0x36, 
                        0x27, 
                        0x19, 
                        0x14
                    }, 

                    Package (0x06)
                    {
                        Zero, 
                        One, 
                        0x02, 
                        One, 
                        0x02, 
                        One
                    }, 

                    Package (0x06)
                    {
                        Zero, 
                        Zero, 
                        Zero, 
                        One, 
                        One, 
                        One
                    }, 

                    Package (0x04)
                    {
                        0x04, 
                        0x03, 
                        0x02, 
                        Zero
                    }, 

                    Package (0x04)
                    {
                        0x02, 
                        One, 
                        Zero, 
                        Zero
                    }
                })
                Name (TMD0, Buffer (0x14) {})
                CreateDWordField (TMD0, Zero, PIO0)
                CreateDWordField (TMD0, 0x04, DMA0)
                CreateDWordField (TMD0, 0x08, PIO1)
                CreateDWordField (TMD0, 0x0C, DMA1)
                CreateDWordField (TMD0, 0x10, CHNF)
                OperationRegion (CFG2, PCI_Config, 0x40, 0x20)
                Field (CFG2, DWordAcc, NoLock, Preserve)
                {
                    PMPT,   4, 
                    PSPT,   4, 
                    PMRI,   6, 
                            Offset (0x02), 
                    SMPT,   4, 
                    SSPT,   4, 
                    SMRI,   6, 
                            Offset (0x04), 
                    PSRI,   4, 
                    SSRI,   4, 
                            Offset (0x08), 
                    PM3E,   1, 
                    PS3E,   1, 
                    SM3E,   1, 
                    SS3E,   1, 
                            Offset (0x0A), 
                    PMUT,   2, 
                        ,   2, 
                    PSUT,   2, 
                            Offset (0x0B), 
                    SMUT,   2, 
                        ,   2, 
                    SSUT,   2, 
                            Offset (0x0C), 
                            Offset (0x14), 
                    PM6E,   1, 
                    PS6E,   1, 
                    SM6E,   1, 
                    SS6E,   1, 
                    PMCR,   1, 
                    PSCR,   1, 
                    SMCR,   1, 
                    SSCR,   1, 
                        ,   4, 
                    PMAE,   1, 
                    PSAE,   1, 
                    SMAE,   1, 
                    SSAE,   1
                }

                Name (GMPT, Zero)
                Name (GMUE, Zero)
                Name (GMUT, Zero)
                Name (GMCR, Zero)
                Name (GSPT, Zero)
                Name (GSUE, Zero)
                Name (GSUT, Zero)
                Name (GSCR, Zero)
                Device (CHN0)
                {
                    Name (_ADR, Zero)
                    Method (_GTM, 0, NotSerialized)
                    {
                        ShiftLeft (PSCR, One, Local1)
                        Or (PMCR, Local1, Local0)
                        ShiftLeft (PMAE, 0x02, Local3)
                        ShiftLeft (PM6E, One, Local4)
                        Or (Local3, Local4, Local3)
                        Or (PM3E, Local3, Local1)
                        ShiftLeft (PMPT, 0x04, Local3)
                        Or (Local1, Local3, Local1)
                        ShiftLeft (PSAE, 0x02, Local3)
                        ShiftLeft (PS6E, One, Local4)
                        Or (Local3, Local4, Local3)
                        Or (PS3E, Local3, Local2)
                        ShiftLeft (PSPT, 0x04, Local3)
                        Or (Local2, Local3, Local2)
                        Return (GTM (PMRI, Local1, PMUT, PSRI, Local2, PSUT, Local0))
                    }

                    Method (_STM, 3, NotSerialized)
                    {
                        Store (Arg0, Debug)
                        Store (Arg0, TMD0)
                        ShiftLeft (PMAE, 0x02, Local3)
                        ShiftLeft (PM6E, One, Local4)
                        Or (Local3, Local4, Local3)
                        Or (PM3E, Local3, Local0)
                        ShiftLeft (PMPT, 0x04, Local3)
                        Or (Local0, Local3, Local0)
                        ShiftLeft (PSAE, 0x02, Local3)
                        ShiftLeft (PS6E, One, Local4)
                        Or (Local3, Local4, Local3)
                        Or (PS3E, Local3, Local1)
                        ShiftLeft (PSPT, 0x04, Local3)
                        Or (Local1, Local3, Local1)
                        Store (PMRI, GMPT)
                        Store (Local0, GMUE)
                        Store (PMUT, GMUT)
                        Store (PMCR, GMCR)
                        Store (PSRI, GSPT)
                        Store (Local1, GSUE)
                        Store (PSUT, GSUT)
                        Store (PSCR, GSCR)
                        STM ()
                        Store (GMPT, PMRI)
                        Store (GMUE, Local0)
                        Store (GMUT, PMUT)
                        Store (GMCR, PMCR)
                        Store (GSUE, Local1)
                        Store (GSUT, PSUT)
                        Store (GSCR, PSCR)
                        If (And (Local0, One))
                        {
                            Store (One, PM3E)
                        }
                        Else
                        {
                            Store (Zero, PM3E)
                        }

                        If (And (Local0, 0x02))
                        {
                            Store (One, PM6E)
                        }
                        Else
                        {
                            Store (Zero, PM6E)
                        }

                        If (And (Local0, 0x04))
                        {
                            Store (One, PMAE)
                        }
                        Else
                        {
                            Store (Zero, PMAE)
                        }

                        If (And (Local1, One))
                        {
                            Store (One, PS3E)
                        }
                        Else
                        {
                            Store (Zero, PS3E)
                        }

                        If (And (Local1, 0x02))
                        {
                            Store (One, PS6E)
                        }
                        Else
                        {
                            Store (Zero, PS6E)
                        }

                        If (And (Local1, 0x04))
                        {
                            Store (One, PSAE)
                        }
                        Else
                        {
                            Store (Zero, PSAE)
                        }

                        Store (GTF (Zero, Arg1), ATA0)
                        Store (GTF (One, Arg2), ATA1)
                    }

                    Device (DRV0)
                    {
                        Name (_ADR, Zero)
                        Method (_GTF, 0, NotSerialized)
                        {
                            Return (RATA (ATA0))
                        }
                    }

                    Device (DRV1)
                    {
                        Name (_ADR, One)
                        Method (_GTF, 0, NotSerialized)
                        {
                            Return (RATA (ATA1))
                        }
                    }
                }

                Device (CHN1)
                {
                    Name (_ADR, One)
                    Method (_GTM, 0, NotSerialized)
                    {
                        ShiftLeft (SSCR, One, Local1)
                        Or (SMCR, Local1, Local0)
                        ShiftLeft (SMAE, 0x02, Local3)
                        ShiftLeft (SM6E, One, Local4)
                        Or (Local3, Local4, Local3)
                        Or (SM3E, Local3, Local1)
                        ShiftLeft (SMPT, 0x04, Local3)
                        Or (Local1, Local3, Local1)
                        ShiftLeft (SSAE, 0x02, Local3)
                        ShiftLeft (SS6E, One, Local4)
                        Or (Local3, Local4, Local3)
                        Or (SS3E, Local3, Local2)
                        ShiftLeft (SSPT, 0x04, Local3)
                        Or (Local2, Local3, Local2)
                        Return (GTM (SMRI, Local1, SMUT, SSRI, Local2, SSUT, Local0))
                    }

                    Method (_STM, 3, NotSerialized)
                    {
                        Store (Arg0, Debug)
                        Store (Arg0, TMD0)
                        ShiftLeft (SMAE, 0x02, Local3)
                        ShiftLeft (SM6E, One, Local4)
                        Or (Local3, Local4, Local3)
                        Or (SM3E, Local3, Local0)
                        ShiftLeft (SMPT, 0x04, Local3)
                        Or (Local0, Local3, Local0)
                        ShiftLeft (SSAE, 0x02, Local3)
                        ShiftLeft (SS6E, One, Local4)
                        Or (Local3, Local4, Local3)
                        Or (SS3E, Local3, Local1)
                        ShiftLeft (SSPT, 0x04, Local3)
                        Or (Local1, Local3, Local1)
                        Store (SMRI, GMPT)
                        Store (Local0, GMUE)
                        Store (SMUT, GMUT)
                        Store (SMCR, GMCR)
                        Store (SSRI, GSPT)
                        Store (Local1, GSUE)
                        Store (SSUT, GSUT)
                        Store (SSCR, GSCR)
                        STM ()
                        Store (GMPT, SMRI)
                        Store (GMUE, Local0)
                        Store (GMUT, SMUT)
                        Store (GMCR, SMCR)
                        Store (GSUE, Local1)
                        Store (GSUT, SSUT)
                        Store (GSCR, SSCR)
                        If (And (Local0, One))
                        {
                            Store (One, SM3E)
                        }
                        Else
                        {
                            Store (Zero, SM3E)
                        }

                        If (And (Local0, 0x02))
                        {
                            Store (One, SM6E)
                        }
                        Else
                        {
                            Store (Zero, SM6E)
                        }

                        If (And (Local0, 0x04))
                        {
                            Store (One, SMAE)
                        }
                        Else
                        {
                            Store (Zero, SMAE)
                        }

                        If (And (Local1, One))
                        {
                            Store (One, SS3E)
                        }
                        Else
                        {
                            Store (Zero, SS3E)
                        }

                        If (And (Local1, 0x02))
                        {
                            Store (One, SS6E)
                        }
                        Else
                        {
                            Store (Zero, SS6E)
                        }

                        If (And (Local1, 0x04))
                        {
                            Store (One, SSAE)
                        }
                        Else
                        {
                            Store (Zero, SSAE)
                        }

                        Store (GTF (Zero, Arg1), ATA2)
                        Store (GTF (One, Arg2), ATA3)
                    }

                    Device (DRV0)
                    {
                        Name (_ADR, Zero)
                        Method (_GTF, 0, NotSerialized)
                        {
                            Return (RATA (ATA2))
                        }
                    }

                    Device (DRV1)
                    {
                        Name (_ADR, One)
                        Method (_GTF, 0, NotSerialized)
                        {
                            Return (RATA (ATA3))
                        }
                    }
                }

                Method (GTM, 7, Serialized)
                {
                    Store (Ones, PIO0)
                    Store (Ones, PIO1)
                    Store (Ones, DMA0)
                    Store (Ones, DMA1)
                    Store (0x10, CHNF)
                    If (REGF) {}
                    Else
                    {
                        Return (TMD0)
                    }

                    If (And (Arg1, 0x20))
                    {
                        Or (CHNF, 0x02, CHNF)
                    }

                    Store (Match (DerefOf (Index (TIM0, One)), MEQ, Arg0, MTR, 
                        Zero, Zero), Local6)
                    Store (DerefOf (Index (DerefOf (Index (TIM0, Zero)), Local6)), 
                        Local7)
                    Store (Local7, DMA0)
                    Store (Local7, PIO0)
                    If (And (Arg4, 0x20))
                    {
                        Or (CHNF, 0x08, CHNF)
                    }

                    Store (Match (DerefOf (Index (TIM0, 0x02)), MEQ, Arg3, MTR, 
                        Zero, Zero), Local6)
                    Store (DerefOf (Index (DerefOf (Index (TIM0, Zero)), Local6)), 
                        Local7)
                    Store (Local7, DMA1)
                    Store (Local7, PIO1)
                    If (And (Arg1, 0x07))
                    {
                        Store (Arg2, Local5)
                        If (And (Arg1, 0x02))
                        {
                            Add (Local5, 0x02, Local5)
                        }

                        If (And (Arg1, 0x04))
                        {
                            Add (Local5, 0x04, Local5)
                        }

                        Store (DerefOf (Index (DerefOf (Index (TIM0, 0x03)), Local5)), 
                            DMA0)
                        Or (CHNF, One, CHNF)
                    }

                    If (And (Arg4, 0x07))
                    {
                        Store (Arg5, Local5)
                        If (And (Arg4, 0x02))
                        {
                            Add (Local5, 0x02, Local5)
                        }

                        If (And (Arg4, 0x04))
                        {
                            Add (Local5, 0x04, Local5)
                        }

                        Store (DerefOf (Index (DerefOf (Index (TIM0, 0x03)), Local5)), 
                            DMA1)
                        Or (CHNF, 0x04, CHNF)
                    }

                    Store (TMD0, Debug)
                    Return (TMD0)
                }

                Method (STM, 0, Serialized)
                {
                    If (REGF) {}
                    Else
                    {
                        Store (Zero, GMUE)
                        Store (Zero, GMUT)
                        Store (Zero, GSUE)
                        Store (Zero, GSUT)
                        If (And (CHNF, One))
                        {
                            Store (Match (DerefOf (Index (TIM0, 0x03)), MLE, DMA0, MTR, 
                                Zero, Zero), Local0)
                            If (LGreater (Local0, 0x05))
                            {
                                Store (0x05, Local0)
                            }

                            Store (DerefOf (Index (DerefOf (Index (TIM0, 0x04)), Local0)), 
                                GMUT)
                            Or (GMUE, One, GMUE)
                            If (LGreater (Local0, 0x02))
                            {
                                Or (GMUE, 0x02, GMUE)
                            }

                            If (LGreater (Local0, 0x04))
                            {
                                And (GMUE, 0xFD, GMUE)
                                Or (GMUE, 0x04, GMUE)
                            }
                        }
                        Else
                        {
                            If (Or (LEqual (PIO0, Ones), LEqual (PIO0, Zero)))
                            {
                                If (And (LLess (DMA0, Ones), LGreater (DMA0, Zero)))
                                {
                                    Store (DMA0, PIO0)
                                    Or (GMUE, 0x80, GMUE)
                                }
                            }
                        }

                        If (And (CHNF, 0x04))
                        {
                            Store (Match (DerefOf (Index (TIM0, 0x03)), MLE, DMA1, MTR, 
                                Zero, Zero), Local0)
                            If (LGreater (Local0, 0x05))
                            {
                                Store (0x05, Local0)
                            }

                            Store (DerefOf (Index (DerefOf (Index (TIM0, 0x04)), Local0)), 
                                GSUT)
                            Or (GSUE, One, GSUE)
                            If (LGreater (Local0, 0x02))
                            {
                                Or (GSUE, 0x02, GSUE)
                            }

                            If (LGreater (Local0, 0x04))
                            {
                                And (GSUE, 0xFD, GSUE)
                                Or (GSUE, 0x04, GSUE)
                            }
                        }
                        Else
                        {
                            If (Or (LEqual (PIO1, Ones), LEqual (PIO1, Zero)))
                            {
                                If (And (LLess (DMA1, Ones), LGreater (DMA1, Zero)))
                                {
                                    Store (DMA1, PIO1)
                                    Or (GSUE, 0x80, GSUE)
                                }
                            }
                        }

                        If (And (CHNF, 0x02))
                        {
                            Or (GMUE, 0x20, GMUE)
                        }

                        If (And (CHNF, 0x08))
                        {
                            Or (GSUE, 0x20, GSUE)
                        }

                        And (Match (DerefOf (Index (TIM0, Zero)), MGE, PIO0, MTR, 
                            Zero, Zero), 0x07, Local0)
                        Store (DerefOf (Index (DerefOf (Index (TIM0, One)), Local0)), 
                            Local1)
                        Store (Local1, GMPT)
                        If (LLess (Local0, 0x03))
                        {
                            Or (GMUE, 0x50, GMUE)
                        }

                        And (Match (DerefOf (Index (TIM0, Zero)), MGE, PIO1, MTR, 
                            Zero, Zero), 0x07, Local0)
                        Store (DerefOf (Index (DerefOf (Index (TIM0, 0x02)), Local0)), 
                            Local1)
                        Store (Local1, GSPT)
                        If (LLess (Local0, 0x03))
                        {
                            Or (GSUE, 0x50, GSUE)
                        }
                    }
                }

                Name (AT01, Buffer (0x07)
                {
                    0x03, 0x00, 0x00, 0x00, 0x00, 0x00, 0xEF
                })
                Name (AT02, Buffer (0x07)
                {
                    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x90
                })
                Name (AT03, Buffer (0x07)
                {
                    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xC6
                })
                Name (AT04, Buffer (0x07)
                {
                    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x91
                })
                Name (ATA0, Buffer (0x1D) {})
                Name (ATA1, Buffer (0x1D) {})
                Name (ATA2, Buffer (0x1D) {})
                Name (ATA3, Buffer (0x1D) {})
                Name (ATAB, Buffer (0x1D) {})
                CreateByteField (ATAB, Zero, CMDC)
                Method (GTFB, 3, Serialized)
                {
                    Multiply (CMDC, 0x38, Local0)
                    Add (Local0, 0x08, Local1)
                    CreateField (ATAB, Local1, 0x38, CMDX)
                    Multiply (CMDC, 0x07, Local0)
                    CreateByteField (ATAB, Add (Local0, 0x02), A001)
                    CreateByteField (ATAB, Add (Local0, 0x06), A005)
                    Store (Arg0, CMDX)
                    Store (Arg1, A001)
                    Store (Arg2, A005)
                    Increment (CMDC)
                }

                Method (GTF, 2, Serialized)
                {
                    Store (Arg1, Debug)
                    Store (Zero, CMDC)
                    Name (ID49, 0x0C00)
                    Name (ID59, Zero)
                    Name (ID53, 0x04)
                    Name (ID63, 0x0F00)
                    Name (ID88, 0x0F00)
                    Name (IRDY, One)
                    Name (PIOT, Zero)
                    Name (DMAT, Zero)
                    If (LEqual (SizeOf (Arg1), 0x0200))
                    {
                        CreateWordField (Arg1, 0x62, IW49)
                        Store (IW49, ID49)
                        CreateWordField (Arg1, 0x6A, IW53)
                        Store (IW53, ID53)
                        CreateWordField (Arg1, 0x7E, IW63)
                        Store (IW63, ID63)
                        CreateWordField (Arg1, 0x76, IW59)
                        Store (IW59, ID59)
                        CreateWordField (Arg1, 0xB0, IW88)
                        Store (IW88, ID88)
                    }

                    Store (0xA0, Local7)
                    If (Arg0)
                    {
                        Store (0xB0, Local7)
                        And (CHNF, 0x08, IRDY)
                        If (And (CHNF, 0x10))
                        {
                            Store (PIO1, PIOT)
                        }
                        Else
                        {
                            Store (PIO0, PIOT)
                        }

                        If (And (CHNF, 0x04))
                        {
                            If (And (CHNF, 0x10))
                            {
                                Store (DMA1, DMAT)
                            }
                            Else
                            {
                                Store (DMA0, DMAT)
                            }
                        }
                    }
                    Else
                    {
                        And (CHNF, 0x02, IRDY)
                        Store (PIO0, PIOT)
                        If (And (CHNF, One))
                        {
                            Store (DMA0, DMAT)
                        }
                    }

                    If (LAnd (LAnd (And (ID53, 0x04), And (ID88, 0xFF00
                        )), DMAT))
                    {
                        Store (Match (DerefOf (Index (TIM0, 0x03)), MLE, DMAT, MTR, 
                            Zero, Zero), Local1)
                        If (LGreater (Local1, 0x05))
                        {
                            Store (0x05, Local1)
                        }

                        GTFB (AT01, Or (0x40, Local1), Local7)
                    }
                    Else
                    {
                        If (LAnd (And (ID63, 0xFF00), PIOT))
                        {
                            And (Match (DerefOf (Index (TIM0, Zero)), MGE, PIOT, MTR, 
                                Zero, Zero), 0x03, Local0)
                            Or (0x20, DerefOf (Index (DerefOf (Index (TIM0, 0x07)), Local0
                                )), Local1)
                            GTFB (AT01, Local1, Local7)
                        }
                    }

                    If (IRDY)
                    {
                        And (Match (DerefOf (Index (TIM0, Zero)), MGE, PIOT, MTR, 
                            Zero, Zero), 0x07, Local0)
                        Or (0x08, DerefOf (Index (DerefOf (Index (TIM0, 0x06)), Local0
                            )), Local1)
                        GTFB (AT01, Local1, Local7)
                    }
                    Else
                    {
                        If (And (ID49, 0x0400))
                        {
                            GTFB (AT01, One, Local7)
                        }
                    }

                    If (LAnd (And (ID59, 0x0100), And (ID59, 0xFF)))
                    {
                        GTFB (AT03, And (ID59, 0xFF), Local7)
                    }

                    Store (ATAB, Debug)
                    Return (ATAB)
                }

                Method (RATA, 1, NotSerialized)
                {
                    CreateByteField (Arg0, Zero, CMDN)
                    Multiply (CMDN, 0x38, Local0)
                    CreateField (Arg0, 0x08, Local0, RETB)
                    Store (RETB, Debug)
                    Concatenate (RETB, FZTF, RETB)
                    Return (RETB)
                }

                Name (FZTF, Buffer (0x07)
                {
                    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xF5
                })
            }

            Device (IDE1)
            {
                Name (_ADR, 0x001F0002)
            }

            Device (HDAC)
            {
                Name (_ADR, 0x001B0000)
                Method (_PRW, 0, NotSerialized)
                {
                    Return (GPRW (0x05, 0x04))
                }
            }

            Device (P0P4)
            {
                Name (_ADR, 0x001C0000)
                Method (_PRW, 0, NotSerialized)
                {
                    Return (GPRW (0x09, 0x04))
                }
            }

            Device (P0P8)
            {
                Name (_ADR, 0x001C0004)
                Method (_PRW, 0, NotSerialized)
                {
                    Return (GPRW (0x09, 0x04))
                }
            }

            Device (MC97)
            {
                Name (_ADR, 0x001E0003)
            }

            Device (P0P5)
            {
                Name (_ADR, 0x001C0001)
                Method (_PRW, 0, NotSerialized)
                {
                    Return (GPRW (0x09, 0x04))
                }

                Method (_PRT, 0, NotSerialized)
                {
                    If (PICM)
                    {
                        Return (AR05)
                    }

                    Return (PR05)
                }
            }

            Device (P0P7)
            {
                Name (_ADR, 0x001C0003)
                Method (_PRW, 0, NotSerialized)
                {
                    Return (GPRW (0x09, 0x04))
                }

                Method (_PRT, 0, NotSerialized)
                {
                    If (PICM)
                    {
                        Return (AR07)
                    }

                    Return (PR07)
                }
            }

            Device (P0P9)
            {
                Name (_ADR, 0x001C0005)
                Method (_PRW, 0, NotSerialized)
                {
                    Return (GPRW (0x09, 0x04))
                }
            }

            Device (USB0)
            {
                Name (_ADR, 0x001D0000)
                OperationRegion (BAR0, PCI_Config, 0xC4, One)
                Field (BAR0, ByteAcc, NoLock, Preserve)
                {
                    USBW,   2, 
                            Offset (0x01)
                }

                Method (_S3D, 0, NotSerialized)
                {
                    If (LOr (LEqual (OSFL (), One), LEqual (OSFL (), 0x02)))
                    {
                        Return (0x02)
                    }
                    Else
                    {
                        Return (0x03)
                    }
                }

                Method (_PSW, 1, NotSerialized)
                {
                    If (Arg0)
                    {
                        Store (0x03, USBW)
                    }
                    Else
                    {
                        Store (Zero, USBW)
                    }
                }
            }

            Device (USB1)
            {
                Name (_ADR, 0x001D0001)
                OperationRegion (BAR0, PCI_Config, 0xC4, One)
                Field (BAR0, ByteAcc, NoLock, Preserve)
                {
                    USBW,   2, 
                            Offset (0x01)
                }

                Method (_S3D, 0, NotSerialized)
                {
                    If (LOr (LEqual (OSFL (), One), LEqual (OSFL (), 0x02)))
                    {
                        Return (0x02)
                    }
                    Else
                    {
                        Return (0x03)
                    }
                }

                Method (_PSW, 1, NotSerialized)
                {
                    If (Arg0)
                    {
                        Store (0x03, USBW)
                    }
                    Else
                    {
                        Store (Zero, USBW)
                    }
                }
            }

            Device (USB2)
            {
                Name (_ADR, 0x001D0002)
                OperationRegion (BAR0, PCI_Config, 0xC4, One)
                Field (BAR0, ByteAcc, NoLock, Preserve)
                {
                    USBW,   2, 
                            Offset (0x01)
                }

                Method (_S3D, 0, NotSerialized)
                {
                    If (LOr (LEqual (OSFL (), One), LEqual (OSFL (), 0x02)))
                    {
                        Return (0x02)
                    }
                    Else
                    {
                        Return (0x03)
                    }
                }

                Method (_PSW, 1, NotSerialized)
                {
                    If (Arg0)
                    {
                        Store (0x03, USBW)
                    }
                    Else
                    {
                        Store (Zero, USBW)
                    }
                }
            }

            Device (USB3)
            {
                Name (_ADR, 0x001D0003)
                OperationRegion (BAR0, PCI_Config, 0xC4, One)
                Field (BAR0, ByteAcc, NoLock, Preserve)
                {
                    USBW,   2, 
                            Offset (0x01)
                }

                Method (_S3D, 0, NotSerialized)
                {
                    If (LOr (LEqual (OSFL (), One), LEqual (OSFL (), 0x02)))
                    {
                        Return (0x02)
                    }
                    Else
                    {
                        Return (0x03)
                    }
                }

                Method (_PSW, 1, NotSerialized)
                {
                    If (Arg0)
                    {
                        Store (0x03, USBW)
                    }
                    Else
                    {
                        Store (Zero, USBW)
                    }
                }
            }

            Device (EUSB)
            {
                Name (_ADR, 0x001D0007)
            }

            Device (P0P6)
            {
                Name (_ADR, 0x001C0002)
                Name (_HPP, Package (0x04)
                {
                    0x08, 
                    0x40, 
                    One, 
                    Zero
                })
                OperationRegion (SLOT, PCI_Config, 0x54, 0x10)
                Field (SLOT, ByteAcc, NoLock, Preserve)
                {
                    SCAP,   32, 
                    SCTL,   16, 
                    ABP1,   1, 
                    PFD1,   1, 
                    MSC1,   1, 
                    PDC1,   1, 
                    CC10,   1, 
                    MS10,   1, 
                    PDS1,   1, 
                    RSV0,   1, 
                    LASC,   1, 
                    RSV1,   7
                }

                OperationRegion (RHUB, PCI_Config, 0x60, 0x10)
                Field (RHUB, ByteAcc, NoLock, Preserve)
                {
                    PMID,   16, 
                    PMES,   1, 
                    PMEP,   1, 
                    RSV2,   14
                }

                OperationRegion (MISC, PCI_Config, 0xD8, 0x08)
                Field (MISC, ByteAcc, NoLock, Preserve)
                {
                    MPCR,   32, 
                    PMMS,   1, 
                    HPPD,   1, 
                    HPAB,   1, 
                    HPCC,   1, 
                    HPLA,   1, 
                    RSV3,   25, 
                    HPCS,   1, 
                    PMCS,   1
                }

                Method (_PRW, 0, NotSerialized)
                {
                    Return (GPRW (0x09, 0x04))
                }

                Method (_PRT, 0, NotSerialized)
                {
                    If (PICM)
                    {
                        Return (AR06)
                    }

                    Return (PR06)
                }
            }

            Device (VGA)
            {
                Name (_ADR, 0x00020000)
                Name (VGAB, Buffer (0x02) {})
                CreateWordField (VGAB, Zero, DISD)
                CreateByteField (VGAB, Zero, NXTD)
                CreateByteField (VGAB, One, AVLD)
                Name (LCDM, One)
                Name (CRTM, 0x02)
                Name (TVOM, 0x04)
                Name (DONE, Zero)
                Name (DOSF, One)
                Method (_INI, 0, NotSerialized)
                {
                    Store (GETD (), DISD)
                    Store (One, DONE)
                }

                Method (_DOS, 1, NotSerialized)
                {
                    Store (Arg0, DOSF)
                }

                Method (_DOD, 0, NotSerialized)
                {
                    Return (Package (0x03)
                    {
                        0x00010100, 
                        0x00010200, 
                        0x00010400
                    })
                }

                Method (CDCS, 1, NotSerialized)
                {
                    Store (0x0D, Local0)
                    If (And (NXTD, Arg0))
                    {
                        Or (Local0, 0x02, Local0)
                    }

                    If (And (AVLD, Arg0))
                    {
                        Or (Local0, 0x10, Local0)
                    }

                    Return (Local0)
                }

                Method (CDGS, 1, NotSerialized)
                {
                    If (And (NXTD, Arg0))
                    {
                        Return (One)
                    }

                    Return (Zero)
                }

                Method (_DSM, 4, NotSerialized)
                {
                    Store (Package (0x06)
                        {
                            "AAPL,HasPanel", 
                            Buffer (One)
                            {
                                0x01
                            }, 

                            "model", 
                            Buffer (0x08)
                            {
                                "GMA 950"
                            }, 

                            "built-in", 
                            Buffer (One)
                            {
                                0x01
                            }
                        }, Local0)
                    DTGP (Arg0, Arg1, Arg2, Arg3, RefOf (Local0))
                    Return (Local0)
                }

                Device (CRTD)
                {
                    Name (_ADR, 0x0100)
                    Method (_DCS, 0, NotSerialized)
                    {
                        Return (CDCS (CRTM))
                    }

                    Method (_DGS, 0, NotSerialized)
                    {
                        Return (CDGS (CRTM))
                    }

                    Method (_DSS, 1, NotSerialized)
                    {
                        If (And (Arg0, 0x40000000))
                        {
                            If (And (Arg0, 0x80000000))
                            {
                                Store (One, DONE)
                            }
                        }
                    }
                }

                Device (TVOD)
                {
                    Name (_ADR, 0x0200)
                    Method (_DCS, 0, NotSerialized)
                    {
                        Return (CDCS (TVOM))
                    }

                    Method (_DGS, 0, NotSerialized)
                    {
                        Return (CDGS (TVOM))
                    }

                    Method (_DSS, 1, NotSerialized)
                    {
                        If (And (Arg0, 0x40000000))
                        {
                            If (And (Arg0, 0x80000000))
                            {
                                Store (One, DONE)
                            }
                        }
                    }
                }

                Device (LCDD)
                {
                    Name (_ADR, 0x0400)
                    Method (_DCS, 0, NotSerialized)
                    {
                        Return (CDCS (LCDM))
                    }

                    Method (_DGS, 0, NotSerialized)
                    {
                        Return (CDGS (LCDM))
                    }

                    Method (_DSS, 1, NotSerialized)
                    {
                        If (And (Arg0, 0x40000000))
                        {
                            If (And (Arg0, 0x80000000))
                            {
                                Store (One, DONE)
                            }
                        }
                    }

                    Method (_BCL, 0, NotSerialized)
                    {
                        Return (Package (0x10)
                        {
                            0x0F, 
                            0x0E, 
                            0x0D, 
                            0x0C, 
                            0x0B, 
                            0x0A, 
                            0x09, 
                            0x08, 
                            0x07, 
                            0x06, 
                            0x05, 
                            0x04, 
                            0x03, 
                            0x02, 
                            One, 
                            Zero
                        })
                    }

                    Method (_BCM, 1, NotSerialized)
                    {
                        Store (Arg0, Local0)
                        ^^^^ATKD.PBLS (Local0)
                    }

                    Method (_BQC, 0, NotSerialized)
                    {
                        Return (^^^^ATKD.PBLG ())
                    }
                }

                Method (SWHD, 1, Serialized)
                {
                    If (DOSF)
                    {
                        Store (Arg0, PAR1)
                        ISMI (0x73)
                    }
                    Else
                    {
                        Notify (VGA, 0x80)
                    }

                    Store (One, DONE)
                }

                Method (GETD, 0, NotSerialized)
                {
                    ISMI (0x72)
                    Return (PAR1)
                }

                Method (GETN, 0, Serialized)
                {
                    If (DONE)
                    {
                        Store (GETD (), DISD)
                    }

                    Store (Zero, DONE)
                    Store (Zero, Local0)
                    While (LNotEqual (NXTD, Local0))
                    {
                        Increment (NXTD)
                        If (LEqual (NXTD, 0x07))
                        {
                            Increment (NXTD)
                        }

                        If (And (NXTD, 0xF8))
                        {
                            Store (One, NXTD)
                        }

                        And (NXTD, AVLD, Local0)
                    }

                    Return (NXTD)
                }

                OperationRegion (GFXR, PCI_Config, 0xF0, 0x02)
                Field (GFXR, ByteAcc, NoLock, Preserve)
                {
                        ,   13, 
                    GFXL,   1
                }
            }
        }

        Scope (\_GPE)
        {
            Method (_L09, 0, NotSerialized)
            {
                Notify (\_SB.PCI0.P0P2, 0x02)
                Notify (\_SB.PCI0.P0P4, 0x02)
                Notify (\_SB.PCI0.P0P8, 0x02)
                Notify (\_SB.PCI0.P0P5, 0x02)
                Notify (\_SB.PCI0.P0P7, 0x02)
                Notify (\_SB.PCI0.P0P9, 0x02)
                Notify (\_SB.PCI0.P0P6, 0x02)
                Notify (\_SB.PWRB, 0x02)
            }

            Method (_L0B, 0, NotSerialized)
            {
                Notify (\_SB.PCI0.P0P1, 0x02)
                Notify (\_SB.PWRB, 0x02)
            }

            Method (_L05, 0, NotSerialized)
            {
                Notify (\_SB.PCI0.HDAC, 0x02)
                Notify (\_SB.PWRB, 0x02)
            }
        }

        Device (PWRB)
        {
            Name (_CID, EisaId ("PNP0C0C"))
            Name (_UID, 0xAA)
            Name (_STA, 0x0B)
        }
    }

    Scope (\)
    {
        Device (AMW0)
        {
            Name (_HID, EisaId ("PNP0C14"))
            Name (_UID, "ASUSWMI")
            Name (_WDG, Buffer (0x50)
            {
                /* 0000 */    0xD0, 0x5E, 0x84, 0x97, 0x6D, 0x4E, 0xDE, 0x11, 
                /* 0008 */    0x8A, 0x39, 0x08, 0x00, 0x20, 0x0C, 0x9A, 0x66, 
                /* 0010 */    0x42, 0x43, 0x01, 0x02, 0xA0, 0x47, 0x67, 0x46, 
                /* 0018 */    0xEC, 0x70, 0xDE, 0x11, 0x8A, 0x39, 0x08, 0x00, 
                /* 0020 */    0x20, 0x0C, 0x9A, 0x66, 0x42, 0x44, 0x01, 0x02, 
                /* 0028 */    0x72, 0x0F, 0xBC, 0xAB, 0xA1, 0x8E, 0xD1, 0x11, 
                /* 0030 */    0x00, 0xA0, 0xC9, 0x06, 0x29, 0x10, 0x00, 0x00, 
                /* 0038 */    0xD2, 0x00, 0x01, 0x08, 0x21, 0x12, 0x90, 0x05, 
                /* 0040 */    0x66, 0xD5, 0xD1, 0x11, 0xB2, 0xF0, 0x00, 0xA0, 
                /* 0048 */    0xC9, 0x06, 0x29, 0x10, 0x4D, 0x4F, 0x01, 0x00
            })
            Name (CCAC, Zero)
            Name (ECD2, Zero)
            Name (EID2, Zero)
            Method (WED2, 1, NotSerialized)
            {
                Store (Arg0, ECD2)
            }

            Method (WMBC, 3, NotSerialized)
            {
                Store (One, Local0)
                Name (T_0, Zero)
                Store (Arg1, T_0)
                If (LEqual (T_0, 0x43455053))
                {
                    Return (SPEC (Arg2))
                }
                Else
                {
                    If (LEqual (T_0, 0x50564544))
                    {
                        Return (DEVP (Arg2))
                    }
                    Else
                    {
                        If (LEqual (T_0, 0x53564643))
                        {
                            Return (CFVS (Arg2))
                        }
                        Else
                        {
                            If (LEqual (T_0, 0x53475053))
                            {
                                Return (SPGS (Arg2))
                            }
                            Else
                            {
                                If (LEqual (T_0, 0x53564544))
                                {
                                    Return (DEVS (Arg2))
                                }
                                Else
                                {
                                    If (LEqual (T_0, 0x53544344))
                                    {
                                        Return (DSTS (Arg2))
                                    }
                                    Else
                                    {
                                        If (LEqual (T_0, 0x44495047))
                                        {
                                            Return (GPID ())
                                        }
                                        Else
                                        {
                                            If (LEqual (T_0, 0x5446424B))
                                            {
                                                Return (KBFT (Arg2))
                                            }
                                            Else
                                            {
                                                If (LEqual (T_0, 0x59454B48))
                                                {
                                                    Return (HKEY ())
                                                }
                                                Else
                                                {
                                                    If (LEqual (T_0, 0x53504448))
                                                    {
                                                        Return (HDPS (Arg2))
                                                    }
                                                    Else
                                                    {
                                                        Return (Zero)
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }

                Return (Local0)
            }

            Method (RSMB, 1, Serialized)
            {
                Name (RBFF, Buffer (0x08)
                {
                    /* 0000 */    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
                })
                CreateDWordField (Arg0, Zero, SLAD)
                CreateDWordField (Arg0, 0x04, COMD)
                CreateDWordField (RBFF, Zero, RSLT)
                CreateDWordField (RBFF, 0x04, DATA)
                Store (\_SB.PCI0.SBRG.RBYT (SLAD, COMD), DATA)
                Acquire (\_SB.PCI0.SBRG.SMBA, 0xFFFF)
                If (LEqual (And (\_SB.PCI0.SBRG.HSTS, 0x09), One))
                {
                    Store (One, RSLT)
                }
                Else
                {
                    Store (Zero, RSLT)
                }

                Release (\_SB.PCI0.SBRG.SMBA)
                Return (RBFF)
            }

            Method (WSMB, 1, Serialized)
            {
                Name (RBFF, Buffer (0x04)
                {
                    0x00, 0x00, 0x00, 0x00
                })
                CreateDWordField (Arg0, Zero, SLAD)
                CreateDWordField (Arg0, 0x04, COMD)
                CreateDWordField (Arg0, 0x08, DATA)
                CreateDWordField (RBFF, Zero, RSLT)
                \_SB.PCI0.SBRG.WBYT (SLAD, COMD, DATA)
                Acquire (\_SB.PCI0.SBRG.SMBA, 0xFFFF)
                If (LEqual (And (\_SB.PCI0.SBRG.HSTS, 0x09), One))
                {
                    Store (One, RSLT)
                }
                Else
                {
                    Store (Zero, RSLT)
                }

                Release (\_SB.PCI0.SBRG.SMBA)
                Return (RBFF)
            }

            Method (RSMW, 1, Serialized)
            {
                Name (RBFF, Buffer (0x08)
                {
                    /* 0000 */    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
                })
                CreateDWordField (Arg0, Zero, SLAD)
                CreateDWordField (Arg0, 0x04, COMD)
                CreateDWordField (RBFF, Zero, RSLT)
                CreateDWordField (RBFF, 0x04, DATA)
                Store (\_SB.PCI0.SBRG.RWRD (SLAD, COMD), DATA)
                Acquire (\_SB.PCI0.SBRG.SMBA, 0xFFFF)
                If (LEqual (And (\_SB.PCI0.SBRG.HSTS, 0x09), One))
                {
                    Store (One, RSLT)
                }
                Else
                {
                    Store (Zero, RSLT)
                }

                Release (\_SB.PCI0.SBRG.SMBA)
                Return (RBFF)
            }

            Method (WSMW, 1, Serialized)
            {
                Name (RBFF, Buffer (0x04)
                {
                    0x00, 0x00, 0x00, 0x00
                })
                CreateDWordField (Arg0, Zero, SLAD)
                CreateDWordField (Arg0, 0x04, COMD)
                CreateDWordField (Arg0, 0x08, DATA)
                CreateDWordField (RBFF, Zero, RSLT)
                \_SB.PCI0.SBRG.WWRD (SLAD, COMD, DATA)
                Acquire (\_SB.PCI0.SBRG.SMBA, 0xFFFF)
                If (LEqual (And (\_SB.PCI0.SBRG.HSTS, 0x09), One))
                {
                    Store (One, RSLT)
                }
                Else
                {
                    Store (Zero, RSLT)
                }

                Release (\_SB.PCI0.SBRG.SMBA)
                Return (RBFF)
            }

            Method (RSMK, 1, Serialized)
            {
                Name (RBFF, Buffer (0x24)
                {
                    /* 0000 */    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
                })
                Name (TMPB, Buffer (0x04)
                {
                    0x00, 0x00, 0x00, 0x00
                })
                CreateDWordField (Arg0, Zero, SLAD)
                CreateDWordField (Arg0, 0x04, COMD)
                CreateDWordField (RBFF, Zero, RSLT)
                CreateField (RBFF, 0x20, 0x0100, DATA)
                CreateDWordField (TMPB, Zero, TEMP)
                \_SB.PCI0.SBRG.RBLK (SLAD, COMD, \_SB.PCI0.SBRG.CLKB, 0x1F)
                Acquire (\_SB.PCI0.SBRG.SMBA, 0xFFFF)
                If (LEqual (And (\_SB.PCI0.SBRG.HSTS, 0x09), One))
                {
                    Store (\_SB.PCI0.SBRG.HDT0, RSLT)
                }
                Else
                {
                    Store (Zero, RSLT)
                }

                Release (\_SB.PCI0.SBRG.SMBA)
                If (RSLT)
                {
                    Store (Zero, TEMP)
                    While (LLess (TEMP, 0x20))
                    {
                        Store (DerefOf (Index (\_SB.PCI0.SBRG.CLKB, TEMP)), Local0)
                        Store (Local0, Index (DATA, TEMP))
                        Increment (TEMP)
                    }
                }

                Return (RBFF)
            }

            Method (WSMK, 1, Serialized)
            {
                Name (RBFF, Buffer (0x04)
                {
                    0x00, 0x00, 0x00, 0x00
                })
                Name (TMPB, Buffer (0x04)
                {
                    0x00, 0x00, 0x00, 0x00
                })
                CreateDWordField (Arg0, Zero, SLAD)
                CreateDWordField (Arg0, 0x04, COMD)
                CreateDWordField (Arg0, 0x08, COUT)
                CreateField (Arg0, 0x0C, 0x0100, DATA)
                CreateDWordField (TMPB, Zero, TEMP)
                CreateDWordField (RBFF, Zero, RSLT)
                Store (Zero, TEMP)
                While (LLess (TEMP, COUT))
                {
                    Increment (TEMP)
                }

                \_SB.PCI0.SBRG.WBLK (SLAD, COMD, COUT, DATA)
                Acquire (\_SB.PCI0.SBRG.SMBA, 0xFFFF)
                If (LEqual (And (\_SB.PCI0.SBRG.HSTS, 0x09), One))
                {
                    Store (\_SB.PCI0.SBRG.HDT0, RSLT)
                }
                Else
                {
                    Store (Zero, RSLT)
                }

                Release (\_SB.PCI0.SBRG.SMBA)
                Return (RBFF)
            }

            Method (WMBD, 3, NotSerialized)
            {
                Store (One, Local0)
                Name (T_0, Zero)
                Store (Arg1, T_0)
                If (LEqual (T_0, 0x424D5352))
                {
                    Return (RSMB (Arg2))
                }
                Else
                {
                    If (LEqual (T_0, 0x424D5357))
                    {
                        Return (WSMB (Arg2))
                    }
                    Else
                    {
                        If (LEqual (T_0, 0x574D5352))
                        {
                            Return (RSMW (Arg2))
                        }
                        Else
                        {
                            If (LEqual (T_0, 0x574D5357))
                            {
                                Return (WSMW (Arg2))
                            }
                            Else
                            {
                                If (LEqual (T_0, 0x4B4D5352))
                                {
                                    Return (RSMK (Arg2))
                                }
                                Else
                                {
                                    If (LEqual (T_0, 0x4B4D5357))
                                    {
                                        Return (WSMK (Arg2))
                                    }
                                    Else
                                    {
                                        Return (Zero)
                                    }
                                }
                            }
                        }
                    }
                }

                Return (Local0)
            }

            Method (_WED, 1, NotSerialized)
            {
                If (LEqual (Arg0, 0xD2))
                {
                    Return (EID2)
                }

                Return (Zero)
            }

            Method (AMWR, 1, Serialized)
            {
                Store (Zero, Local1)
                If (ECD2)
                {
                    Store (Arg0, EID2)
                    Notify (AMW0, 0xD2)
                    Store (One, Local1)
                }
                Else
                {
                    Store (0xFA, DBG8)
                }

                Return (Local1)
            }

            Method (AMWN, 1, Serialized)
            {
                Store (Zero, Local0)
                If (\_SB.LID.LIDS)
                {
                    Store (AMWR (Arg0), Local0)
                }

                Return (Local0)
            }

            Name (WQMO, Buffer (0x0A68)
            {
                /* 0000 */    0x46, 0x4F, 0x4D, 0x42, 0x01, 0x00, 0x00, 0x00, 
                /* 0008 */    0x58, 0x0A, 0x00, 0x00, 0x72, 0x40, 0x00, 0x00, 
                /* 0010 */    0x44, 0x53, 0x00, 0x01, 0x1A, 0x7D, 0xDA, 0x54, 
                /* 0018 */    0xA8, 0xC5, 0x9E, 0x00, 0x01, 0x06, 0x18, 0x42, 
                /* 0020 */    0x10, 0x07, 0x10, 0x4A, 0x23, 0x88, 0x42, 0x04, 
                /* 0028 */    0x0A, 0x0D, 0xA1, 0x38, 0x0A, 0x60, 0x30, 0x12, 
                /* 0030 */    0x20, 0x24, 0x07, 0x42, 0x2E, 0x98, 0x98, 0x00, 
                /* 0038 */    0x11, 0x10, 0xF2, 0x2A, 0xC0, 0xA6, 0x00, 0x93, 
                /* 0040 */    0x20, 0xEA, 0xDF, 0x1F, 0xA2, 0x24, 0x38, 0x94, 
                /* 0048 */    0x10, 0x08, 0x49, 0x14, 0x60, 0x5E, 0x80, 0x6E, 
                /* 0050 */    0x01, 0x86, 0x05, 0xD8, 0x16, 0x60, 0x5A, 0x80, 
                /* 0058 */    0x63, 0x48, 0x2A, 0x0D, 0x9C, 0x12, 0x58, 0x0A, 
                /* 0060 */    0x84, 0x84, 0x0A, 0x50, 0x2E, 0xC0, 0xB7, 0x00, 
                /* 0068 */    0xED, 0x88, 0x92, 0x2C, 0xC0, 0x32, 0x8C, 0x08, 
                /* 0070 */    0x3C, 0x8A, 0xC8, 0x46, 0xE3, 0x04, 0x65, 0x43, 
                /* 0078 */    0xA3, 0x64, 0x40, 0xC8, 0xB3, 0x00, 0xEB, 0xC0, 
                /* 0080 */    0x84, 0xC0, 0xEE, 0x05, 0x98, 0x13, 0xE0, 0x4D, 
                /* 0088 */    0x80, 0xB8, 0x61, 0xC8, 0xDA, 0x00, 0x04, 0x55, 
                /* 0090 */    0x98, 0x00, 0x5B, 0x30, 0x42, 0xA9, 0x0D, 0x46, 
                /* 0098 */    0x28, 0x8D, 0x21, 0x68, 0x18, 0x46, 0x89, 0x78, 
                /* 00A0 */    0x48, 0x9D, 0xC1, 0x0A, 0x25, 0x62, 0x98, 0x10, 
                /* 00A8 */    0x11, 0x2A, 0xC3, 0x20, 0xC3, 0x0A, 0x15, 0x2D, 
                /* 00B0 */    0x6E, 0x84, 0xF6, 0x07, 0x41, 0xA2, 0xAD, 0x58, 
                /* 00B8 */    0x43, 0x75, 0xA4, 0xD1, 0xA0, 0x86, 0x97, 0xE0, 
                /* 00C0 */    0x70, 0x3D, 0xD4, 0x73, 0xEC, 0x5C, 0x80, 0x74, 
                /* 00C8 */    0x60, 0x81, 0x04, 0x3F, 0x8B, 0x3A, 0xC7, 0x49, 
                /* 00D0 */    0x40, 0x12, 0x18, 0xEB, 0xF8, 0xD9, 0xC0, 0xF1, 
                /* 00D8 */    0xAE, 0x01, 0x35, 0xE3, 0xE3, 0x65, 0xBF, 0x00, 
                /* 00E0 */    0xC3, 0xF1, 0x21, 0x7A, 0xA0, 0xE1, 0x4E, 0xE0, 
                /* 00E8 */    0x10, 0x19, 0xA0, 0xE7, 0x74, 0x34, 0x98, 0x03, 
                /* 00F0 */    0x80, 0x1D, 0x4E, 0x46, 0xF7, 0x80, 0x52, 0x05, 
                /* 00F8 */    0x98, 0x1D, 0xB3, 0x2C, 0x02, 0x69, 0x3C, 0x86, 
                /* 0100 */    0x3E, 0xDD, 0xF3, 0x39, 0xE1, 0x04, 0x96, 0x3F, 
                /* 0108 */    0x08, 0xD4, 0xC8, 0x0C, 0x6D, 0x83, 0xD3, 0x12, 
                /* 0110 */    0x66, 0xC8, 0xC3, 0x3F, 0x2C, 0x26, 0x16, 0x42, 
                /* 0118 */    0x1F, 0x04, 0x8F, 0x07, 0xDE, 0xFF, 0x7F, 0x3C, 
                /* 0120 */    0xE0, 0x51, 0x7C, 0x26, 0x10, 0xC2, 0x2B, 0x41, 
                /* 0128 */    0x6C, 0x0F, 0xE8, 0x39, 0xC1, 0xC0, 0xD8, 0x01, 
                /* 0130 */    0xD9, 0xAF, 0x00, 0x84, 0xE0, 0x65, 0x8E, 0x48, 
                /* 0138 */    0x4E, 0x11, 0x34, 0x26, 0x63, 0xB4, 0x0A, 0xA1, 
                /* 0140 */    0x21, 0x84, 0x36, 0xC4, 0xD9, 0xC5, 0x3F, 0x78, 
                /* 0148 */    0xC3, 0x9C, 0xBB, 0x09, 0x8A, 0x1C, 0x01, 0x4A, 
                /* 0150 */    0xCC, 0x08, 0x50, 0xC7, 0x80, 0xE8, 0xA1, 0xCF, 
                /* 0158 */    0x26, 0xFA, 0xF1, 0x44, 0x39, 0x89, 0x03, 0xF2, 
                /* 0160 */    0x99, 0xC1, 0x08, 0xC1, 0xCB, 0x3D, 0x24, 0x10, 
                /* 0168 */    0xCD, 0x73, 0xD0, 0x89, 0xE1, 0x9C, 0x0E, 0x81, 
                /* 0170 */    0xA5, 0xB6, 0x33, 0x4A, 0x16, 0x65, 0xA9, 0xB2, 
                /* 0178 */    0x71, 0xBE, 0xA0, 0x83, 0xB0, 0x20, 0x20, 0xCD, 
                /* 0180 */    0xDD, 0x10, 0x27, 0x6D, 0xE4, 0xC0, 0x31, 0xAA, 
                /* 0188 */    0x1F, 0x36, 0x15, 0x01, 0xA7, 0xC3, 0x86, 0xC7, 
                /* 0190 */    0xED, 0xF8, 0x24, 0x8A, 0x3E, 0x20, 0x0A, 0xE7, 
                /* 0198 */    0xB0, 0x67, 0x0E, 0x0A, 0x62, 0x40, 0x27, 0x81, 
                /* 01A0 */    0x90, 0x93, 0xA3, 0x00, 0x4A, 0xCB, 0x38, 0xC9, 
                /* 01A8 */    0xB8, 0x4E, 0xED, 0x4D, 0xC0, 0xD3, 0x7A, 0x2C, 
                /* 01B0 */    0x38, 0x8C, 0xE3, 0x3A, 0x6B, 0x8B, 0xBE, 0x31, 
                /* 01B8 */    0xD0, 0xF9, 0xF8, 0x2E, 0xC0, 0x35, 0x40, 0x68, 
                /* 01C0 */    0x46, 0x86, 0xB7, 0x1A, 0x40, 0x0A, 0xC6, 0x4F, 
                /* 01C8 */    0x02, 0x8F, 0x00, 0x26, 0xB0, 0xAE, 0x03, 0x01, 
                /* 01D0 */    0xF4, 0xCB, 0x86, 0x87, 0xEF, 0x13, 0xC6, 0xE3, 
                /* 01D8 */    0x45, 0x82, 0xFA, 0xEE, 0x03, 0xA0, 0x00, 0xF2, 
                /* 01E0 */    0x01, 0xC0, 0x4A, 0xEF, 0x00, 0x74, 0x0C, 0x21, 
                /* 01E8 */    0xC2, 0x44, 0x33, 0x3A, 0x97, 0xB0, 0x52, 0xFD, 
                /* 01F0 */    0xFF, 0x47, 0xCB, 0x0F, 0x2A, 0x1E, 0xAD, 0x41, 
                /* 01F8 */    0x3C, 0x5A, 0x07, 0x1A, 0x2D, 0xFA, 0x98, 0x61, 
                /* 0200 */    0x85, 0xA3, 0x92, 0xCF, 0x09, 0x68, 0xB8, 0x30, 
                /* 0208 */    0x08, 0x0A, 0x3F, 0x70, 0x40, 0x03, 0x3C, 0xBD, 
                /* 0210 */    0x37, 0x03, 0xCF, 0xC4, 0x70, 0x9E, 0x2F, 0x87, 
                /* 0218 */    0xF3, 0x7C, 0xF9, 0x70, 0x7C, 0xA0, 0x80, 0x3F, 
                /* 0220 */    0x60, 0x2C, 0x41, 0x81, 0x13, 0x06, 0x39, 0x3C, 
                /* 0228 */    0x46, 0xF0, 0x60, 0xA9, 0xAC, 0x71, 0xA1, 0xEE, 
                /* 0230 */    0x07, 0x3E, 0xD1, 0x30, 0xEC, 0x43, 0x3D, 0x9A, 
                /* 0238 */    0xB7, 0x84, 0x33, 0x7C, 0x9B, 0x38, 0xA8, 0x77, 
                /* 0240 */    0x0F, 0x3B, 0x15, 0x6A, 0xD1, 0x21, 0xAC, 0x47, 
                /* 0248 */    0xCA, 0x61, 0x8D, 0x16, 0xF6, 0x80, 0x9F, 0x3B, 
                /* 0250 */    0x7C, 0xCF, 0xE0, 0x57, 0x1A, 0x1F, 0x43, 0xE8, 
                /* 0258 */    0x2A, 0x74, 0xAA, 0xE0, 0xA2, 0x20, 0x14, 0x6F, 
                /* 0260 */    0x2D, 0x1A, 0xFE, 0x59, 0x78, 0x5C, 0xAF, 0x18, 
                /* 0268 */    0xBE, 0x02, 0x3C, 0x9C, 0xF8, 0x0C, 0x10, 0x3F, 
                /* 0270 */    0xD0, 0x11, 0xBC, 0x88, 0xF8, 0xEC, 0xE3, 0xCB, 
                /* 0278 */    0x8B, 0x0F, 0x19, 0xEC, 0x64, 0xC1, 0x43, 0x50, 
                /* 0280 */    0x28, 0xC6, 0xE1, 0x00, 0x25, 0x1C, 0x46, 0x70, 
                /* 0288 */    0x06, 0xF1, 0xF0, 0x1C, 0xE4, 0x70, 0x80, 0x3E, 
                /* 0290 */    0x07, 0x79, 0x20, 0x6C, 0x10, 0x06, 0x39, 0x8F, 
                /* 0298 */    0x97, 0x1F, 0x76, 0xB1, 0xC0, 0xFF, 0xFF, 0x2F, 
                /* 02A0 */    0x16, 0xC0, 0x2B, 0xCD, 0xA0, 0xD0, 0x7A, 0x06, 
                /* 02A8 */    0x05, 0x01, 0xE3, 0xF9, 0xC1, 0xE3, 0xF5, 0x6C, 
                /* 02B0 */    0x3D, 0x2D, 0xF0, 0x8E, 0xD8, 0xE7, 0x0F, 0xE0, 
                /* 02B8 */    0x1C, 0xFE, 0xF0, 0x82, 0x8A, 0x3B, 0x24, 0x0A, 
                /* 02C0 */    0xE2, 0xB3, 0x81, 0xA3, 0x8C, 0x17, 0x3D, 0x13, 
                /* 02C8 */    0x1F, 0x86, 0x7C, 0x5C, 0x78, 0xBA, 0xC1, 0x1C, 
                /* 02D0 */    0x3E, 0xC0, 0x3D, 0x12, 0x1F, 0x3E, 0x80, 0xC7, 
                /* 02D8 */    0xFF, 0xFF, 0xF0, 0x01, 0xFC, 0x24, 0x5A, 0xD4, 
                /* 02E0 */    0x2A, 0xF4, 0xF0, 0x01, 0xAE, 0x20, 0x27, 0x24, 
                /* 02E8 */    0xB4, 0x9C, 0xC3, 0x07, 0x72, 0x22, 0x61, 0xA2, 
                /* 02F0 */    0xFB, 0x8C, 0xF4, 0xE2, 0x61, 0x09, 0x07, 0x0F, 
                /* 02F8 */    0x54, 0x78, 0x12, 0xC5, 0x3F, 0x15, 0xA0, 0x02, 
                /* 0300 */    0x9F, 0x0A, 0x28, 0x88, 0x01, 0x7D, 0xA8, 0x80, 
                /* 0308 */    0x33, 0x83, 0x67, 0x2F, 0xCC, 0x3C, 0x60, 0x9C, 
                /* 0310 */    0x91, 0x00, 0x5B, 0x87, 0x0A, 0xF0, 0xFE, 0xFF, 
                /* 0318 */    0x0F, 0x15, 0xC0, 0xE1, 0x80, 0x04, 0xC8, 0x92, 
                /* 0320 */    0x78, 0x41, 0x7A, 0xA8, 0x00, 0xD7, 0x81, 0xD3, 
                /* 0328 */    0x87, 0x0A, 0x7E, 0xD0, 0xB4, 0x28, 0x20, 0x1D, 
                /* 0330 */    0xF1, 0x7C, 0xA8, 0x80, 0x71, 0x11, 0x32, 0xFC, 
                /* 0338 */    0x6B, 0xDD, 0xB1, 0x3C, 0x87, 0x91, 0x73, 0x05, 
                /* 0340 */    0x3A, 0xF6, 0xC1, 0x00, 0x15, 0x74, 0xF4, 0x14, 
                /* 0348 */    0xC4, 0x80, 0x4E, 0x71, 0x30, 0x40, 0xEB, 0x38, 
                /* 0350 */    0x57, 0xA0, 0x8E, 0x71, 0xC0, 0xEF, 0xFF, 0x7F, 
                /* 0358 */    0xA6, 0x00, 0x4E, 0x22, 0x8E, 0x56, 0xA8, 0xE1, 
                /* 0360 */    0x7A, 0xAC, 0x06, 0xF1, 0x58, 0x7D, 0x0C, 0xF5, 
                /* 0368 */    0x58, 0x71, 0xDF, 0x00, 0x1F, 0x01, 0xF0, 0x47, 
                /* 0370 */    0x27, 0x1C, 0xD8, 0x73, 0x05, 0x60, 0xDA, 0xE3, 
                /* 0378 */    0xB9, 0x02, 0x74, 0xD2, 0xCF, 0x15, 0xA8, 0xA1, 
                /* 0380 */    0x79, 0x2D, 0x3E, 0xFB, 0xF0, 0x29, 0xBD, 0x87, 
                /* 0388 */    0x1E, 0xA7, 0x83, 0x1F, 0xDD, 0xE8, 0x90, 0x1C, 
                /* 0390 */    0x99, 0x44, 0x07, 0x45, 0x9F, 0x0B, 0x78, 0x4C, 
                /* 0398 */    0x08, 0xFD, 0xFF, 0xE1, 0x0C, 0x62, 0x40, 0x67, 
                /* 03A0 */    0x38, 0x17, 0xA0, 0x55, 0x80, 0x68, 0x36, 0x07, 
                /* 03A8 */    0xE6, 0xD3, 0xA7, 0x0F, 0x3D, 0x00, 0xAB, 0xFF, 
                /* 03B0 */    0xFF, 0x0E, 0x35, 0x6A, 0x75, 0x7A, 0x9A, 0x00, 
                /* 03B8 */    0x57, 0x84, 0xD3, 0x04, 0x8A, 0xC3, 0x42, 0x4E, 
                /* 03C0 */    0x13, 0xA8, 0x03, 0xA6, 0xBD, 0x5F, 0x5B, 0xC9, 
                /* 03C8 */    0x85, 0xFC, 0xC9, 0xC7, 0x77, 0x94, 0x87, 0x74, 
                /* 03D0 */    0x76, 0xA2, 0x00, 0xB8, 0xF9, 0xFF, 0x3F, 0x05, 
                /* 03D8 */    0x03, 0x16, 0x3C, 0x9E, 0x28, 0x40, 0x26, 0xED, 
                /* 03E0 */    0xE4, 0x88, 0x0E, 0xB8, 0x56, 0x9D, 0x63, 0xF1, 
                /* 03E8 */    0xA7, 0x60, 0x46, 0x30, 0xD4, 0x79, 0x82, 0x42, 
                /* 03F0 */    0x38, 0x0E, 0x85, 0xC2, 0x9C, 0xAB, 0x50, 0xF2, 
                /* 03F8 */    0xE1, 0x28, 0x88, 0x87, 0xE6, 0x30, 0x27, 0x60, 
                /* 0400 */    0xD0, 0x1C, 0x0B, 0xE0, 0xDD, 0x28, 0xD8, 0xB1, 
                /* 0408 */    0x00, 0x36, 0x81, 0x8F, 0x05, 0xE0, 0x8B, 0x33, 
                /* 0410 */    0x2C, 0xF4, 0x68, 0x7D, 0x7B, 0xC6, 0x1D, 0x45, 
                /* 0418 */    0x0C, 0x71, 0xE8, 0x4F, 0x0F, 0x70, 0xC7, 0x05, 
                /* 0420 */    0xEF, 0xFF, 0x7F, 0x7A, 0x00, 0xBC, 0x1D, 0x63, 
                /* 0428 */    0x75, 0x7A, 0x00, 0x59, 0x92, 0xD3, 0x03, 0x6A, 
                /* 0430 */    0xC0, 0xD6, 0x03, 0xA4, 0x73, 0x02, 0xF6, 0x3A, 
                /* 0438 */    0x12, 0xF8, 0x0D, 0x20, 0xC4, 0x89, 0x3E, 0xCD, 
                /* 0440 */    0x59, 0xC1, 0x01, 0x11, 0x95, 0x9D, 0x44, 0xC9, 
                /* 0448 */    0xCF, 0x28, 0xA8, 0xAC, 0x63, 0xA7, 0x20, 0x06, 
                /* 0450 */    0xF4, 0x79, 0x1C, 0xF0, 0x71, 0xBF, 0x01, 0xD7, 
                /* 0458 */    0xFF, 0xFF, 0x7E, 0x03, 0x73, 0xA3, 0x9E, 0x2C, 
                /* 0460 */    0x8F, 0x3C, 0x59, 0x0A, 0xE2, 0xC9, 0xFA, 0x52, 
                /* 0468 */    0x01, 0x1C, 0x6E, 0x38, 0x80, 0x4F, 0x89, 0x0E, 
                /* 0470 */    0xA5, 0x5E, 0x2A, 0x40, 0x26, 0xEF, 0x86, 0x83, 
                /* 0478 */    0x0E, 0xB9, 0x56, 0x5D, 0x98, 0xD8, 0xA1, 0xDF, 
                /* 0480 */    0xE3, 0xF6, 0x7D, 0x95, 0x13, 0x0C, 0x76, 0xC3, 
                /* 0488 */    0x41, 0x45, 0xA2, 0x50, 0xA0, 0x73, 0x01, 0x2A, 
                /* 0490 */    0x02, 0x1C, 0x05, 0xF1, 0xD0, 0x7C, 0x2E, 0xB0, 
                /* 0498 */    0x92, 0x73, 0x01, 0xFA, 0x56, 0xF6, 0x42, 0xE1, 
                /* 04A0 */    0xC1, 0xF9, 0x5E, 0x60, 0x98, 0xE2, 0x87, 0xA2, 
                /* 04A8 */    0x7B, 0x8F, 0x61, 0xFE, 0xFF, 0xCF, 0x05, 0x60, 
                /* 04B0 */    0xBE, 0xE2, 0x80, 0xCB, 0x98, 0x00, 0x6D, 0x90, 
                /* 04B8 */    0x24, 0xD0, 0xB8, 0xD0, 0xE3, 0xF0, 0xA8, 0x8E, 
                /* 04C0 */    0x29, 0xE6, 0xC3, 0x5B, 0x90, 0x27, 0x38, 0x36, 
                /* 04C8 */    0x2F, 0xCC, 0xF9, 0x01, 0x98, 0x0E, 0x8C, 0x5F, 
                /* 04D0 */    0x57, 0x81, 0xB8, 0x50, 0x93, 0x12, 0xCF, 0x0F, 
                /* 04D8 */    0xE0, 0x0A, 0x71, 0xAB, 0x46, 0x4B, 0xB9, 0x11, 
                /* 04E0 */    0xA2, 0x30, 0x5E, 0x49, 0x62, 0xF8, 0x96, 0x6F, 
                /* 04E8 */    0x6C, 0xC3, 0x3C, 0x00, 0x62, 0xAE, 0x84, 0x30, 
                /* 04F0 */    0xFE, 0xFF, 0x57, 0x42, 0x80, 0xFF, 0xFF, 0xFF, 
                /* 04F8 */    0x23, 0x05, 0xD6, 0xA5, 0x42, 0x8D, 0x52, 0x8F, 
                /* 0500 */    0x14, 0xE0, 0xBA, 0x03, 0xFA, 0x16, 0x86, 0x93, 
                /* 0508 */    0x04, 0xA4, 0x0B, 0xFF, 0x69, 0x3C, 0x00, 0xF8, 
                /* 0510 */    0x4A, 0x01, 0xE3, 0xDA, 0xCE, 0x8E, 0x38, 0x3C, 
                /* 0518 */    0xFE, 0xB1, 0x00, 0xE8, 0x5F, 0x09, 0xC1, 0x79, 
                /* 0520 */    0x2C, 0x00, 0xDE, 0x22, 0x5D, 0x5A, 0x34, 0x7B, 
                /* 0528 */    0x2C, 0x00, 0x57, 0xD8, 0x83, 0x0B, 0x0A, 0xDC, 
                /* 0530 */    0x92, 0x0E, 0x2E, 0xA8, 0x63, 0xFB, 0x01, 0x3F, 
                /* 0538 */    0x99, 0x71, 0xA0, 0xFF, 0xFF, 0xB9, 0x3C, 0x4A, 
                /* 0540 */    0xF1, 0x9B, 0x9D, 0x31, 0xDE, 0x0F, 0xC2, 0x3C, 
                /* 0548 */    0x16, 0xE8, 0xE8, 0x82, 0x8A, 0x7D, 0x74, 0x01, 
                /* 0550 */    0xE5, 0xF8, 0x4E, 0xE9, 0x1C, 0x8E, 0xE1, 0x69, 
                /* 0558 */    0x0F, 0x60, 0xE8, 0xFF, 0xFF, 0x58, 0x81, 0x3D, 
                /* 0560 */    0x98, 0x59, 0xC2, 0xB1, 0x02, 0x5C, 0x12, 0x85, 
                /* 0568 */    0x9E, 0xF6, 0x40, 0xF6, 0xA9, 0x30, 0x2C, 0x97, 
                /* 0570 */    0x71, 0x48, 0xA1, 0xA3, 0x8F, 0x67, 0x40, 0x58, 
                /* 0578 */    0xC7, 0xBB, 0x88, 0x2F, 0x16, 0xBE, 0x4C, 0x19, 
                /* 0580 */    0xD0, 0xE2, 0x57, 0x45, 0x0F, 0x15, 0x96, 0x0B, 
                /* 0588 */    0x83, 0x1A, 0x9D, 0xCF, 0x02, 0xF8, 0xD1, 0x1D, 
                /* 0590 */    0xDC, 0x31, 0x05, 0x67, 0x27, 0x2F, 0xC3, 0xF1, 
                /* 0598 */    0x81, 0xFB, 0x2A, 0xD0, 0xFC, 0xB4, 0x74, 0x37, 
                /* 05A0 */    0xF0, 0xC5, 0xD4, 0xB7, 0x68, 0x3A, 0x64, 0xD4, 
                /* 05A8 */    0x05, 0xD5, 0x63, 0x3F, 0x9E, 0x53, 0x7D, 0x42, 
                /* 05B0 */    0xF5, 0x65, 0xCB, 0x57, 0x7C, 0x36, 0x64, 0x86, 
                /* 05B8 */    0xC6, 0x09, 0xDE, 0xEC, 0x0C, 0xCD, 0x07, 0xE7, 
                /* 05C0 */    0x1B, 0xDE, 0x6B, 0x81, 0x07, 0xC9, 0xDC, 0x1F, 
                /* 05C8 */    0x05, 0xA4, 0x10, 0x41, 0x27, 0x82, 0x77, 0x84, 
                /* 05D0 */    0x1A, 0x05, 0x78, 0xBB, 0x1A, 0xC8, 0x96, 0x00, 
                /* 05D8 */    0x71, 0xA7, 0x01, 0x61, 0xBD, 0xCB, 0x45, 0x09, 
                /* 05E0 */    0x11, 0x21, 0x68, 0x14, 0xE3, 0x45, 0x08, 0x15, 
                /* 05E8 */    0x22, 0x4A, 0xD4, 0xE6, 0x40, 0x74, 0xA5, 0x8B, 
                /* 05F0 */    0x1A, 0x24, 0x5A, 0x30, 0x23, 0x30, 0xFB, 0x83, 
                /* 05F8 */    0x20, 0xD2, 0x5F, 0x14, 0xBA, 0x78, 0x38, 0xD2, 
                /* 0600 */    0x68, 0x50, 0x27, 0x40, 0x3E, 0xD4, 0x73, 0x7C, 
                /* 0608 */    0xC0, 0x65, 0x20, 0x2F, 0xB3, 0xD6, 0x39, 0x4E, 
                /* 0610 */    0x32, 0x7B, 0x83, 0xEB, 0x4C, 0x01, 0xCD, 0x35, 
                /* 0618 */    0xA0, 0x66, 0xFC, 0xFF, 0x7F, 0x2C, 0x00, 0xCB, 
                /* 0620 */    0xA1, 0x02, 0xFE, 0x78, 0x7C, 0x35, 0xF0, 0x7C, 
                /* 0628 */    0x4E, 0xF8, 0x35, 0x9C, 0x0C, 0x02, 0x75, 0x3E, 
                /* 0630 */    0xE2, 0x23, 0x7D, 0xF7, 0x30, 0xE4, 0x3B, 0x93, 
                /* 0638 */    0x09, 0x2C, 0xF6, 0x18, 0x42, 0xC7, 0x03, 0x7E, 
                /* 0640 */    0xC5, 0x67, 0x02, 0x5D, 0x3E, 0x8D, 0xED, 0x53, 
                /* 0648 */    0x8C, 0x23, 0x1C, 0x9F, 0xA0, 0x80, 0x3E, 0x51, 
                /* 0650 */    0xF1, 0x9B, 0x08, 0x3B, 0x10, 0x71, 0x51, 0x47, 
                /* 0658 */    0x0D, 0xD4, 0x69, 0xC1, 0x07, 0x05, 0x86, 0xF8, 
                /* 0660 */    0xC8, 0x6C, 0x88, 0x27, 0x0D, 0x76, 0x28, 0x01, 
                /* 0668 */    0xA7, 0xBC, 0x43, 0x09, 0x28, 0x40, 0x7C, 0xB2, 
                /* 0670 */    0x60, 0xF3, 0xC2, 0x10, 0xF8, 0x60, 0x14, 0x1E, 
                /* 0678 */    0x73, 0x08, 0x31, 0x3C, 0x3F, 0x25, 0x3C, 0x9E, 
                /* 0680 */    0x30, 0xEC, 0x37, 0x14, 0x4F, 0xE1, 0x70, 0x7C, 
                /* 0688 */    0xA4, 0x30, 0x42, 0xF0, 0x72, 0x4F, 0x16, 0xE4, 
                /* 0690 */    0x30, 0x74, 0x74, 0xCF, 0x5D, 0x98, 0xA1, 0x7A, 
                /* 0698 */    0x08, 0xFC, 0xBC, 0xE0, 0x21, 0xF0, 0x01, 0xB4, 
                /* 06A0 */    0x3A, 0x3B, 0x72, 0x5E, 0x39, 0x27, 0xFF, 0xFF, 
                /* 06A8 */    0xE7, 0xC4, 0xC7, 0xCB, 0xC7, 0x84, 0x1D, 0x00, 
                /* 06B0 */    0x0F, 0xBE, 0x24, 0x9F, 0x45, 0x68, 0x8C, 0xE5, 
                /* 06B8 */    0xFB, 0x38, 0x02, 0xC8, 0x99, 0xC4, 0x13, 0x48, 
                /* 06C0 */    0x84, 0x97, 0x91, 0x20, 0x21, 0x8E, 0xE5, 0x35, 
                /* 06C8 */    0xC4, 0x20, 0x31, 0xDE, 0xE9, 0x7C, 0x1C, 0xE1, 
                /* 06D0 */    0x30, 0xCF, 0x24, 0x86, 0x7B, 0x38, 0x78, 0x15, 
                /* 06D8 */    0x79, 0x21, 0x31, 0xCC, 0xA3, 0x88, 0xCF, 0x07, 
                /* 06E0 */    0x31, 0x8C, 0x19, 0x2A, 0xDA, 0x09, 0xF8, 0x38, 
                /* 06E8 */    0xC2, 0x0E, 0xC3, 0x1E, 0xAA, 0x8F, 0x23, 0x80, 
                /* 06F0 */    0xD5, 0xFF, 0xFF, 0x71, 0x04, 0x98, 0x1C, 0x11, 
                /* 06F8 */    0x70, 0xA7, 0x0D, 0xB8, 0xF7, 0x89, 0x10, 0x4F, 
                /* 0700 */    0x1A, 0x2F, 0x09, 0xCF, 0x1A, 0xC0, 0x45, 0xA8, 
                /* 0708 */    0x96, 0x73, 0x0F, 0x4B, 0xF3, 0x18, 0xD0, 0x71, 
                /* 0710 */    0x8F, 0x73, 0x58, 0x13, 0x90, 0x86, 0xC9, 0x67, 
                /* 0718 */    0x71, 0xEE, 0xCF, 0x05, 0x67, 0x17, 0x3B, 0x48, 
                /* 0720 */    0x98, 0x20, 0x4F, 0x04, 0x8F, 0x51, 0x4C, 0x03, 
                /* 0728 */    0xA4, 0xCE, 0x7A, 0x3C, 0x3D, 0x85, 0x74, 0x9F, 
                /* 0730 */    0xD8, 0x50, 0x4A, 0x8F, 0x7C, 0x14, 0xC4, 0x67, 
                /* 0738 */    0x04, 0x87, 0x38, 0xC7, 0xA0, 0x87, 0xEF, 0x39, 
                /* 0740 */    0x9C, 0xD1, 0x81, 0xBC, 0x07, 0xB0, 0xBB, 0x1E, 
                /* 0748 */    0xF0, 0x3C, 0xE9, 0xE0, 0xD1, 0x7D, 0x53, 0x38, 
                /* 0750 */    0xCF, 0xF7, 0x03, 0x8F, 0x08, 0x6C, 0xFF, 0xFF, 
                /* 0758 */    0x11, 0xF1, 0x99, 0xFA, 0x32, 0x08, 0x9C, 0x43, 
                /* 0760 */    0xDC, 0x05, 0x50, 0xB2, 0xEF, 0x02, 0x14, 0xC4, 
                /* 0768 */    0x13, 0xF3, 0x85, 0x15, 0x0E, 0xFE, 0x0B, 0x2B, 
                /* 0770 */    0x30, 0xB9, 0x2C, 0xF8, 0x9A, 0x04, 0xBE, 0x20, 
                /* 0778 */    0x17, 0x06, 0x28, 0xB7, 0x81, 0x87, 0x27, 0x36, 
                /* 0780 */    0x28, 0xF0, 0x43, 0xF9, 0xBA, 0x08, 0x7C, 0xFF, 
                /* 0788 */    0xFF, 0x97, 0x5A, 0xF0, 0x2A, 0x75, 0x6A, 0x53, 
                /* 0790 */    0xE1, 0x75, 0x11, 0x5C, 0x51, 0xAE, 0x25, 0xA8, 
                /* 0798 */    0x5B, 0x93, 0x05, 0x01, 0xE9, 0x9E, 0x88, 0x39, 
                /* 07A0 */    0x97, 0xC0, 0xBB, 0x39, 0x6B, 0x55, 0xBA, 0x97, 
                /* 07A8 */    0xF0, 0xE0, 0x14, 0x8A, 0x7E, 0x78, 0x40, 0x85, 
                /* 07B0 */    0x3D, 0x3C, 0x50, 0x10, 0x5F, 0x8C, 0x7C, 0x2F, 
                /* 07B8 */    0x01, 0xB8, 0x70, 0x2B, 0x86, 0x73, 0xB4, 0xC0, 
                /* 07C0 */    0xCC, 0x08, 0xF3, 0xFF, 0x9F, 0x11, 0xB8, 0x4E, 
                /* 07C8 */    0x04, 0x3E, 0xB9, 0x00, 0xE7, 0x9B, 0x3B, 0xF8, 
                /* 07D0 */    0x4E, 0x2E, 0xC0, 0xE5, 0x54, 0x02, 0xB8, 0xF2, 
                /* 07D8 */    0x7A, 0x2A, 0x01, 0xDD, 0xDD, 0xCB, 0xFF, 0xFF, 
                /* 07E0 */    0xBB, 0x17, 0x58, 0xAE, 0x26, 0x67, 0x12, 0x2D, 
                /* 07E8 */    0xB8, 0xEF, 0x5E, 0x00, 0x9F, 0xFF, 0xFF, 0x77, 
                /* 07F0 */    0x2F, 0x80, 0x68, 0x5E, 0xEF, 0x5E, 0xC0, 0xEB, 
                /* 07F8 */    0x5C, 0x82, 0xB9, 0x7B, 0x81, 0xF3, 0xFF, 0x7F, 
                /* 0800 */    0xF7, 0x02, 0xF8, 0xFF, 0xFF, 0xBF, 0x7B, 0x01, 
                /* 0808 */    0xF2, 0x4F, 0x25, 0x20, 0xCB, 0x76, 0x2A, 0x41, 
                /* 0810 */    0x2B, 0x3C, 0x47, 0x43, 0x9D, 0xC0, 0xA1, 0x3C, 
                /* 0818 */    0x61, 0xBC, 0xAA, 0x27, 0xB0, 0x9E, 0xCB, 0x17, 
                /* 0820 */    0x4A, 0x09, 0x8C, 0x2E, 0x5F, 0x80, 0x8D, 0xFF, 
                /* 0828 */    0xFF, 0xE5, 0x0B, 0xF0, 0x1B, 0xE8, 0x2E, 0x80, 
                /* 0830 */    0x8A, 0x70, 0x17, 0xA0, 0x20, 0xBE, 0x7C, 0x01, 
                /* 0838 */    0x5E, 0x42, 0x41, 0xC8, 0xC8, 0x4D, 0x82, 0x5E, 
                /* 0840 */    0xBE, 0xE0, 0x5C, 0x1C, 0x7C, 0x3F, 0xF2, 0xA0, 
                /* 0848 */    0xC0, 0x35, 0x98, 0xF3, 0x2E, 0xF6, 0xA4, 0x48, 
                /* 0850 */    0xE1, 0xF0, 0xFF, 0xFF, 0xEB, 0x09, 0xEE, 0xCE, 
                /* 0858 */    0xE1, 0xB1, 0x81, 0x43, 0xDC, 0x15, 0x0C, 0xD8, 
                /* 0860 */    0xBB, 0xBC, 0x9D, 0x80, 0x4B, 0xDB, 0xDA, 0x75, 
                /* 0868 */    0x3B, 0xC1, 0x25, 0x3C, 0x4E, 0x43, 0x3E, 0x9E, 
                /* 0870 */    0x60, 0xF2, 0xDC, 0x4E, 0x50, 0x49, 0x60, 0x94, 
                /* 0878 */    0x85, 0x44, 0x47, 0x08, 0xAE, 0xFE, 0x26, 0x46, 
                /* 0880 */    0x41, 0x6C, 0xE1, 0x76, 0x02, 0xE8, 0xFB, 0xFF, 
                /* 0888 */    0xDF, 0x4E, 0x80, 0xCF, 0x98, 0xE1, 0x8C, 0xE8, 
                /* 0890 */    0xBD, 0xC2, 0x90, 0x3E, 0x83, 0x01, 0xD3, 0x40, 
                /* 0898 */    0x47, 0x10, 0xF4, 0x25, 0x0D, 0x9B, 0xE0, 0x06, 
                /* 08A0 */    0x42, 0x67, 0x04, 0xEF, 0x02, 0x02, 0x77, 0x62, 
                /* 08A8 */    0xB0, 0x0E, 0x20, 0xE0, 0x3B, 0xAB, 0x01, 0x1E, 
                /* 08B0 */    0xFE, 0xFF, 0xF7, 0x1C, 0x30, 0x1F, 0x00, 0x7C, 
                /* 08B8 */    0x56, 0x03, 0x54, 0xDD, 0x5E, 0x40, 0xA6, 0xD0, 
                /* 08C0 */    0xA6, 0x4F, 0x8D, 0x46, 0xAD, 0x1A, 0x94, 0xA9, 
                /* 08C8 */    0x51, 0xA6, 0x41, 0xAD, 0x3E, 0x95, 0x1A, 0x33, 
                /* 08D0 */    0x36, 0x8A, 0x04, 0x63, 0xDC, 0x9E, 0xA8, 0x88, 
                /* 08D8 */    0xE5, 0x08, 0xC4, 0xBA, 0x29, 0x64, 0xE4, 0xB2, 
                /* 08E0 */    0x61, 0x10, 0x01, 0x59, 0xF6, 0xA2, 0x05, 0x44, 
                /* 08E8 */    0x40, 0x04, 0x64, 0x21, 0xEF, 0x06, 0x01, 0x59, 
                /* 08F0 */    0x15, 0x88, 0x80, 0x9C, 0x0A, 0x88, 0x46, 0x04, 
                /* 08F8 */    0xA2, 0x71, 0x3C, 0x00, 0xB1, 0x70, 0x20, 0x02, 
                /* 0900 */    0xB2, 0x3A, 0x13, 0x40, 0x4C, 0x2A, 0x88, 0xEE, 
                /* 0908 */    0x10, 0xE4, 0x73, 0x21, 0x20, 0x8B, 0x04, 0x11, 
                /* 0910 */    0x90, 0x33, 0xAE, 0x4F, 0x40, 0x0E, 0x0C, 0x22, 
                /* 0918 */    0x20, 0x87, 0xFC, 0x86, 0x08, 0xC8, 0x91, 0x41, 
                /* 0920 */    0x04, 0x64, 0x95, 0x3A, 0x80, 0x98, 0x64, 0x10, 
                /* 0928 */    0x01, 0x59, 0x9E, 0x0F, 0x20, 0x26, 0x16, 0x44, 
                /* 0930 */    0x40, 0xCE, 0xF9, 0x18, 0x10, 0x90, 0x43, 0x83, 
                /* 0938 */    0x08, 0xC8, 0x01, 0x69, 0xC4, 0xF0, 0xFF, 0x7F, 
                /* 0940 */    0x78, 0x10, 0x85, 0x80, 0x2C, 0xF6, 0xED, 0x20, 
                /* 0948 */    0x20, 0x4B, 0x07, 0x11, 0x90, 0xA3, 0x03, 0x51, 
                /* 0950 */    0x21, 0x52, 0x80, 0x58, 0x0C, 0x2B, 0x40, 0x2C, 
                /* 0958 */    0x13, 0x88, 0x80, 0x9C, 0x41, 0x0B, 0x10, 0x4B, 
                /* 0960 */    0x04, 0x22, 0x20, 0x2B, 0x7A, 0x05, 0x08, 0xC8, 
                /* 0968 */    0xFA, 0x40, 0x04, 0xE4, 0x84, 0x40, 0x34, 0x2F, 
                /* 0970 */    0x10, 0x15, 0xFB, 0xFC, 0x10, 0x90, 0x95, 0x83, 
                /* 0978 */    0x68, 0x70, 0xC4, 0x0D, 0x10, 0xD3, 0x0C, 0x22, 
                /* 0980 */    0x20, 0x27, 0x7E, 0x4A, 0x08, 0xC8, 0xF9, 0x41, 
                /* 0988 */    0x04, 0xE4, 0x00, 0x7A, 0x80, 0x58, 0x1A, 0x10, 
                /* 0990 */    0x01, 0x59, 0xBD, 0x1F, 0x20, 0x96, 0x05, 0x44, 
                /* 0998 */    0x40, 0xD6, 0xA4, 0x08, 0x84, 0x25, 0x02, 0xA1, 
                /* 09A0 */    0x9A, 0x1C, 0x81, 0xB0, 0x3C, 0x96, 0x40, 0x98, 
                /* 09A8 */    0x1A, 0x4D, 0x47, 0x03, 0xEA, 0xE9, 0x58, 0x40, 
                /* 09B0 */    0x41, 0x04, 0xE4, 0xE4, 0x40, 0x54, 0x86, 0x28, 
                /* 09B8 */    0x20, 0x16, 0x19, 0x44, 0x40, 0x16, 0x60, 0x0A, 
                /* 09C0 */    0x88, 0x49, 0x07, 0x11, 0x90, 0x83, 0x00, 0x51, 
                /* 09C8 */    0x19, 0xAE, 0x80, 0x98, 0x26, 0x10, 0x01, 0x39, 
                /* 09D0 */    0x08, 0x10, 0x4D, 0x05, 0x44, 0xB5, 0x3C, 0x23, 
                /* 09D8 */    0x04, 0x64, 0x61, 0x20, 0x3A, 0x38, 0x10, 0x5B, 
                /* 09E0 */    0x40, 0x4C, 0x12, 0x88, 0x8E, 0x0A, 0xE4, 0x79, 
                /* 09E8 */    0x23, 0x20, 0x67, 0x03, 0x11, 0x90, 0x05, 0xF9, 
                /* 09F0 */    0x02, 0x62, 0xEA, 0x40, 0x04, 0x64, 0x25, 0x2F, 
                /* 09F8 */    0x10, 0x01, 0x59, 0x17, 0x88, 0x06, 0x49, 0x80, 
                /* 0A00 */    0x68, 0x3E, 0x20, 0xAA, 0xEE, 0xFB, 0xA1, 0x63, 
                /* 0A08 */    0x03, 0x01, 0x11, 0x90, 0xF3, 0x01, 0xD1, 0xB0, 
                /* 0A10 */    0x40, 0x54, 0xE2, 0x3B, 0x24, 0x10, 0xD1, 0x0B, 
                /* 0A18 */    0x22, 0x20, 0x6B, 0x93, 0x06, 0xC4, 0x94, 0x82, 
                /* 0A20 */    0xE8, 0xB8, 0x40, 0xAC, 0x1D, 0x17, 0x28, 0x88, 
                /* 0A28 */    0x80, 0xAC, 0x54, 0x1B, 0x10, 0x93, 0x0D, 0x22, 
                /* 0A30 */    0xA0, 0xFF, 0xFF, 0x01, 0xC8, 0x1B, 0x10, 0x13, 
                /* 0A38 */    0x0C, 0x22, 0x20, 0x07, 0x07, 0xA2, 0x32, 0x7E, 
                /* 0A40 */    0x36, 0x02, 0x72, 0x04, 0x73, 0x40, 0x2C, 0x0F, 
                /* 0A48 */    0x88, 0x06, 0x4A, 0xD4, 0x01, 0x31, 0x45, 0x20, 
                /* 0A50 */    0x1A, 0x34, 0x01, 0xA2, 0xA9, 0x80, 0xA8, 0x32, 
                /* 0A58 */    0x77, 0x40, 0x4C, 0x26, 0x88, 0x8E, 0x0D, 0x44, 
                /* 0A60 */    0xDE, 0xB1, 0x81, 0x82, 0x08, 0xC8, 0xFF, 0x7F
            })
            Method (SPEC, 1, Serialized)
            {
                Return (AMWV)
            }

            Method (DEVP, 1, Serialized)
            {
                CreateDWordField (Arg0, Zero, DVID)
                CreateDWordField (Arg0, 0x04, PARA)
                If (LEqual (PARA, One))
                {
                    Name (T_0, Zero)
                    Store (DVID, T_0)
                    If (LEqual (T_0, 0x00010011))
                    {
                        Or (DSAF, One, DSAF)
                    }
                    Else
                    {
                        If (LEqual (T_0, 0x00010013))
                        {
                            Or (DSAF, 0x02, DSAF)
                        }
                        Else
                        {
                            If (LEqual (T_0, 0x00010023))
                            {
                                Or (DSAF, 0x04, DSAF)
                            }
                            Else
                            {
                                If (LEqual (T_0, 0x00060013))
                                {
                                    Or (DSAF, 0x08, DSAF)
                                }
                                Else
                                {
                                    If (LEqual (T_0, 0x00010015))
                                    {
                                        Or (DSAF, 0x20, DSAF)
                                    }
                                    Else
                                    {
                                        If (LEqual (T_0, 0x00090011))
                                        {
                                            Or (DSAF, 0x40, DSAF)
                                        }
                                        Else
                                        {
                                            If (LEqual (T_0, 0x00070011))
                                            {
                                                Or (DSAF, 0x80, DSAF)
                                            }
                                            Else
                                            {
                                                If (LEqual (T_0, 0x00080013))
                                                {
                                                    Or (DSAF, 0x0100, DSAF)
                                                }
                                                Else
                                                {
                                                    If (LEqual (T_0, 0x00010019))
                                                    {
                                                        Or (DSAF, 0x0200, DSAF)
                                                    }
                                                    Else
                                                    {
                                                        If (LEqual (T_0, 0x00010017))
                                                        {
                                                            Or (DSAF, 0x0400, DSAF)
                                                        }
                                                        Else
                                                        {
                                                            If (LEqual (T_0, 0x00050011))
                                                            {
                                                                Or (DSAF, 0x0800, DSAF)
                                                            }
                                                            Else
                                                            {
                                                                If (LEqual (T_0, 0x00050012))
                                                                {
                                                                    Or (DSAF, 0x1000, DSAF)
                                                                }
                                                                Else
                                                                {
                                                                    If (LEqual (T_0, 0x00060017))
                                                                    {
                                                                        Or (DSAF, 0x2000, DSAF)
                                                                    }
                                                                    Else
                                                                    {
                                                                        If (LEqual (T_0, 0x00080021))
                                                                        {
                                                                            Or (DSAF, 0x4000, DSAF)
                                                                        }
                                                                        Else
                                                                        {
                                                                            If (LEqual (T_0, 0x00100011))
                                                                            {
                                                                                Or (DSAF, 0x8000, DSAF)
                                                                            }
                                                                            Else
                                                                            {
                                                                                Return (Zero)
                                                                            }
                                                                        }
                                                                    }
                                                                }
                                                            }
                                                        }
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
                Else
                {
                    If (LEqual (PARA, Zero))
                    {
                        Name (T_1, Zero)
                        Store (DVID, T_1)
                        If (LEqual (T_1, 0x00010011))
                        {
                            And (DSAF, 0xFFFFFFFE, DSAF)
                        }
                        Else
                        {
                            If (LEqual (T_1, 0x00010013))
                            {
                                And (DSAF, 0xFFFFFFFD, DSAF)
                            }
                            Else
                            {
                                If (LEqual (T_1, 0x00010023))
                                {
                                    And (DSAF, 0xFFFFFFFB, DSAF)
                                }
                                Else
                                {
                                    If (LEqual (T_1, 0x00060013))
                                    {
                                        And (DSAF, 0xFFFFFFF7, DSAF)
                                    }
                                    Else
                                    {
                                        If (LEqual (T_1, 0x00010015))
                                        {
                                            And (DSAF, 0xFFFFFFDF, DSAF)
                                        }
                                        Else
                                        {
                                            If (LEqual (T_1, 0x00090011))
                                            {
                                                And (DSAF, 0xFFFFFFBF, DSAF)
                                            }
                                            Else
                                            {
                                                If (LEqual (T_1, 0x00070011))
                                                {
                                                    And (DSAF, 0xFFFFFF7F, DSAF)
                                                }
                                                Else
                                                {
                                                    If (LEqual (T_1, 0x00080013))
                                                    {
                                                        And (DSAF, 0xFFFFFEFF, DSAF)
                                                    }
                                                    Else
                                                    {
                                                        If (LEqual (T_1, 0x00010019))
                                                        {
                                                            And (DSAF, 0xFFFFFDFF, DSAF)
                                                        }
                                                        Else
                                                        {
                                                            If (LEqual (T_1, 0x00010017))
                                                            {
                                                                And (DSAF, 0xFFFFFBFF, DSAF)
                                                            }
                                                            Else
                                                            {
                                                                If (LEqual (T_1, 0x00050011))
                                                                {
                                                                    And (DSAF, 0xFFFFF7FF, DSAF)
                                                                }
                                                                Else
                                                                {
                                                                    If (LEqual (T_1, 0x00050012))
                                                                    {
                                                                        And (DSAF, 0xFFFFEFFF, DSAF)
                                                                    }
                                                                    Else
                                                                    {
                                                                        If (LEqual (T_1, 0x00060017))
                                                                        {
                                                                            And (DSAF, 0xFFFFDFFF, DSAF)
                                                                        }
                                                                        Else
                                                                        {
                                                                            If (LEqual (T_1, 0x00080021))
                                                                            {
                                                                                And (DSAF, 0xFFFFBFFF, DSAF)
                                                                            }
                                                                            Else
                                                                            {
                                                                                If (LEqual (T_1, 0x00100011))
                                                                                {
                                                                                    And (DSAF, 0xFFFF7FFF, DSAF)
                                                                                }
                                                                                Else
                                                                                {
                                                                                    Return (Zero)
                                                                                }
                                                                            }
                                                                        }
                                                                    }
                                                                }
                                                            }
                                                        }
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }

                Return (One)
            }

            Method (CFVS, 1, Serialized)
            {
                CreateDWordField (Arg0, Zero, SHEM)
                Return (\_SB.ATKD.CFVS (SHEM))
            }

            Method (SPGS, 1, Serialized)
            {
                CreateDWordField (Arg0, Zero, P4GR)
                Return (Zero)
            }

            Method (DEVS, 1, Serialized)
            {
                CreateDWordField (Arg0, Zero, DVID)
                CreateDWordField (Arg0, 0x04, CPAR)
                Name (T_0, Zero)
                Store (DVID, T_0)
                If (LEqual (T_0, Zero))
                {
                    Return (Zero)
                }
                Else
                {
                    If (LEqual (T_0, 0x00010011))
                    {
                        Return (OWLS (CPAR))
                    }
                    Else
                    {
                        If (LEqual (T_0, 0x00010013))
                        {
                            Return (OBTS (CPAR))
                        }
                        Else
                        {
                            If (LEqual (T_0, 0x00060013))
                            {
                                Return (OCMS (CPAR))
                            }
                            Else
                            {
                                If (LEqual (T_0, 0x00080013))
                                {
                                    Return (OCRS (CPAR))
                                }
                                Else
                                {
                                    If (LEqual (T_0, 0x00050011))
                                    {
                                        Return (\_SB.ATKD.PBPS (CPAR))
                                    }
                                    Else
                                    {
                                        Return (Zero)
                                    }
                                }
                            }
                        }
                    }
                }
            }

            Method (DSTS, 1, Serialized)
            {
                CreateDWordField (Arg0, Zero, DVID)
                Name (T_0, Zero)
                Store (DVID, T_0)
                If (LEqual (T_0, 0x00010011))
                {
                    Or (OWLG (), 0x00030000, Local0)
                }
                Else
                {
                    If (LEqual (T_0, 0x00010013))
                    {
                        Or (OBTG (), 0x00030000, Local0)
                    }
                    Else
                    {
                        If (LEqual (T_0, 0x00060013))
                        {
                            Or (OCMG (), 0x00030000, Local0)
                        }
                        Else
                        {
                            If (LEqual (T_0, 0x00080013))
                            {
                                Or (OCRG (), 0x00030000, Local0)
                            }
                            Else
                            {
                                If (LEqual (T_0, 0x00050011))
                                {
                                    Or (\_SB.ATKD.PBPG (), 0x00070000, Local0)
                                }
                                Else
                                {
                                    If (LEqual (T_0, 0x00120000))
                                    {
                                        Or (0x00030001, Local0, Local0)
                                    }
                                    Else
                                    {
                                        If (LEqual (T_0, Zero))
                                        {
                                            Return (Zero)
                                        }
                                        Else
                                        {
                                            Store (Zero, Local0)
                                        }
                                    }
                                }
                            }
                        }
                    }
                }

                And (Local0, 0x0007FFFF, Local0)
                Return (Local0)
            }

            Method (GPID, 0, Serialized)
            {
                Name (RBFF, Buffer (0x04) {})
                Name (WPIX, Package (0x04)
                {
                    0x0320, 
                    0x0400, 
                    0x0400, 
                    Zero
                })
                Name (HPIX, Package (0x04)
                {
                    0x01E0, 
                    0x0258, 
                    0x0300, 
                    Zero
                })
                CreateWordField (RBFF, Zero, WIDP)
                CreateWordField (RBFF, 0x02, HEIP)
                Store (\_SB.ATKD.HWCF (), Local0)
                ShiftRight (Local0, 0x08, Local0)
                And (Local0, 0x03, Local0)
                Store (DerefOf (Index (WPIX, Local0)), Local1)
                Store (DerefOf (Index (HPIX, Local0)), Local2)
                Store (Local1, WIDP)
                Store (Local2, HEIP)
                Return (RBFF)
            }

            Method (KBFT, 1, Serialized)
            {
                CreateBitField (Arg0, Zero, KBF1)
                Store (KBF1, \_SB.PCI0.SBRG.EC0.S251)
                Return (One)
            }

            Method (HKEY, 0, Serialized)
            {
                Store (\_SB.PCI0.SBRG.EC0.SM08, Local0)
                Return (One)
            }

            Method (HDPS, 1, Serialized)
            {
                Name (HDPW, Buffer (0x04)
                {
                    0x00, 0x00, 0x00, 0x00
                })
                Store (Arg0, HDPW)
                CreateDWordField (HDPW, Zero, HDP0)
                Return (\_SB.ATKD.HDPS (HDP0))
            }
        }
    }

    OperationRegion (_SB.PCI0.SBRG.PIX0, PCI_Config, 0x60, 0x0C)
    Field (\_SB.PCI0.SBRG.PIX0, ByteAcc, NoLock, Preserve)
    {
        PIRA,   8, 
        PIRB,   8, 
        PIRC,   8, 
        PIRD,   8, 
                Offset (0x08), 
        PIRE,   8, 
        PIRF,   8, 
        PIRG,   8, 
        PIRH,   8
    }

    Scope (_SB)
    {
        Name (BUFA, ResourceTemplate ()
        {
            IRQ (Level, ActiveLow, Shared, )
                {15}
        })
        CreateWordField (BUFA, One, IRA0)
        Device (LNKA)
        {
            Name (_HID, EisaId ("PNP0C0F"))
            Name (_UID, One)
            Method (_STA, 0, NotSerialized)
            {
                And (PIRA, 0x80, Local0)
                If (Local0)
                {
                    Return (0x09)
                }
                Else
                {
                    Return (0x0B)
                }
            }

            Method (_PRS, 0, NotSerialized)
            {
                Return (PRSA)
            }

            Method (_DIS, 0, NotSerialized)
            {
                Or (PIRA, 0x80, PIRA)
            }

            Method (_CRS, 0, NotSerialized)
            {
                And (PIRA, 0x0F, Local0)
                ShiftLeft (One, Local0, IRA0)
                Return (BUFA)
            }

            Method (_SRS, 1, NotSerialized)
            {
                CreateWordField (Arg0, One, IRA)
                FindSetRightBit (IRA, Local0)
                Decrement (Local0)
                Store (Local0, PIRA)
            }
        }

        Device (LNKB)
        {
            Name (_HID, EisaId ("PNP0C0F"))
            Name (_UID, 0x02)
            Method (_STA, 0, NotSerialized)
            {
                And (PIRB, 0x80, Local0)
                If (Local0)
                {
                    Return (0x09)
                }
                Else
                {
                    Return (0x0B)
                }
            }

            Method (_PRS, 0, NotSerialized)
            {
                Return (PRSB)
            }

            Method (_DIS, 0, NotSerialized)
            {
                Or (PIRB, 0x80, PIRB)
            }

            Method (_CRS, 0, NotSerialized)
            {
                And (PIRB, 0x0F, Local0)
                ShiftLeft (One, Local0, IRA0)
                Return (BUFA)
            }

            Method (_SRS, 1, NotSerialized)
            {
                CreateWordField (Arg0, One, IRA)
                FindSetRightBit (IRA, Local0)
                Decrement (Local0)
                Store (Local0, PIRB)
            }
        }

        Device (LNKC)
        {
            Name (_HID, EisaId ("PNP0C0F"))
            Name (_UID, 0x03)
            Method (_STA, 0, NotSerialized)
            {
                And (PIRC, 0x80, Local0)
                If (Local0)
                {
                    Return (0x09)
                }
                Else
                {
                    Return (0x0B)
                }
            }

            Method (_PRS, 0, NotSerialized)
            {
                Return (PRSC)
            }

            Method (_DIS, 0, NotSerialized)
            {
                Or (PIRC, 0x80, PIRC)
            }

            Method (_CRS, 0, NotSerialized)
            {
                And (PIRC, 0x0F, Local0)
                ShiftLeft (One, Local0, IRA0)
                Return (BUFA)
            }

            Method (_SRS, 1, NotSerialized)
            {
                CreateWordField (Arg0, One, IRA)
                FindSetRightBit (IRA, Local0)
                Decrement (Local0)
                Store (Local0, PIRC)
            }
        }

        Device (LNKD)
        {
            Name (_HID, EisaId ("PNP0C0F"))
            Name (_UID, 0x04)
            Method (_STA, 0, NotSerialized)
            {
                And (PIRD, 0x80, Local0)
                If (Local0)
                {
                    Return (0x09)
                }
                Else
                {
                    Return (0x0B)
                }
            }

            Method (_PRS, 0, NotSerialized)
            {
                Return (PRSD)
            }

            Method (_DIS, 0, NotSerialized)
            {
                Or (PIRD, 0x80, PIRD)
            }

            Method (_CRS, 0, NotSerialized)
            {
                And (PIRD, 0x0F, Local0)
                ShiftLeft (One, Local0, IRA0)
                Return (BUFA)
            }

            Method (_SRS, 1, NotSerialized)
            {
                CreateWordField (Arg0, One, IRA)
                FindSetRightBit (IRA, Local0)
                Decrement (Local0)
                Store (Local0, PIRD)
            }
        }

        Device (LNKE)
        {
            Name (_HID, EisaId ("PNP0C0F"))
            Name (_UID, 0x05)
            Method (_STA, 0, NotSerialized)
            {
                And (PIRE, 0x80, Local0)
                If (Local0)
                {
                    Return (0x09)
                }
                Else
                {
                    Return (0x0B)
                }
            }

            Method (_PRS, 0, NotSerialized)
            {
                Return (PRSE)
            }

            Method (_DIS, 0, NotSerialized)
            {
                Or (PIRE, 0x80, PIRE)
            }

            Method (_CRS, 0, NotSerialized)
            {
                And (PIRE, 0x0F, Local0)
                ShiftLeft (One, Local0, IRA0)
                Return (BUFA)
            }

            Method (_SRS, 1, NotSerialized)
            {
                CreateWordField (Arg0, One, IRA)
                FindSetRightBit (IRA, Local0)
                Decrement (Local0)
                Store (Local0, PIRE)
            }
        }

        Device (LNKF)
        {
            Name (_HID, EisaId ("PNP0C0F"))
            Name (_UID, 0x06)
            Method (_STA, 0, NotSerialized)
            {
                And (PIRF, 0x80, Local0)
                If (Local0)
                {
                    Return (0x09)
                }
                Else
                {
                    Return (0x0B)
                }
            }

            Method (_PRS, 0, NotSerialized)
            {
                Return (PRSF)
            }

            Method (_DIS, 0, NotSerialized)
            {
                Or (PIRF, 0x80, PIRF)
            }

            Method (_CRS, 0, NotSerialized)
            {
                And (PIRF, 0x0F, Local0)
                ShiftLeft (One, Local0, IRA0)
                Return (BUFA)
            }

            Method (_SRS, 1, NotSerialized)
            {
                CreateWordField (Arg0, One, IRA)
                FindSetRightBit (IRA, Local0)
                Decrement (Local0)
                Store (Local0, PIRF)
            }
        }

        Device (LNKG)
        {
            Name (_HID, EisaId ("PNP0C0F"))
            Name (_UID, 0x07)
            Method (_STA, 0, NotSerialized)
            {
                And (PIRG, 0x80, Local0)
                If (Local0)
                {
                    Return (0x09)
                }
                Else
                {
                    Return (0x0B)
                }
            }

            Method (_PRS, 0, NotSerialized)
            {
                Return (PRSG)
            }

            Method (_DIS, 0, NotSerialized)
            {
                Or (PIRG, 0x80, PIRG)
            }

            Method (_CRS, 0, NotSerialized)
            {
                And (PIRG, 0x0F, Local0)
                ShiftLeft (One, Local0, IRA0)
                Return (BUFA)
            }

            Method (_SRS, 1, NotSerialized)
            {
                CreateWordField (Arg0, One, IRA)
                FindSetRightBit (IRA, Local0)
                Decrement (Local0)
                Store (Local0, PIRG)
            }
        }

        Device (LNKH)
        {
            Name (_HID, EisaId ("PNP0C0F"))
            Name (_UID, 0x08)
            Method (_STA, 0, NotSerialized)
            {
                And (PIRH, 0x80, Local0)
                If (Local0)
                {
                    Return (0x09)
                }
                Else
                {
                    Return (0x0B)
                }
            }

            Method (_PRS, 0, NotSerialized)
            {
                Return (PRSH)
            }

            Method (_DIS, 0, NotSerialized)
            {
                Or (PIRH, 0x80, PIRH)
            }

            Method (_CRS, 0, NotSerialized)
            {
                And (PIRH, 0x0F, Local0)
                ShiftLeft (One, Local0, IRA0)
                Return (BUFA)
            }

            Method (_SRS, 1, NotSerialized)
            {
                CreateWordField (Arg0, One, IRA)
                FindSetRightBit (IRA, Local0)
                Decrement (Local0)
                Store (Local0, PIRH)
            }
        }
    }

    OperationRegion (SMRG, SystemIO, SMBS, 0x10)
    Field (SMRG, ByteAcc, NoLock, Preserve)
    {
        HSTS,   8, 
        SSTS,   8, 
        HSTC,   8, 
        HCMD,   8, 
        HADR,   8, 
        HDT0,   8, 
        HDT1,   8, 
        BLKD,   8
    }

    Field (SMRG, ByteAcc, NoLock, Preserve)
    {
                Offset (0x05), 
        HDTW,   16
    }

    Method (SCMD, 4, NotSerialized)
    {
        Store (0x05, Local0)
        While (Local0)
        {
            Store (Arg0, HADR)
            Store (Arg1, HCMD)
            Store (Arg2, HDTW)
            Store (0xFF, HSTS)
            Store (Arg3, HSTC)
            Store (0xFF, Local7)
            While (Local7)
            {
                Decrement (Local7)
                If (And (HSTS, 0x02))
                {
                    Store (Zero, Local7)
                    Store (One, Local0)
                }
            }

            Decrement (Local0)
        }

        If (And (HSTS, 0x02))
        {
            Return (HDTW)
        }
        Else
        {
            Return (Ones)
        }
    }

    Method (SBYT, 2, NotSerialized)
    {
        SCMD (Arg0, Arg1, Zero, 0x44)
    }

    Method (WBYT, 3, NotSerialized)
    {
        SCMD (Arg0, Arg1, Arg2, 0x48)
    }

    Method (WWRD, 3, NotSerialized)
    {
        SCMD (Arg0, Arg1, Arg2, 0x4C)
    }

    Method (RSBT, 2, NotSerialized)
    {
        Or (Arg0, One, Arg0)
        Return (SCMD (Arg0, Arg1, Zero, 0x44))
    }

    Method (RBYT, 2, NotSerialized)
    {
        Or (Arg0, One, Arg0)
        Return (SCMD (Arg0, Arg1, Zero, 0x48))
    }

    Method (RWRD, 2, NotSerialized)
    {
        Or (Arg0, One, Arg0)
        Return (SCMD (Arg0, Arg1, Zero, 0x4C))
    }

    Scope (_TZ)
    {
        Name (LTMP, 0x3C)
        Name (TCRT, 0x55)
        Name (TSP, 0x1E)
        Name (TPSV, 0x52)
        Method (KELV, 1, NotSerialized)
        {
            And (Arg0, 0xFF, Local0)
            Multiply (Local0, 0x0A, Local0)
            Add (Local0, 0x0AAC, Local0)
            Return (Local0)
        }

        Method (RTMP, 0, Serialized)
        {
            Store (\_SB.PCI0.SBRG.EC0.RCTP (), Local0)
            If (LLess (Local0, 0xFF))
            {
                Store (Local0, LTMP)
            }

            Return (LTMP)
        }

        Method (LFNT, 1, Serialized)
        {
            Name (T_0, Zero)
            Store (Arg0, T_0)
            If (LEqual (T_0, Zero))
            {
                If (\_SB.PCI0.SBRG.EC0.ECAV ())
                {
                    If (LNot (Acquire (\_SB.PCI0.SBRG.EC0.MUEC, 0xFFFF)))
                    {
                        Store (One, \_SB.PCI0.SBRG.EC0.BNKD)
                        Store (0xFF, \_SB.PCI0.SBRG.EC0.FT00)
                        Store (FN29, \_SB.PCI0.SBRG.EC0.FT29)
                        Store (FN28, \_SB.PCI0.SBRG.EC0.FT28)
                        Store (FN27, \_SB.PCI0.SBRG.EC0.FT27)
                        Store (FN26, \_SB.PCI0.SBRG.EC0.FT26)
                        Store (FN25, \_SB.PCI0.SBRG.EC0.FT25)
                        Store (FN24, \_SB.PCI0.SBRG.EC0.FT24)
                        Store (FN23, \_SB.PCI0.SBRG.EC0.FT23)
                        Store (FN22, \_SB.PCI0.SBRG.EC0.FT22)
                        Store (FN21, \_SB.PCI0.SBRG.EC0.FT21)
                        Store (FN20, \_SB.PCI0.SBRG.EC0.FT20)
                        Store (FN19, \_SB.PCI0.SBRG.EC0.FT19)
                        Store (FN18, \_SB.PCI0.SBRG.EC0.FT18)
                        Store (FN17, \_SB.PCI0.SBRG.EC0.FT17)
                        Store (FN16, \_SB.PCI0.SBRG.EC0.FT16)
                        Store (FN15, \_SB.PCI0.SBRG.EC0.FT15)
                        Store (FN14, \_SB.PCI0.SBRG.EC0.FT14)
                        Store (FN13, \_SB.PCI0.SBRG.EC0.FT13)
                        Store (FN12, \_SB.PCI0.SBRG.EC0.FT12)
                        Store (FN11, \_SB.PCI0.SBRG.EC0.FT11)
                        Store (FN10, \_SB.PCI0.SBRG.EC0.FT10)
                        Store (FN09, \_SB.PCI0.SBRG.EC0.FT09)
                        Store (FN08, \_SB.PCI0.SBRG.EC0.FT08)
                        Store (FN07, \_SB.PCI0.SBRG.EC0.FT07)
                        Store (FN06, \_SB.PCI0.SBRG.EC0.FT06)
                        Store (FN05, \_SB.PCI0.SBRG.EC0.FT05)
                        Store (FN04, \_SB.PCI0.SBRG.EC0.FT04)
                        Store (FN03, \_SB.PCI0.SBRG.EC0.FT03)
                        Store (FN02, \_SB.PCI0.SBRG.EC0.FT02)
                        Store (FN01, \_SB.PCI0.SBRG.EC0.FT01)
                        Store (FN00, \_SB.PCI0.SBRG.EC0.FT00)
                        Store (Zero, \_SB.PCI0.SBRG.EC0.BNKD)
                        Release (\_SB.PCI0.SBRG.EC0.MUEC)
                    }
                }
            }
            Else
            {
                If (LEqual (T_0, One))
                {
                    If (\_SB.PCI0.SBRG.EC0.ECAV ())
                    {
                        If (LNot (Acquire (\_SB.PCI0.SBRG.EC0.MUEC, 0xFFFF)))
                        {
                            Store (One, \_SB.PCI0.SBRG.EC0.BNKD)
                            Store (0xFF, \_SB.PCI0.SBRG.EC0.FT00)
                            Store (FA29, \_SB.PCI0.SBRG.EC0.FT29)
                            Store (FA28, \_SB.PCI0.SBRG.EC0.FT28)
                            Store (FA27, \_SB.PCI0.SBRG.EC0.FT27)
                            Store (FA26, \_SB.PCI0.SBRG.EC0.FT26)
                            Store (FA25, \_SB.PCI0.SBRG.EC0.FT25)
                            Store (FA24, \_SB.PCI0.SBRG.EC0.FT24)
                            Store (FA23, \_SB.PCI0.SBRG.EC0.FT23)
                            Store (FA22, \_SB.PCI0.SBRG.EC0.FT22)
                            Store (FA21, \_SB.PCI0.SBRG.EC0.FT21)
                            Store (FA20, \_SB.PCI0.SBRG.EC0.FT20)
                            Store (FA19, \_SB.PCI0.SBRG.EC0.FT19)
                            Store (FA18, \_SB.PCI0.SBRG.EC0.FT18)
                            Store (FA17, \_SB.PCI0.SBRG.EC0.FT17)
                            Store (FA16, \_SB.PCI0.SBRG.EC0.FT16)
                            Store (FA15, \_SB.PCI0.SBRG.EC0.FT15)
                            Store (FA14, \_SB.PCI0.SBRG.EC0.FT14)
                            Store (FA13, \_SB.PCI0.SBRG.EC0.FT13)
                            Store (FA12, \_SB.PCI0.SBRG.EC0.FT12)
                            Store (FA11, \_SB.PCI0.SBRG.EC0.FT11)
                            Store (FA10, \_SB.PCI0.SBRG.EC0.FT10)
                            Store (FA09, \_SB.PCI0.SBRG.EC0.FT09)
                            Store (FA08, \_SB.PCI0.SBRG.EC0.FT08)
                            Store (FA07, \_SB.PCI0.SBRG.EC0.FT07)
                            Store (FA06, \_SB.PCI0.SBRG.EC0.FT06)
                            Store (FA05, \_SB.PCI0.SBRG.EC0.FT05)
                            Store (FA04, \_SB.PCI0.SBRG.EC0.FT04)
                            Store (FA03, \_SB.PCI0.SBRG.EC0.FT03)
                            Store (FA02, \_SB.PCI0.SBRG.EC0.FT02)
                            Store (FA01, \_SB.PCI0.SBRG.EC0.FT01)
                            Store (FA00, \_SB.PCI0.SBRG.EC0.FT00)
                            Store (Zero, \_SB.PCI0.SBRG.EC0.BNKD)
                            Release (\_SB.PCI0.SBRG.EC0.MUEC)
                        }
                    }
                }
            }
        }

        ThermalZone (TZ00)
        {
            Method (_CRT, 0, NotSerialized)
            {
                Return (KELV (TCRT))
            }

            Method (_TMP, 0, NotSerialized)
            {
                Store (0x05, Local1)
                While (Local1)
                {
                    Store (RTMP (), Local0)
                    If (LGreater (Local0, TCRT))
                    {
                        Decrement (Local1)
                    }
                    Else
                    {
                        Store (Zero, Local1)
                    }
                }

                Return (KELV (Local0))
            }

            Name (_PSL, Package (0x02)
            {
                \_PR.P001, 
                \_PR.P002
            })
            Name (_TSP, 0x1E)
            Name (_TC1, 0x02)
            Name (_TC2, 0x0A)
            Method (_PSV, 0, NotSerialized)
            {
                Return (KELV (TPSV))
            }
        }
    }

    Scope (_SB)
    {
        Name (XCPD, Zero)
        Name (XNPT, One)
        Name (XCAP, 0x02)
        Name (XDCP, 0x04)
        Name (XDCT, 0x08)
        Name (XDST, 0x0A)
        Name (XLCP, 0x0C)
        Name (XLCT, 0x10)
        Name (XLST, 0x12)
        Name (XSCP, 0x14)
        Name (XSCT, 0x18)
        Name (XSST, 0x1A)
        Name (XRCT, 0x1C)
        Mutex (MUTE, 0x00)
        Method (RBPE, 1, NotSerialized)
        {
            Acquire (MUTE, 0xFFFF)
            Add (Arg0, PCIB, Local0)
            OperationRegion (PCFG, SystemMemory, Local0, One)
            Field (PCFG, ByteAcc, NoLock, Preserve)
            {
                XCFG,   8
            }

            Release (MUTE)
            Return (XCFG)
        }

        Method (RWPE, 1, NotSerialized)
        {
            Acquire (MUTE, 0xFFFF)
            And (Arg0, 0xFFFFFFFE, Arg0)
            Add (Arg0, PCIB, Local0)
            OperationRegion (PCFG, SystemMemory, Local0, 0x02)
            Field (PCFG, WordAcc, NoLock, Preserve)
            {
                XCFG,   16
            }

            Release (MUTE)
            Return (XCFG)
        }

        Method (RDPE, 1, NotSerialized)
        {
            Acquire (MUTE, 0xFFFF)
            And (Arg0, 0xFFFFFFFC, Arg0)
            Add (Arg0, PCIB, Local0)
            OperationRegion (PCFG, SystemMemory, Local0, 0x04)
            Field (PCFG, DWordAcc, NoLock, Preserve)
            {
                XCFG,   32
            }

            Release (MUTE)
            Return (XCFG)
        }

        Method (WBPE, 2, NotSerialized)
        {
            Acquire (MUTE, 0xFFFF)
            Add (Arg0, PCIB, Local0)
            OperationRegion (PCFG, SystemMemory, Local0, One)
            Field (PCFG, ByteAcc, NoLock, Preserve)
            {
                XCFG,   8
            }

            Store (Arg1, XCFG)
            Release (MUTE)
        }

        Method (WWPE, 2, NotSerialized)
        {
            Acquire (MUTE, 0xFFFF)
            And (Arg0, 0xFFFFFFFE, Arg0)
            Add (Arg0, PCIB, Local0)
            OperationRegion (PCFG, SystemMemory, Local0, 0x02)
            Field (PCFG, WordAcc, NoLock, Preserve)
            {
                XCFG,   16
            }

            Store (Arg1, XCFG)
            Release (MUTE)
        }

        Method (WDPE, 2, NotSerialized)
        {
            Acquire (MUTE, 0xFFFF)
            And (Arg0, 0xFFFFFFFC, Arg0)
            Add (Arg0, PCIB, Local0)
            OperationRegion (PCFG, SystemMemory, Local0, 0x04)
            Field (PCFG, DWordAcc, NoLock, Preserve)
            {
                XCFG,   32
            }

            Store (Arg1, XCFG)
            Release (MUTE)
        }

        Method (RWDP, 3, NotSerialized)
        {
            Acquire (MUTE, 0xFFFF)
            And (Arg0, 0xFFFFFFFC, Arg0)
            Add (Arg0, PCIB, Local0)
            OperationRegion (PCFG, SystemMemory, Local0, 0x04)
            Field (PCFG, DWordAcc, NoLock, Preserve)
            {
                XCFG,   32
            }

            And (XCFG, Arg2, Local1)
            Or (Local1, Arg1, XCFG)
            Release (MUTE)
        }

        Method (RPME, 1, NotSerialized)
        {
            Add (Arg0, 0x84, Local0)
            Store (RDPE (Local0), Local1)
            If (LEqual (Local1, Ones))
            {
                Return (Zero)
            }
            Else
            {
                If (LAnd (Local1, 0x00010000))
                {
                    WDPE (Local0, And (Local1, 0x00010000))
                    Return (One)
                }

                Return (Zero)
            }
        }
    }

    Scope (_SB)
    {
        Scope (PCI0)
        {
            Name (CRS, ResourceTemplate ()
            {
                WordBusNumber (ResourceProducer, MinFixed, MaxFixed, PosDecode,
                    0x0000,             // Granularity
                    0x0000,             // Range Minimum
                    0x00FF,             // Range Maximum
                    0x0000,             // Translation Offset
                    0x0100,             // Length
                    ,, )
                IO (Decode16,
                    0x0CF8,             // Range Minimum
                    0x0CF8,             // Range Maximum
                    0x01,               // Alignment
                    0x08,               // Length
                    )
                WordIO (ResourceProducer, MinFixed, MaxFixed, PosDecode, EntireRange,
                    0x0000,             // Granularity
                    0x0000,             // Range Minimum
                    0x0CF7,             // Range Maximum
                    0x0000,             // Translation Offset
                    0x0CF8,             // Length
                    ,, , TypeStatic)
                WordIO (ResourceProducer, MinFixed, MaxFixed, PosDecode, EntireRange,
                    0x0000,             // Granularity
                    0x0D00,             // Range Minimum
                    0xFFFF,             // Range Maximum
                    0x0000,             // Translation Offset
                    0xF300,             // Length
                    ,, , TypeStatic)
                DWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed, Cacheable, ReadWrite,
                    0x00000000,         // Granularity
                    0x000A0000,         // Range Minimum
                    0x000BFFFF,         // Range Maximum
                    0x00000000,         // Translation Offset
                    0x00020000,         // Length
                    ,, , AddressRangeMemory, TypeStatic)
                DWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed, Cacheable, ReadWrite,
                    0x00000000,         // Granularity
                    0x000C0000,         // Range Minimum
                    0x000DFFFF,         // Range Maximum
                    0x00000000,         // Translation Offset
                    0x00020000,         // Length
                    ,, _Y0B, AddressRangeMemory, TypeStatic)
                DWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed, Cacheable, ReadWrite,
                    0x00000000,         // Granularity
                    0x00000000,         // Range Minimum
                    0x00000000,         // Range Maximum
                    0x00000000,         // Translation Offset
                    0x00000000,         // Length
                    ,, _Y0C, AddressRangeMemory, TypeStatic)
            })
            CreateDWordField (CRS, \_SB.PCI0._Y0B._MIN, MIN5)
            CreateDWordField (CRS, \_SB.PCI0._Y0B._MAX, MAX5)
            CreateDWordField (CRS, \_SB.PCI0._Y0B._LEN, LEN5)
            CreateDWordField (CRS, \_SB.PCI0._Y0C._MIN, MIN6)
            CreateDWordField (CRS, \_SB.PCI0._Y0C._MAX, MAX6)
            CreateDWordField (CRS, \_SB.PCI0._Y0C._LEN, LEN6)
            Method (_CRS, 0, NotSerialized)
            {
                Store (MG1L, Local0)
                If (Local0)
                {
                    Store (MG1B, MIN5)
                    Store (MG1L, LEN5)
                    Add (MIN5, Decrement (Local0), MAX5)
                }

                Store (MG2B, MIN6)
                Store (MG2L, LEN6)
                Store (MG2L, Local0)
                Add (MIN6, Decrement (Local0), MAX6)
                Return (CRS)
            }
        }
    }

    Name (WOTB, Zero)
    Name (WSSB, Zero)
    Name (WAXB, Zero)
    Method (_PTS, 1, NotSerialized)
    {
        Store (Arg0, DBG8)
        PTS (Arg0)
        Store (Zero, Index (WAKP, Zero))
        Store (Zero, Index (WAKP, One))
        If (LAnd (LEqual (Arg0, 0x04), LEqual (OSFL (), 0x02)))
        {
            Sleep (0x0BB8)
        }

        Store (ASSB, WSSB)
        Store (AOTB, WOTB)
        Store (AAXB, WAXB)
        Store (Arg0, ASSB)
        Store (OSFL (), AOTB)
        Store (Zero, AAXB)
    }

    Method (DTGP, 5, NotSerialized)
    {
        If (LEqual (Arg0, Buffer (0x10)
                {
                    /* 0000 */    0xC6, 0xB7, 0xB5, 0xA0, 0x18, 0x13, 0x1C, 0x44, 
                    /* 0008 */    0xB0, 0xC9, 0xFE, 0x69, 0x5E, 0xAF, 0x94, 0x9B
                }))
        {
            If (LEqual (Arg1, One))
            {
                If (LEqual (Arg2, Zero))
                {
                    Store (Buffer (One)
                        {
                            0x03
                        }, Arg4)
                    Return (One)
                }

                If (LEqual (Arg2, One))
                {
                    Return (One)
                }
            }
        }

        Store (Buffer (One)
            {
                0x00
            }, Arg4)
        Return (Zero)
    }

    Method (_WAK, 1, NotSerialized)
    {
        ShiftLeft (Arg0, 0x04, DBG8)
        WAK (Arg0)
        If (ASSB)
        {
            Store (WSSB, ASSB)
            Store (WOTB, AOTB)
            Store (WAXB, AAXB)
        }

        If (DerefOf (Index (WAKP, Zero)))
        {
            Store (Zero, Index (WAKP, One))
        }
        Else
        {
            Store (Arg0, Index (WAKP, One))
        }

        Return (WAKP)
    }

    Name (_S0, Package (0x04)
    {
        Zero, 
        Zero, 
        Zero, 
        Zero
    })
    If (SS1)
    {
        Name (_S1, Package (0x04)
        {
            One, 
            Zero, 
            Zero, 
            Zero
        })
    }

    If (SS3)
    {
        Name (_S3, Package (0x04)
        {
            0x05, 
            Zero, 
            Zero, 
            Zero
        })
    }

    If (SS4)
    {
        Name (_S4, Package (0x04)
        {
            0x06, 
            Zero, 
            Zero, 
            Zero
        })
    }

    Name (_S5, Package (0x04)
    {
        0x07, 
        Zero, 
        Zero, 
        Zero
    })
    Method (PTS, 1, NotSerialized)
    {
        If (Arg0)
        {
            \_SB.PCI0.SBRG.EC0.EC0S (Arg0)
            \_SB.PCI0.NPTS (Arg0)
            \_SB.PCI0.SBRG.SPTS (Arg0)
            LPFS (Arg0)
        }
    }

    Scope (_SB.PCI0)
    {
        Method (_INI, 0, NotSerialized)
        {
            Return (OSFL ())
        }
    }

    Method (WAK, 1, NotSerialized)
    {
        \_SB.PCI0.SBRG.EC0.EC0W (Arg0)
        \_SB.PCI0.NWAK (Arg0)
        \_SB.PCI0.SBRG.SWAK (Arg0)
        LPWK (Arg0)
        \_SB.ATKD.PBLS (\_SB.ATKD.PBLG ())
    }
}

