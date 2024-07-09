/*
 * Bochs/QEMU ACPI DSDT ASL definition
 *
 * Copyright (c) 2006 Fabrice Bellard
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Lesser General Public
 * License version 2 as published by the Free Software Foundation.
 *
 * This library is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public
 * License along with this library; if not, write to the Free Software
 * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
 */

ACPI_EXTRACT_ALL_CODE ssdp_pcihp_aml

DefinitionBlock ("ssdt-pcihp.aml", "SSDT", 0x01, "BXPC", "BXSSDTPC", 0x1)
{

/****************************************************************
 * PCI hotplug
 ****************************************************************/

    /* Objects supplied by DSDT */
    External(\_SB.PCI0, DeviceObj)
    External(\_SB.PCI0.PCEJ, MethodObj)

    Scope(\_SB.PCI0) {

        /* Bulk generated PCI hotplug devices */
        ACPI_EXTRACT_DEVICE_START ssdt_pcihp_start
        ACPI_EXTRACT_DEVICE_END ssdt_pcihp_end
        ACPI_EXTRACT_DEVICE_STRING ssdt_pcihp_name

        // Method _EJ0 can be patched by BIOS to EJ0_
        // at runtime, if the slot is detected to not support hotplug.
        // Extract the offset of the address dword and the
        // _EJ0 name to allow this patching.
        Device(SAA) {
            ACPI_EXTRACT_NAME_BYTE_CONST ssdt_pcihp_id
            Name(_SUN, 0xAA)
            ACPI_EXTRACT_NAME_DWORD_CONST ssdt_pcihp_adr
            Name(_ADR, 0xAA0000)
            ACPI_EXTRACT_METHOD_STRING ssdt_pcihp_ej0
            Method(_EJ0, 1) {
                PCEJ(_SUN)
            }
        }
    }
}
