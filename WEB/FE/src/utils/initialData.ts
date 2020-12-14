import svgTimeStamp from '@static/TimeStamp.svg';
import svgSecretKey from '@static/SecretKey.svg';
import svgHMAC from '@static/HMAC.svg';
import svgTruncation from '@static/Truncation.svg';
import svgOTP from '@static/OTP.svg';

interface ArrayData {
  [timeStamp1: string]: { [left: string]: number };
}

const initialArrayData: ArrayData = {
  timeStamp1: { left: 161, top: 65, width: 87, height: 77 },
  secretKey1: { left: 337, top: 65, width: 87, height: 77 },
  hmac1: { left: 163, top: 182, width: 269, height: 27 },
  truncation1: { left: 163, top: 250, width: 269, height: 27 },
  otp1: { left: 195, top: 318, width: 206, height: 53 },
  timeStamp2: { left: 826, top: 65, width: 87, height: 77 },
  secretKey2: { left: 1002, top: 65, width: 87, height: 77 },
  hmac2: { left: 828, top: 182, width: 269, height: 27 },
  truncation2: { left: 828, top: 250, width: 269, height: 27 },
  otp2: { left: 860, top: 318, width: 206, height: 53 },
  list: { width: 1028, height: 180 },
};

interface StudyDataProps {
  [list: string]: { [name: string]: string }[];
}

const initialStudyData: StudyDataProps = {
  list: [
    { name: 'timeStamp1', svg: svgTimeStamp },
    { name: 'secretKey1', svg: svgSecretKey },
    { name: 'hmac1', svg: svgHMAC },
    { name: 'truncation1', svg: svgTruncation },
    { name: 'otp1', svg: svgOTP },
    { name: 'timeStamp2', svg: svgTimeStamp },
    { name: 'secretKey2', svg: svgSecretKey },
    { name: 'hmac2', svg: svgHMAC },
    { name: 'truncation2', svg: svgTruncation },
    { name: 'otp2', svg: svgOTP },
  ],
  timeStamp1: [],
  secretKey1: [],
  hmac1: [],
  truncation1: [],
  otp1: [],
  timeStamp2: [],
  secretKey2: [],
  hmac2: [],
  truncation2: [],
  otp2: [],
};
export { initialArrayData, initialStudyData };
