# encoding: utf-8
# Code generated by Microsoft (R) AutoRest Code Generator.
# Changes may cause incorrect behavior and will be lost if the code is
# regenerated.

module Azure::Compute::Mgmt::V2019_03_01
  module Models
    #
    # Defines values for VirtualMachineSizeTypes
    #
    module VirtualMachineSizeTypes
      BasicA0 = "Basic_A0"
      BasicA1 = "Basic_A1"
      BasicA2 = "Basic_A2"
      BasicA3 = "Basic_A3"
      BasicA4 = "Basic_A4"
      StandardA0 = "Standard_A0"
      StandardA1 = "Standard_A1"
      StandardA2 = "Standard_A2"
      StandardA3 = "Standard_A3"
      StandardA4 = "Standard_A4"
      StandardA5 = "Standard_A5"
      StandardA6 = "Standard_A6"
      StandardA7 = "Standard_A7"
      StandardA8 = "Standard_A8"
      StandardA9 = "Standard_A9"
      StandardA10 = "Standard_A10"
      StandardA11 = "Standard_A11"
      StandardA1V2 = "Standard_A1_v2"
      StandardA2V2 = "Standard_A2_v2"
      StandardA4V2 = "Standard_A4_v2"
      StandardA8V2 = "Standard_A8_v2"
      StandardA2mV2 = "Standard_A2m_v2"
      StandardA4mV2 = "Standard_A4m_v2"
      StandardA8mV2 = "Standard_A8m_v2"
      StandardB1s = "Standard_B1s"
      StandardB1ms = "Standard_B1ms"
      StandardB2s = "Standard_B2s"
      StandardB2ms = "Standard_B2ms"
      StandardB4ms = "Standard_B4ms"
      StandardB8ms = "Standard_B8ms"
      StandardD1 = "Standard_D1"
      StandardD2 = "Standard_D2"
      StandardD3 = "Standard_D3"
      StandardD4 = "Standard_D4"
      StandardD11 = "Standard_D11"
      StandardD12 = "Standard_D12"
      StandardD13 = "Standard_D13"
      StandardD14 = "Standard_D14"
      StandardD1V2 = "Standard_D1_v2"
      StandardD2V2 = "Standard_D2_v2"
      StandardD3V2 = "Standard_D3_v2"
      StandardD4V2 = "Standard_D4_v2"
      StandardD5V2 = "Standard_D5_v2"
      StandardD2V3 = "Standard_D2_v3"
      StandardD4V3 = "Standard_D4_v3"
      StandardD8V3 = "Standard_D8_v3"
      StandardD16V3 = "Standard_D16_v3"
      StandardD32V3 = "Standard_D32_v3"
      StandardD64V3 = "Standard_D64_v3"
      StandardD2sV3 = "Standard_D2s_v3"
      StandardD4sV3 = "Standard_D4s_v3"
      StandardD8sV3 = "Standard_D8s_v3"
      StandardD16sV3 = "Standard_D16s_v3"
      StandardD32sV3 = "Standard_D32s_v3"
      StandardD64sV3 = "Standard_D64s_v3"
      StandardD11V2 = "Standard_D11_v2"
      StandardD12V2 = "Standard_D12_v2"
      StandardD13V2 = "Standard_D13_v2"
      StandardD14V2 = "Standard_D14_v2"
      StandardD15V2 = "Standard_D15_v2"
      StandardDS1 = "Standard_DS1"
      StandardDS2 = "Standard_DS2"
      StandardDS3 = "Standard_DS3"
      StandardDS4 = "Standard_DS4"
      StandardDS11 = "Standard_DS11"
      StandardDS12 = "Standard_DS12"
      StandardDS13 = "Standard_DS13"
      StandardDS14 = "Standard_DS14"
      StandardDS1V2 = "Standard_DS1_v2"
      StandardDS2V2 = "Standard_DS2_v2"
      StandardDS3V2 = "Standard_DS3_v2"
      StandardDS4V2 = "Standard_DS4_v2"
      StandardDS5V2 = "Standard_DS5_v2"
      StandardDS11V2 = "Standard_DS11_v2"
      StandardDS12V2 = "Standard_DS12_v2"
      StandardDS13V2 = "Standard_DS13_v2"
      StandardDS14V2 = "Standard_DS14_v2"
      StandardDS15V2 = "Standard_DS15_v2"
      StandardDS134V2 = "Standard_DS13-4_v2"
      StandardDS132V2 = "Standard_DS13-2_v2"
      StandardDS148V2 = "Standard_DS14-8_v2"
      StandardDS144V2 = "Standard_DS14-4_v2"
      StandardE2V3 = "Standard_E2_v3"
      StandardE4V3 = "Standard_E4_v3"
      StandardE8V3 = "Standard_E8_v3"
      StandardE16V3 = "Standard_E16_v3"
      StandardE32V3 = "Standard_E32_v3"
      StandardE64V3 = "Standard_E64_v3"
      StandardE2sV3 = "Standard_E2s_v3"
      StandardE4sV3 = "Standard_E4s_v3"
      StandardE8sV3 = "Standard_E8s_v3"
      StandardE16sV3 = "Standard_E16s_v3"
      StandardE32sV3 = "Standard_E32s_v3"
      StandardE64sV3 = "Standard_E64s_v3"
      StandardE3216V3 = "Standard_E32-16_v3"
      StandardE328sV3 = "Standard_E32-8s_v3"
      StandardE6432sV3 = "Standard_E64-32s_v3"
      StandardE6416sV3 = "Standard_E64-16s_v3"
      StandardF1 = "Standard_F1"
      StandardF2 = "Standard_F2"
      StandardF4 = "Standard_F4"
      StandardF8 = "Standard_F8"
      StandardF16 = "Standard_F16"
      StandardF1s = "Standard_F1s"
      StandardF2s = "Standard_F2s"
      StandardF4s = "Standard_F4s"
      StandardF8s = "Standard_F8s"
      StandardF16s = "Standard_F16s"
      StandardF2sV2 = "Standard_F2s_v2"
      StandardF4sV2 = "Standard_F4s_v2"
      StandardF8sV2 = "Standard_F8s_v2"
      StandardF16sV2 = "Standard_F16s_v2"
      StandardF32sV2 = "Standard_F32s_v2"
      StandardF64sV2 = "Standard_F64s_v2"
      StandardF72sV2 = "Standard_F72s_v2"
      StandardG1 = "Standard_G1"
      StandardG2 = "Standard_G2"
      StandardG3 = "Standard_G3"
      StandardG4 = "Standard_G4"
      StandardG5 = "Standard_G5"
      StandardGS1 = "Standard_GS1"
      StandardGS2 = "Standard_GS2"
      StandardGS3 = "Standard_GS3"
      StandardGS4 = "Standard_GS4"
      StandardGS5 = "Standard_GS5"
      StandardGS48 = "Standard_GS4-8"
      StandardGS44 = "Standard_GS4-4"
      StandardGS516 = "Standard_GS5-16"
      StandardGS58 = "Standard_GS5-8"
      StandardH8 = "Standard_H8"
      StandardH16 = "Standard_H16"
      StandardH8m = "Standard_H8m"
      StandardH16m = "Standard_H16m"
      StandardH16r = "Standard_H16r"
      StandardH16mr = "Standard_H16mr"
      StandardL4s = "Standard_L4s"
      StandardL8s = "Standard_L8s"
      StandardL16s = "Standard_L16s"
      StandardL32s = "Standard_L32s"
      StandardM64s = "Standard_M64s"
      StandardM64ms = "Standard_M64ms"
      StandardM128s = "Standard_M128s"
      StandardM128ms = "Standard_M128ms"
      StandardM6432ms = "Standard_M64-32ms"
      StandardM6416ms = "Standard_M64-16ms"
      StandardM12864ms = "Standard_M128-64ms"
      StandardM12832ms = "Standard_M128-32ms"
      StandardNC6 = "Standard_NC6"
      StandardNC12 = "Standard_NC12"
      StandardNC24 = "Standard_NC24"
      StandardNC24r = "Standard_NC24r"
      StandardNC6sV2 = "Standard_NC6s_v2"
      StandardNC12sV2 = "Standard_NC12s_v2"
      StandardNC24sV2 = "Standard_NC24s_v2"
      StandardNC24rsV2 = "Standard_NC24rs_v2"
      StandardNC6sV3 = "Standard_NC6s_v3"
      StandardNC12sV3 = "Standard_NC12s_v3"
      StandardNC24sV3 = "Standard_NC24s_v3"
      StandardNC24rsV3 = "Standard_NC24rs_v3"
      StandardND6s = "Standard_ND6s"
      StandardND12s = "Standard_ND12s"
      StandardND24s = "Standard_ND24s"
      StandardND24rs = "Standard_ND24rs"
      StandardNV6 = "Standard_NV6"
      StandardNV12 = "Standard_NV12"
      StandardNV24 = "Standard_NV24"
    end
  end
end
