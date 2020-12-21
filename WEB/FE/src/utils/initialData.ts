import svgTimeStamp from '@static/TimeStamp.svg';
import svgSecretKey from '@static/SecretKey.svg';
import svgHMAC from '@static/HMAC.svg';
import svgTruncation from '@static/Truncation.svg';
import svgOTP from '@static/OTP.svg';

interface ArrayData {
  [timeStamp1: string]: { [left: string]: number };
}

const initialArrayData: ArrayData = {
  timeStamp1: { left: 213, top: 80, width: 80, height: 71 },
  secretKey1: { left: 364, top: 80, width: 80, height: 71 },
  hmac1: { left: 209, top: 184, width: 240, height: 69 },
  truncation1: { left: 209, top: 286, width: 240, height: 69 },
  otp1: { left: 234, top: 388, width: 187, height: 69 },
  timeStamp2: { left: 805, top: 80, width: 80, height: 71 },
  secretKey2: { left: 968, top: 80, width: 80, height: 71 },
  hmac2: { left: 806, top: 183, width: 240, height: 69 },
  truncation2: { left: 806, top: 286, width: 240, height: 69 },
  otp2: { left: 833, top: 387, width: 187, height: 69 },
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
