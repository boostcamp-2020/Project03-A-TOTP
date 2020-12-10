export enum Colors {
  grayBrown = '#5C4D43',
  puple = '#3F3D56',
  mustard = '#C57A07',
  black = '#000000',
  gray = '#D9D8DD',
  white = '#FFFFFF',
  border = '#eaecef',
  darkerBorder = '#ddd',
  headerBg = '#FFFFFF',
  danger = '#ff4d4f',
  link = '#4192F1',
  tableHeader = '#F3F2F6',
  primary = '#3B589B',
  text = '#333333',
}

export enum FontSize {
  xl = '32px',
  lg = '20px',
  md = '16px',
  sm = '14px',
  xs = '12px',
}

export enum FontWeight {
  thin = 200,
  light = 300,
  regular = 500,
  bold = 700,
}

export enum Size {
  pageWidth = '1280px',
}

export const theme = {
  color: Colors,
  fontSize: FontSize,
  fontWeight: FontWeight,
  size: Size,
};
