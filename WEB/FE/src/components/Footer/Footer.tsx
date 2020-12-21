import React from 'react';
import styled from 'styled-components';
import githubImage from '@static/github.svg';

const Wrapper = styled.footer`
  height: 108px;
`;

const Inner = styled.div`
  max-width: ${({ theme }) => theme.size.pageWidth};
  height: 100%;
  margin: auto;
  border-top: 1px solid ${({ theme }) => theme.color.border};
  display: flex;
  justify-content: center;
  align-items: center;

  .github-logo {
    img {
      width: 22px;
      vertical-align: bottom;
      margin-left: 1rem;
    }
  }
`;

interface FooterProps {}

const Footer: React.FC<FooterProps> = () => {
  return (
    <Wrapper>
      <Inner>
        <span>
          &copy; {new Date().getFullYear()} Boostcamp. All right reserved{' '}
          <a
            className='github-logo'
            href='https://github.com/boostcamp-2020/Project03-A-TOTP'
            target='_blank'
          >
            <img src={githubImage} alt='github logo' />
          </a>
        </span>
      </Inner>
    </Wrapper>
  );
};

export { Footer };
